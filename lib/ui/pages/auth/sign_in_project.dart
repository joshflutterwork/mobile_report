// part of '../pages.dart';

// class SignInProject extends GetView<AuthController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(24),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SizedBox(height: 30),
//             TextField(
//               controller: controller.emailCT,
//               keyboardType: TextInputType.emailAddress,
//               cursorColor: Colors.red,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   labelText: "Email",
//                   hintText: "Email"),
//             ),
//             SizedBox(height: 30),
//             TextField(
//               controller: controller.passwordController,
//               keyboardType: TextInputType.emailAddress,
//               cursorColor: Colors.red,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   labelText: "Password",
//                   hintText: "Password"),
//             ),
//             SizedBox(height: 30),
//             Obx(
//               () => Container(
//                 height: 50,
//                 width: double.infinity,
//                 margin: EdgeInsets.only(top: 8, bottom: 30),
//                 child: RaisedButton(
//                     color: Colors.red[900],
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8)),
//                     child: controller.isLoading.value
//                         ? loadingMinIndicator
//                         : Text(
//                             "Login",
//                             style: TextStyle(color: Colors.white),
//                           ),
//                     onPressed: () => controller.loginProject()),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
