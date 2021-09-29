part of '../pages.dart';

class Splash extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    controller.splash();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Padding(
          padding: const EdgeInsets.all(24),
          child: Image.asset('assets/icons/splash.png'),
        ),
        SizedBox(height: 24),
        Center(child: loadingCircleRed)
      ]),
    );
  }
}
