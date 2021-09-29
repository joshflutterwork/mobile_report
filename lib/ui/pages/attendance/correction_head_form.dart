part of '../pages.dart';

class CorrectionHeadForm extends StatefulWidget {
  final bool isUpdate;
  final int? id;
  final String? reason;
  final String? typeName;
  CorrectionHeadForm({
    this.id,
    this.isUpdate = false,
    this.reason,
    this.typeName,
  });
  @override
  _CorrectionHeadFormState createState() => _CorrectionHeadFormState();
}

class _CorrectionHeadFormState extends State<CorrectionHeadForm> {
  String? employee;
  String? selectedType;
  String? eSelectedType;
  int indexEmployee = 0;
  int indexHour = 0;
  int indexType = 0;
  int? idHourIn;
  int? idHourOut;
  int? _idEmployee;
  List<String> type = ['Absen', 'Telat'];
  bool isLoading = false;
  bool isGetLoading = false;
  bool isCekAbsen = false;
  TextEditingController dateSController =
      TextEditingController(text: "23/04/2021");
  TextEditingController dateEController =
      TextEditingController(text: "16/04/2021");
  TextEditingController reasonController = TextEditingController();
  TextEditingController? eReasonController;
  TextEditingController? inCorrectController;
  TextEditingController? outCorrectController;

  var formatter = DateFormat("dd/MM/yyyy");
  var _formatter = DateFormat("yyyy-MM-dd");

  DateTime setFirstDate = DateTime.now();
  DateTime setEndDate = DateTime.now();
  DateTime updateFirstDate = DateTime.now();
  DateTime updateEndDate = DateTime.now();
  TimeOfDay setInTime = TimeOfDay.now();
  TimeOfDay setOutTime = TimeOfDay.now();

  _selectDate(BuildContext context, String type) async {
    final DateTime? picked = await showDatePicker(
      currentDate: DateTime.now(),
      context: context,
      initialDate: (type == 'first' && widget.isUpdate != true)
          ? setFirstDate
          : (type == 'end' && widget.isUpdate != true)
              ? setEndDate
              : (type == 'first' && widget.isUpdate == true)
                  ? updateFirstDate
                  : updateEndDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(setFirstDate.year + 1),
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
    if (picked != setFirstDate && type == 'first' && widget.isUpdate != true) {
      setState(() => setFirstDate = picked!);
    } else if (picked != setEndDate &&
        type == 'end' &&
        widget.isUpdate != true) {
      setState(() => setEndDate = picked!);
    } else if (picked != null &&
        picked != updateFirstDate &&
        type == 'first' &&
        widget.isUpdate == true) {
      setState(() => updateFirstDate = picked);
    } else if (picked != null &&
        picked != updateEndDate &&
        type == 'end' &&
        widget.isUpdate == true) {
      setState(() => updateEndDate = picked);
    }
  }

  _selectedTime(BuildContext context, String type) async {
    final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        cancelText: 'Not Now',
        confirmText: 'Select',
        initialTime: type == 'in' ? setInTime : setOutTime,
        builder: (BuildContext? context, Widget? child) {
          return Theme(
              data: ThemeData.light().copyWith(
                  colorScheme:
                      ColorScheme.light().copyWith(primary: mainColor)),
              child: child!);
        });
    if (pickedTime != null && pickedTime != setInTime && type == 'in') {
      setState(() => setInTime = pickedTime);
    } else if (pickedTime != null && pickedTime != setOutTime && type != 'in') {
      setState(() => setOutTime = pickedTime);
    }
  }

  void submitCorrection(context) {
    Map dataAbsen = {
      "user_id": _idEmployee,
      "date_start": formatter.format(setFirstDate.toLocal()),
      "date_end": formatter.format(setEndDate.toLocal()),
      "type": (selectedType == "Telat") ? 1 : 0,
      "reason": reasonController.text,
    };
    Map dataTelat = {
      "user_id": _idEmployee,
      "date_start": formatter.format(setFirstDate.toLocal()),
      "type": (selectedType == "Telat") ? 1 : 0,
      "reason": reasonController.text,
      "correct_details[attendance_id]": "[$idHourIn,$idHourOut]",
      "correct_details[hour_in]": "${setInTime.format(context)}:00",
      "correct_details[hour_out]": "${setOutTime.format(context)}:00",
    };
    if (!isLoading) {
      setState(() => isLoading = true);
      Provider.of<LeaveProvider>(context, listen: false)
          .storeCorrection(context, dataTelat, dataAbsen, selectedType!)
          .then((value) {
        if (value) {
          Get.offAll(() => CorrectionPage());
        } else {
          setState(() => isLoading = false);
          Get.snackbar("Failed", "Correction Leave Failed",
              colorText: white,
              icon: Icon(MdiIcons.closeCircleOutline, color: white),
              backgroundColor: mainColor);
        }
      });
    }
  }

