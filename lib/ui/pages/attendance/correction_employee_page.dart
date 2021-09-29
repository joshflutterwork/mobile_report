part of '../pages.dart';

class CorrectionEmployeePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final correctionEmp = Get.put(CorrectionController());
    var formatter = DateFormat("dd-MM-yyyy");

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Flexible(
                    child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none, hintText: 'Search'),
                      controller: correctionEmp.search,
                      onChanged: (text) {
                        correctionEmp.onSearch(correctionEmp.search.text);
                      },
                    ),
                  ),
                  (correctionEmp.isTyping.value)
                      ? IconButton(
                          onPressed: () => correctionEmp.onTyping(),
                          icon: Icon(Icons.close_rounded, color: Colors.black),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ),
        ),
        body: ListView(
          children: [
            Container(
              padding: EdgeInsets.only(bottom: 90),
              child: (correctionEmp.isLoading.value)
                  ? Padding(
                      padding: EdgeInsets.only(top: height / 2.8),
                      child: loadingMainIndicator,
                    )
                  : (correctionEmp.employeeList.length != 0)
                      ? Column(
                          children: [
                            ...correctionEmp.employeeList.map((item) {
                              return cardCorrection(
                                  dateStart: formatter.format(item.dateStart!),
                                  dateEnd: (item.dateEnd != null)
                                      ? formatter.format(item.dateEnd!)
                                      : '',
                                  name: item.name!,
                                  reason: item.reason!,
                                  type: item.type!,
                                  status: item.status!,
                                  onDelete: () {
                                    correctionEmp.deleteCorrection(item.id!);
                                  },
                                  onUpdate: () {
                                    Get.to(
                                      () => CorrectionEmployeeForm(
                                        isUpdate: true,
                                        type: item.type!,
                                        reason: item.reason,
                                      ),
                                    );
                                    correctionEmp.getEdit(item.id!);
                                  });
                            }),
                          ],
                        )
                      : Padding(
                          padding: EdgeInsets.only(top: height / 2.8),
                          child: Text('Data tidak ditemukan',
                              textAlign: TextAlign.center),
                        ),
            )
          ],
        ),
        bottomNavigationBar: GestureDetector(
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              color: mainColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: Center(
              child: Text('Tambah Data', style: whiteFontStyle),
            ),
          ),
          onTap: () => Get.to(() => CorrectionEmployeeForm()),
        ),
      ),
    );
  }

  cardCorrection({
    String? dateStart,
    String? dateEnd,
    String? name,
    int? type,
    int? status,
    String? reason,
    required Function() onDelete,
    required Function() onUpdate,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(dateStart!),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Icon(Icons.arrow_forward_rounded),
              ),
              Text(dateEnd!),
            ],
          ),
          Text(name!),
          Text(type != 1 ? 'Absen' : 'Telat'),
          Text(reason!),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: lineGreyColor),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Icon(
                  Icons.arrow_drop_down_circle_outlined,
                  color: (status == 0)
                      ? Colors.purple
                      : (status == 1)
                          ? Colors.green
                          : Colors.red,
                ),
                SizedBox(width: 8),
                Text((status == 0)
                    ? 'New'
                    : (status == 1)
                        ? 'Head Approved'
                        : 'Head Declined'),
              ]),
            ),
          ),
          (status == 0)
              ? Row(
                  children: [
                    IconButton(icon: Icon(Icons.delete), onPressed: onDelete),
                    IconButton(icon: Icon(Icons.edit), onPressed: onUpdate)
                  ],
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
