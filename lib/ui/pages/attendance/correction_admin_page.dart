part of '../pages.dart';

class CorrectionAdminPage extends StatefulWidget {
  @override
  _CorrectionAdminPageState createState() => _CorrectionAdminPageState();
}

class _CorrectionAdminPageState extends State<CorrectionAdminPage> {
  final _controller = TextEditingController();
  String _searchText = '';

  @override
  void initState() {
    _controller.addListener(
      () {
        setState(() {
          _searchText = _controller.text;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: lineGreyColor,
      appBar: AppBar(
        title: Text('Koreksi Absensi (Admin)'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Get.offAll(
            () => AttendancePage(),
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: white,
            child: TextField(
              controller: _controller,
              cursorColor: mainColor,
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
              // onChanged: (value) {
              //   Provider.of<LeaveProvider>(context, listen: false)
              //       .getEmployeeCorrection(context, _searchText);
              // },
            ),
          ),
          Container(
            height: height * 0.78,
            margin: EdgeInsets.symmetric(horizontal: 8),
            child: FutureBuilder(
              future: Provider.of<LeaveProvider>(context, listen: false)
                  .getEmployeeCorrection(context, _searchText, status: 'admin'),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return loadingMainIndicator;
                }
                return Consumer<LeaveProvider>(
                  builder: (context, data, _) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.dataCorrection!.length,
                      itemBuilder: (context, i) {
                        var status = data.dataCorrection![i].status;

                        return Card(
                          elevation: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(data.dataCorrection![i].name ?? '',
                                    style: blackFontStyleBold),
                                Row(children: [
                                  Text(data.dataCorrection![i].dateStart ?? ''),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8),
                                    child: Icon(MdiIcons.arrowRightThick),
                                  ),
                                  Text(data.dataCorrection![i].dateEnd ?? ''),
                                ]),
                                Text(data.dataCorrection![i].reason ?? ''),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: lineGreyColor),
                                    ),
                                    child: FlatButton.icon(
                                      label: Text(
                                          (status == 1)
                                              ? 'Head Approved'
                                              : (status == 2)
                                                  ? ' Head Declined'
                                                  : (status == 3)
                                                      ? 'Admin Approved'
                                                      : 'Admin Declined',
                                          style:
                                              TextStyle(color: Colors.black)),
                                      icon: Icon(
                                        Icons.arrow_drop_down_circle_outlined,
                                        color: (status == 0)
                                            ? Colors.deepPurple
                                            : (status == 1 || status == 3)
                                                ? Colors.green
                                                : mainColor,
                                      ),
                                      onPressed: (status == 1)
                                          ? () => showModalSheet(context,
                                              data.dataCorrection![i].id!)
                                          : null,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  late String type;
  late String selectedType;
  bool isLoading = false;

  void updateStatus(context, int id) {
    if (!isLoading) {
      setState(() => isLoading = true);
      Provider.of<LeaveProvider>(context, listen: false)
          .statusCorrection(context, id, 'admin',
              status: (selectedType == 'Admin Approved') ? 3 : 4)
          .then((value) {
        if (value) {
          Get.offAll(() => CorrectionAdminPage());
        } else {
          setState(() => isLoading = false);
          Get.snackbar("Failed", "Update Status Correction Failed",
              icon: Icon(MdiIcons.closeCircleOutline, color: white),
              backgroundColor: mainColor);
        }
      });
    }
  }

  void showModalSheet(BuildContext context, int id) {
    List type = ['Admin Approved', 'Admin Declined'];

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
                    color: (selectedType == "Admin Approved")
                        ? Colors.green
                        : mainColor,
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
          // child: DropdownButton<String?>(
          //   value: selectedType,
          //   hint: Text("Update status"),
          //   items: type.map((value) =>
          //           DropdownMenuItem(child: Text(value), value: value))
          //       .toList(),
          //   onChanged: (String? newType) {
          //     setState(() {
          //       selectedType = newType!;
          //     });
          //   },
          // ),
        ),
      ),
    );
  }
}
