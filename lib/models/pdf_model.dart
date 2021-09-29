import 'package:keluarga_bintoro/models/models.dart';

class Customer {
  final String? name;
  final String? address;
  final String? nik;

  const Customer({
    this.name,
    this.address,
    this.nik,
  });
}

class Supplier {
  final String? name;
  final String? address;
  final String? paymentInfo;

  const Supplier({
    this.name,
    this.address,
    this.paymentInfo,
  });
}

class Invoice {
  final Supplier? supplier;
  final Customer? customer;
  final String? month;
  final int? year;
  final Address? address;
  final int? id;
  final String? netSalary;
  final String? terbilang;
  final List<Penerimaan>? penerimaan;
  final List<Pengurangan>? pengurangan;
  final List<DetailPotonganAbsen>? detailPotonganAbsen;
  final List<DetailPotonganTelat>? detailPotonganTelat;
  final List<DetailPotonganKasbon>? detailPotonganKasbon;

  const Invoice({
    this.supplier,
    this.customer,
    this.month,
    this.year,
    this.address,
    this.id,
    this.netSalary,
    this.terbilang,
    this.penerimaan,
    this.pengurangan,
    this.detailPotonganAbsen,
    this.detailPotonganTelat,
    this.detailPotonganKasbon,
  });
}

class Address {
  final String? street;
  final String? kab;
  final String? prov;
  const Address({
    this.street,
    this.kab,
    this.prov,
  });
}
