part of '../pages.dart';

class CompanyAnnouncement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final companyController = Get.put(CompanyController());
    companyController.fetchPolicy(false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengumuman'),
        centerTitle: true,
      ),
      body: Obx(() => (companyController.isLoading.value == false)
          ? ListView(
              children: [
                ...companyController.list.map((item) {
                  return GestureDetector(
                    onTap: () => Get.to(
                      () => DetailInfoPage(model: item),
                    ),
                    child: Card(
                      elevation: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.title!, style: mainFontStyle),
                            Text(
                              "Dibuat oleh ${item.uName} pada ${item.createdAt}",
                              style:
                                  greyFontStyleSubtitle.copyWith(fontSize: 12),
                            ),
                            SizedBox(height: 12)
                          ],
                        ),
                      ),
                    ),
                  );
                })
              ],
            )
          : loadingCircleRed),
    );
  }
}
