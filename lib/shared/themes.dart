part of 'shareds.dart';

Color white = Colors.white;
Color mainColor = Colors.red.shade900;
Color yellowAcc = Color(0xFFFBD460);
Color greyColor = Colors.grey.shade500; //"8D92A3".toColor();
Color lineGreyColor = "FAFAFC".toColor();
Color disableColor = "dcdde1".toColor();
Color blues = Colors.blue;

TextStyle blackFontStyleTitle = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500);
TextStyle blackFontStyleTitle1 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 22, fontWeight: FontWeight.w500);
TextStyle blackFontStyleTitle2 = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w500);
TextStyle blackFontStyleTitle3 =
    GoogleFonts.poppins().copyWith(color: Colors.black);
TextStyle blackFontStyleBold = GoogleFonts.poppins()
    .copyWith(color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold);
TextStyle greyFontStyleSubtitle = GoogleFonts.poppins()
    .copyWith(color: greyColor, fontSize: 16, fontWeight: FontWeight.w300);
TextStyle whiteFontStyle = GoogleFonts.poppins()
    .copyWith(color: white, fontSize: 16, fontWeight: FontWeight.w300);
TextStyle mainFontStyle = GoogleFonts.poppins()
    .copyWith(color: mainColor, fontSize: 16, fontWeight: FontWeight.bold);
TextStyle marronFontStyle = GoogleFonts.poppins().copyWith(color: mainColor);

const double defaultMargin = 24;
int selectedIndex = 0;

Widget loadingBounceIndicator = SpinKitThreeBounce(color: white, size: 24);
Widget loadingMainIndicator = SpinKitThreeBounce(color: mainColor, size: 24);
Widget loadingMinIndicator = SpinKitThreeBounce(color: white, size: 16);
Widget loadingMiniIndicator = Padding(
  padding: EdgeInsets.only(top: 24),
  child: SpinKitThreeBounce(color: mainColor, size: 14),
);

Widget loadingCircle = SpinKitCircle(color: white);
Widget loadingCircleRed = SpinKitCircle(color: mainColor);
