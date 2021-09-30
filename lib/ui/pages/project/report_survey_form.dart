part of '../pages.dart';

class ReportSurveyForm extends StatefulWidget {
  final bool isEdit;
  final Datum? data;
  ReportSurveyForm({this.isEdit = false, this.data});
  @override
  _ReportSurveyFormState createState() => _ReportSurveyFormState();
}

class _ReportSurveyFormState extends State<ReportSurveyForm> {
  SurveyShcedulePicker? shcedulePicker;
  WorkTypePicker? workPicker;
  UnitPrice? unitPrice;
  ServiceCategory? service;
  Cabang? cabang;
  List<ServicePicker>? listServicePicker;
  List<WorkTypePicker>? listWorkPicker;
  List<WorkMethodPicker>? listWorkMethod;
  List<MaterialPicker>? listMaterial;
  List<LocationPicker>? listLoc;
  List<AccessRoad>? listRoad;
  List<LandContour>? listLand;
  List<WallCondition>? wall;
  List<StructureCondition>? structure;
  List<FootprintCircumstance>? listFootprint;
  TextEditingController budgetCT = TextEditingController();
  TextEditingController existingBuildingArea = TextEditingController();
  TextEditingController existingLandArea = TextEditingController();
  TextEditingController buildingArea = TextEditingController();
  TextEditingController landArea = TextEditingController();
  TextEditingController note = TextEditingController();

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  var formatter = DateFormat("yyyy-MM-dd");
  List<AHSform> vPekerjaan = [];
  List<JobSummariesForm> vJob = [];
  List<Map<String, dynamic>> dataAHS = [];
  List<Map<String, dynamic>> dataJob = [];
  List<Map<String, dynamic>> dataImage = [];
  String title = 'Tambah';
  @override
  void initState() {
    super.initState();
    if (widget.isEdit == true) {
      title = 'Edit';
      budgetCT.text = widget.data!.budget!;
      existingBuildingArea.text = widget.data!.existingBuildingArea ?? '-';
      existingLandArea.text = widget.data!.existingLandArea ?? '-';
      buildingArea.text = widget.data!.buildingArea ?? '-';
      landArea.text = widget.data!.landArea ?? '-';
      note.text = widget.data!.note ?? '-';
      _selectedDay = widget.data!.requestDate;

      vPekerjaan = widget.data!.uPrice!.map((e) {
        var newAHS = AHS(title: e.name!, volume: e.volume!);
        return AHSform(
            user: newAHS,
            onDelete: () {
              onDelete(newAHS);
            });
      }).toList();
    }

    vJob = widget.data!.jobs!.map((e) {
      var newJobs = Jobs(
          ahs: e.price!.toString(),
          kasus: e.cases!,
          harga: e.totalPrice!.toString(),
          saran: e.suggestion!,
          image: e.imageJob!);
      return JobSummariesForm(
          job: newJobs,
          isDelete: () {
            onDeleteJob(newJobs);
          });
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final survey = Get.find<SurveyController>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: Text('$title Laporan Survey')),
      body: SingleChildScrollView(
        child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.symmetric(horizontal: 12),
            children: [
              SizedBox(height: 24),
              labelText('Referensi Jadwal Survey'),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white),
                child: ListTile(
                  title: Text(
                    (shcedulePicker == null)
                        ? (widget.isEdit == true)
                            ? widget.data!.subjekJadwal ?? ''
                            : 'Pilih Referensi Jadwal Survey'
                        : shcedulePicker!.text ?? '',
                    style: TextStyle(
                        color: (shcedulePicker == null)
                            ? Colors.grey
                            : Colors.black),
                  ),
                  onTap: () {
                    Get.to(() => ListSchedule())!.then((value) {
                      if (value != null && value is SurveyShcedulePicker) {
                        shcedulePicker = value;
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
              labelText('Kategori Bisnis'),
              TextField(
                //controller: controller.emailCT,
                readOnly: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(30, 16, 0, 16),
                  hintStyle: TextStyle(
                      color: (shcedulePicker == null)
                          ? Colors.grey
                          : Colors.black),
                  hintText: shcedulePicker == null ||
                          shcedulePicker!.businessCategory == null
                      ? '-'
                      : shcedulePicker!.businessCategory,
                ),
              ),
              labelText('Jasa'),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white),
                child: ListTile(
                  title: listServicePicker == null
                      ? Text(
                          'Pilih Jasa',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text(
                          '${listServicePicker!.map((e) => e.text).toString()}'),
                  onTap: () {
                    Get.to(() => ServicePickerPage())!.then((value) {
                      if (value != null && value is List<ServicePicker>) {
                        listServicePicker = value;
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
              labelText('Jenis Pekerjaan'),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white),
                child: ListTile(
                  title: listWorkPicker == null
                      ? widget.data!.accessRoad!.length > 0
                          ? Row(
                              children: widget.data!.accessRoad!
                                  .map((e) => Text('${e.name}, '))
                                  .toList())
                          : Text(
                              'Pilih Jenis Pekerjaan',
                              style: TextStyle(color: Colors.grey),
                            )
                      : Text(
                          '${listWorkPicker!.map((e) => e.text).toString()}'),
                  onTap: () {
                    Get.to(() => WorkPickerPage())!.then((value) {
                      if (value != null && value is List<WorkTypePicker>) {
                        listWorkPicker = value;
                        setState(() {});
                        print(listWorkPicker!.map((e) => e.id).toList());
                      }
                    });
                  },
                ),
              ),
              labelText('Metode Kerja'),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white),
                child: ListTile(
                  title: listWorkMethod == null
                      ? Text(
                          'Pilih Metode Kerja',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text(
                          '${listWorkMethod!.map((e) => e.name).toString()}'),
                  onTap: () {
                    Get.to(() => WorkMethodPickerPage())!.then((value) {
                      if (value != null && value is List<WorkMethodPicker>) {
                        listWorkMethod = value;
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
              labelText('Material/Chemical'),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white),
                child: ListTile(
                  title: listMaterial == null
                      ? Text(
                          'Pilih Material/Chemical',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text('${listMaterial!.map((e) => e.text).toString()}'),
                  onTap: () {
                    Get.to(() => MaterialPickerPage())!.then((value) {
                      if (value != null && value is List<MaterialPicker>) {
                        listMaterial = value;
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
              labelText('Akses Lokasi'),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white),
                child: ListTile(
                  title: listLoc == null
                      ? Text(
                          'Pilih Akses Lokasi',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text('${listLoc!.map((e) => e.text).toString()}'),
                  onTap: () {
                    Get.to(() => LocationPickerPage())!.then((value) {
                      if (value != null && value is List<LocationPicker>) {
                        listLoc = value;
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
              labelText('Akses  Jalan'),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white),
                child: ListTile(
                  title: listRoad == null
                      ? Text(
                          'Pilih Akses Jalan',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text('${listRoad!.map((e) => e.text).toString()}'),
                  onTap: () {
                    Get.to(() => RoadPickerPage())!.then((value) {
                      if (value != null && value is List<AccessRoad>) {
                        listRoad = value;
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
              labelText('Contur Tanah'),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white),
                child: ListTile(
                  title: listLand == null
                      ? Text(
                          'Pilih Contur Tanah',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text('${listLand!.map((e) => e.text).toString()}'),
                  onTap: () {
                    Get.to(() => LandPickerPage())!.then((value) {
                      if (value != null && value is List<LandContour>) {
                        listLand = value;
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
              labelText('Keadaan Tapak'),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white),
                child: ListTile(
                  title: listFootprint == null
                      ? Text(
                          'Pilih Keadaan Tapak',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text('${listFootprint!.map((e) => e.text).toString()}'),
                  onTap: () {
                    Get.to(() => FootPickerPage())!.then((value) {
                      if (value != null &&
                          value is List<FootprintCircumstance>) {
                        listFootprint = value;
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
              labelText('Keadaan Struktur'),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white),
                child: ListTile(
                  title: structure == null
                      ? Text(
                          'Pilih Keadaan Struktur',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text('${structure!.map((e) => e.text).toString()}'),
                  onTap: () {
                    Get.to(() => StructurePage())!.then((value) {
                      if (value != null && value is List<StructureCondition>) {
                        structure = value;
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
              labelText('Keadaan Dinding'),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: Colors.white),
                child: ListTile(
                  title: wall == null
                      ? Text(
                          'Pilih Keadaan Dinding',
                          style: TextStyle(color: Colors.grey),
                        )
                      : Text('${wall!.map((e) => e.text).toString()}'),
                  onTap: () {
                    Get.to(() => WallPage())!.then((value) {
                      if (value != null && value is List<WallCondition>) {
                        wall = value;
                        setState(() {});
                      }
                    });
                  },
                ),
              ),
              labelText('Luas Tanah Permintaan'),
              TextField(
                controller: landArea,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(30, 16, 0, 16),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Luas Tanah Permintaan'),
              ),
              labelText('Luas Bangunan Permintaan'),
              TextField(
                controller: buildingArea,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(30, 16, 0, 16),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Luas Bangunan Permintaan'),
              ),
              labelText('Luas Tanah Yang Sudah Ada'),
              TextField(
                controller: existingLandArea,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(30, 16, 0, 16),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Luas Tanah Yang Sudah Ada'),
              ),
              labelText('Luas Bangunan Yang Sudah Ada'),
              TextField(
                controller: existingBuildingArea,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(35),
                      borderSide: BorderSide.none,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: EdgeInsets.fromLTRB(30, 16, 0, 16),
                    hintStyle: TextStyle(color: Colors.grey),
                    hintText: 'Luas Bangunan Yang Sudah Ada'),
              ),
              labelText('Budget'),
              TextField(
                inputFormatters: [
                  CurrencyTextInputFormatter(
                    locale: 'id',
                    decimalDigits: 0,
                    symbol: '',
                  )
                ],
                controller: budgetCT,
                style: TextStyle(
                  color: Color(0xFF43A8FC),
                ),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                  prefix: Text('Rp '),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(30, 16, 0, 16),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Budget',
                ),
              ),
              labelText('Request Tanggal Pekerjaan'),
              //Calender
              Container(
                padding: EdgeInsets.only(
                  bottom: 25,
                  left: 0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: TableCalendar(
                    firstDay: kFirstDay,
                    lastDay: kLastDay,
                    focusedDay: _focusedDay,
                    availableGestures: AvailableGestures.horizontalSwipe,
                    availableCalendarFormats: {
                      CalendarFormat.month: 'Months',
                    },
                    selectedDayPredicate: (day) {
                      // Use `selectedDayPredicate` to determine which day is currently selected.
                      // If this returns true, then `day` will be marked as selected.

                      // Using `isSameDay` is recommended to disregard
                      // the time-part of compared DateTime objects.
                      return isSameDay(_selectedDay, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        // Call `setState()` when updating the selected day
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                          print(_selectedDay);
                          print(formatter.format(_selectedDay!.toLocal()));
                        });
                      }
                    },
                    onPageChanged: (focusedDay) {
                      // No need to call `setState()` here
                      _focusedDay = focusedDay;
                    },
                  ),
                ),
              ),
              labelText('Volume Pekerjaan'),
              vPekerjaan.length <= 0
                  ? Center(child: labelText('Data masih kosong'))
                  : SingleChildScrollView(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        addAutomaticKeepAlives: true,
                        itemCount: vPekerjaan.length,
                        itemBuilder: (ctx, i) => vPekerjaan[i],
                      ),
                    ),
              TextButton.icon(
                  onPressed: onAddForm,
                  icon: Icon(Icons.add),
                  label: Text('Tambah Volume Pekerjaan')),
              labelText('Daftar Ringkasan Pekerjaan'),
              vJob.length <= 0
                  ? Center(child: labelText('Data masih kosong'))
                  : SingleChildScrollView(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        addAutomaticKeepAlives: true,
                        itemCount: vJob.length,
                        itemBuilder: (ctx, i) => vJob[i],
                      ),
                    ),
              TextButton.icon(
                  onPressed: onAddFormJob,
                  icon: Icon(Icons.add),
                  label: Text('Tambah Ringkasan Pekerjaan')),
              labelText('Catatan'),
              TextField(
                minLines: 1,
                maxLines: 10,
                controller: note,
                style: TextStyle(
                  color: Color(0xFF43A8FC),
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(35),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: EdgeInsets.fromLTRB(30, 16, 0, 16),
                  hintStyle: TextStyle(color: Colors.grey),
                  hintText: 'Catatan',
                ),
              ),
              SizedBox(height: 12),
              Obx(
                () => ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    primary: mainColor,
                    minimumSize: Size(double.infinity, 45),
                  ),
                  onPressed: (widget.isEdit != true)
                      ? () async {
                          if (shcedulePicker == null) {
                            showBotToastText(
                                'Isian referensi jadwal wajib diisi');
                          } else if (listServicePicker == null) {
                            showBotToastText('Isian jasa wajib diisi');
                          } else if (listWorkPicker == null) {
                            showBotToastText(
                                'Isian jenis pekerjaan wajib diisi');
                          }
                          // } else if (listWorkMethodd == null) {
                          //   showBotToastText('Isian metode kerja wajib diisi');
                          // } else if (listLocd == null) {
                          //   showBotToastText(
                          //       'Isian location accesses wajib diisi');
                          // } else if (listRoadd == null) {
                          //   showBotToastText('Isian access roads wajib diisi');
                          // } else if (listLanddd == null) {
                          //   showBotToastText('Isian land contours wajib diisi');
                          // } else if (listFootprintdd == null) {
                          //   showBotToastText(
                          //       'Isian footprint circumstances wajib diisi');
                          // } else if (structuredd == null) {
                          //   showBotToastText(
                          //       'Isian structure condition wajib diisi');
                          // } else if (walldd == null) {
                          //   showBotToastText(
                          //       'Isian wall condition wajib diisi');
                          // } else if (landAreadd.text == '') {
                          //   showBotToastText('Isian land area wajib diisi');
                          // } else if (buildingAreadd.text == '') {
                          //   showBotToastText('Isian building area wajib diisi');
                          // } else if (existingLandAreadd.text == '') {
                          //   showBotToastText(
                          //       'Isian existing land area wajib diisi');
                          // } else if (existingBuildingAreadd.text == '') {
                          //   showBotToastText(
                          //       'Isian existing building area wajib diisi');
                          // } else if (budgetCTdd.text == '') {
                          //   showBotToastText('Isian budget wajib diisi');
                          // } else if (_selectedDay == null) {
                          //   showBotToastText('Isian request date wajib diisi');
                          // }
                          await onSave();
                          await onSaveJob();
                          setState(() {});
                          Map<String, dynamic> data = {
                            "origin": "android",
                            "survey_schedule_id": shcedulePicker!.id,
                            "site_project_id": authController.getCabangId(),
                            "existing_land_area": existingLandArea.text,
                            "existing_building_area": existingBuildingArea.text,
                            "land_area": landArea.text,
                            "building_area": buildingArea.text,
                            "budget": budgetCT.text.replaceAll(".", ""),
                            "request_date":
                                formatter.format(_selectedDay!.toLocal()),
                            "note": note.text,
                            if (listWorkPicker != null)
                              "work_types":
                                  listWorkPicker!.map((e) => e.id).toList(),
                            "services":
                                listServicePicker!.map((e) => e.id).toList(),
                            if (listWorkMethod != null)
                              "work_methods":
                                  listWorkMethod!.map((e) => e.id).toList(),
                            if (listMaterial != null)
                              "materials":
                                  listMaterial!.map((e) => e.id).toList(),
                            "job_summaries": dataJob,
                            if (listLoc != null)
                              "location_accesses":
                                  listLoc!.map((e) => e.id).toList(),
                            if (listRoad != null)
                              "access_roads":
                                  listRoad!.map((e) => e.id).toList(),
                            if (listLand != null)
                              "land_contours":
                                  listLand!.map((e) => e.id).toList(),
                            if (listFootprint != null)
                              "footprint_circumstances":
                                  listFootprint!.map((e) => e.id).toList(),
                            if (structure != null)
                              "structure_condition":
                                  structure!.map((e) => e.id).toList(),
                            if (wall != null)
                              "wall_condition": wall!.map((e) => e.id).toList(),
                            if (dataAHS.isNotEmpty) "unit_prices": dataAHS,
                          };
                          survey.createSurvey(data);
                        }
                      : () {
                          Get.back();
                        },
                  icon: Icon(Icons.done),
                  label: survey.isLoading.value == true
                      ? loadingBounceIndicator
                      : Text('Simpan'),
                ),
              ),
              SizedBox(height: 12),
            ]),
      ),
    );
  }

  ///on form user deleted
  void onDelete(AHS _user) {
    setState(() {
      var find = vPekerjaan.firstWhere(
        (it) => it.user == _user,
      );
      vPekerjaan.removeAt(vPekerjaan.indexOf(find));
    });
  }

  void onDeleteJob(Jobs _job) {
    setState(() {
      var find = vJob.firstWhere(
        (it) => it.job == _job,
      );
      vJob.removeAt(vJob.indexOf(find));
    });
  }

  ///on add form
  void onAddForm() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      var _user = AHS();
      vPekerjaan.add(AHSform(
        user: _user,
        onDelete: () => onDelete(_user),
      ));
    });
  }

  void onAddFormJob() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      var _job = Jobs();
      vJob.add(JobSummariesForm(
        job: _job,
        isDelete: () => onDeleteJob(_job),
      ));
    });
  }

  ///on save forms
  onSaveJob() {
    if (vJob.length > 0) {
      var allValids = true;
      vJob.forEach((form) => allValids = allValids && form.isValid());
      if (allValids) {
        //var data = vPekerjaan.map((it) => it.user).toList();
        vJob.forEach((element) {
          element.job!.image!.forEach((e) {
            return dataImage.add({
              "name": e.name,
              "image": e.image,
            });
          });
          return dataJob.add({
            "images": dataImage,
            "case": element.job!.kasus,
            "suggestion": element.job!.saran,
            "unit_price_id": element.job!.ahs,
          });
        });
        print(dataJob);
        logger.v(dataJob);
      }
    }
  }

  onSave() {
    if (vPekerjaan.length > 0) {
      var allValid = true;
      vPekerjaan.forEach((form) => allValid = allValid && form.isValid());
      if (allValid) {
        //var data = vPekerjaan.map((it) => it.user).toList();
        vPekerjaan.forEach((element) {
          return dataAHS.add({
            "unit_price_id": element.user!.title,
            "volume": element.user!.volume,
          });
        });
        print(dataAHS);
      }
    }
  }
}

Widget labelText(String label) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8),
    child: Text(
      label,
      style: TextStyle(
          color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
    ),
  );
}
