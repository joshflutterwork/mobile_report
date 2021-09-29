part of '../controllers.dart';

class MaterialController extends GetxController {
  final authController = Get.find<AuthController>();
  RxList<MaterialPicker> listMaterial = <MaterialPicker>[].obs;
  List<MaterialPicker> _selectedMaterial = [];
  List<MaterialPicker> get selectedMaterial => _selectedMaterial;
  var more = true;
  var page = 1;
  RxBool isLoading = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    this.getMaterial();
    super.onInit();
    scrollController.addListener(() {
      if (
          //scrollController.position.extentBefore > 110
          scrollController.position.pixels ==
              scrollController.position.maxScrollExtent) {
        if (more == true && isLoading(true)) {
          print("reached getMaterial");
          page++;
          getMaterial(page: page);
        }
      }
    });
  }

  addMaterial(MaterialPicker work) {
    _selectedMaterial.add(work);
    update();
  }

  removeMaterial(MaterialPicker work) {
    _selectedMaterial.remove(work);
    update();
  }

  void getMaterial({int? page}) {
    try {
      isLoading.toggle();
      print('page : $page');

      Request request = Request(
        url:
            '${authController.getUnitId()}/material/select2?search=&page=$page&site_project_id=${authController.getCabangId()}',
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
              (data as List).map((e) => MaterialPicker.fromJson(e)).toList();
          if (v is List<MaterialPicker>) {
            listMaterial.addAll(v);
            more = paginate;
            isLoading.toggle();
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
