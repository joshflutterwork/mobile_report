part of '../pages.dart';

class ProfileSalary extends GetView<SalaryController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.isLoading.value == false)
        ? ListView(
            children: [
              ...controller.salary.map((item) {
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
                          child: RaisedButton(
                            onPressed: () => controller.getDetail(item.id!),
                            elevation: 0,
                            color: mainColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: Text('Generate Slip', style: whiteFontStyle),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          )
        : loadingCircleRed);
  }
}
