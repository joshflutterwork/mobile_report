part of '../pages.dart';

class ProfileAbsen extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.isLoading.value == false)
        ? ListView(
            children: [
              ...controller.absensi.map((item) {
                return Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.date ?? '',
                            style: (item.holiday != true)
                                ? blackFontStyleBold
                                : mainFontStyle),
                        SizedBox(height: defaultMargin),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text('Masuk', style: blackFontStyleTitle3),
                            Text('Keluar', style: blackFontStyleTitle3)
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(item.punchIn ?? '00:00'),
                            Text(item.punchOut ?? '00:00'),
                          ],
                        ),
                        SizedBox(height: defaultMargin),
                        Text('Produktif   Soon'),
                        Text('Istirahat    Soon'),
                        Text('Lembur     Soon'),
                        lineCutObject(),
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
