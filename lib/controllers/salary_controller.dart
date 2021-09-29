part of 'controllers.dart';

class SalaryController extends GetxController {
  final authController = Get.find<AuthController>();
  RxList<Salary> salary = <Salary>[].obs;
  Rx<DetailSalary> detailSalary = DetailSalary().obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    getSalary();
    super.onInit();
  }

  getSalary() async {
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'salary-continue',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data =
              jsonDecode(res.body)['data'].cast<Map<String, dynamic>>();
          final value = (data as List).map((e) => Salary.fromJson(e)).toList();
          if (value is List<Salary>) {
            salary.addAll(value);
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

  getDetail(int id) async {
    showBotToastText('Harap tunggu proses generate...');
    try {
      isLoading.toggle();
      Request request = Request(
        url: 'salary-continue-detail/$id',
        headers: {'Authorization': 'Bearer ${authController.getTokenHRIS()}'},
      );
      await request.get().then((res) {
        if (res.statusCode == 200) {
          final data = jsonDecode(res.body);
          final value = DetailSalary.fromJson(data);
          if (value is DetailSalary) {
            detailSalary.update((val) {
              val!.nama = value.nama;
              val.nik = value.nik;
              val.bulan = value.bulan;
              val.tahun = value.tahun;
              val.idGaji = value.idGaji;
              val.jabatan = value.jabatan;
              val.terbilang = value.terbilang;
              val.gajiBersih = value.gajiBersih;
              val.penerimaan = value.penerimaan;
              val.pengurangan = value.pengurangan;
              val.detailPotonganAbsen = value.detailPotonganAbsen;
              val.detailPotonganKasbon = value.detailPotonganKasbon;
              val.detailPotonganTelat = value.detailPotonganTelat;
            });
            exportToPdf();
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

  exportToPdf() async {
    final invoice = Invoice(
      id: detailSalary.value.idGaji,
      month: detailSalary.value.bulan,
      year: detailSalary.value.tahun,
      netSalary: detailSalary.value.gajiBersih,
      terbilang: detailSalary.value.terbilang,
      address: Address(
        street: 'Jalan Kebembem Raya No. 6',
        kab: 'Lenteng Agung, Jagakarsa',
        prov: 'Jakarta Selatan, 12620',
      ),
      supplier: Supplier(
        name: detailSalary.value.nama,
        address: detailSalary.value.jabatan,
        paymentInfo: detailSalary.value.nik,
      ),
      customer: Customer(
        name: detailSalary.value.nama,
        address: detailSalary.value.jabatan,
        nik: detailSalary.value.nik,
      ),
      penerimaan: detailSalary.value.penerimaan,
      pengurangan: detailSalary.value.pengurangan,
      detailPotonganAbsen: detailSalary.value.detailPotonganAbsen,
      detailPotonganTelat: detailSalary.value.detailPotonganTelat,
      detailPotonganKasbon: detailSalary.value.detailPotonganKasbon,
    );
    final pdfFile = await PdfInvoiceApi.generate(invoice);

    PdfApi.openFile(pdfFile);
  }
}
