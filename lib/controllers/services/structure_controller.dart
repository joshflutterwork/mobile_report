part of '../controllers.dart';

class StructureController extends GetxController {
  final authController = Get.find<AuthController>();
  RxList<StructureCondition> list = <StructureCondition>[].obs;
  List<StructureCondition> _selected = [];
  List<StructureCondition> get selectedStructure => _selected;
  var more = true;
  var page = 1;
  RxBool isLoading = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    this.getStructure();
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (more == true && isLoading(true)) {
          print("reached Wall");
          page++;
          getStructure(page: page);
        }
      }
    });
  }

  add(StructureCondition loc) {
    _selected.add(loc);
    update();
  }

  remove(StructureCondition loc) {
    _selected.remove(loc);
    update();
  }

  void getStructure({int? page}) {
    isLoading.toggle();

    try {
      print('o====o ${authController.getUnitId()}');
      Request request = Request(
        url:
            '${authController.getUnitId()}/structure_condition/select2?search=&page=$page',
        headers: {
          'Authorization': 'Bearer ${authController.getTokenProject()}'
        },
      );
      request.getPro().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['results'].cast<Map<String, dynamic>>();
          final paginate = jsonDecode(res.body)['pagination']['more'];
          final v = (data as List)
              .map((e) => StructureCondition.fromJson(e))
              .toList();
          if (v is List<StructureCondition>) {
            list.addAll(v);
            logger.v(data);
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
