part of '../controllers.dart';

class WorkController extends GetxController {
  final authController = Get.find<AuthController>();
  RxList<WorkTypePicker> listWork = <WorkTypePicker>[].obs;
  List<WorkTypePicker> _selectedWork = [];
  List<WorkTypePicker> get selectedWork => _selectedWork;
  var more = true;
  var page = 1;
  RxBool isLoading = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    this.getWork();
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (more == true && isLoading(true)) {
          print("reached work");
          page++;
          getWork(page: page);
        }
      }
    });
  }

  addWork(WorkTypePicker work) {
    _selectedWork.add(work);
    update();
  }

  removeWork(WorkTypePicker work) {
    _selectedWork.remove(work);
    update();
  }

  void getWork({int? page}) {
    try {
      isLoading.toggle();
      Request request = Request(
        url:
            '${authController.getUnitId()}/work_type/select2?search=&page=$page',
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
              (data as List).map((e) => WorkTypePicker.fromJson(e)).toList();
          if (v is List<WorkTypePicker>) {
            listWork.addAll(v);
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
