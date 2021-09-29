part of '../pages.dart';

class AttendancePage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return GeneralMenu(
      'Kehadiran',
      child: ListView(
        children: [
          GeneralContent(
            'Kehadiran',
            Icons.date_range_rounded,
            onTap: () => Get.to(
              () => AttendanceNote(),
            ),
          ),
          GeneralContent(
            'Cuti / Izin',
            Icons.hail_rounded,
            onTap: () => Get.to(
              () => LeaveEmployeePage(),
            ),
          ),
          if (controller.getUserRoleID() == 1)
            Column(
              children: [
                GeneralContent(
                  'Cuti / Izin Admin',
                  Icons.hail_rounded,
                  onTap: () => Get.to(
                    () => LeaveAdminPage(),
                  ),
                ),
                GeneralContent(
                  '${correction}Admin',
                  Icons.edit_road_rounded,
                  onTap: () => Get.to(
                    () => CorrectionAdminPage(),
                  ),
                ),
              ],
            ),
          if (controller.getStatusHead() == 'true')
            GeneralContent(
              '${correction}Head',
              Icons.edit_road_rounded,
              onTap: () => Get.to(
                () => CorrectionPage(),
              ),
            ),
          GeneralContent(
            '${correction}Karyawan',
            Icons.edit_road_rounded,
            onTap: () => Get.to(
              () => CorrectionEmployeePage(),
            ),
          ),
        ],
      ),
    );
  }
}
