part of '../controllers.dart';

class RoadController extends GetxController {
  final authController = Get.find<AuthController>();
  RxList<AccessRoad> listRoad = <AccessRoad>[].obs;
  List<AccessRoad> _selectedRoad = [];
  List<AccessRoad> get selectedRoad => _selectedRoad;
  var more = true;
  var page = 1;
  RxBool isLoading = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    this.getRoad();
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (more == true && isLoading(true)) {
          print("reached getRoad");
          page++;
          getRoad(page: page);
        }
      }
    });
  }

  addRoad(AccessRoad road) {
    _selectedRoad.add(road);
    update();
  }

  removeRoad(AccessRoad road) {
    _selectedRoad.remove(road);
    update();
  }

  void getRoad({int? page}) {
    try {
      isLoading.toggle();

      Request request = Request(
        url:
            '${authController.getUnitId()}/access_road/select2?search=&page=$page',
        headers: {
          'Authorization': 'Bearer ${authController.getTokenProject()}'
        },
      );
      request.getPro().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['results'].cast<Map<String, dynamic>>();
          final paginate = jsonDecode(res.body)['pagination']['more'];
          final v = (data as List).map((e) => AccessRoad.fromJson(e)).toList();
          if (v is List<AccessRoad>) {
            listRoad.addAll(v);
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
