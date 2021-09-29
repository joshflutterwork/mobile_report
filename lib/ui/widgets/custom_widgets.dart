part of 'widgets.dart';

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    if (diff.inHours > 0) {
      time = diff.inHours.toString() + ' jam lalu';
    } else if (diff.inMinutes > 0) {
      time = diff.inMinutes.toString() + ' menit lalu';
    } else if (diff.inSeconds > 0) {
      time = 'baru saja';
    } else if (diff.inMilliseconds > 0) {
      time = 'baru saja';
    } else if (diff.inMicroseconds > 0) {
      time = 'baru saja';
    } else {
      time = 'baru saja';
    }
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    time = diff.inDays.toString() + ' hari lalu';
  } else if (diff.inDays > 6) {
    time = (diff.inDays / 7).floor().toString() + ' minggu lalu';
  } else if (diff.inDays > 29) {
    time = (diff.inDays / 30).floor().toString() + ' bulan lalu';
  } else if (diff.inDays > 365) {
    time = '${date.month} ${date.day}, ${date.year}';
  }
  return time;
}

const chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => chars.codeUnitAt(Random().nextInt(chars.length))));

Widget generateDashedDivider(double width) {
  int n = width ~/ 5;
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
        n,
        (index) => (index % 2 == 0)
            ? Container(
                height: 2,
                width: width / n,
                color: Color(0xFFE4E4E4),
              )
            : SizedBox(
                width: width / n,
              )),
  );
}

launchHandler(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Widget lineCutObject() {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 16),
    height: 6,
    width: double.infinity,
    color: lineGreyColor,
  );
}

Widget cardDataFeature(
    {IconData? icon, required String title, required Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.infinity,
      color: white,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultMargin, vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon, color: greyColor),
                    SizedBox(width: 16),
                    Text(
                      title,
                      style: blackFontStyleTitle2,
                    )
                  ],
                ),
                Icon(Icons.arrow_forward_ios_rounded,
                    color: greyColor, size: 14),
              ],
            ),
          ),
          Divider(indent: 47)
        ],
      ),
    ),
  );
}

Widget headerCardTitle(
    {String? headTitle, required Function() headEdit, int? status}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headTitle!,
          style: blackFontStyleTitle.copyWith(fontSize: 16),
        ),
        headTitle != null
            ? editing(onTapEdit: headEdit, status: status)
            : SizedBox()
      ],
    ),
  );
}

Widget editing({required Function() onTapEdit, int? status}) {
  return onTapEdit != null
      ? GestureDetector(
          onTap: onTapEdit,
          child: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
              color: status == null ? Colors.grey[300] : white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(status == null ? Icons.edit_rounded : Icons.more_vert,
                color: greyColor),
          ),
        )
      : SizedBox();
}

Widget cardWidgetHoriz(String title, String value,
    {String? t1,
    String? t2,
    String? t3,
    Color? color,
    Color? color1,
    int? count,
    Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: (count == null)
            ? [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: defaultMargin),
                    child: Text(title),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: onTap,
                    child: Text(value),
                  ),
                ),
              ]
            : (count == 4)
                ? [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: defaultMargin),
                        child: Text(title),
                      ),
                    ),
                    Expanded(
                      child: Text(value),
                    ),
                    Expanded(
                      child: Text(t1!),
                    ),
                    Expanded(
                      child: Text(t2!),
                    ),
                  ]
                : [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: defaultMargin),
                        child: Text(title),
                      ),
                    ),
                    Expanded(
                      child: Text(value),
                    ),
                    Expanded(
                      child: Text(t1!),
                    ),
                    Expanded(
                      child: Text(t2!),
                    ),
                    Expanded(
                      child: Text(t3!),
                    ),
                  ]),
  );
}

Widget customShimmerImage(double bRadius, {double? cHeight, double? cWidth}) {
  return Shimmer(
    gradient: LinearGradient(
        begin: Alignment(-1, 0.5),
        end: Alignment(1, -0.5),
        stops: [0.45, 0.5, 0.55],
        colors: [Colors.grey.shade200, Colors.white, Colors.grey.shade200]),
    child: Container(
      width: cWidth != null ? cWidth : 102,
      height: cHeight != null ? cHeight : 102,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(bRadius),
        color: white,
      ),
    ),
  );
}

Widget queueShimmer(context, {int? value}) {
  return Column(
      children: (value == null)
          ? [
              customShimmer(context),
              customShimmer(context),
              customShimmer(context),
              customShimmer(context),
            ]
          : [
              customShimmer(context),
              customShimmer(context),
            ]);
}

