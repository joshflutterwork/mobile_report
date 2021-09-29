part of '../controllers.dart';

class LandController extends GetxController {
  final authController = Get.find<AuthController>();
  RxList<LandContour> listLand = <LandContour>[].obs;
  List<LandContour> _selectedLand = [];
  List<LandContour> get selectedLand => _selectedLand;
  var more = true;
  var page = 1;
  RxBool isLoading = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    this.getLand();
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (more == true && isLoading(true)) {
          print("reached land");
          page++;
          getLand(page: page);
        }
      }
    });
  }

  addLand(LandContour loc) {
    _selectedLand.add(loc);
    update();
  }

  removeLand(LandContour loc) {
    _selectedLand.remove(loc);
    update();
  }

  void getLand({int? page}) {
    isLoading.toggle();

    try {
      Request request = Request(
        url:
            '${authController.getUnitId()}/land_contour/select2?search=&page=$page',
        headers: {
          'Authorization': 'Bearer ${authController.getTokenProject()}'
        },
      );
      request.getPro().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['results'].cast<Map<String, dynamic>>();
          final paginate = jsonDecode(res.body)['pagination']['more'];
          final v = (data as List).map((e) => LandContour.fromJson(e)).toList();
          if (v is List<LandContour>) {
            listLand.addAll(v);
            more = paginate;
            isLoading.toggle();
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
