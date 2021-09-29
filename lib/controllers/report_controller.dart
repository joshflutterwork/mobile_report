part of 'controllers.dart';

//work report controller
class ReportController extends GetxController {
  final authController = Get.find<AuthController>();
  final Rx<IndexWorkReport> indexSurvey = IndexWorkReport().obs;

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
    this.getWorkReport();
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
          getWorkReport(page: pages);
        }
      }
    });
  }

  void getWorkReport({int? page, String? search}) async {
    try {
      print(authController.getCabangId() + "cabang id");
      isLoading.toggle();
      Request request = Request(
        url:
            //'${authController.getUnitId()}
            '1/work_report?search=$search&page=$page&site_project_id=',
        //${authController.getCabangId()}',
        headers: {
          'Authorization': 'Bearer ${authController.getTokenProject()}'
        },
      );
      request.getPro().then((res) {
        logger.i(res.statusCode);
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          final value = IndexWorkReport.fromJson(data);
          logger.v(data);
          if (value is IndexWorkReport) {
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
}