Widget customShimmer(context) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: Shimmer(
      gradient: LinearGradient(
          stops: [0.45, 0.5, 0.55],
          colors: [Colors.grey.shade200, Colors.white, Colors.grey.shade200]),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 20,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.grey[200],
        ),
      ),
    ),
  );
}

Widget cardListCorrection(String title, String value,
    {Color? color, Color? color1, TextStyle? style1}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: style1 == null
                ? blackFontStyleTitle2.copyWith(color: color1)
                : style1),
        Text(value,
            style: style1 == null
                ? TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                  )
                : style1),
      ],
    ),
  );
}

class CustomShapeClippers extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0.0, 330.0 - 200);
    path.quadraticBezierTo(size.width / 2, 200, size.width, 330.0 - 200);
    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}

Widget cardStepper(
    {String? name, String? speciality, String? dateIn, String? dateOut}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
    child: Container(
      child: Row(
        children: [
          Column(
            children: [
              CircleAvatar(backgroundColor: greyColor, radius: 5),
              Container(
                width: 2.5,
                height: 60,
                color: greyColor,
              )
            ],
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  //max 28
                  name!,
                  style: blackFontStyleTitle2.copyWith(
                      fontWeight: FontWeight.bold),
                ),
                //max 30
                Text(speciality!, style: greyFontStyleSubtitle),
                Text("$dateIn - $dateOut", style: TextStyle(color: greyColor)),
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget customListView(
    {int? value,
    List<TodayActivity?>? todayActivity,
    List<Education?>? education,
    List<Experience?>? experience,
    List<LeaveListAccess?>? leaveListAccses,
    List<Course?>? course}) {
  return Container(
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: value == null
          ? education!.length
          : (value == 1)
              ? experience!.length
              : (value == 3)
                  ? todayActivity!.length
                  : (value == 4)
                      ? leaveListAccses!.length
                      : course!.length,
      itemBuilder: (ctx, i) {
        return value == 2
            ? Row(children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: defaultMargin),
                  child: Text('${course![i]!.title}'),
                )),
                Expanded(child: Text('${course[i]!.committee}')),
                Expanded(child: Text('${course[i]!.dateIn}')),
                Expanded(child: Text('${course[i]!.longTime}')),
              ])
            : (value == 4)
                ? Card(
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          Text('${leaveListAccses![i]!.name}',
                              style: blackFontStyleTitle2),
                          SizedBox(height: 12),
                          Text(leaveListAccses[i]!.name != "Remaining Leaves"
                              ? leaveListAccses[i]!.days.toString()
                              : leaveListAccses[i]!.days),
                        ],
                      ),
                    ),
                  )
                : cardStepper(
                    name: value == null
                        ? '${education![i]!.name}'
                        : value == 3
                            ? '${todayActivity![i]!.type}'
                            : '${experience![i]!.jobDesc}',
                    speciality: value == null
                        ? '${education![i]!.speciality}'
                        : value == 3
                            ? '${todayActivity![i]!.dateTime}'
                            : 'at ${experience![i]!.company}',
                    dateIn: value == null
                        ? '${education![i]!.dateIn}'
                        : value == 3
                            ? ''
                            : '${experience![i]!.dateIn}',
                    dateOut: value == null
                        ? '${education![i]!.dateOut}'
                        : value == 3
                            ? ''
                            : '${experience![i]!.dateOut}');
      },
    ),
  );
}

getOpenAlert(String title, String content, String textConfirm,
    {required Function() onConfirm, required Function() onCancel}) {
  return Get.defaultDialog(
    title: title,
    titleStyle: TextStyle(fontWeight: FontWeight.bold),
    onCancel: onCancel,
    onConfirm: onConfirm,
    buttonColor: mainColor,
    textCancel: 'Batalkan',
    textConfirm: textConfirm,
    cancelTextColor: mainColor,
    confirmTextColor: white,
    content: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(content, textAlign: TextAlign.center),
          ),
        ],
      ),
    ),
  );
}

openAlertNoNew(context, String title) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 12),
                Text(
                  'Alert',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                Text(title, textAlign: TextAlign.center),
                SizedBox(height: 25),
                Align(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () => Get.back(),
                    child: Text('Ok'),
                  ),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        );
      });
}

openAlertBox(context, {required Function() onConfirm}) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 10.0),
          content: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: 12),
                Text(
                  'Logout',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 60),
                Text('Are you sure, You want to logout ?'),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlatButton(
                      onPressed: () => Get.back(),
                      child: Text('No'),
                    ),
                    FlatButton(
                      onPressed: onConfirm,
                      // () {
                      //   Provider.of<AuthProvider>(context, listen: false)
                      //       .logout();
                      //   Get.offAll(() => LoginForm());
                      // },
                      child: Text('Yes'),
                    )
                  ],
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        );
      });
}
