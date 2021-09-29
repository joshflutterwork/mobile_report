part of '../pages.dart';

class LeaveAdminPage extends StatefulWidget {
  @override
  _LeaveAdminPageState createState() => _LeaveAdminPageState();
}

class _LeaveAdminPageState extends State<LeaveAdminPage> {
  bool isLoading = false;
  int leaveIndex = 0;
  String _leave = "";
  String? _status;
  List _mStatus = ['New', 'Approved', 'Declined'];
  int? _idLeave;
  List<MyLeaves> leaveList = [];
  List<LeaveAdminModel> leaveAdmin = [];
  TextEditingController employeeController = TextEditingController();

  StatusLeaveAdmin? statusLeaveAdmin;
  fecthStatus() async {
    setState(() => isLoading = true);
    final StatusLeaveAdmin dataStatus =
        await AttendanceService.getStatusLeaveAdmin(context);
    if (dataStatus is StatusLeaveAdmin) {
      statusLeaveAdmin = dataStatus;
      setState(() => isLoading = false);
    }
  }

  fecthType() async {
    var response = await AttendanceService.getMyLeaves(context);
    print(response);
    setState(() {
      leaveList = response;
    });
  }

  fecthLeaves(
      {String? name,
      String? leaveId,
      String? status,
      String? from,
      String? to}) async {
    isLoading = true;
    if (mounted) setState(() {});
    final data = await AttendanceService.getFilterLeave(
      context,
      name: employeeController.text,
      leaveId: _idLeave.toString(),
      status: _status!,
      from: selectedFromDate.toString(),
      to: selectedToDate.toString(),
    );
    leaveAdmin.clear();
    if (data.isNotEmpty) {
      setState(() {
        leaveAdmin.addAll(data);
        isLoading = false;
      });
      if (mounted) setState(() {});
      return;
    }
    isLoading = false;
    if (mounted) setState(() {});
    print(data);
  }

  var formatter = DateFormat("dd/MM/yyyy");
  DateTime selectedFromDate = DateTime.now();
  DateTime selectedToDate = DateTime.now();

