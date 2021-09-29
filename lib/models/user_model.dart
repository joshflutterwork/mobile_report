part of 'models.dart';

class UserModel {
  int? id;
  String? name;
  String? departmnet;
  String? job;
  String? employeeId;
  String? joinDate;
  String? phone;
  String? email;
  String? birthday;
  String? address;
  String? gender;
  String? reportTo;
  String? image;
  UserModel(
      {this.id,
      this.name,
      this.departmnet,
      this.job,
      this.employeeId,
      this.joinDate,
      this.phone,
      this.email,
      this.birthday,
      this.address,
      this.gender,
      this.reportTo,
      this.image});
  factory UserModel.fromJson(Map<String, dynamic> object) {
    return UserModel(
      id: object["id"],
      name: object["name"],
      departmnet: object["department"],
      job: object["job"],
      employeeId: object["employee_id"],
      joinDate: object["join_date"],
      phone: object["phone"],
      email: object["email"],
      birthday: object["birthday"],
      address: object["address"],
      gender: object["gender"],
      reportTo: object["reports_to"],
      image: object["profile_picture"],
    );
  }
}

class Personal {
  String? nik;
  String? simA;
  String? simC;
  String? npwp;
  Personal({
    this.nik,
    this.simA,
    this.simC,
    this.npwp,
  });
  factory Personal.fromJson(Map<String, dynamic> object) {
    return Personal(
      nik: object["nik"],
      simA: object["sim_a"],
      simC: object["sim_c"],
      npwp: object["npwp"],
    );
  }
}

class Document {
  String? ijazah;
  String? ktp;
  String? kk;
  String? sim;
  String? nikah;
  String? akta;
  String? sertifikat;
  Document(
      {this.ijazah,
      this.ktp,
      this.kk,
      this.sim,
      this.nikah,
      this.akta,
      this.sertifikat});
  factory Document.fromJson(Map<String, dynamic> object) {
    return Document(
      ijazah: object["ijazah"],
      akta: object["akta"],
      kk: object["kk"],
      sim: object["sim"],
      ktp: object["ktp"],
      nikah: object["nikah"],
      sertifikat: object["sertifikat"],
    );
  }
}

class Emergency {
  String? nameAddress;
  String? phone;
  Emergency({this.nameAddress, this.phone});
  factory Emergency.fromJson(Map<String, dynamic> object) {
    return Emergency(
      nameAddress: object["name_address"],
      phone: object["phone"],
    );
  }
}

class Spouse {
  String? husband;
  String? wife;
  List<String>? children;
  Spouse({this.husband, this.wife, this.children});
  factory Spouse.fromJson(Map<String, dynamic> object) {
    return Spouse(
      husband: object["husband"],
      wife: object["wife"],
      children: List<String>.from(object["children"].map((x) => x)),
    );
  }
}

class Education {
  int? id;
  String? level;
  String? name;
  String? speciality;
  int? dateIn;
  int? dateOut;
  Education(
      {this.id,
      this.level,
      this.name,
      this.speciality,
      this.dateIn,
      this.dateOut});
  factory Education.fromJson(Map<String, dynamic> json) {
    return Education(
      id: json["id"],
      level: json["level"],
      name: json["name"],
      speciality: json["speciality"],
      dateIn: json["date_in"],
      dateOut: json["date_out"],
    );
  }
}

class Experience {
  int? id;
  String? company;
  String? jobDesc;
  String? dateIn;
  String? dateOut;
  Experience({this.id, this.company, this.jobDesc, this.dateIn, this.dateOut});
  factory Experience.fromJson(Map<String, dynamic> json) {
    return Experience(
      id: json["id"],
      company: json["company"],
      jobDesc: json["job_desc"],
      dateIn: json["date_in"],
      dateOut: json["date_out"],
    );
  }
}

class Language {
  int? id;
  String? language;
  String? reading;
  String? writing;
  String? speaking;
  String? understanding;
  Language(
      {this.id,
      this.language,
      this.reading,
      this.speaking,
      this.understanding,
      this.writing});
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      id: json["id"],
      language: json["language"],
      reading: json["reading"],
      speaking: json["speaking"],
      writing: json["writing"],
      understanding: json["understanding"],
    );
  }
}

class Course {
  int? id;
  String? title;
  String? committee;
  String? dateIn;
  String? longTime;
  Course({this.id, this.title, this.committee, this.dateIn, this.longTime});
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json["id"],
      committee: json["committee"],
      dateIn: json["date_in"],
      longTime: json["long_time"],
      title: json["title"],
    );
  }
}

class Desease {
  int? id;
  String? name;
  String? deseaseType;
  String? relationship;
  int? treatedYear;
  String? place;
  Desease(
      {this.id,
      this.name,
      this.deseaseType,
      this.relationship,
      this.treatedYear,
      this.place});
  factory Desease.fromJson(Map<String, dynamic> json) => Desease(
        id: json["id"],
        name: json["name"],
        deseaseType: json["desease_type"],
        relationship: json["relationship"],
        treatedYear: json["treated_year"],
        place: json["place"],
      );
}
