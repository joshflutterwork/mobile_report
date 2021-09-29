part of 'models.dart';

class Salary {
  int? id;
  String? emlopyee;
  String? role;
  String? email;
  String? cofirm;
  String? total;
  String? slip;
  Salary(
      {this.id,
      this.emlopyee,
      this.role,
      this.email,
      this.cofirm,
      this.total,
      this.slip});
  factory Salary.fromJson(Map<String, dynamic> json) => Salary(
      id: json["id"],
      emlopyee: json["employee"],
      role: json["role"],
      email: json["email"],
      cofirm: json["cofirm"],
      total: json["total"],
      slip: json["slip"]);
}

class DetailSalary {
  int? idGaji;
  String? nama;
  String? nik;
  String? jabatan;
  String? bulan;
  int? tahun;
  String? gajiBersih;
  String? terbilang;
  List<Penerimaan>? penerimaan;
  List<Pengurangan>? pengurangan;
  List<DetailPotonganAbsen>? detailPotonganAbsen;
  List<DetailPotonganTelat>? detailPotonganTelat;
  List<DetailPotonganKasbon>? detailPotonganKasbon;
  DetailSalary(
      {this.idGaji,
      this.nama,
      this.nik,
      this.jabatan,
      this.bulan,
      this.tahun,
      this.gajiBersih,
      this.terbilang,
      this.penerimaan,
      this.pengurangan,
      this.detailPotonganAbsen,
      this.detailPotonganTelat,
      this.detailPotonganKasbon});
  factory DetailSalary.fromJson(Map<String, dynamic> json) => DetailSalary(
        idGaji: json["id_gaji"],
        nama: json["nama"],
        nik: json["nik"],
        jabatan: json["jabatan"],
        bulan: json["bulan"],
        tahun: json["tahun"],
        gajiBersih: json["gaji_bersih"],
        terbilang: json["terbilang"],
        penerimaan: (json["penerimaan"] as List)
            .map((e) => Penerimaan.fromJson(e))
            .toList(),
        pengurangan: (json["pengurangan"] as List)
            .map((e) => Pengurangan.fromJson(e))
            .toList(),
        detailPotonganAbsen: (json["detail_potongan_absen"] as List)
            .map((e) => DetailPotonganAbsen.fromJson(e))
            .toList(),
        detailPotonganTelat: (json["detail_potongan_telat"] as List)
            .map((e) => DetailPotonganTelat.fromJson(e))
            .toList(),
        detailPotonganKasbon: (json["detail_potongan_kasbon"] as List)
            .map((e) => DetailPotonganKasbon.fromJson(e))
            .toList(),
      );
}

class Penerimaan {
  String? name;
  int? total;
  Penerimaan({this.name, this.total});
  factory Penerimaan.fromJson(Map<String, dynamic> json) => Penerimaan(
        name: json["name"],
        total: json["total"],
      );
}

class Pengurangan {
  String? name;
  int? total;
  Pengurangan({this.name, this.total});
  factory Pengurangan.fromJson(Map<String, dynamic> json) => Pengurangan(
        name: json["name"],
        total: json["total"],
      );
}

class DetailPotonganAbsen {
  int? denda;
  String? date;

  DetailPotonganAbsen({this.denda, this.date});
  factory DetailPotonganAbsen.fromJson(Map<String, dynamic> json) =>
      DetailPotonganAbsen(
        date: json["tanggal_absent"],
        denda: json["denda"],
      );
}

class DetailPotonganTelat {
  int? denda;
  String? date;
  int? jamTelat;

  DetailPotonganTelat({this.denda, this.date, this.jamTelat});
  factory DetailPotonganTelat.fromJson(Map<String, dynamic> json) =>
      DetailPotonganTelat(
        date: json["tanggal_absent"],
        denda: json["denda"],
        jamTelat: json["jam_telat"],
      );
}

class DetailPotonganKasbon {
  int? id;
  String? date;
  int? amount;
  DetailPotonganKasbon({this.id, this.date, this.amount});
  factory DetailPotonganKasbon.fromJson(Map<String, dynamic> json) =>
      DetailPotonganKasbon(
        id: json["id"],
        date: json["date"],
        amount: json["amount"],
      );
}
