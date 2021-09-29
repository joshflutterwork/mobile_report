part of '../pages.dart';

class AttendanceNote extends StatefulWidget {
  @override
  _AttendanceNoteState createState() => _AttendanceNoteState();
}

class _AttendanceNoteState extends State<AttendanceNote> {
  DateTime selectedDate = DateTime.now();
  String selectedMonth = 'July';
  List<MonthlyActivity> monthly = [];
  bool isLoading = false;

  _fecthMonthly(String month, String year) async {
    isLoading = true;
    if (mounted) setState(() {});
    final data = await AttendanceService.getMonthlyActivity(context,
        month: month, year: year);
    monthly.clear();
    if (data.isNotEmpty) {
      setState(() {
        monthly.addAll(data);
        isLoading = false;
      });
      if (mounted) setState(() {});
      return;
    }
    isLoading = false;
    if (mounted) setState(() {});
  }

  @override
  void initState() {
    super.initState();
    this._fecthMonthly(selectedMonth, selectedDate.year.toString());
  }

  @override
  Widget build(BuildContext context) {
    final attendance = Get.put(AttendanceController());
    return GeneralPage(
      onBackButton: () {
        Get.back();
      },
      title: 'Kehadiran Anda',
      subtitle: 'Catatan kehadiran Anda',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16, left: defaultMargin),
            child: Row(
              children: [
                Text("Timesheet", style: blackFontStyleTitle),
                SizedBox(width: 8),
                Text('${attendance.currentDate}', style: greyFontStyleSubtitle)
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 60,
            margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            padding: EdgeInsets.only(left: defaultMargin, top: 8),
            decoration: BoxDecoration(
                color: Colors.grey[50],
                border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(4)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Masuk pada", style: blackFontStyleTitle3),
                Text("${attendance.currentDay}", style: greyFontStyleSubtitle)
              ],
            ),
          ),
          Container(
            width: 120,
            height: 120,
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: lineGreyColor, width: 4),
                borderRadius: BorderRadius.circular(60)),
            child: Center(child: Text("Soon", style: blackFontStyleTitle3)),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 24),
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 85),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: mainColor,
              ),
              child: Text('Soon', style: whiteFontStyle),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultMargin, vertical: defaultMargin),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 24),
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        border: Border.all(color: greyColor),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Text("Break\nSoon", textAlign: TextAlign.center),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 24),
                    height: 45,
                    decoration: BoxDecoration(
                        color: Colors.grey[50],
                        border: Border.all(color: greyColor),
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child:
                          Text("Overtime\nSoon", textAlign: TextAlign.center),
                    ),
                  ),
                ),
              ],
            ),
          ),
          lineCutObject(),
          Padding(
            padding: const EdgeInsets.only(left: defaultMargin),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Statistik", style: blackFontStyleTitle)),
          ),
          cardStatistics("Today", "3.45 / 8 hrs",
              chartColor: Colors.orange, size: 0.25),
          cardStatistics("This Week", "28 / 40 hrs",
              chartColor: Colors.yellow.shade900, size: 0.45),
          cardStatistics("This Month", "90 / 160 hrs",
              chartColor: Colors.green, size: 0.4),
          cardStatistics("Remaining", "90 / 160 hrs",
              chartColor: Colors.pink, size: 0.5),
          cardStatistics("Overtime", "4", chartColor: Colors.blue, size: 0.8),
          lineCutObject(),
          Padding(
            padding: const EdgeInsets.only(
                left: defaultMargin, bottom: defaultMargin),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Aktivitas Hari Ini", style: blackFontStyleTitle)),
          ),
          Obx(() => (attendance.isLoading.value == true)
              ? loadingCircleRed
              : (attendance.todayActivity.isEmpty)
                  ? Center(child: Text('Belum ada aktivitas'))
                  : Column(
                      children: [
                        ...attendance.todayActivity.map((item) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: defaultMargin),
                            child: Container(
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      CircleAvatar(
                                          backgroundColor: greyColor,
                                          radius: 5),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.type ?? '',
                                          style: blackFontStyleTitle2.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(item.dateTime ?? '',
                                            style: greyFontStyleSubtitle),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }),
                      ],
                    )),
          lineCutObject(),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultMargin, vertical: defaultMargin),
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: 'Pilih Bulan',
                labelStyle: blackFontStyleTitle2,
                border: const OutlineInputBorder(),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  isExpanded: true,
                  isDense: true, // Reduces the dropdowns height by +/- 50%
                  icon: Icon(Icons.keyboard_arrow_down),
                  value: selectedMonth,
                  style: blackFontStyleTitle2,
                  items: months.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (selectedItem) => setState(() {
                    selectedMonth = selectedItem!;
                  }),
                ),
              ),
            ),
          ),
          buttonCustom(
              onPressed: () => handleReadOnlyInputClick(context),
              title: 'Pilih Tahun  : ',
              value: "${selectedDate.year}".split(' ')[0]),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 24),
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  _fecthMonthly(selectedMonth, selectedDate.year.toString());
                });
              },
              style: ElevatedButton.styleFrom(
                primary: mainColor,
              ),
              child: isLoading
                  ? loadingBounceIndicator
                  : Text('Cari', style: whiteFontStyle),
            ),
          ),
          lineCutObject(),
          FutureBuilder(
              future: AttendanceService.getMonthlyActivity(context,
                  month: selectedMonth, year: selectedDate.year.toString()),
              builder: (ctx, snapshot) {
                return snapshot.data != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          child: HorizontalDataTable(
                            leftHandSideColumnWidth: 100,
                            rightHandSideColumnWidth: 420,
                            isFixedHeader: true,
                            headerWidgets: _getTitleWidget(),
                            leftSideItemBuilder: _generateFirstColumnRow,
                            rightSideItemBuilder:
                                _generateRightHandSideColumnRow,
                            itemCount: monthly.length,
                            rowSeparatorWidget: const Divider(
                              color: Colors.black54,
                              height: 1.0,
                              thickness: 0.0,
                            ),
                          ),
                          height: height * 0.5,
                        ),
                      )
                    : queueShimmer(context);
              }),
        ],
      ),
    );
  }

  Future<Null> handleReadOnlyInputClick(context) async {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) => Container(
              width: MediaQuery.of(context).size.width,
              child: YearPicker(
                initialDate: selectedDate,
                selectedDate: selectedDate,
                firstDate: DateTime(1995),
                lastDate: DateTime.now(),
                onChanged: (val) {
                  //print(val);
                  setState(() {
                    selectedDate = val;
                  });
                  Get.back();
                },
              ),
            ));
  }

  Widget cardStatistics(String title, String time,
      {Color? chartColor, double? size}) {
    return Container(
        width: double.infinity,
        height: 60,
        margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        decoration: BoxDecoration(
            border: Border.all(color: greyColor),
            borderRadius: BorderRadius.circular(4)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title, style: blackFontStyleTitle3),
                Text(time, style: greyFontStyleSubtitle)
              ],
            ),
            Container(
                height: 4,
                width: MediaQuery.of(context).size.width * size!,
                decoration: BoxDecoration(
                    color: chartColor, borderRadius: BorderRadius.circular(2))),
            SizedBox(height: 1.2),
          ],
        ));
  }

  buttonCustom({required Function() onPressed, String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      child: SizedBox(
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title!, style: blackFontStyleTitle2),
              SizedBox(width: 8),
              Text(value!, style: blackFontStyleTitle2),
            ],
          ),
          style: ElevatedButton.styleFrom(primary: white),
        ),
      ),
    );
  }

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Tanggal', 80),
      _getTitleItemWidget('Masuk', 90),
      _getTitleItemWidget('Keluar', 90),
      _getTitleItemWidget('Produktif', 90),
      _getTitleItemWidget('Istirahat', 60),
      _getTitleItemWidget('Lembur', 80),
    ];
  }

  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
      width: width,
      height: 56,
      padding: EdgeInsets.only(left: 12),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateFirstColumnRow(BuildContext context, int i) {
    return Container(
      child: Text('${monthly[i].date}',
          style: (monthly[i].holiday == true) ? marronFontStyle : null),
      width: 100,
      height: 52,
      padding: EdgeInsets.only(left: 5),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int i) {
    return Row(
      children: [
        Container(
          child: (monthly[i].holiday == true)
              ? Text('Libur', style: marronFontStyle)
              : Text(monthly[i].punchIn ?? ''),
          width: 80,
          height: 52,
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: (monthly[i].holiday == true)
              ? Text('Libur', style: marronFontStyle)
              : Text(monthly[i].punchOut ?? ''),
          width: 80,
          height: 52,
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text((monthly[i].holiday == true) ? 'Soon' : 'Soon'),
          width: 90,
          height: 52,
          padding: EdgeInsets.only(left: 40),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text((monthly[i].holiday == true) ? 'Soon' : 'Soon'),
          width: 80,
          height: 52,
          padding: EdgeInsets.only(left: 35),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text((monthly[i].holiday == true) ? 'Soon' : 'Soon'),
          width: 80,
          height: 52,
          padding: EdgeInsets.only(left: 25),
          alignment: Alignment.centerLeft,
        ),
      ],
    );
  }
}
