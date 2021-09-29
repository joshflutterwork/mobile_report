part of '../pages.dart';

class SplashProjectPage extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    controller.splashProject();
    return Scaffold(
      backgroundColor: mainColor,
      body: Center(child: loadingCircle),
    );
  }
}
