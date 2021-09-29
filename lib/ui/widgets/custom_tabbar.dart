part of 'widgets.dart';

class CustomTabbar extends StatelessWidget {
  final int selectedIndex;
  final List<String> titles;
  final Function(int) onTap;
  final Color colorTab;
  final Color onTitle;
  final Color stripColor;

  CustomTabbar(
      {required this.titles,
      required this.selectedIndex,
      required this.onTap,
      required this.colorTab,
      required this.stripColor,
      required this.onTitle});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Stack(
        children: [
          Container(
              margin: EdgeInsets.only(top: 48),
              height: 1,
              color: "F2F2F2".toColor()),
          Row(
            children: titles
                .map((e) => Padding(
                      padding: EdgeInsets.only(left: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (onTap != null) {
                                onTap(titles.indexOf(e));
                              }
                            },
                            child: Container(
                              height: 34,
                              decoration: (titles.indexOf(e) == selectedIndex)
                                  ? BoxDecoration(
                                      // gradient: LinearGradient(colors: [
                                      //   Colors.redAccent,
                                      //   Colors.orangeAccent
                                      // ]),
                                      borderRadius: BorderRadius.circular(8),
                                      color: colorTab != null
                                          ? colorTab
                                          : mainColor)
                                  : BoxDecoration(),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Text(e,
                                      style:
                                          (titles.indexOf(e) == selectedIndex)
                                              ? TextStyle(
                                                  fontSize: 16,
                                                  color: onTitle != null
                                                      ? onTitle
                                                      : white,
                                                  fontWeight: FontWeight.bold)
                                              : TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 16)),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 40,
                            height: 3,
                            margin: EdgeInsets.only(top: 13),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1.5),
                                color: (titles.indexOf(e) == selectedIndex)
                                    ? stripColor != null
                                        ? stripColor
                                        : "020202".toColor()
                                    : Colors.transparent),
                          )
                        ],
                      ),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}
