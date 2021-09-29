part of '../controllers.dart';

class LocationController extends GetxController {
  final authController = Get.find<AuthController>();
  RxList<LocationPicker> listLocation = <LocationPicker>[].obs;
  List<LocationPicker> _selectedLoc = [];
  List<LocationPicker> get selectedLoc => _selectedLoc;
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
          print("reached location_access");
          page++;
          getLocation(page: page);
        }
      }
    });
  }

  addLoc(LocationPicker loc) {
    _selectedLoc.add(loc);
    update();
  }

  removeLoc(LocationPicker loc) {
    _selectedLoc.remove(loc);
    update();
  }

  void getLocation({int? page}) {
    try {
      isLoading.toggle();

      Request request = Request(
        url:
            '${authController.getUnitId()}/location_access/select2?search=&page=$page',
        headers: {
          'Authorization': 'Bearer ${authController.getTokenProject()}'
        },
      );
      request.getPro().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['results'].cast<Map<String, dynamic>>();
          final paginate = jsonDecode(res.body)['pagination']['more'];
          final v =
              (data as List).map((e) => LocationPicker.fromJson(e)).toList();
          if (v is List<LocationPicker>) {
            listLocation.addAll(v);
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
