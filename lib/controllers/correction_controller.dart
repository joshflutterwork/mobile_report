part of 'controllers.dart';

class CorrectionController extends GetxController {
  final RxList<IndexEmplyee> employeeList = <IndexEmplyee>[].obs;
  final RxList<GetHour> hourList = <GetHour>[].obs;
  final Rx<GetEditCorrection> getEdited = GetEditCorrection().obs;

  final search = TextEditingController();
  final reason = TextEditingController();
  var isLoading = false.obs;
  var isTyping = false.obs;
  var searchText = "".obs;

  @override
  void onInit() {
    fetchCorrection();
    search.addListener(() {
      searchText = search.text.obs;
      search.text.length != 0 ? isTyping(true) : isTyping(false);
    });
    super.onInit();
  }

  void onTyping() {
    isTyping(false);
    search.clear();
    employeeList.clear();
    fetchCorrection();
  }

  void onSearch(searchText) async {
    employeeList.clear();
    fetchCorrection(name: searchText);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<int?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }

  void checkAbsen(String date) async {
    try {
      hourList.clear();
      isLoading(true);
      String? token = await getToken();
      int? userId = await getId();
      Request request = Request(
        url: 'correction-hour/$userId/$date',
        headers: {'Authorization': 'Bearer $token'},
      );
      await request.get().then((res) {
        final data = jsonDecode(res.body)['data'].cast<Map<String, dynamic>>();
        if (res.statusCode == 200) {
          final value = (data as List).map((e) => GetHour.fromJson(e)).toList();
          if (value is List<GetHour>) {
            hourList.addAll(value);
          }
        }
      });
    } finally {
      isLoading(false);
    }
  }

  void fetchCorrection({String? name}) async {
    try {
      employeeList.clear();
      isLoading(true);
      String? token = await getToken();
      Request request = Request(
        url: 'correction/list-karyawan-employee?name=$name',
        headers: {'Authorization': 'Bearer $token'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['data'].cast<Map<String, dynamic>>();
          final value =
              (data as List).map((e) => IndexEmplyee.fromJson(e)).toList();
          if (value is List<IndexEmplyee>) {
            employeeList.addAll(value);
          }
        }
      });
    } catch (e) {
      print(e);
    } finally {
      isLoading(false);
    }
  }

  Future<bool> addCorrection(String dateStart, String dateEnd, int type,
      {String? attendanceId,
      String? hourIn,
      String? hourOut,
      String? reasonCT,
      bool isUpdate = false,
      int? id}) async {
    isLoading(true);
    String? token = await getToken();
    int? userId = await getId();
    Request request = Request(
      url: (isUpdate) ? 'correction/update/$id' : 'correction/store-employee',
      body: type == 0
          ? {
              'date_start': dateStart,
              'date_end': dateEnd,
              'type': '$type',
              'reason': (isUpdate) ? reasonCT : reason.text,
              'user_id': '$userId',
            }
          : {
              'date_start': dateStart,
              'type': '$type',
              'reason': (isUpdate) ? reasonCT : reason.text,
              'user_id': '$userId',
              'correct_details[attendance_id]': attendanceId,
              'correct_details[hour_in]': hourIn,
              'correct_details[hour_out]': hourOut,
            },
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    await request.post().then((res) {
      if (res.statusCode == 200) {
        employeeList.clear();
        isLoading(false);
        Get.back();
        showBotToastText(
            '${(isUpdate) ? 'Edit data' : 'Tambah data'} berhasil');
        fetchCorrection();
        return true;
      }
      showBotToastText('${(isUpdate) ? 'Edit data' : 'Tambah data'} gagal');
      isLoading(false);
    });
    return false;
  }

  void deleteCorrection(int id) async {
    try {
      isLoading(true);
      String? token = await getToken();
      Request request = Request(
        url: 'correction/delete/$id',
        headers: {'Authorization': 'Bearer $token'},
      );
      await request.post().then((res) {
        if (res.statusCode == 200) {
          employeeList.clear();
          isLoading(false);
          showBotToastText('Data berhasil dihapus');
          fetchCorrection();
        }
      });
    } catch (e) {
      print("delete: $e");
    } finally {
      isLoading(false);
    }
  }

  void getEdit(int id) async {
    try {
      isLoading(true);
      String? token = await getToken();
      Request request = Request(
        url: 'correction/edit/$id',
        headers: {'Authorization': 'Bearer $token'},
      );
      request.get().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body)['data'];
          final value = GetEditCorrection.fromJson(data);
          if (value is GetEditCorrection) {
            getEdited.update((val) {
              val!.id = value.id;
              val.dateStart = value.dateStart;
              val.dateEnd = value.dateEnd;
              val.userId = value.userId;
              val.correctDetail = value.correctDetail;
            });
          }
        }
      });
    } finally {
      isLoading(false);
    }
  }
}
