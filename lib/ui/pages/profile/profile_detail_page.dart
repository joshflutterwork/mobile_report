part of '../pages.dart';

class ProfileDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userController = Get.find<UserController>();
    var user = userController.user.value;
    Get.put(LeaveController());
    Get.put(AttendanceController());
    Get.put(SalaryController());
    return Scaffold(
      backgroundColor: white,
      body: DefaultTabController(
        length: 4,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverAppBar(
                backgroundColor: white,
                brightness: Brightness.light,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_rounded, color: Colors.black),
                  onPressed: () => Get.back(),
                ),
                // title: Text(
                //   'Profil karyawan',
                //   style: whiteFontStyle,
                // ),
                expandedHeight: height * 0.97,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  background: SafeArea(
                    child: Container(
                      color: white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 8),
                          GestureDetector(
                            onTap: () {},
                            //  => Get.to(PickImageDemo(
                            //   id: widget.id,
                            //   name: nameController.text,
                            //   address: addressController.text,
                            //   birth: birthController.text,
                            //   email: emailController.text,
                            //   phone: phoneController.text,
                            // )
                            // ),
                            child: Container(
                              width: 150,
                              height: 150,
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/icons/photo_border.png'),
                                ),
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage('${user.image}'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                            ),
                          ),
                          Column(children: [
                            Text('${user.name}',
                                style: blackFontStyleTitle,
                                textAlign: TextAlign.center),
                            Text('${user.job}',
                                style: greyFontStyleSubtitle.copyWith(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center),
                            SizedBox(height: 8),
                            Text('Employee ID : ${user.employeeId}',
                                style: blackFontStyleTitle2,
                                textAlign: TextAlign.center),
                            Text('Date of Join : ${user.joinDate}',
                                style: greyFontStyleSubtitle.copyWith(
                                    fontSize: 12),
                                textAlign: TextAlign.center),
                          ]),
                          Container(
                            width: double.infinity,
                            height: 45,
                            margin: EdgeInsets.only(top: 12),
                            padding: EdgeInsets.symmetric(horizontal: 70),
                            child: ElevatedButton(
                              onPressed: () => Get.to(() => ChangePassPage()),
                              child:
                                  Text('Ubah Password', style: whiteFontStyle),
                              style:
                                  ElevatedButton.styleFrom(primary: mainColor),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: generateDashedDivider(
                                MediaQuery.of(context).size.width -
                                    2 * defaultMargin),
                          ),
                          cardWidgetHoriz('No. Telepon :', '${user.birthday}'),
                          cardWidgetHoriz('Email :', '${user.email}'),
                          cardWidgetHoriz('Tgl Lahir :', '${user.birthday}'),
                          cardWidgetHoriz('Alamat :', '${user.address}'),
                          cardWidgetHoriz('Jenis Kelamin :', '${user.gender}'),
                          cardWidgetHoriz('Atasan :', '${user.reportTo}'),
                          lineCutObject(),
                          SizedBox(height: 28),
                        ],
                      ),
                    ),
                  ),
                ),
                bottom: TabBar(
                  isScrollable: true,
                  labelColor: white,
                  unselectedLabelColor: Colors.black,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(25), // Creates border
                      color: mainColor),
                  tabs: [
                    Tab(
                      child: Text('Profil'),
                    ),
                    Tab(
                      child: Text('Cuti'),
                    ),
                    Tab(
                      child: Text('Kehadiran'),
                    ),
                    Tab(
                      child: Text('Penggajian'),
                    ),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              ProfilePersonal(),
              ProfileCuti(),
              ProfileAbsen(),
              ProfileSalary(),
            ],
          ),
        ),
      ),
    );
  }
}

// class PickImageDemo extends StatefulWidget {
//   final String? name;
//   final String? email;
//   final String? birth;
//   final String? address;
//   final String? phone;
//   final int? id;

//   PickImageDemo(
//       {this.name, this.email, this.birth, this.address, this.phone, this.id})
//       : super();

//   @override
//   _PickImageDemoState createState() => _PickImageDemoState();
// }

// class _PickImageDemoState extends State<PickImageDemo> {
//   File? file;
//   File? update;

//   void _choose() async {
//     // = await ImagePicker.pickImage(source: ImageSource.camera);
//     // ignore: deprecated_member_use
//     file = await ImagePicker.pickImage(source: ImageSource.gallery);
//     setState(() {
//       update = file;
//     });
//   }

//   void _upload() async {
//     if (file == null) return;
//     String base64Image = base64Encode(file.readAsBytesSync());
//     String fileName = file.path.split("/").last;
//     String ext = fileName.split(".").last;
//     String send = "${ext}bintoro$base64Image";
//     if (file == null) {
//       // Flushbar(
//       //   duration: Duration(seconds: 5),
//       //   flushbarPosition: FlushbarPosition.BOTTOM,
//       //   backgroundColor: mainColor,
//       //   message: 'Pilih gambar terlebih dahulu',
//       // )..show(context);
//     } else {
//       await UserService.updateProfile(
//         context,
//         widget.id,
//         image: send,
//         name: widget.name,
//         email: widget.email,
//         birth: widget.birth,
//         phone: widget.phone,
//         address: widget.phone,
//       ).then((value) {
//         Get.back();
//       });
//     }
//     print(send);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Photo'),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(defaultMargin),
//         child: Column(
//           children: <Widget>[
//             file == null
//                 ? Container(
//                     width: 170,
//                     height: 170,
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/icons/photo_border.png'),
//                       ),
//                     ),
//                     child: Center(child: Text('No Image Selected')),
//                   )
//                 : Container(
//                     width: 170,
//                     height: 170,
//                     padding: EdgeInsets.all(8),
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: AssetImage('assets/icons/photo_border.png'),
//                       ),
//                     ),
//                     child: Container(
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         image: DecorationImage(
//                             image: FileImage(update), fit: BoxFit.cover),
//                       ),
//                     ),
//                   ),
//             SizedBox(height: defaultMargin),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 SizedBox(
//                   height: 45,
//                   child: RaisedButton(
//                     color: mainColor,
//                     onPressed: _choose,
//                     child: Text('Choose Image', style: whiteFontStyle),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 SizedBox(
//                   height: 45,
//                   child: RaisedButton(
//                     color: mainColor,
//                     onPressed: _upload,
//                     child: Text('Upload Image', style: whiteFontStyle),
//                   ),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
