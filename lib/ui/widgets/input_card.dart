part of 'widgets.dart';

class InputCard extends StatelessWidget {
  final String? title, hintText, selectedDate, time;
  final int? maxLine, minLine;
  final bool? isEnable, isNeedWidget, typeDate, keyNumber, autofocus;
  final Widget? child;
  final TextEditingController? controller;
  InputCard({
    this.time = '',
    this.controller,
    this.title,
    this.selectedDate = '',
    this.isEnable = true,
    this.typeDate = false,
    this.autofocus = false,
    this.keyNumber = false,
    this.isNeedWidget = false,
    this.child,
    this.hintText,
    this.maxLine = 1,
    this.minLine = 1,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
          child: Text(title!, style: blackFontStyleTitle2),
        ),
        Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: defaultMargin),
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: isEnable != true ? Colors.grey[300] : white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),
          child: (isNeedWidget != true && typeDate != true)
              ? TextField(
                  controller: controller,
                  cursorColor: mainColor,
                  maxLines: maxLine,
                  minLines: minLine,
                  enabled: isEnable,
                  autofocus: autofocus!,
                  keyboardType: keyNumber != true ? null : TextInputType.number,
                  decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none,
                      hintStyle: isEnable != true
                          ? blackFontStyleTitle2.copyWith(letterSpacing: 1.3)
                          : greyFontStyleSubtitle),
                )
              : (typeDate == true)
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(selectedDate!,
                              style: blackFontStyleTitle2.copyWith(
                                  letterSpacing: 1.3)),
                          Icon((time != 'time')
                              ? MdiIcons.calendar
                              : MdiIcons.clockOutline)
                        ],
                      ),
                    )
                  : child,
        )
      ],
    );
  }
}
