import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:keluarga_bintoro/models/pdf_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:pdf/widgets.dart';

class PdfApi {
  static Future<File> saveDocument({
    String? name,
    Document? pdf,
  }) async {
    final bytes = await pdf!.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}

class PdfInvoiceApi {
  static Future<File> generate(Invoice invoice) async {
    final pdf = Document();
    final headers = ['Tanggal', 'Jumlah'];
    final headLate = ['Tanggal', 'Jam', 'Jumlah'];
    final headKasbon = ['#ID', 'Bulan', 'Jumlah'];
    numberFormat(int nominal) {
      return NumberFormat.currency(
              locale: 'id', symbol: 'Rp ', decimalDigits: 0)
          .format(nominal);
    }

    buildRowTable(List<List<dynamic>> dataFirst, dataSecond, String nameFirst,
        String nameSecond,
        {bool head = false}) {
      return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nameFirst,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    Table.fromTextArray(
                      headerAlignment: Alignment.centerLeft,
                      headers: head != true ? null : headers,
                      headerStyle: head != true
                          ? null
                          : TextStyle(fontWeight: FontWeight.bold),
                      data: dataFirst,
                    ),
                  ]),
            ),
            SizedBox(width: 24),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(nameSecond,
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 12),
                    Table.fromTextArray(
                      headerAlignment: Alignment.centerLeft,
                      headers: head != true ? null : headLate,
                      headerStyle: head != true
                          ? null
                          : TextStyle(fontWeight: FontWeight.bold),
                      data: dataSecond,
                    ),
                  ]),
            ),
          ]);
    }

    final imageJpg =
        (await rootBundle.load('assets/icons/corp.png')).buffer.asUint8List();
    final dataPengerimaan = invoice.penerimaan!
        .map((e) => [e.name, numberFormat(e.total!)])
        .toList();
    final dataPengurangan = invoice.pengurangan!
        .map((e) => [e.name, numberFormat(e.total!)])
        .toList();
    final dataAbsen = invoice.detailPotonganAbsen!
        .map((e) => [e.date, numberFormat(e.denda!)])
        .toList();
    final dataTelat = invoice.detailPotonganTelat!
        .map((e) => [e.date, e.jamTelat, numberFormat(e.denda!)])
        .toList();
    final dataKasbon = invoice.detailPotonganKasbon!
        .map((e) => [e.id, e.date, numberFormat(e.amount!)])
        .toList();
    pdf.addPage(
      MultiPage(
        build: (context) => [
          Center(
            child: Image(MemoryImage(imageJpg), height: 55, width: 55),
          ),
          buildHeader(invoice),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildRowTable(
              dataPengerimaan, dataPengurangan, 'Penerimaan', 'Pengurangan'),
          SizedBox(height: 24),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Gaji Bersih: ${invoice.netSalary} ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: '(${invoice.terbilang})')
              ],
            ),
          ),
        ],
        // footer: (context) => buildFooter(invoice),
      ),
    );

    pdf.addPage(
      MultiPage(
        build: (context) => [
          Text('Lampiran', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildRowTable(dataAbsen, dataTelat, 'Detail Potongan Absen',
              'Detail Potongan Telat',
              head: true),
          SizedBox(height: 24),
          Text('Detail Potongan Kasbon',
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              child: Table.fromTextArray(
                headerAlignment: Alignment.centerLeft,
                headers: headKasbon,
                headerStyle: TextStyle(fontWeight: FontWeight.bold),
                data: dataKasbon,
              ),
            ),
            Expanded(
              child: Container(),
            ),
          ])
        ],
      ),
    );

    return PdfApi.saveDocument(
        name: 'Slip_${invoice.month}_${invoice.year}.pdf', pdf: pdf);
  }

  static Widget buildHeader(Invoice invoice) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 1 * PdfPageFormat.cm),
          Center(
            child: Text(
              'SLIP GAJI BULAN ${invoice.month!.toUpperCase()} ${invoice.year}',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 15 * PdfPageFormat.mm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildSupplierAddress(invoice.address!),
              buildSlipSalary(invoice.month!, invoice.year!, invoice.id!),
            ],
          ),
          SizedBox(height: 1 * PdfPageFormat.cm),
          buildCustomerAddress(invoice.customer!),
        ],
      );

  static Widget buildCustomerAddress(Customer customer) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(customer.name!, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(customer.address!),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(customer.nik!),
        ],
      );

  static Widget buildSupplierAddress(Address address) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(address.street!),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(address.kab!),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text(address.prov!),
        ],
      );
  static Widget buildSlipSalary(String month, int year, int id) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            'SLIP GAJI #$id',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(height: 1 * PdfPageFormat.mm),
          Text('Gaji Bulan: $month, $year'),
        ],
      );
}
