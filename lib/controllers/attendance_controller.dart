part of 'controllers.dart';

class AttendanceController extends GetxController {
  final authController = Get.find<AuthController>();
  RxList<MonthlyActivity> absensi = <MonthlyActivity>[].obs;
  RxList<TodayActivity> todayActivity = <TodayActivity>[].obs;
  var currentMonth = Jiffy().month;
  var currentYear = Jiffy().year;
  var currentDate = Jiffy().yMMMMd;
  var currentDay = Jiffy().yMMMMEEEEdjm;
  var isLoading = false.obs;

  @override
  void onInit() {
    getAbsensi('$currentYear', '$currentMonth');
    getTodayActivity();
    super.onInit();
  }

  getAbsensi(String year, String month) async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'attendance/monthly-activity?year=$year&month=$month',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['data'].cast<Map<String, dynamic>>();
          final value =
              (data as List).map((e) => MonthlyActivity.fromJson(e)).toList();
          if (value is List<MonthlyActivity>) {
            absensi.addAll(value);
          }
        }
      });
    } catch (e) {
      logger.e(e);
    } finally {
      isLoading.toggle();
    }
  }

  getTodayActivity() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'attendance/today-activity',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['data'].cast<Map<String, dynamic>>();
          final value =
              (data as List).map((e) => TodayActivity.fromJson(e)).toList();
          if (value is List<TodayActivity>) {
            todayActivity.addAll(value);
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
