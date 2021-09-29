part of '../pages.dart';

class ProfileCuti extends GetView<LeaveController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => (controller.isLoading.value == false)
        ? ListView(
            children: [
              ...controller.leave.map((item) {
                Color setColor() {
                  return item.status == 'New'
                      ? Colors.deepPurple
                      : item.status == 'Approved'
                          ? Colors.green
                          : mainColor;
                }

                return Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(item.name ?? '', style: blackFontStyleBold),
                            SizedBox(width: 8),
                            Text('( ${item.noOfDays} day )'),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Row(
                            children: [
                              Text(item.from ?? ''),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: Icon(MdiIcons.arrowRightThick),
                              ),
                              Text(item.to ?? ''),
                            ],
                          ),
                        ),
                        Text(item.reason ?? '', textAlign: TextAlign.justify),
                        Align(
                          alignment: Alignment.topRight,
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(color: lineGreyColor),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    item.status ?? '',
                                    style: blackFontStyleTitle3.copyWith(
                                        color: setColor()),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.radio_button_checked_rounded,
                                      color: setColor(), size: 16),
                                ],
                              )),
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
