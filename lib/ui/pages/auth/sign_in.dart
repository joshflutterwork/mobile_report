part of '../pages.dart';

class SignIn extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Colors.red.shade900,
              Colors.red.shade800,
              Colors.red.shade400,
            ],
          ),
        ),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 30, bottom: 20),
                      child: Text("Selamat Datang,\nKeluarga Bintoro",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold))),
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 65),
                      TextField(
                        controller: controller.emailCT,
                        keyboardType: TextInputType.emailAddress,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Email",
                            hintText: "Email"),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24),
                        child: TextField(
                          cursorColor: Colors.red,
                          obscureText: controller.secureText.value,
                          controller: controller.passwordCT,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10)),
                            labelText: "Password",
                            hintText: "Password",
                            suffixIcon: IconButton(
                              onPressed: controller.showHide,
                              icon: Icon(controller.secureText.value
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                          ),
                        ),
                      ),
                      // (playerId == null)
                      //     ? Padding(
                      //         padding: EdgeInsets.only(top: 32),
                      //         child: Text("Please restart app before login"),
                      //       )
                      //     : SizedBox(height: 32),
                      Container(
                        height: 50,
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 8, bottom: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            if (controller.emailCT.text == '' ||
                                controller.passwordCT.text == '') {
                              showBotToastText('Please fill in all the fields');
                              controller.isLoading.toggle();
                            }
                            controller.login();
                          },
                          style: ElevatedButton.styleFrom(primary: mainColor),
                          child: controller.isLoading.value
                              ? loadingMinIndicator
                              : Text(
                                  "Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                        // RaisedButton(
                        //     color: Colors.red[900],
                        //     shape: RoundedRectangleBorder(
                        //         borderRadius: BorderRadius.circular(8)),
                        //     child: controller.isLoading.value
                        //         ? loadingMinIndicator
                        //         : Text(
                        //             "Login",
                        //             style: TextStyle(color: Colors.white),
                        //           ),
                        //     onPressed:
                        //         // (playerId == null)
                        //         //     ? () => exit(0)
                        //         //     :
                        //         () {
                        //       controller.login();
                        //     }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