  _selectDate(BuildContext context, {String? value}) async {
    final DateTime? picked = await showDatePicker(
      currentDate: DateTime.now(),
      context: context,
      initialDate: value == 'to' ? selectedToDate : selectedFromDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(selectedFromDate.year + 1),
      helpText: value == 'to' ? 'Select to date' : 'Select from date',
      cancelText: 'Not Now',
      confirmText: 'Select',
      builder: (BuildContext? context, Widget? child) {
        return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light().copyWith(primary: mainColor)),
            child: child!);
      },
    );
    if (picked != null && picked != selectedFromDate && value != 'to') {
      setState(() => selectedFromDate = picked);
    } else if (picked != null && picked != selectedToDate && value == 'to') {
      setState(() => selectedToDate = picked);
    }
  }

  @override
  void initState() {
    super.initState();
    fecthStatus();
    fecthType();
    this.fecthLeaves(
      name: employeeController.text,
      leaveId: _idLeave.toString(),
      status: _status,
      from: selectedFromDate.toString(),
      to: selectedToDate.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Cuti/Izin (Admin)'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Get.offAll(
            () => AttendancePage(),
          ),
        ),
      ),
      body: ListView(
        children: [
          statusLeaveAdmin != null
              ? Column(
                  children: [
                    statusItem('Today Presents', statusLeaveAdmin!.today!),
                    statusItem('Planned Leaves',
                        statusLeaveAdmin!.planned!.toString()),
                    statusItem('Unplanned Leaves',
                        statusLeaveAdmin!.unPlanned.toString()),
                    statusItem('Pending Requests',
                        statusLeaveAdmin!.pendding.toString()),
                  ],
                )
              : loadingMainIndicator,
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text("Emloyee Name", style: blackFontStyleTitle2),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            child: TextField(
              controller: employeeController,
              cursorColor: mainColor,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintStyle: greyFontStyleSubtitle,
                  hintText: 'Emloyee Name'),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text("Leave Type", style: blackFontStyleTitle2),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            child: DropdownButton(
              underline: Container(color: Colors.transparent),
              isExpanded: true,
              hint: Text("Select Leave Type"),
              value: _leave != "" ? leaveList[leaveIndex] : null,
              items: leaveList.map((value) {
                return DropdownMenuItem(
                  child: Text(value.name!),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  // _leave = value.name;

                  // _idLeave = value.id;
                  // leaveIndex = leaveList.indexWhere(
                  //   (element) => element.name == value.name,
                  // );
                });
              },
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text("Leave Status", style: blackFontStyleTitle2),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black),
            ),
            child: DropdownButton(
              isExpanded: true,
              underline: Container(color: Colors.transparent),
              hint: Text("Select Leave Status"),
              value: _status,
              items: _mStatus.map((value) {
                return DropdownMenuItem(
                  child: Text(value),
                  value: value,
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  // _status = value;
                });
              },
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text("From", style: blackFontStyleTitle2),
          ),
          GestureDetector(
            onTap: () => _selectDate(context),
            child: Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatter.format(selectedFromDate.toLocal())),
                  Icon(Icons.date_range_rounded)
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text("To", style: blackFontStyleTitle2),
          ),
          GestureDetector(
            onTap: () => _selectDate(context, value: 'to'),
            child: Container(
              height: 50,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: defaultMargin),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formatter.format(selectedToDate.toLocal())),
                  Icon(Icons.date_range_rounded)
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 24),
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: RaisedButton(
              onPressed: () {
                setState(() {
                  fecthLeaves(
                    name: employeeController.text,
                    leaveId: _idLeave.toString(),
                    status: _status,
                    from: selectedFromDate.toString(),
                    to: selectedToDate.toString(),
                  );
                });
              },
              elevation: 0,
              color: mainColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              child: isLoading
                  ? loadingBounceIndicator
                  : Text('Search', style: whiteFontStyle),
            ),
          ),
          lineCutObject(),
          FutureBuilder(
              future: AttendanceService.getFilterLeave(context),
              builder: (ctx, snapshot) {
                return snapshot.data != null
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: Container(
                          child: HorizontalDataTable(
                            leftHandSideColumnWidth: 100,
                            rightHandSideColumnWidth: 590,
                            isFixedHeader: true,
                            headerWidgets: _getTitleWidget(),
                            leftSideItemBuilder: _generateFirstColumnRow,
                            rightSideItemBuilder:
                                _generateRightHandSideColumnRow,
                            itemCount: leaveAdmin.length,
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

  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Employee', 80),
      _getTitleItemWidget('Leave Type', 100),
      _getTitleItemWidget('From', 150),
      _getTitleItemWidget('To', 110),
      _getTitleItemWidget('Days', 50),
      _getTitleItemWidget('Reason', 70),
      _getTitleItemWidget('Status', 80),
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
      child: Text('${leaveAdmin[i].name}'),
      width: 80,
      height: 52,
      padding: EdgeInsets.only(left: 5),
      alignment: Alignment.centerLeft,
    );
  }

  Widget _generateRightHandSideColumnRow(BuildContext context, int i) {
    return Row(
      children: [
        Container(
          child: Text(leaveAdmin[i].leave!),
          width: 90,
          height: 52,
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(leaveAdmin[i].from!),
          width: 130,
          height: 52,
          padding: EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(leaveAdmin[i].to!),
          width: 130,
          height: 52,
          padding: EdgeInsets.only(left: 40),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(leaveAdmin[i].days!),
          width: 50,
          height: 52,
          padding: EdgeInsets.only(left: 35),
          alignment: Alignment.centerLeft,
        ),
        Container(
          child: Text(leaveAdmin[i].reason!),
          width: 80,
          height: 52,
          padding: EdgeInsets.only(left: 25),
          alignment: Alignment.centerLeft,
        ),
        GestureDetector(
          onTap: leaveAdmin[i].status != 'New'
              ? () => openAlertNoNew(context,
                  "You can't change your leave. Has been approved or rejected")
              : () {
                  showModalSheet(context, leaveAdmin[i].id!);
                },
          child: Container(
            child: Row(
              children: [
                CircleAvatar(
                  radius: 3,
                  backgroundColor: (leaveAdmin[i].status == 'New')
                      ? Colors.deepPurple
                      : (leaveAdmin[i].status == 'Approved')
                          ? Colors.green
                          : mainColor,
                ),
                SizedBox(width: 8),
                Text(leaveAdmin[i].status!)
              ],
            ),
            width: 102,
            height: 52,
            padding: EdgeInsets.only(left: 25),
            alignment: Alignment.centerLeft,
          ),
        ),
      ],
    );
  }

  Widget statusItem(String title, String value) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 12),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: greyColor),
      ),
      child: Column(
        children: [Text(title), Text(value, style: blackFontStyleBold)],
      ),
    );
  }

  late String type;
  late String selectedType;
  bool isUpStatus = false;
  void updateStatus(context, int id) {
    if (!isLoading) {
      setState(() => isLoading = true);
      Provider.of<LeaveProvider>(context, listen: false)
          .statusLeave(context, id, selectedType)
          .then((value) {
        if (value) {
          Get.offAll(() => LeaveAdminPage());
        } else {
          setState(() => isLoading = false);
          print(id);
          print(selectedType);
          Get.snackbar("Failed", "Update Status Correction Failed",
              colorText: white,
              icon: Icon(MdiIcons.closeCircleOutline, color: white),
              backgroundColor: mainColor);
        }
      });
    }
  }

  void showModalSheet(BuildContext context, int id) {
    List type = ['Approved', 'Declined'];

    showModalBottomSheet<void>(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(10),
            topLeft: Radius.circular(10),
          ),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter state) {
            return createBox(context, type, state, id);
          });
        });
  }

  createBox(BuildContext context, List val, StateSetter state, int id) {
    return SingleChildScrollView(
      child: LimitedBox(
        maxHeight: 250,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Update Status', style: blackFontStyleBold),
                    GestureDetector(
                      child: Icon(MdiIcons.close, size: 20),
                      onTap: () => Get.back(),
                    ),
                  ],
                ),
              ),
              buildMainDropdown(val, state),
              Container(
                height: 50,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                  child: RaisedButton(
                    color:
                        (selectedType == "Approved") ? Colors.green : mainColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: isLoading
                        ? loadingBounceIndicator
                        : Text(
                            selectedType,
                            style: TextStyle(color: Colors.white),
                          ),
                    onPressed: () => updateStatus(context, id),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  buildMainDropdown(List type, StateSetter setState) {
    return DropdownButtonHideUnderline(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),
          child: DropdownButton(
            value: selectedType,
            hint: Text("New"),
            items: type
                .map((value) =>
                    DropdownMenuItem(child: Text(value), value: value))
                .toList(),
            onChanged: (newType) {
              setState(() {
                //selectedType = newType;
              });
            },
          ),
        ),
      ),
    );
  }
}
