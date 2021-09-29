part of '../pages.dart';

class CompanyProfileDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final companyController = Get.put(CompanyController());
    companyController.getProfile();
    return GeneralPage(
      onBackButton: () {
        Get.back();
      },
      title: 'Profil',
      subtitle: 'Profil perusahaan',
      child: Container(
        color: "#ecf0f1".toColor(),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 100,
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/icons/splash.png'),
                ),
              ),
            ),
            Obx(() => (companyController.isLoading.value == false)
                ? Container(
                    height: height,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(defaultMargin),
                      ),
                    ),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                      child: Text('${companyController.profile.value.desc}',
                          textAlign: TextAlign.justify),
                    ),
                  )
                : loadingCircleRed),
          ],
        ),
      ),
    );
  }
}
