part of 'providers.dart';

class LeaveProvider extends ChangeNotifier {
  List<MonthlyActivity> _absen = [];
  List<MonthlyActivity> get dataAbsensi => _absen;

  Future<List<MonthlyActivity>> getAbsensi(
      context, String year, String month) async {
    String url =
        API_URL + "/mob/attendance/monthly-activity?year=$year&month=$month";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _absen = result
          .map<MonthlyActivity>((json) => MonthlyActivity.fromJson(json))
          .toList();
      return _absen;
    } else {
      throw Exception();
    }
  }

  List<LeaveRequest> _data = [];
  List<LeaveRequest> get dataLeaves => _data;

  Future<List<LeaveRequest>> getLeaves(context) async {
    final url = API_URL + "/mob/leaves/requests";
    final token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result
          .map<LeaveRequest>((json) => LeaveRequest.fromJson(json))
          .toList();
      print(response.statusCode);
      print(result);
      return _data;
    } else {
      throw Exception();
    }
  }

  Future<bool> storeLeave(context, Map data) async {
    final url = API_URL + "/mob/leaves/store";
    final token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final response =
        await http.post(Uri.parse(url), body: json.encode(data), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['response'] == 'success') {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> updateLeave(context, Map data) async {
    final url = API_URL + "/mob/leaves/update";
    final token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final response =
        await http.post(Uri.parse(url), body: json.encode(data), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['response'] == 'success') {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> deleteLeave(context, String id) async {
    String url = API_URL + "/mob/leaves/delete";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final response = await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      "id": id
    });
    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['response'] == 'success') {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> statusLeave(context, int id, String type) async {
    String url = API_URL + "/mob/leave-admin/update-status/$id";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final response = await http.post(Uri.parse(url),
        body: {"status": "$type"}, headers: {'Authorization': 'Bearer $token'});
    // final result = json.decode(response.body);
    if (response.statusCode == 200) {
      notifyListeners();
      return true;
    }
    return false;
  }

  List<EmployeeCorrection>? _dataCorrection = [];
  List<EmployeeCorrection>? get dataCorrection => _dataCorrection;

  Future<List<EmployeeCorrection>> getEmployeeCorrection(context, String name,
      {String? status}) async {
    final url = API_URL + "/mob/correction/list?status=$status&name=$name";
    final token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _dataCorrection = result
          .map<EmployeeCorrection>((json) => EmployeeCorrection.fromJson(json))
          .toList();
      return _dataCorrection!;
    } else {
      throw Exception();
    }
  }

  List<ListEmployee> _dataListEmployee = [];
  List<ListEmployee> get dataListEmployee => _dataListEmployee;

  Future<List<ListEmployee>> getListEmployee(context) async {
    final url = API_URL + "/mob/correction/list-karyawan";
    final token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _dataListEmployee = result
          .map<ListEmployee>((json) => ListEmployee.fromJson(json))
          .toList();
      return _dataListEmployee;
    } else {
      throw Exception();
    }
  }

  Future<bool> storeCorrection(
      context, Map dataTelat, Map dataAbsen, String type) async {
    final url = API_URL + "/mob/correction/store";
    final token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final response = await http.post(Uri.parse(url),
        body: json.encode((type == 'Telat') ? dataTelat : dataAbsen),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['response'] == 'success') {
      notifyListeners();
      return true;
    }
    print(result);
    return false;
  }

  Future<bool> updateCorrection(
      context, Map editTelat, Map editAbsen, String type, int id) async {
    final url = API_URL + "/mob/correction/update/$id";
    final token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final response = await http.post(Uri.parse(url),
        body: json.encode((type == 'Telat') ? editTelat : editAbsen),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        });
    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['response'] == 'success') {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> deleteCorrection(context, int id) async {
    String url = API_URL + "/mob/correction/delete/$id";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final response = await http
        .post(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['response'] == 'success') {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> statusCorrection(context, int id, String urlStatus,
      {int? status}) async {
    String url = API_URL + "/mob/correction/$urlStatus-update/$id";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final response = await http.post(Uri.parse(url),
        body: {"status": "$status"},
        headers: {'Authorization': 'Bearer $token'});
    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['response'] == 'success') {
      notifyListeners();
      return true;
    }
    return false;
  }

  List<CorrectionHour>? _dataAbsen = [];
  List<CorrectionHour>? get dataAbsen => _dataAbsen;

  Future<List<CorrectionHour>> getAbsenHour(
      context, int id, String date) async {
    final url = API_URL + "/mob/correction-hour/$id/$date";
    final token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    final response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      final result =
          json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      print(result);
      _dataAbsen = result
          .map<CorrectionHour>((json) => CorrectionHour.fromJson(json))
          .toList();
      return _dataAbsen!;
    } else {
      throw Exception();
    }
  }
}
