part of '../controllers.dart';

class ServiceController extends GetxController {
  final authController = Get.find<AuthController>();
  RxList<ServicePicker> listService = <ServicePicker>[].obs;
  List<ServicePicker> _selectedJasa = [];
  List<ServicePicker> get selectedJasa => _selectedJasa;

  var more = true;
  var page = 1;
  RxBool isLoading = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    this.getService();
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (more == true && isLoading(true)) {
          print("reached service");
          page++;
          getService(page: page);
        }
      }
    });
  }

  addJasa(ServicePicker jasa) {
    _selectedJasa.add(jasa);
    update();
  }

  removeJasa(ServicePicker jasa) {
    _selectedJasa.remove(jasa);
  }

  void getService({int? page}) {
    try {
      isLoading.toggle();
      Request request = Request(
        url: '${authController.getUnitId()}/service/select2?search=&page=$page',
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
              (data as List).map((e) => ServicePicker.fromJson(e)).toList();
          if (v is List<ServicePicker>) {
            listService.addAll(v);
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
