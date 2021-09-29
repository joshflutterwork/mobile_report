part of 'controllers.dart';

class LeaveController extends GetxController {
  final authController = Get.find<AuthController>();
  RxList<LeaveRequest> leave = <LeaveRequest>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getLeaves();
    super.onInit();
  }

  getLeaves() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'leaves/requests',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['data'].cast<Map<String, dynamic>>();
          final value =
              (data as List).map((e) => LeaveRequest.fromJson(e)).toList();
          if (value is List<LeaveRequest>) {
            leave.addAll(value);
          }
          logger.v(data);
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }
}
