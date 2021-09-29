part of 'pages.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final userController = Get.put(UserController());
  void _showMenuBottomSheet(BuildContext context) {
    showModalBottomSheet(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24),
        ),
      ),
      context: context,
      builder: (context) {
        return BottomSheetWidget(callback: () {});
      },
      useRootNavigator: true,
    );
  }

  @override
  void initState() {
    userController.setController(TabController(length: 2, vsync: this));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        controller: userController.tabController,
        children: [
          HomePage(),
          ProfilePage(),
        ],
      ),
      floatingActionButton: MyFloatingActionButton(_showMenuBottomSheet),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Material(
        color: mainColor,
        elevation: 5,
        child: TabBar(
          onTap: (_) {
            userController.switchFab(false);
          },
          indicatorColor: white,
          controller: userController.tabController,
          tabs: [
            Tab(icon: Icon(Icons.home_rounded, color: white)),
            Tab(icon: Icon(Icons.person_rounded, color: white)),
          ],
        ),
      ),
    );
  }
}

class MyFloatingActionButton extends StatefulWidget {
  final Function onShowedMenuBottomSheet;

  MyFloatingActionButton(this.onShowedMenuBottomSheet);
  @override
  _MyFloatingActionButtonState createState() => _MyFloatingActionButtonState();
}

class _MyFloatingActionButtonState extends State<MyFloatingActionButton> {
  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();

    return FloatingActionButton(
      backgroundColor: mainColor,
      child: Icon(userController.showBS ? Icons.close : Icons.menu),
      onPressed: () {
        //prov.switchFab();
        widget.onShowedMenuBottomSheet(context);
      },
    );
  }
}
