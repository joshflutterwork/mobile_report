part of '../pages.dart';

class CorrectionEmployeeForm extends StatefulWidget {
  final bool isUpdate;
  final int type;
  final String? reason;
  CorrectionEmployeeForm({this.isUpdate = false, this.type = 0, this.reason});
  @override
  _CorrectionEmployeeFormState createState() => _CorrectionEmployeeFormState();
}

class _CorrectionEmployeeFormState extends State<CorrectionEmployeeForm> {
  final correctionEmp = Get.find<CorrectionController>();
  List<String> type = ['Absen', 'Telat'];
  String? selectedType;
  int indexType = 0;
  TextEditingController? reasonCT;
  DateTime setFirstDate = DateTime.now();
  DateTime setEndDate = DateTime.now();
  late DateTime updateFirstDate;
  late DateTime updateEndDate;
  TimeOfDay setInTime = TimeOfDay.now();
  TimeOfDay setOutTime = TimeOfDay.now();
  var formatter = DateFormat("dd/MM/yyyy");
  var sendFormat = DateFormat("yyyy-MM-dd");

  _selectDate(BuildContext context, String type) async {
    final DateTime? picked = await showDatePicker(
      currentDate: DateTime.now(),
      context: context,
      initialDate: (type == 'first') ? setFirstDate : setEndDate,
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
    if (picked != null && picked != setFirstDate && type == 'first') {
      setState(() => setFirstDate = picked);
    } else if (picked != null && picked != setEndDate && type == 'end') {
      setState(() => setEndDate = picked);
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

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      String data = (widget.type == 0) ? 'Absen' : 'Telat';
      selectedType = type.firstWhere((e) => e == data);
      reasonCT = TextEditingController(text: widget.reason);
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (widget.isUpdate) {
      reasonCT!.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isUpdate ? 'Edit' : 'Tambah Data'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          //testGetEdit(),
          InputCard(
            title: 'Alasan',
            hintText: 'Alasan',
            minLine: 1,
            maxLine: 3,
            controller: (widget.isUpdate) ? reasonCT : correctionEmp.reason,
          ),
          InputCard(
            title: 'Tipe',
            isNeedWidget: true,
            child: DropdownButton<String>(
              underline: Container(color: Colors.transparent),
              onChanged: (val) {
                FocusScope.of(context).requestFocus(FocusNode());
                selectedType = val!;
                if (mounted) setState(() {});
              },
              hint: Text('Type'),
              isExpanded: true,
              value: selectedType,
              dropdownColor: Colors.white,
              elevation: 25,
              items: type.map((v) {
                return DropdownMenuItem(
                  child: Text('$v'),
                  value: v,
                );
              }).toList(),
            ),
          ),
          (selectedType == 'Absen')
              ? Column(children: [
                  GestureDetector(
                    onTap: () {
                      _selectDate(context, 'first');
                      setState(() {});
                    },
                    child: InputCard(
                      title: 'Tanggal Awal',
                      typeDate: true,
                      selectedDate: formatter.format(setFirstDate.toLocal()),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectDate(context, 'end'),
                    child: InputCard(
                      title: 'Tanggal Akhir',
                      typeDate: true,
                      selectedDate: formatter.format(setEndDate.toLocal()),
                    ),
                  )
                ])
              : (widget.isUpdate && selectedType == 'Telat')
                  ? Column(
                      children: [
                        Obx(
                          () => (correctionEmp.getEdited.value.dateStart ==
                                  null)
                              ? loadingMiniIndicator
                              : GestureDetector(
                                  onTap: () => _selectDate(context, 'first'),
                                  child: InputCard(
                                    title: 'Tanggal',
                                    typeDate: true,
                                    selectedDate: (widget.isUpdate)
                                        ? formatter.format(correctionEmp
                                            .getEdited.value.dateStart!)
                                        : formatter
                                            .format(setFirstDate.toLocal()),
                                  ),
                                ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(24),
                          child: bottonBottom('Cek Absensi',
                              border: BorderRadius.circular(8), onTap: () {
                            correctionEmp.checkAbsen(
                                sendFormat.format(setFirstDate.toLocal()));
                          }),
                        ),
                        resultCekAbsen(),
                      ],
                    )
                  : (widget.isUpdate == false && selectedType == 'Telat')
                      ? Column(
                          children: [
                            GestureDetector(
                              onTap: () => _selectDate(context, 'first'),
                              child: InputCard(
                                title: 'Tanggal',
                                typeDate: true,
                                selectedDate:
                                    formatter.format(setFirstDate.toLocal()),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(24),
                              child: bottonBottom('Cek Absensi',
                                  border: BorderRadius.circular(8), onTap: () {
                                correctionEmp.checkAbsen(
                                    sendFormat.format(setFirstDate.toLocal()));
                              }),
                            ),
                            resultCekAbsen(),
                          ],
                        )
                      : SizedBox(),
          SizedBox(height: 90),
        ],
      ),
      bottomNavigationBar: (selectedType != 'Telat')
          ? bottonBottom((widget.isUpdate) ? 'Edit' : 'Submit', onTap: () {
              if (widget.isUpdate) {
                correctionEmp.addCorrection(
                    formatter.format(setFirstDate.toLocal()),
                    formatter.format(setEndDate.toLocal()),
                    indexType,
                    id: correctionEmp.getEdited.value.id,
                    reasonCT: reasonCT!.text,
                    isUpdate: true);
              } else {
                correctionEmp.addCorrection(
                    formatter.format(setFirstDate.toLocal()),
                    formatter.format(setEndDate.toLocal()),
                    indexType);
              }
            })
          : SizedBox(),
    );
  }

  resultCekAbsen() {
    return Obx(() => (correctionEmp.hourList.length != 0)
        ? Column(
            children: [
              InputCard(
                title: 'Jam Masuk Awal',
                hintText: correctionEmp.hourList[0].hourIn.toString(),
                isEnable: false,
              ),
              InputCard(
                title: 'Jadwal Keluar Awal',
                hintText: correctionEmp.hourList[1].hourIn.toString(),
                isEnable: false,
              ),
              GestureDetector(
                onTap: () => _selectedTime(context, 'in'),
                child: InputCard(
                  title: 'Jam Masuk Koreksi',
                  typeDate: true,
                  time: 'time',
                  selectedDate: setInTime.format(context),
                ),
              ),
              GestureDetector(
                onTap: () => _selectedTime(context, 'out'),
                child: InputCard(
                  title: 'Jam Keluar Koreksi',
                  typeDate: true,
                  time: 'time',
                  selectedDate: setOutTime.format(context),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(24),
                child: bottonBottom('Submit', border: BorderRadius.circular(8),
                    onTap: () {
                  correctionEmp.addCorrection(
                      formatter.format(setFirstDate.toLocal()),
                      formatter.format(setEndDate.toLocal()),
                      1,
                      attendanceId: (correctionEmp.hourList[0].id ==
                              correctionEmp.hourList[1].id)
                          ? '[${correctionEmp.hourList[0].id}]'
                          : '[${correctionEmp.hourList[0].id},${correctionEmp.hourList[1].id}]',
                      hourIn: '${setInTime.format(context)}:00',
                      hourOut: '${setOutTime.format(context)}:00');
                }),
              )
            ],
          )
        : (widget.isUpdate == true)
            ? Column(
                children: [
                  GestureDetector(
                    onTap: () => _selectedTime(context, 'in'),
                    child: InputCard(
                      title: 'Jam Masuk Koreksi',
                      typeDate: true,
                      time: 'time',
                      selectedDate: setInTime.format(context),
                    ),
                  ),
                  GestureDetector(
                    onTap: () => _selectedTime(context, 'out'),
                    child: InputCard(
                      title: 'Jam Keluar Koreksi',
                      typeDate: true,
                      time: 'time',
                      selectedDate: setOutTime.format(context),
                    ),
                  ),
                  (correctionEmp.getEdited.value.correctDetail == null)
                      ? loadingMiniIndicator
                      : Column(
                          children: [
                            ...correctionEmp.getEdited.value.correctDetail!.map(
                              (e) {
                                return Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(24),
                                      child: bottonBottom(
                                        'Edit',
                                        border: BorderRadius.circular(8),
                                        onTap: () {
                                          correctionEmp.addCorrection(
                                              formatter.format(
                                                  setFirstDate.toLocal()),
                                              formatter
                                                  .format(setEndDate.toLocal()),
                                              1,
                                              isUpdate: true,
                                              attendanceId: e.attendanceId,
                                              reasonCT: reasonCT!.text,
                                              id: correctionEmp
                                                  .getEdited.value.id,
                                              hourIn:
                                                  '${setInTime.format(context)}:00',
                                              hourOut:
                                                  '${setOutTime.format(context)}:00');
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                ],
              )
            : SizedBox());
  }

  bottonBottom(String title,
      {required Function() onTap, BorderRadiusGeometry? border}) {
    return Obx(
      () => GestureDetector(
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: mainColor,
            borderRadius: border != null
                ? border
                : BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
          ),
          child: Center(
            child: (correctionEmp.isLoading.value)
                ? loadingBounceIndicator
                : Text(title, style: whiteFontStyle),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  testGetEdit() {
    return Obx(
      () => Column(children: [
        Text('${correctionEmp.getEdited.value.id}'),
        Text('${correctionEmp.getEdited.value.userId}'),
        Text('${correctionEmp.getEdited.value.dateStart}'),
        Text('${correctionEmp.getEdited.value.dateEnd}'),
        ...correctionEmp.getEdited.value.correctDetail!.map((e) {
          return Column(children: [
            Text('${e.id}'),
            Text('${e.correctId}'),
            Text('${e.attendanceId}'),
            Text('${e.hourIn}'),
            Text('${e.hourOut}'),
          ]);
        }),
      ]),
    );
  }
}
