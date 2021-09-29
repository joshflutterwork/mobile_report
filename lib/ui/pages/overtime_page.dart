part of 'pages.dart';

class OvertimePage extends StatefulWidget {
  @override
  _OvertimePageState createState() => _OvertimePageState();
}

class _OvertimePageState extends State<OvertimePage> {
  List<Container> listOvertime = [];
  var overtime = [
    {
      "name": "Lembur maintenance",
      "date": "9 0ct 2021",
      "for": "16 Feb 2021 - 18 Feb 2021",
      "reFor": "Amanda Bella"
    },
    {
      "name": "Lembur mengerjakan",
      "date": "9 0ct 2021",
      "for": "16 Feb 2021 - 18 Feb 2021",
      "reFor": "Amanda Bella"
    },
    {
      "name": "Lembur maintenance",
      "date": "9 0ct 2021",
      "for": "16 Feb 2021 - 18 Feb 2021",
      "reFor": "Amanda Bella"
    },
    {
      "name": "Lembur mengerjakan",
      "date": "9 0ct 2021",
      "for": "16 Feb 2021 - 18 Feb 2021",
      "reFor": "Amanda Bella"
    },
    {
      "name": "Lembur maintenance",
      "date": "9 0ct 2021",
      "for": "16 Feb 2021 - 18 Feb 2021",
      "reFor": "Amanda Bella"
    },
    {
      "name": "Lembur mengerjakan",
      "date": "9 0ct 2021",
      "for": "16 Feb 2021 - 18 Feb 2021",
      "reFor": "Amanda Bella"
    },
    {
      "name": "Lembur mengerjakan",
      "date": "9 0ct 2021",
      "for": "16 Feb 2021 - 18 Feb 2021",
      "reFor": "Amanda Bella"
    },
    {
      "name": "Lembur maintenance",
      "date": "9 0ct 2021",
      "for": "16 Feb 2021 - 18 Feb 2021",
      "reFor": "Amanda Bella"
    },
    {
      "name": "Lembur mengerjakan",
      "date": "9 0ct 2021",
      "for": "16 Feb 2021 - 18 Feb 2021",
      "reFor": "Amanda Bella"
    },
    {
      "name": "Lembur maintenance",
      "date": "9 0ct 2021",
      "for": "16 Feb 2021 - 18 Feb 2021",
      "reFor": "Amanda Bella"
    },
    {
      "name": "Lembur maintenance",
      "date": "9 0ct 2021",
      "for": "16 Feb 2021 - 18 Feb 2021",
      "reFor": "Amanda Bella"
    },
    {
      "name": "Lembur mengerjakan last",
      "date": "9 0ct 2021",
      "for": "16 Feb 2021 - 18 Feb 2021",
      "reFor": "Amanda Bella"
    },
  ];

  void _overtime() async {
    for (var i = 0; i < overtime.length; i++) {
      final thisOvertime = overtime[i];
      listOvertime.add(Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(thisOvertime["name"]!,
                    style: mainFontStyle.copyWith(fontWeight: FontWeight.bold)),
                Text(thisOvertime["date"]!, style: greyFontStyleSubtitle),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text("For : ${thisOvertime["for"]}",
                      style: greyFontStyleSubtitle),
                ),
                Text("Fully Appoved", style: greyFontStyleSubtitle),
              ],
            ),
            Divider()
          ],
        ),
      ));
    }
  }

  @override
  void initState() {
    _overtime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return GeneralPage(
      onBackButton: () {
        Get.back();
      },
      title: 'Overtime',
      subtitle: 'Your overtime note',
      child: Column(
        children: [
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 8),
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: RaisedButton(
              onPressed: () {},
              elevation: 0,
              color: mainColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: Text('+ New Request', style: whiteFontStyle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: defaultMargin),
            child: generateDashedDivider(
                MediaQuery.of(context).size.width - 2 * defaultMargin),
          ),
          Container(
              height: height * 0.70,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(defaultMargin),
                ),
              ),
              child: ListView(children: listOvertime)),
        ],
      ),
    );
  }
}