  void updateCorrection(context) {
    Map editAbsen = {
      "user_id": _idEmployee,
      "date_start": formatter.format(updateFirstDate.toLocal()),
      "date_end": formatter.format(updateEndDate.toLocal()),
      "type": (selectedType == "Telat") ? 1 : 0,
      "reason": eReasonController!.text,
    };
    Map editTelat = {"": ""};
    if (!isLoading) {
      setState(() => isLoading = true);
      Provider.of<LeaveProvider>(context, listen: false)
          .updateCorrection(
              context, editTelat, editAbsen, selectedType!, widget.id!)
          .then((value) {
        if (value) {
          Get.offAll(() => CorrectionPage());
        } else {
          setState(() => isLoading = false);
          Get.snackbar("Update Failed", "Correction Leave Failed",
              icon: Icon(MdiIcons.closeCircleOutline, color: white),
              colorText: white,
              backgroundColor: mainColor);
        }
      });
    }
  }

  void cekAbesensi(context) {
    try {
      if (!isLoading) {
        setState(() => isLoading = true);
        Provider.of<LeaveProvider>(context, listen: false)
            .getAbsenHour(context, _idEmployee!,
                _formatter.format(setFirstDate.toLocal()))
            .then((value) {
          setState(() {
            isCekAbsen = true;
            isLoading = false;
          });
          print(value);
        });
      }
    } finally {
      setState(() {
        isCekAbsen = false;
        isLoading = false;
      });
      Get.snackbar(
        "Failed",
        "Terjadi kesalahan",
        icon: Icon(MdiIcons.closeCircleOutline, color: white),
        backgroundColor: mainColor,
        colorText: white,
      );
    }
  }

  bool isLoadDelete = false;
  void delCorrection(context, int id) {
    if (!isLoadDelete) {
      setState(() => isLoadDelete = true);
      Provider.of<LeaveProvider>(context, listen: false)
          .deleteCorrection(context, id)
          .then((value) {
        if (value) {
          Get.offAll(() => CorrectionPage());
        } else {
          setState(() => isLoadDelete = false);
          Get.snackbar(
            "Failed",
            "Delete Correction Failed",
            icon: Icon(MdiIcons.closeCircleOutline, color: white),
            backgroundColor: mainColor,
            colorText: white,
          );
        }
      });
    }
  }

  CorrectionEdit? dataEdit;
  _loadData() async {
    setState(() => isGetLoading = true);
    final CorrectionEdit correctionEdit =
        await AttendanceService.getEditCorrec(context, widget.id!);
    if (correctionEdit is CorrectionEdit) {
      dataEdit = correctionEdit;
      fetchDate();
      setState(() => isGetLoading = false);
    }
  }

  fetchDate() {
    updateFirstDate = dataEdit!.dateStart!;
    updateEndDate = dataEdit!.dateEnd!;
    _idEmployee = dataEdit!.id!;
  }

