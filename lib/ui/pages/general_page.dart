part of 'pages.dart';

class GeneralPage extends StatelessWidget {
  final String title;
  final String subtitle;
  final Function()? onBackButton;
  final Widget? child;
  final Widget? childSub;
  final Widget? suffixArea;
  final Color? backColor;
  final Color? backgroundColor;
  final Color? lineColor;
  final Color? titleColor;
  final Color? subtitleColor;
  final Color? tabBarColor;
  final bool suffix;
  final bool sub;

  GeneralPage(
      {this.title = "Title",
      this.subtitle = "Subtitle",
      this.titleColor,
      this.subtitleColor,
      this.child,
      this.onBackButton,
      this.backgroundColor,
      this.lineColor,
      this.tabBarColor,
      this.childSub,
      this.suffix = false,
      this.suffixArea,
      this.sub = false,
      this.backColor});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: tabBarColor == null ? white : tabBarColor),
          SafeArea(
            child: Container(color: backColor ?? white),
          ),
          SafeArea(
            child: ListView(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      width: double.infinity,
                      color: backgroundColor == null ? white : backgroundColor,
                      height: 80,
                      child: Row(
                        children: [
                          onBackButton != null
                              ? GestureDetector(
                                  child: Container(
                                    width: 24,
                                    height: 24,
                                    margin: EdgeInsets.only(right: 24),
                                    child: Icon(Icons.arrow_back_ios_rounded),
                                  ),
                                  onTap: onBackButton,
                                )
                              : SizedBox(),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(title,
                                    style: blackFontStyleTitle.copyWith(
                                      color: titleColor == null
                                          ? Colors.black
                                          : titleColor,
                                    )),
                                sub == false
                                    ? Text(subtitle,
                                        style: greyFontStyleSubtitle.copyWith(
                                            color: subtitleColor == null
                                                ? greyColor
                                                : subtitleColor))
                                    : childSub ?? SizedBox()
                              ],
                            ),
                          ),
                          suffix == false ? SizedBox() : suffixArea!
                        ],
                      ),
                    ),
                    Container(
                      height: 6,
                      width: double.infinity,
                      color: lineColor == null ? lineGreyColor : lineColor,
                    ),
                    child!
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
