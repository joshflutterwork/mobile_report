part of 'controllers.dart';

class SurveyController extends GetxController {
  final authController = Get.find<AuthController>();
  final Rx<IndexSurvey> indexSurvey = IndexSurvey().obs;
  RxList<ServiceCategory> listService = <ServiceCategory>[].obs;
  RxList<Cabang> listCabang = <Cabang>[].obs;

  final search = TextEditingController();
  var searchText = "".obs;

  var more = true;
  var hasMore = true;
  var pages = 1;
  var page = 1;
  final box = GetStorage();
  var isLoading = false.obs;
  var isTyping = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    this.getServiceCategory();
    this.getCabang();
    this.getSurveyReport();
    super.onInit();
    search.addListener(() {
      searchText = search.text.obs;
      search.text.length != 0 ? isTyping(true) : isTyping(false);
    });
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (hasMore) {
          print("reached getSurveyReport");
          pages++;
          getSurveyReport(page: pages);
        }
      }
    });
  }

  void onTyping() {
    isTyping(false);
    search.clear();
    getSurveyReport();
  }

  void onSearch(searchText) async {
    getSurveyReport(search: searchText);
  }

  void getSurveyReport({int? page, String? search}) async {
    try {
      print(authController.getCabangId() + "cabang id");
      isLoading.toggle();
      Request request = Request(
        url:
            '${authController.getUnitId()}/survey_report?search=$search&page=$page&site_project_id=${authController.getCabangId()}',
        headers: {
          'Authorization': 'Bearer ${authController.getTokenProject()}'
        },
      );
      request.getPro().then((res) {
        logger.i(res.statusCode);
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          final value = IndexSurvey.fromJson(data);
          logger.v(data);
          if (value is IndexSurvey) {
            indexSurvey.update((val) {
              val!.data = value.data;
              val.htmlLinks = value.htmlLinks;
              val.total = value.total;
              val.hasMorePage = value.hasMorePage;
              val.currentPage = value.currentPage;
              isLoading.toggle();
            });
          }
        } else if (res.statusCode == 401) {
          final data = jsonDecode(res.body);
          authController.tokenExpired(data['message']);
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  void getServiceCategory() {
    try {
      Request request = Request(
        url: 'service_category/by_role',
        headers: {
          'Authorization': 'Bearer ${authController.getTokenProject()}'
        },
      );
      request.getPro().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          final v =
              (data as List).map((e) => ServiceCategory.fromJson(e)).toList();
          if (v is List<ServiceCategory>) {
            listService.addAll(v);
            logger.v(data);
          }
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  void getCabang() {
    try {
      isLoading.toggle();
      listCabang.clear();
      Request request = Request(
        url:
            '${authController.getUnitId()}/site_project/by_service_category/${authController.getUnitId()}',
        headers: {
          'Authorization': 'Bearer ${authController.getTokenProject()}'
        },
      );
      request.getPro().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          final v = (data as List).map((e) => Cabang.fromJson(e)).toList();
          if (v is List<Cabang>) {
            listCabang.addAll(v);
            logger.v(data);
            isLoading.toggle();
          }
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  void createSurvey(Map<String, dynamic> data) {
    try {
      isLoading.toggle();
      Request request = Request(
        url: '${authController.getUnitId()}/survey_report',
        body: json.encode(data),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ${authController.getTokenProject()}'
        },
      );
      request.postPro().then((res) {
        if (res.statusCode == 200) {
          logger.v(res.statusCode);
          final da = json.decode(res.body);
          logger.v(da);
          getSurveyReport();
          isLoading.toggle();
          Get.back();
          showBotToastText('Berhasil');
        } else {
          logger.i(res.statusCode);
          isLoading.toggle();
          showBotToastText('Isian job summaries wajib diisi');
          print('Error ${res.statusCode}');
          final da = json.decode(res.body);
          logger.v(da);
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  void updateSurvey(Map<String, dynamic> data, int id) {
    try {
      Request request = Request(
        url: '${authController.getUnitId()}/survey_report/$id',
        body: json.encode(data),
        headers: {
          'content-type': 'application/json',
          'Authorization': 'Bearer ${authController.getTokenProject()}'
        },
      );
      request.postPro().then((res) {
        if (res.statusCode == 200) {
          logger.v(res.statusCode);
          final da = json.decode(res.body);
          logger.v(da);
          getSurveyReport();
          Get.back();
          showBotToastText('Berhasil');
        } else {
          logger.i(res.statusCode);
          showBotToastText('Error ${res.statusCode}');
          final da = json.decode(res.body);
          logger.v(da);
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  getPdf(int id) {
    try {
      isLoading.toggle();
      Request request = Request(
        url:
            '${authController.getUnitId()}/survey_report/download_pdf/$id?site_project_id=${authController.getCabangId()}',
        headers: {
          'Authorization': 'Bearer ${authController.getTokenProject()}'
        },
      );
      request.getPro().then((res) async {
        if (res.statusCode == 200) {
          final data = res.body;
          logger.v(data);
          isLoading.toggle();
          //showBotToastText(data);
          await openUrl(data);
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> openUrl(String url,
      {bool forceWebView = false, bool enableJavaScript = false}) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceWebView: forceWebView, enableJavaScript: enableJavaScript);
    } else {
      showBotToastText("This link isn't correct, please try again later");
    }
  }
}
