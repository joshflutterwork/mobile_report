part of '../pages.dart';

class ChangePassPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        title: Text('Ubah Password', style: blackFontStyleTitle2),
        centerTitle: true,
        leading: GestureDetector(
          child: Icon(Icons.close_rounded, color: Colors.black),
          onTap: () => Get.back(),
        ),
      ),
      body: ListView(
        children: [
          InputCard(
            title: 'Password Lama',
            controller: controller.oldPassController,
          ),
          InputCard(
            title: 'Password Baru',
            controller: controller.newPassController,
          ),
          InputCard(
            title: 'Konfirmasi Password Baru',
            controller: controller.confirmPassController,
          ),
          Container(
            height: 50,
            width: double.infinity,
            margin: EdgeInsets.all(24),
            child: RaisedButton(
              onPressed: () => controller.changePassword(),
              elevation: 0,
              color: mainColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Obx(
                () => (controller.isLoading.value)
                    ? loadingMinIndicator
                    : Text('Ubah Password', style: whiteFontStyle),
              ),
            ),
          )
        ],
      ),
    );
  }
}
