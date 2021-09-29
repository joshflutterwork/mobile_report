part of 'widgets.dart';

class BottomSheetWidget extends StatefulWidget {
  final Function callback;

  BottomSheetWidget({required this.callback});

  @override
  _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());

    return Container(
      alignment: Alignment.center,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Center(
            child: Column(
          children: [
            GestureDetector(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  width: MediaQuery.of(context).size.width / 5.5,
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: mainColor,
                  ),
                ),
              ),
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              controller: _scrollController,
              crossAxisCount: 3,
              children: <Widget>[
                IconsMenu("Home", Icons.home_rounded, onTap: () {
                  userController.setActiveTab(0);
                  Get.back();
                }),
                IconsMenu(
                  company,
                  Icons.business_rounded,
                  onTap: () => Get.to(() => CompanyProfile()),
                ),
                IconsMenu("Profile", Icons.person_rounded, onTap: () {
                  userController.setActiveTab(1);
                  Get.back();
                }),
                IconsMenu(attendance, Icons.hail, onTap: () {
                  Get.to(() => AttendancePage());
                }),
                IconsMenu("Aktivitas", Icons.volunteer_activism, onTap: () {
                  Get.off(() => HomeAktivitasPage());
                }),
                IconsMenu("Report", Icons.save_rounded, onTap: () {
                  Get.off(() => SplashProjectPage());
                }),
                IconsMenu("Salary", Icons.attach_money_rounded, onTap: () {
                  Get.to(() => SalaryEmployeePage());
                }),
              ],
            )
          ],
        )),
      ),
    );
  }
}

class IconsMenu extends StatefulWidget {
  final String text;
  final IconData iconData;
  final Function() onTap;
  IconsMenu(this.text, this.iconData, {required this.onTap});

  @override
  _IconsMenuState createState() => _IconsMenuState();
}

class _IconsMenuState extends State<IconsMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45), color: Colors.white),
            child: InkWell(
                child: Icon(widget.iconData, size: 24, color: mainColor),
                onTap: widget.onTap),
          ),
          SizedBox(height: 8),
          Expanded(child: Text(widget.text, textAlign: TextAlign.center))
        ],
      ),
    );
  }
}
