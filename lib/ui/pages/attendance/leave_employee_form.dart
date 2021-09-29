part of '../pages.dart';

class LeaveEmployeeForm extends StatefulWidget {
  final int? leaveId, userRoleId;
  final String? nameLeave, reasonLeave, dayLeave;
  final bool isUpdate;

  LeaveEmployeeForm(
      {this.leaveId,
      this.nameLeave,
      this.reasonLeave,
      this.dayLeave,
      this.userRoleId,
      this.isUpdate = false});

  @override
  _LeaveEmployeeFormState createState() => _LeaveEmployeeFormState();
}

class _LeaveEmployeeFormState extends State<LeaveEmployeeForm> {
  final TextEditingController dayController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();
  TextEditingController? updateReason;
  TextEditingController? updateDays;

  String _leave = "";
  int leaveIndex = 0;
  late int _idLeave;
  bool isLoading = false;
  var formatter = DateFormat("dd/MM/yyyy");
  DateTime setFromDate = DateTime.now();
  DateTime setToDate = DateTime.now();
  late DateTime updateFromDate;
  late DateTime updateToDate;

  _selectDate(BuildContext context, String type) async {
    final DateTime? picked = await showDatePicker(
      currentDate: DateTime.now(),
      context: context,
      initialDate: (type == 'from' && widget.isUpdate != true)
          ? setFromDate
          : (type == 'to' && widget.isUpdate != true)
              ? setToDate
              : (type == 'from' && widget.isUpdate == true)
                  ? updateFromDate
                  : updateToDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(setFromDate.year + 1),
      helpText: 'Select date',
      cancelText: 'Not Now',
      confirmText: 'Select',
      builder: (BuildContext? context, Widget? child) {
        return Theme(
            data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light().copyWith(primary: mainColor)),
            child: child!);
      },
    );
    if (picked != null &&
        picked != setFromDate &&
        type == 'from' &&
        widget.isUpdate != true) {
      setState(() => setFromDate = picked);
    } else if (picked != null &&
        picked != setToDate &&
        type == 'to' &&
        widget.isUpdate != true) {
      setState(() => setToDate = picked);
    } else if (picked != null &&
        picked != updateFromDate &&
        type == 'from' &&
        widget.isUpdate == true) {
      setState(() => updateFromDate = picked);
    } else if (picked != null &&
        picked != updateToDate &&
        type == 'to' &&
        widget.isUpdate == true) {
      setState(() => updateToDate = picked);
    }
  }

  void updateLeave(context) {
    Map<String, dynamic> updateData = {
      "leave_employee_id": widget.leaveId,
      "leave_id": _idLeave,
      "name": widget.nameLeave,
      "from": formatter.format(updateFromDate.toLocal()),
      "to": formatter.format(updateToDate.toLocal()),
      "days": updateDays!.text,
      "reason": updateReason!.text
    };
    if (!isLoading) {
      setState(() => isLoading = true);
      Provider.of<LeaveProvider>(context, listen: false)
          .updateLeave(context, updateData)
          .then((value) {
        if (value) {
          Get.offAll(() => LeaveEmployeePage());
        } else {
          setState(() => isLoading = false);
          print(updateData);
          Get.snackbar(
            "Failed",
            "Update Leave Failed",
            colorText: white,
            backgroundColor: mainColor,
            icon: Icon(MdiIcons.closeCircleOutline, color: white),
          );
        }
      });
    }
  }

  void submitLeave(context) {
    Map<String, dynamic> data = {
      "leave_employee_id": widget.leaveId,
      "leave_id": _idLeave,
      "name": widget.nameLeave,
      "from": formatter.format(setFromDate.toLocal()),
      "to": formatter.format(setToDate.toLocal()),
      "days": dayController.text,
      "reason": reasonController.text,
    };
    if (!isLoading) {
      setState(() => isLoading = true);
      Provider.of<LeaveProvider>(context, listen: false)
          .storeLeave(context, data)
          .then((value) {
        if (value) {
          Get.offAll(() => LeaveEmployeePage());
        } else {
          setState(() => isLoading = false);
          Get.snackbar(
            "Failed",
            "Submit Leave Failed",
            colorText: white,
            backgroundColor: mainColor,
            icon: Icon(MdiIcons.closeCircleOutline, color: white),
          );
        }
      });
    }
  }

  bool isLoadDelete = false;
  void deletedLeave(context, String id) {
    if (!isLoadDelete) {
      setState(() => isLoadDelete = true);
      Provider.of<LeaveProvider>(context, listen: false)
          .deleteLeave(context, id)
          .then((value) {
        if (value) {
          Get.offAll(() => LeaveEmployeePage());
        } else {
          setState(() => isLoadDelete = false);
          Get.snackbar(
            "Failed",
            "Delete Leave Failed",
            icon: Icon(MdiIcons.closeCircleOutline, color: white),
          );
        }
      });
    }
  }

  List<MyLeaves> leaveList = [];

  _fecthType() async {
    var response = await AttendanceService.getMyLeaves(context);
    print(response);
    if (mounted) {
      setState(() {
        leaveList = response;
      });
    }
  }

  EditMyLeave? editMyLeave;
  bool isLoadEdit = false;
  _loadData() async {
    setState(() => isLoadEdit = true);
    final EditMyLeave dataMyLeave =
        await AttendanceService.getEditMyLeave(context, widget.leaveId!);
    if (dataMyLeave is EditMyLeave) {
      editMyLeave = dataMyLeave;
      setState(() => isLoadEdit = false);
      updateFromDate = editMyLeave!.from!;
      updateToDate = editMyLeave!.to!;
      _idLeave = editMyLeave!.leaveId!;
    }
  }

  @override
  void initState() {
    super.initState();
    _fecthType();
    _loadData();
    updateReason = TextEditingController(text: widget.reasonLeave);
    updateDays = TextEditingController(text: widget.dayLeave);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text(widget.isUpdate != true ? 'Add Leave' : 'Update Leave'),
        actions: [
          widget.isUpdate != true
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: IconButton(
                    icon:
                        isLoadDelete ? loadingMinIndicator : Icon(Icons.delete),
                    onPressed: () =>
                        deletedLeave(context, widget.leaveId.toString()),
                  ),
                )
        ],
      ),
      body: (editMyLeave != null || widget.isUpdate != true)
          ? Container(
              margin: EdgeInsets.all(8),
              child: ListView(
                children: [
                  InputCard(
                    title: 'Tipe Izin',
                    isNeedWidget: true,
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
                          // _leave = value!.name;

                          // _idLeave = value.id;
                          // leaveIndex = leaveList.indexWhere(
                          //   (element) => element.name == value.name,
                          // );
                        });
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, 'from'),
                    child: InputCard(
                      title: 'Form *',
                      typeDate: true,
                      selectedDate: widget.isUpdate != true
                          ? formatter.format(setFromDate.toLocal())
                          : formatter.format(updateFromDate),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, 'to'),
                    child: InputCard(
                      title: 'To *',
                      typeDate: true,
                      selectedDate: widget.isUpdate != true
                          ? formatter.format(setToDate.toLocal())
                          : formatter.format(updateToDate),
                    ),
                  ),
                  InputCard(
                    title: 'Number of days',
                    hintText: 'Number of days',
                    keyNumber: true,
                    controller:
                        widget.isUpdate != true ? dayController : updateDays,
                  ),
                  InputCard(
                    title: 'Reason *',
                    hintText: 'Reason',
                    maxLine: 3,
                    controller: widget.isUpdate != true
                        ? reasonController
                        : updateReason,
                  ),
                  SizedBox(height: 90),
                ],
              ),
            )
          : loadingMainIndicator,
      floatingActionButton: FloatingActionButton(
          backgroundColor: mainColor,
          child: isLoading ? loadingBounceIndicator : Icon(Icons.save),
          onPressed: () => widget.isUpdate != true
              ? submitLeave(context)
              : updateLeave(context)),
    );
  }
}
