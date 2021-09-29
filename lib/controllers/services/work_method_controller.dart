part of '../controllers.dart';

class WorkMethodController extends GetxController {
  final authController = Get.find<AuthController>();
  RxList<WorkMethodPicker> listWorkMethod = <WorkMethodPicker>[].obs;
  List<WorkMethodPicker> _selectedWorkMethod = [];
  List<WorkMethodPicker> get selectedWorkMethod => _selectedWorkMethod;
  var more = true;
  var page = 1;
  RxBool isLoading = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    this.getWorkMethod();
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (more == true && isLoading(true)) {
          print("reached WorkMethodPicker");
          page++;
          getWorkMethod(page: page);
        }
      }
    });
  }

  addWork(WorkMethodPicker work) {
    _selectedWorkMethod.add(work);
    update();
  }

  removeWork(WorkMethodPicker work) {
    _selectedWorkMethod.remove(work);
    update();
  }

  void getWorkMethod({int? page}) {
    try {
      isLoading.toggle();
      Request request = Request(
        url:
            '${authController.getUnitId()}/work_method/select2?search=&page=$page',
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
              (data as List).map((e) => WorkMethodPicker.fromJson(e)).toList();
          if (v is List<WorkMethodPicker>) {
            listWorkMethod.addAll(v);
            more = paginate;
            isLoading.toggle();
            print('page : $page');
            print('page : $paginate');
            if (paginate == false) {
              isLoading(false);
            }
          }
        }
        logger.i(res.statusCode);
        logger.v(res.body);
      });
    } catch (e) {
      logger.e(e);
    }
  }
}
