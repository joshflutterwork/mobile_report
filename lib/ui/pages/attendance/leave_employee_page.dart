part of '../pages.dart';

class LeaveEmployeePage extends StatefulWidget {
  @override
  _LeaveEmployeePageState createState() => _LeaveEmployeePageState();
}

class _LeaveEmployeePageState extends State<LeaveEmployeePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lineGreyColor,
      appBar: AppBar(
        title: Text('Cuti & Izin'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => Get.offAll(
            () => AttendancePage(),
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(8),
        child: FutureBuilder(
          future: Provider.of<LeaveProvider>(context, listen: false)
              .getLeaves(context),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return loadingMainIndicator;
            }
            return Consumer<LeaveProvider>(
              builder: (context, data, _) {
                return ListView.builder(
                  itemCount: data.dataLeaves.length,
                  itemBuilder: (context, i) {
                    Color setColor() {
                      return data.dataLeaves[i].status == 'New'
                          ? Colors.deepPurple
                          : data.dataLeaves[i].status == 'Approved'
                              ? Colors.green
                              : mainColor;
                    }

                    return InkWell(
                      onTap: () {
                        if (data.dataLeaves[i].status == 'New') {
                          Get.to(
                            () => LeaveEmployeeForm(
                              isUpdate: true,
                              leaveId: data.dataLeaves[i].id,
                              nameLeave: data.dataLeaves[i].name,
                              reasonLeave: data.dataLeaves[i].reason,
                              dayLeave: data.dataLeaves[i].noOfDays,
                            ),
                          );
                        } else {
                          openAlertNoNew(context,
                              "You can't change your Leave. Has been approved or declined");
                        }
                      },
                      child: Card(
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(data.dataLeaves[i].name!,
                                      style: blackFontStyleBold),
                                  SizedBox(width: 8),
                                  Text(
                                      '( ${data.dataLeaves[i].noOfDays} day )'),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  children: [
                                    Text(data.dataLeaves[i].from!),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Icon(MdiIcons.arrowRightThick),
                                    ),
                                    Text(data.dataLeaves[i].to!),
                                  ],
                                ),
                              ),
                              Text("Alasan : ${data.dataLeaves[i].reason}",
                                  textAlign: TextAlign.justify),
                              Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(color: lineGreyColor),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          data.dataLeaves[i].status!,
                                          style: blackFontStyleTitle3.copyWith(
                                              color: setColor()),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(Icons.radio_button_checked_rounded,
                                            color: setColor(), size: 16),
                                      ],
                                    )),
                              ),
                            ],
                          ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => LeaveEmployeeForm()),
        backgroundColor: mainColor,
        child: Icon(Icons.add),
      ),
    );
  }
}
