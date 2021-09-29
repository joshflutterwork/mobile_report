part of 'controllers.dart';

class UserController extends GetxController {
  final authController = Get.find<AuthController>();
  final Rx<UserModel> user = UserModel().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getUser();
    super.onInit();
  }

  void getUser() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'employee',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      request.get().then((res) {
        if (res.statusCode == 200) {
          logger.v(res.body);
          final data = jsonDecode(res.body)['data'];
          final value = UserModel.fromJson(data);
          if (value is UserModel) {
            user.update((val) {
              val!.job = value.job;
              val.id = value.id;
              val.name = value.name;
              val.phone = value.phone;
              val.email = value.email;
              val.gender = value.gender;
              val.address = value.address;
              val.joinDate = value.joinDate;
              val.birthday = value.birthday;
              val.reportTo = value.reportTo;
              val.employeeId = value.employeeId;
              val.departmnet = value.departmnet;
              val.image = value.image;
            });
          }
          isLoading.toggle();
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }

  TabController? tabController;
  bool showBS = false;

  void switchFab([bool? showBS]) {
    this.showBS = showBS ?? !this.showBS;
    update();
  }

  void setActiveTab(int index) {
    this.showBS = false;
    tabController!.index = index;
    update();
  }

  void setController(TabController controller) {
    tabController = controller;
  }
}
