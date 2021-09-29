part of 'controllers.dart';

class CompanyController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<Profile> profile = Profile().obs;
  RxList<PolicyAnnoun> list = <PolicyAnnoun>[].obs;
  final authController = Get.find<AuthController>();

  getProfile() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'company',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body)['data'];
          final value = Profile.fromJson(data);
          if (value is Profile) {
            profile.update((val) {
              val!.desc = value.desc;
              val.image = value.image;
            });
          }
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }

  void fetchPolicy(bool isPolicy) async {
    try {
      list.clear();
      isLoading.toggle();
      Request request = Request(
          url: (isPolicy == true) ? 'policy' : 'announcement',
          headers: {
            'Authorization': 'Bearer ${authController.getTokenHRIS()}'
          });
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['data'].cast<Map<String, dynamic>>();
          logger.v(res.body);

          final value = (data as List)
              .map<PolicyAnnoun>((e) => PolicyAnnoun.fromJson(e))
              .toList();
          if (value is List<PolicyAnnoun>) {
            list.addAll(value);
          }
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }
}
