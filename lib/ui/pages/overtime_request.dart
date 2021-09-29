part of 'pages.dart';

class OvertimeRequest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GeneralPage(
      onBackButton: () {
        Get.back();
      },
      title: 'New Request',
      subtitle: 'Your Overtime',
      child: Column(
        children: [
          CardRequest(
            icon: Icons.info_outline_rounded,
            onSubmit: () {},
            onDraft: () {},
          ),
        ],
      ),
    );
  }
}
