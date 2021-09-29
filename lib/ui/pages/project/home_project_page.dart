part of '../pages.dart';

class HomeProjectPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    final userId = controller.getUserRoleProject();
    return GeneralMenu(
      'Report',
      child: ListView(
        children: [
          if (userId == 12 ||
              userId == 3 ||
              userId == 24 ||
              userId == 22 ||
              userId == 21 ||
              userId == 23 ||
              userId != 0)
            Obx(
              () => Column(children: [
                GeneralContent(
                  'Report CRM',
                  Icons.groups_rounded,
                  onTap: controller.showWidget,
                ),
                controller.isVisible.value
                    ? Padding(
                        padding: EdgeInsets.only(left: 34),
                        child: Column(children: [
                          GeneralContent(
                            'Laporan Survey',
                            Icons.groups_rounded,
                            onTap: () => Get.to(
                              () => ReportSurveyPage(Type.report),
                            ),
                          ),
                          GeneralContent(
                            'Laporan Tugas',
                            Icons.groups_rounded,
                            onTap: () {},
                          ),
                          GeneralContent(
                            'Laporan Rapat',
                            Icons.groups_rounded,
                            onTap: () {},
                          ),
                          GeneralContent(
                            'Laporan Panggilan',
                            Icons.groups_rounded,
                            onTap: () {},
                          ),
                        ]),
                      )
                    : SizedBox(),
                GeneralContent(
                  'Report Proyek',
                  Icons.business_center_rounded,
                  onTap: controller.showReportProyek,
                ),
                controller.reportProyek.value
                    ? Padding(
                        padding: EdgeInsets.only(left: 34),
                        child: Column(children: [
                          GeneralContent(
                            'Laporan Tugas',
                            Icons.business_center_rounded,
                            onTap: () {},
                          ),
                          GeneralContent(
                            'Laporan Rapat',
                            Icons.business_center_rounded,
                            onTap: () {},
                          ),
                          GeneralContent(
                            'Laporan Pekerjaan',
                            Icons.business_center_rounded,
                            onTap: () => Get.to(() => WorkReportPage()),
                          ),
                          GeneralContent(
                            'Laporan cek quality',
                            Icons.business_center_rounded,
                            onTap: () {},
                          ),
                          GeneralContent(
                            'Laporan quality proof',
                            Icons.business_center_rounded,
                            onTap: () {},
                          ),
                        ]),
                      )
                    : SizedBox(),
              ]),
            )
        ],
      ),
    );
  }
}
