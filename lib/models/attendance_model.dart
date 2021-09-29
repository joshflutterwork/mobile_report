part of 'models.dart';

class TodayActivity {
  String? dateTime;
  String? type;
  TodayActivity({this.dateTime, this.type});
  factory TodayActivity.fromJson(Map<String, dynamic> json) =>
      TodayActivity(dateTime: json["Date Time"], type: json["Type"]);
}

class LeaveListAccess {
  String? name;
  var days;
  LeaveListAccess({this.name, this.days});
  factory LeaveListAccess.fromJson(Map<String, dynamic> json) =>
      LeaveListAccess(name: json["name"], days: json["days"]);
}

class MyLeaves {
  int? id;
  String? name;
  MyLeaves({this.id, this.name});
  factory MyLeaves.fromJson(Map<String, dynamic> json) =>
      MyLeaves(id: json["id"], name: json["name"]);
}

class EditMyLeave {
  int? leaveId;
  DateTime? from;
  DateTime? to;
  String? days;
  String? reason;
  EditMyLeave({this.leaveId, this.from, this.to, this.days, this.reason});
  factory EditMyLeave.fromJson(Map<String, dynamic> json) => EditMyLeave(
      leaveId: json["leave_id"],
      from: json["from"] == null
          ? null
          : DateFormat("dd/MM/yyyy").parse(json["from"]),
      to: json["to"] == null
          ? null
          : DateFormat("dd/MM/yyyy").parse(json["to"]),
      days: json["days"],
      reason: json["reason"]);
}

class StatusLeaveAdmin {
  String? today;
  int? planned;
  int? unPlanned;
  int? pendding;
  StatusLeaveAdmin({this.today, this.planned, this.unPlanned, this.pendding});
  factory StatusLeaveAdmin.fromJson(Map<String, dynamic> json) =>
      StatusLeaveAdmin(
          today: json["today_presents"],
          planned: json["planned_leaves"],
          unPlanned: json["unplanned_leaves"],
          pendding: json["pending_requests"]);
}

class LeaveRequest {
  int? id;
  String? name;
  String? from;
  String? to;
  String? noOfDays;
  String? reason;
  String? status;
  String? approvedBy;
  LeaveRequest(
      {this.id,
      this.name,
      this.from,
      this.to,
      this.noOfDays,
      this.reason,
      this.status,
      this.approvedBy});
  factory LeaveRequest.fromJson(Map<String, dynamic> json) => LeaveRequest(
      id: json["id"],
      name: json["name"],
      from: json["from"],
      to: json["to"],
      noOfDays: json["no_of_days"],
      reason: json["reason"],
      status: json["status"],
      approvedBy: json["approved_by"]);
}

class MonthlyActivity {
  String? date;
  String? nik;
  String? name;
  String? punchIn;
  String? punchOut;
  bool? holiday;
  MonthlyActivity(
      {this.date,
      this.nik,
      this.name,
      this.punchIn,
      this.punchOut,
      this.holiday});
  factory MonthlyActivity.fromJson(Map<String, dynamic> json) =>
      MonthlyActivity(
        date: json["date"],
        nik: json["nik"],
        name: json["name"],
        punchIn: json["punchIn"],
        punchOut: json["punchOut"],
        holiday: json["holiday"],
      );
}

class LeaveAdminModel {
  int? id;
  String? name;
  String? image;
  String? leave;
  String? from;
  String? to;
  String? days;
  String? reason;
  String? status;
  LeaveAdminModel(
      {this.name,
      this.id,
      this.image,
      this.leave,
      this.from,
      this.to,
      this.days,
      this.reason,
      this.status});
  factory LeaveAdminModel.fromJson(Map<String, dynamic> json) =>
      LeaveAdminModel(
          id: json["id"],
          name: json["employee"]["name"],
          image: json["employee"]["image"],
          leave: json["leave"],
          from: json["from"],
          to: json["to"],
          days: json["days"],
          reason: json["reason"],
          status: json["status"]);
}
