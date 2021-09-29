part of 'services.dart';

class AttendanceService {
////GET
  static Future<List<LeaveListAccess>> getLeaveListAccess(context) async {
    List<LeaveListAccess>? list;
    String url = API_URL + "/mob/leaves/list-access";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data["data"] as List;
      list = rest
          .map<LeaveListAccess>((json) => LeaveListAccess.fromJson(json))
          .toList();
    }
    return list!;
  }

  static Future<List<LeaveRequest>> getLeaveRequest(context) async {
    List<LeaveRequest>? list;
    String url = API_URL + "/mob/leaves/requests";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data["data"] as List;
      list = rest
          .map<LeaveRequest>((json) => LeaveRequest.fromJson(json))
          .toList();
    }
    return list!;
  }

  static Future<List<MyLeaves>> getMyLeaves(context) async {
    List<MyLeaves>? list;
    String url = API_URL + "/mob/leaves/my-leaves";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data["data"] as List;
      list = rest.map<MyLeaves>((json) => MyLeaves.fromJson(json)).toList();
    }
    return list!;
  }

  static Future<List<MonthlyActivity>> getMonthlyActivity(context,
      {String? year, String? month}) async {
    String selectedMonth = (month == 'January')
        ? '01'
        : (month == 'February')
            ? '02'
            : (month == 'March')
                ? '03'
                : (month == 'April')
                    ? '04'
                    : (month == 'May')
                        ? '05'
                        : (month == 'June')
                            ? '06'
                            : (month == 'July')
                                ? '07'
                                : (month == 'August')
                                    ? '08'
                                    : (month == 'September')
                                        ? '09'
                                        : (month == 'October')
                                            ? '10'
                                            : (month == 'November')
                                                ? '11'
                                                : (month == 'December')
                                                    ? '12'
                                                    : '0';
    List<MonthlyActivity>? list;
    String url = API_URL +
        "/mob/attendance/monthly-activity?year=$year&month=$selectedMonth";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data["data"] as List;
      list = rest
          .map<MonthlyActivity>((json) => MonthlyActivity.fromJson(json))
          .toList();
    }
    return list!;
  }

  static Future<List<LeaveAdminModel>> getFilterLeave(context,
      {String name = '',
      String leaveId = '',
      String status = '',
      String from = '',
      String to = ''}) async {
    List<LeaveAdminModel>? list;
    String url = API_URL +
        '/mob/leave-admin?name=$name&leave_id=$leaveId&status=$status&from=$from&to=$to';
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    var response = await http.get(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    });
    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      var rest = data["data"] as List;
      list = rest
          .map<LeaveAdminModel>((json) => LeaveAdminModel.fromJson(json))
          .toList();
    }
    return list!;
  }

  static Future<EditMyLeave> getEditMyLeave(context, int id) async {
    Future<EditMyLeave>? data;
    String url = API_URL + "/mob/leaves/edit/$id";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      return EditMyLeave.fromJson(jsonObject["data"]);
    }
    return data!;
  }

  static Future<StatusLeaveAdmin> getStatusLeaveAdmin(context) async {
    Future<StatusLeaveAdmin>? data;
    String url = API_URL + "/mob/leave-admin/status";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      return StatusLeaveAdmin.fromJson(jsonObject["data"]);
    }
    return data!;
  }

  static Future updateStatus(context, String status) async {
    String url = API_URL + "/mob/leave-admin/status";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      "status": status
    }).then((value) {
      print(value.statusCode);
      print(value.body);
    });
  }

  static Future deleteLeave(context, int id) async {
    String url = API_URL + "/mob/leaves/delete";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    await http.post(Uri.parse(url), headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    }, body: {
      "id": id
    }).then((value) {
      print(value.statusCode);
      print(value.body);
    });
  }

  static Future getEditCorrec(context, int id) async {
    String url = API_URL + "/mob/correction/edit/$id";
    String? token =
        await Provider.of<AuthProvider>(context, listen: false).getToken();
    var response = await http
        .get(Uri.parse(url), headers: {'Authorization': 'Bearer $token'});
    if (response.statusCode == 200) {
      var jsonObject = json.decode(response.body);
      return CorrectionEdit.fromJson(jsonObject);
    }
    return null;
  }
}
