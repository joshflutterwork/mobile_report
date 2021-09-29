part of 'widgets.dart';

class StatusPage extends StatelessWidget {
  final String? image, name, title, postId;
  final int? idDB, idFB, time, userId;
  final Function() onUpdate, onDelete, onClick, onComment, onLike;
  final Widget? child;
  StatusPage(
      {this.idDB,
      this.idFB,
      this.postId,
      this.userId,
      this.image,
      this.name,
      this.title,
      this.time,
      this.child,
      required this.onLike,
      required this.onUpdate,
      required this.onClick,
      required this.onComment,
      required this.onDelete});

  @override
  Widget build(BuildContext context) {
    List<CustomPopupMenu> choices = <CustomPopupMenu>[
      CustomPopupMenu(
        title: 'Edit post',
        icon: Icons.edit_rounded,
        onTap: onUpdate,
      ),
      CustomPopupMenu(
        title: 'Delete post',
        icon: Icons.delete_rounded,
        onTap: onDelete,
      ),
    ];

    List<CustomPopupMenu> report = <CustomPopupMenu>[
      CustomPopupMenu(title: 'Report', icon: Icons.report, onTap: () {}),
    ];

    return GestureDetector(
      onTap: onClick,
      child: Container(
        color: white,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border:
                              Border.all(width: 2, color: Colors.grey.shade100),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(image!), fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  name!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 4),
                                Icon(Icons.public, size: 12),
                              ],
                            ),
                            Text(readTimestamp(time!)),
                          ],
                        ),
                      ),
                      (idDB == idFB)
                          ? PopupMenuButton<CustomPopupMenu>(
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.more_vert_rounded,
                                    color: greyColor),
                              ),
                              elevation: 3.2,
                              onCanceled: () {
                                print('You have not chossed anything');
                              },
                              tooltip: 'Popup Menu',
                              onSelected: (res) {
                                res.onTap();
                              },
                              itemBuilder: (BuildContext context) {
                                return choices.map((CustomPopupMenu choice) {
                                  return PopupMenuItem<CustomPopupMenu>(
                                    value: choice,
                                    child: Row(
                                      children: [
                                        Icon(choice.icon,
                                            color: Color(0xFF92929e)),
                                        SizedBox(width: 5),
                                        Text(choice.title!,
                                            style: TextStyle(
                                                color: Color(0xFF92929e)))
                                      ],
                                    ),
                                  );
                                }).toList();
                              },
                            )
                          : PopupMenuButton<CustomPopupMenu>(
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                child: Icon(Icons.more_vert_rounded,
                                    color: greyColor),
                              ),
                              elevation: 3.2,
                              onCanceled: () {
                                print('You have not chossed anything');
                              },
                              tooltip: 'Popup Menu',
                              onSelected: (res) {
                                res.onTap();
                              },
                              itemBuilder: (BuildContext context) {
                                return report.map((CustomPopupMenu report) {
                                  return PopupMenuItem<CustomPopupMenu>(
                                    value: report,
                                    child: Row(
                                      children: [
                                        Icon(report.icon,
                                            color: Color(0xFF92929e)),
                                        SizedBox(width: 5),
                                        Text(report.title!,
                                            style: TextStyle(
                                                color: Color(0xFF92929e)))
                                      ],
                                    ),
                                  );
                                }).toList();
                              },
                            )
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 12,
                      ),
                      child: Text(title!),
                    ),
                  ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      child!,
                      TextButton.icon(
                        onPressed: onComment,
                        icon: Icon(Icons.chat_bubble_outline_rounded,
                            color: Colors.black),
                        label: Text(
                          'Komentar',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            lineCutObject(),
          ],
        ),
      ),
    );
  }
}

class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon, required this.onTap});
  String? title;
  IconData? icon;
  Function() onTap;
}

class GetBottomSheet {
  static postSheet({
    String? name,
    String? department,
    String? imageProfile,
    TextEditingController? controller,
    required Function() onPost,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
      ),
      child: ListView(
        children: [
          SafeArea(
            child: Container(
              margin: EdgeInsets.all(24),
              child: Text(''),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 2, color: Colors.grey.shade100),
                        color: white,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(imageProfile!),
                            fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name!, style: mainFontStyle),
                          Text(department!, style: greyFontStyleSubtitle),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: onPost,
                      child: Container(
                        width: 80,
                        height: 45,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: mainColor,
                        ),
                        child:
                            Center(child: Text("POST", style: whiteFontStyle)),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          lineCutObject(),
          InputCard(
            title: 'Your Post',
            hintText: 'Share something great today...',
            controller: controller!,
            maxLine: 10,
            minLine: 1,
            autofocus: true,
          ),
        ],
      ),
    );
  }
}
