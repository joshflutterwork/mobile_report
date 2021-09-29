// part of 'pages.dart';

// class LoginForm extends StatefulWidget {
//   final String playerID;
//   const LoginForm({Key key, this.playerID}) : super(key: key);

//   @override
//   LoginFormState createState() => LoginFormState();
// }

// class LoginFormState extends State<LoginForm> {
//   String title = "title";
//   String content = "content";
//   final _formKey = GlobalKey<FormState>();
//   //String _errorMessage = '';
//   bool isPasswordValid = false;
//   bool isSigningIn = false;
//   bool _secureText = true;
//   bool _isLoading = false;

//   showHide() {
//     setState(() {
//       _secureText = !_secureText;
//     });
//   }

//   TextEditingController emailController = TextEditingController(
//       text: kDebugMode ? 'admin@hr.bintorocorp.co.id' : '');
//   TextEditingController passController =
//       TextEditingController(text: kDebugMode ? 'admin' : '');

//   Future<void> submitForm() async {
//     setState(() => _isLoading = true);
//     //setState(() => _errorMessage = '');
//     bool result = await Provider.of<AuthProvider>(context, listen: false)
//         .login(emailController, passController);
//     if (result == false) {
//       setState(() {
//         //_errorMessage = 'Pastikan email dan password Anda benar';
//         // Flushbar(
//         //     duration: Duration(seconds: 5),
//         //     flushbarPosition: FlushbarPosition.BOTTOM,
//         //     backgroundColor: mainColor,
//         //     message: _errorMessage)
//         //   ..show(context);
//         setState(() => _isLoading = false);
//       });
//     } else {
//       storePlayer(context, playerId);
//       Get.off(() => MainPage());
//     }
//   }

//   String playerId = '';
//   fetchData() async {
//     final prefs = await SharedPreferences.getInstance();
//     setState(() {
//       playerId = prefs.getString('playerId');
//       print(playerId);
//     });
//   }

//   void storePlayer(context, String id) {
//     Provider.of<UserProvider>(context, listen: false)
//         .storeAppId(context, id)
//         .then((value) {
//       if (value) {
//         Get.snackbar(
//           "Berhasil",
//           "Selamat datang di Keluarga Bintoro",
//           icon: Icon(MdiIcons.rocketLaunchOutline, color: mainColor),
//           backgroundColor: white,
//           colorText: mainColor,
//         );
//       } else {
//         Get.snackbar(
//           "Failed",
//           "Maybe your phone isn't support",
//           icon: Icon(MdiIcons.closeCircleOutline, color: mainColor),
//           backgroundColor: white,
//           colorText: mainColor,
//         );
//       }
//     });
//   }

//   @override
//   void initState() {
//     fetchData();
//     super.initState();
//     OneSignal.shared.setNotificationReceivedHandler((notification) {
//       setState(() {
//         title = notification.payload.title;
//         content = notification.payload.body;
//       });
//     });
//     OneSignal.shared.setNotificationOpenedHandler((openedResult) {
//       print('tap notification');
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             colors: [
//               Colors.red[900],
//               Colors.red[800],
//               Colors.red[400],
//             ],
//           ),
//         ),
//         child: Form(
//           key: _formKey,
//           child: ListView(
//             children: [
//               SizedBox(height: 20),
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Container(
//                         margin: EdgeInsets.only(top: 30, bottom: 20),
//                         child: Text("Selamat Datang,\nKeluarga Bintoro",
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 24,
//                                 fontWeight: FontWeight.bold))),
//                   ],
//                 ),
//               ),
//               Container(
//                 height: MediaQuery.of(context).size.height,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(30),
//                     topRight: Radius.circular(30),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 24),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 65),
//                       TextField(
//                         controller: emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         cursorColor: Colors.red,
//                         decoration: InputDecoration(
//                             border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10)),
//                             labelText: "Email",
//                             hintText: "Email"),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 24),
//                         child: TextField(
//                           onChanged: (text) {
//                             setState(() {});
//                           },
//                           cursorColor: Colors.red,
//                           obscureText: _secureText,
//                           controller: passController,
//                           decoration: InputDecoration(
//                               border: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(10)),
//                               labelText: "Password",
//                               hintText: "Password",
//                               suffixIcon: IconButton(
//                                 onPressed: showHide,
//                                 icon: Icon(_secureText
//                                     ? Icons.visibility_off
//                                     : Icons.visibility),
//                               )),
//                         ),
//                       ),
//                       (playerId == null)
//                           ? Padding(
//                               padding: EdgeInsets.only(top: 32),
//                               child: Text("Please restart app before login"),
//                             )
//                           : SizedBox(height: 32),
//                       Container(
//                         height: 50,
//                         width: double.infinity,
//                         margin: EdgeInsets.only(top: 8, bottom: 30),
//                         child: RaisedButton(
//                             color: Colors.red[900],
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(8)),
//                             child: _isLoading
//                                 ? loadingBounceIndicator
//                                 : Text(
//                                     (playerId == null)
//                                         ? "Restart Now"
//                                         : "Login",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                             onPressed:
//                                 // (playerId == null)
//                                 //     ? () => exit(0)
//                                 //     :
//                                 () {
//                               setState(() => _isLoading = true);
//                               if (_formKey.currentState.validate()) {
//                                 _formKey.currentState.save();
//                                 submitForm();
//                               }
//                             }),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
