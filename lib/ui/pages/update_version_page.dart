part of 'pages.dart';

class UpdateVersionPage extends StatelessWidget {
  final String? newVersion, linkGoogle, linkImage, message;
  UpdateVersionPage(
      {this.newVersion, this.linkGoogle, this.linkImage, this.message});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        actions: [
          Container(
            width: 150,
            height: 120,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/icons/logo_company.png'),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.network(linkImage!),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Update Aplikasi ke versi $newVersion ?',
                    style: blackFontStyleBold),
                SizedBox(height: 12),
                Text(message!),
              ],
            ),
          ),
          SizedBox(height: 80),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: RaisedButton(
            color: mainColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Text(
              "Update",
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => launchHandler(linkGoogle!),
          ),
        ),
      ),
    );
  }
}
