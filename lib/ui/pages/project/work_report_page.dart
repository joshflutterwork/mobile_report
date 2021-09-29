part of '../pages.dart';

class WorkReportPage extends StatelessWidget {
  const WorkReportPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ReportController());
    return Scaffold(
      appBar: AppBar(
        title: Text('List laporan pekerjaan'),
      ),
      body: ListView(
        children: [
          Container(
            child: Row(children: [
              Expanded(
                child: TextField(
                  controller: controller.search,
                  onChanged: (text) {
                    //controller.onSearch(controller.search.text);
                  },
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(35),
                        borderSide: BorderSide.none,
                      ),
                      prefixIcon: Icon(Icons.search),
                      fillColor: Colors.white,
                      suffixIcon: (controller.isTyping.value)
                          ? IconButton(
                              onPressed: () {}, //=> controller.onTyping(),
                              icon: Icon(Icons.close_rounded,
                                  color: Colors.black),
                            )
                          : SizedBox(),
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(30, 16, 0, 16),
                      hintStyle: TextStyle(color: Colors.grey),
                      hintText: 'Search'),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: Colors.white),
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Unit Bisnis'),
                    onTap: () {
                      // Get.bottomSheet(Container(
                      //         height: Get.height * 0.5,
                      //         color: Colors.white,
                      //         child: (controller.listService.isEmpty)
                      //             ? loadingMainIndicator
                      //             : ListView.builder(
                      //                 controller: controller.scrollController,
                      //                 itemCount:
                      //                     controller.listService.length,
                      //                 itemBuilder: (context, index) {
                      //                   return GestureDetector(
                      //                     onTap: () {
                      //                       Get.back(
                      //                           result: controller
                      //                               .listService[index]);
                      //                     },
                      //                     child: Container(
                      //                       margin: EdgeInsets.all(12),
                      //                       height: 45,
                      //                       color: Colors.white,
                      //                       width: double.infinity,
                      //                       child: Text(controller
                      //                               .listService[index]
                      //                               .title ??
                      //                           ''),
                      //                     ),
                      //                   );
                      //                 },
                      //               )))
                      //     .then((value) {
                      //   if (value != null && value is ServiceCategory) {
                      //     service = value;
                      //     controller.box.write('unit_id', '${service!.id}');
                      //     setState(() {});
                      //     cabang = null;
                      //     print(controller.box.read('unit_id'));
                      //     controller.getSurveyReport();
                      //     controller.getCabang();

                      //     //showBotToastText('waiting...');
                      //   }
                      // });
                    },
                  ),
                ),
              ),
            ]),
          ),
          SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35), color: Colors.white),
            child: ListTile(
              leading: Icon(Icons.pin_drop_rounded),
              trailing:
                  //  (cabang == null)
                  //     ? SizedBox()
                  //     :
                  GestureDetector(
                      onTap: () {
                        // setState(() {
                        //   cabang = null;
                        //   controller.box.write('cabang', '');
                        //   controller.getSurveyReport();
                        // });
                      },
                      child: Icon(Icons.close, color: mainColor, size: 20)),
              title: Text('Cabang'),
              onTap:
                  // (controller.listCabang.isEmpty)
                  //     ? () {}:
                  () {
                // Get.bottomSheet(Container(
                //         height: Get.height * 0.5,
                //         color: Colors.white,
                //         child: (controller.isLoading.value)
                //             ? loadingMainIndicator
                //             : (controller.listCabang.isEmpty)
                //                 ? SizedBox()
                //                 : ListView.builder(
                //                     controller:
                //                         controller.scrollController,
                //                     itemCount:
                //                         controller.listCabang.length,
                //                     itemBuilder: (context, index) {
                //                       return GestureDetector(
                //                         onTap: () {
                //                           Get.back(
                //                               result: controller
                //                                   .listCabang[index]);
                //                         },
                //                         child: Container(
                //                           margin: EdgeInsets.all(12),
                //                           height: 45,
                //                           color: Colors.white,
                //                           width: double.infinity,
                //                           child: Text(controller
                //                                   .listCabang[index]
                //                                   .name ??
                //                               ''),
                //                         ),
                //                       );
                //                     },
                //                   )))
                //     .then((value) {
                //   if (value != null && value is Cabang) {
                //     cabang = value;
                //     controller.box.write(
                //         'cabang', '${cabang!.serviceCategoryId}');
                //     setState(() {});
                //     print(controller.box.read('cabang'));
                //     controller.getSurveyReport();
                //   }
                // });
              },
            ),
          ),
          (controller.isLoading.value)
              ? Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.35),
                  child: loadingCircleRed,
                )
              : controller.indexSurvey.value.total == 0
                  ? Center(
                      child: Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.35),
                      child: labelText('Data Kosong'),
                    ))
                  : Column(
                      children: [
                        ...controller.indexSurvey.value.data!.map(
                          (item) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(item.progress),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
