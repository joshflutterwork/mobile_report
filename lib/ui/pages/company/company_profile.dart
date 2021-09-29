part of '../pages.dart';

class CompanyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralMenu(
      'Perusahaan',
      child: ListView(
        children: [
          GeneralContent(
            'Profile',
            Icons.business_center_rounded,
            onTap: () => Get.to(
              () => CompanyProfileDetail(),
            ),
          ),
          GeneralContent(
            'Kebijakan',
            Icons.policy_rounded,
            onTap: () => Get.to(
              () => CompanyPolicy(),
            ),
          ),
          GeneralContent(
            'Pengumuman',
            Icons.campaign_rounded,
            onTap: () => Get.to(
              () => CompanyAnnouncement(),
            ),
          ),
        ],
      ),
    );
  }
}