  @override
  void initState() {
    super.initState();
    _loadData();
    eReasonController = TextEditingController(text: widget.reason);
    eSelectedType = widget.typeName;
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LeaveProvider>(context, listen: false).getListEmployee(context);
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        title: Text((widget.isUpdate != true) ? 'Tambah Data' : 'Edit Data'),
        actions: [
          widget.isUpdate != true
              ? SizedBox()
              : Padding(
                  padding: const EdgeInsets.only(right: 24),
                  child: IconButton(
                    icon:
                        isLoadDelete ? loadingMinIndicator : Icon(Icons.delete),
                    onPressed: () => delCorrection(context, widget.id!),
                  ),
                )
        ],
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              InputCard(
                title: 'Tipe',
                isNeedWidget: true,
                child: DropdownButton<String>(
                    underline: Container(color: Colors.transparent),
                    isExpanded: true,
                    hint: Text("Pilih Tipe"),
                    value:
                        widget.isUpdate == true ? eSelectedType : selectedType,
                    items: type.map((value) {
                      return DropdownMenuItem(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                        eSelectedType = value;
                        indexType =
                            type.indexWhere((element) => element == value);
                      });
                    }),
              ),
              InputCard(
                title: 'Nama Karyawan',
                isNeedWidget: true,
                child: Consumer<LeaveProvider>(
                  builder: (context, data, _) {
                    return DropdownButton(
                      underline: Container(color: Colors.transparent),
                      isExpanded: true,
                      hint: Text("Pilih Karyawan"),
                      value: _idEmployee != null
                          ? data.dataListEmployee[indexEmployee]
                          : null,
                      items: data.dataListEmployee.map((value) {
                        return DropdownMenuItem(
                          child: Text(value.name!),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          // employee = value.name!;
                          // _idEmployee = value.id!;
                          // indexEmployee = data.dataListEmployee
                          //     .indexWhere((element) => element.id == value.id);
                        });
                      },
                    );
                  },
                ),
              ),
              InputCard(
                title: 'Alasan',
                hintText: 'Alasan',
                maxLine: 3,
                controller: widget.isUpdate != true
                    ? reasonController
                    : eReasonController,
              ),
              // dataEdit != null
              //     ? Text(dataEdit.dateStart.toString() ?? '-')
              //     : loadingMainIndicator,
              (selectedType == 'Absen' || widget.isUpdate == true)
                  ? Column(children: [
                      GestureDetector(
                        onTap: () {
                          _selectDate(context, 'first');
                          setState(() {});
                        },
                        child: InputCard(
                          title: 'Tanggal Awal',
                          typeDate: true,
                          selectedDate: widget.isUpdate != true
                              ? formatter.format(setFirstDate.toLocal())
                              : formatter.format(updateFirstDate),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _selectDate(context, 'end'),
                        child: InputCard(
                          title: 'Tanggal Akhir',
                          typeDate: true,
                          selectedDate: widget.isUpdate != true
                              ? formatter.format(setEndDate.toLocal())
                              : formatter.format(updateEndDate),
                        ),
                      )
                    ])
                  : (selectedType == 'Telat')
                      ? GestureDetector(
                          onTap: () => _selectDate(context, 'first'),
                          child: InputCard(
                            title: 'Tanggal',
                            typeDate: true,
                            selectedDate: widget.isUpdate != true
                                ? formatter.format(setFirstDate.toLocal())
                                : formatter.format(updateFirstDate),
                          ))
                      : SizedBox(),
              (isCekAbsen != true)
                  ? SizedBox()
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: FutureBuilder(
                            future: Provider.of<LeaveProvider>(context,
                                    listen: false)
                                .getAbsenHour(context, _idEmployee!,
                                    _formatter.format(setFirstDate.toLocal())),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return loadingMainIndicator;
                              }
                              return Consumer<LeaveProvider>(
                                builder: (context, data, _) {
                                  idHourIn = data.dataAbsen![0].id;
                                  idHourOut = data.dataAbsen![1].id;
                                  return data.dataAbsen == null
                                      ? SizedBox()
                                      : Padding(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          child: Column(
                                            children: [
                                              InputCard(
                                                title: 'Jadwal Masuk Koreksi',
                                                hintText:
                                                    data.dataAbsen![0].hourIn,
                                                isEnable: false,
                                              ),
                                              InputCard(
                                                title: 'Jadwal Keluar Koreksi',
                                                hintText:
                                                    data.dataAbsen![1].hourIn,
                                                isEnable: false,
                                              )
                                            ],
                                          ),
                                        );
                                },
                              );
                            },
                          ),
                        ),
                        GestureDetector(
                            onTap: () => _selectedTime(context, 'in'),
                            child: InputCard(
                              title: 'Jam Masuk Koreksi',
                              typeDate: true,
                              time: 'time',
                              selectedDate: setInTime.format(context),
                            )),
                        GestureDetector(
                            onTap: () => _selectedTime(context, 'out'),
                            child: InputCard(
                              title: 'Jam Keluar Koreksi',
                              typeDate: true,
                              time: 'time',
                              selectedDate: setOutTime.format(context),
                            )),
                      ],
                    ),
              SizedBox(height: 90)
            ],
          ),
          (selectedType == 'Telat')
              ? ButtonRequestCard(
                  title: (isCekAbsen != true) ? 'Cek Absensi' : 'Submit',
                  isLoading: isLoading,
                  onTap: (isCekAbsen == true)
                      ? () => submitCorrection(context)
                      : () => cekAbesensi(context),
                )
              : ButtonRequestCard(
                  title: 'Submit',
                  isLoading: isLoading,
                  onTap: (widget.isUpdate != true)
                      ? () => submitCorrection(context)
                      : () => updateCorrection(context),
                )
        ],
      ),
    );
  }
}
