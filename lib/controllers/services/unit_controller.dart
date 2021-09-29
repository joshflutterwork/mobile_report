part of '../controllers.dart';

class UnitController extends GetxController {
  final authController = Get.find<AuthController>();
  RxList<UnitPrice> listAhs = <UnitPrice>[].obs;
  List<UnitPrice> _selectedAhs = [];
  List<UnitPrice> get selectedAhs => _selectedAhs;
  var more = true;
  var page = 1;
  RxBool isLoading = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    this.getLocation();
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (more == true && isLoading(true)) {
          print("reached unit_price");
          page++;
          getLocation(page: page);
        }
      }
    });
  }

  addLoc(UnitPrice loc) {
    _selectedAhs.add(loc);
    update();
  }

  removeLoc(UnitPrice loc) {
    _selectedAhs.remove(loc);
    update();
  }

  void getLocation({int? page}) {
    try {
      isLoading.toggle();
      Request request = Request(
        url:
            '${authController.getUnitId()}/unit_price/select2?search=&page=$page&site_project_id=${authController.getCabangId()}',
        headers: {
          'Authorization': 'Bearer ${authController.getTokenProject()}'
        },
      );
      request.getPro().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['results'].cast<Map<String, dynamic>>();
          final paginate = jsonDecode(res.body)['pagination']['more'];
          final v = (data as List).map((e) => UnitPrice.fromJson(e)).toList();
          if (v is List<UnitPrice>) {
            listAhs.addAll(v);
            more = paginate;
            isLoading.toggle();
            logger.v(data);
            print('page : $page');
            print('page : $paginate');
            if (paginate == false) {
              isLoading(false);
            }
          }
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }
}
