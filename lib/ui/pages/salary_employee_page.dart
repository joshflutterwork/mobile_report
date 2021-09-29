part of 'pages.dart';

class SalaryEmployeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final salaryController = Get.put(SalaryController());
    return GeneralMenu(
      'Riwayat Penggajian',
      child: Obx(() => (salaryController.isLoading.value == false)
          ? ListView(
              children: [
                ...salaryController.salary.map((item) {
                  return Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.emlopyee ?? '', style: blackFontStyleBold),
                          Text(item.role ?? ''),
                          Text(item.email ?? ''),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(item.cofirm ?? '',
                                  style: blackFontStyleTitle3),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border: Border.all(color: lineGreyColor),
                                ),
                                child: Text(item.total ?? '',
                                    style: blackFontStyleTitle3),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: ElevatedButton(
                              onPressed: () =>
                                  salaryController.getDetail(item.id!),
                              child:
                                  Text('Generate Slip', style: whiteFontStyle),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            )
          : loadingCircle),
    );
  }
}
