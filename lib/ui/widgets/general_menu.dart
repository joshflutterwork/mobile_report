part of 'widgets.dart';

class GeneralMenu extends StatelessWidget {
  final String title;
  final IconData? actions;
  final Widget? child;
  GeneralMenu(this.title, {this.child, this.actions});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: Icon(Icons.close_rounded, color: Colors.black),
          onPressed: () {
            Get.back();
            Get.back();
          },
        ),
        actions: [Icon(actions, color: Colors.black)],
      ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 12),
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Padding(
              padding: EdgeInsets.fromLTRB(12, 34, 12, 8), child: child),
        ),
      ),
    );
  }
}

class GeneralContent extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() onTap;
  GeneralContent(this.title, this.icon, {required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(24),
        margin: EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ]),
            CircleAvatar(
              radius: 18,
              child: Icon(Icons.arrow_forward_rounded, size: 20),
            )
          ],
        ),
      ),
    );
  }
}
