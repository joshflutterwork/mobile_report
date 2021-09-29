part of '../controllers.dart';

class FootprintController extends GetxController {
  final authController = Get.find<AuthController>();
  RxList<FootprintCircumstance> listFootprint = <FootprintCircumstance>[].obs;
  List<FootprintCircumstance> _selected = [];
  List<FootprintCircumstance> get selected => _selected;
  var more = true;
  var page = 1;
  RxBool isLoading = false.obs;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    this.getFootprint();
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (more == true && isLoading(true)) {
          print("reached location_access");
          page++;
          getFootprint(page: page);
        }
      }
    });
  }

  add(FootprintCircumstance loc) {
    _selected.add(loc);
    update();
  }

  remove(FootprintCircumstance loc) {
    _selected.remove(loc);
    update();
  }

  void getFootprint({int? page}) {
    try {
      isLoading.toggle();
      Request request = Request(
        url:
            '${authController.getUnitId()}/footprint_circumstance/select2?search=&page=$page',
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
              .map((e) => FootprintCircumstance.fromJson(e))
              .toList();
          if (v is List<FootprintCircumstance>) {
            listFootprint.addAll(v);
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
