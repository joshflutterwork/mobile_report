part of 'models.dart';

List<IndexEmplyee> indexEmplyeeFromJson(String str) => List<IndexEmplyee>.from(
    json.decode(str).map((x) => IndexEmplyee.fromJson(x)));

class IndexEmplyee {
  IndexEmplyee({
    this.id,
    this.name,
    this.dateStart,
    this.dateEnd,
    this.type,
    this.status,
    this.reason,
  });

  int? id;
  String? name;
  DateTime? dateStart;
  DateTime? dateEnd;
  int? type;
  int? status;
  String? reason;

  factory IndexEmplyee.fromJson(Map<String, dynamic> json) => IndexEmplyee(
        id: json["id"],
        name: json["name"],
        dateStart: DateTime.parse(json["date_start"]),
        dateEnd:
            json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
        type: json["type"],
        status: json["status"],
        reason: json["reason"],
      );
}

GetEditCorrection getEditCorrectionFromJson(String str) =>
    GetEditCorrection.fromJson(json.decode(str));

class GetEditCorrection {
  GetEditCorrection({
    this.id,
    this.userId,
    this.dateStart,
    this.dateEnd,
    this.correctDetail,
  });

  int? id;
  int? userId;
  DateTime? dateStart;
  DateTime? dateEnd;
  List<CorrectDetail>? correctDetail;

  factory GetEditCorrection.fromJson(Map<String, dynamic> json) =>
      GetEditCorrection(
        id: json["id"],
        userId: json["user_id"],
        dateStart: DateTime.parse(json["date_start"]),
        dateEnd:
            json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
        correctDetail: List<CorrectDetail>.from(
            json["correct_detail"].map((x) => CorrectDetail.fromJson(x))),
      );
}

class CorrectDetail {
  CorrectDetail({
    this.id,
    this.correctId,
    this.attendanceId,
    this.hourIn,
    this.hourOut,
  });

  int? id;
  int? correctId;
  String? attendanceId;
  String? hourIn;
  String? hourOut;

  factory CorrectDetail.fromJson(Map<String, dynamic> json) => CorrectDetail(
        id: json["id"],
        correctId: json["correct_id"],
        attendanceId: json["attendance_id"],
        hourIn: json["hour_in"],
        hourOut: json["hour_out"],
      );
}

List<GetHour> getHourFromJson(String str) =>
    List<GetHour>.from(json.decode(str).map((x) => GetHour.fromJson(x)));

class GetHour {
  GetHour({
    this.id,
    this.hourIn,
    this.dateIn,
  });

  int? id;
  String? hourIn;
  DateTime? dateIn;

  factory GetHour.fromJson(Map<String, dynamic> json) => GetHour(
        id: json["id"],
        hourIn: json["hour_in"],
        dateIn: DateTime.parse(json["date_in"]),
      );
}

class ListEmployee {
  int? id;
  String? name;
  ListEmployee({this.id, this.name});
  factory ListEmployee.fromJson(Map<String, dynamic> json) =>
      ListEmployee(id: json["id"], name: json["name"]);
}

class EmployeeCorrection {
  int? id;
  String? name;
  String? dateStart;
  String? dateEnd;
  int? type;
  int? status;
  String? reason;
  EmployeeCorrection(
      {this.id,
      this.name,
      this.dateStart,
      this.dateEnd,
      this.type,
      this.status,
      this.reason});
  factory EmployeeCorrection.fromJson(Map<String, dynamic> json) =>
      EmployeeCorrection(
          id: json['id'],
          name: json['name'],
          dateStart: json['date_start'],
          dateEnd: json['date_end'],
          type: json['type'],
          status: json['status'],
          reason: json['reason']);
}

class CorrectionHour {
  int? id;
  String? hourIn;
  String? dateIn;
  CorrectionHour({this.id, this.hourIn, this.dateIn});
  factory CorrectionHour.fromJson(Map<String, dynamic> json) => CorrectionHour(
      id: json['id'], hourIn: json['hour_in'], dateIn: json['date_in']);
}

class CorrectionEdit {
  int? id;
  int? userId;
  DateTime? dateStart;
  DateTime? dateEnd;
  CorrectionEdit({this.id, this.userId, this.dateStart, this.dateEnd});
  factory CorrectionEdit.fromJson(Map<String, dynamic> json) => CorrectionEdit(
        id: json['data']['id'],
        userId: json['data']['user_id'],
        dateStart: DateTime.parse(json['data']['date_start']),
        dateEnd: DateTime.parse(json['data']['date_end']),
      );
}
