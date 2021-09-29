part of 'widgets.dart';

class CardRequest extends StatelessWidget {
  final IconData? icon;
  final Image? image;
  final String? name, startDate, endDate;
  final Function() onDraft, onSubmit;
  CardRequest(
      {this.icon,
      required this.onDraft,
      required this.onSubmit,
      this.image,
      this.name,
      this.startDate,
      this.endDate});
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: defaultMargin, top: defaultMargin),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(imgBin), fit: BoxFit.cover),
              ),
            ),
            cardCorrection(title: 'Requested for', value: 'SAM SUDIN'),
          ],
        ),
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              margin: const EdgeInsets.only(
                  left: defaultMargin, top: defaultMargin),
              decoration: BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(icon == null ? Icons.date_range_rounded : icon,
                  color: white),
            ),
            cardCorrection(title: 'Start Date', value: '16-02-2021'),
            cardCorrection(title: 'End Date', value: '18-02-2021'),
          ],
        ),
        lineCutObject(),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: defaultMargin),
            child: Text(
              "Details",
              style: blackFontStyleTitle2.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Divider(indent: defaultMargin, endIndent: defaultMargin),
        GestureDetector(
          onTap: () {
            // showDialog(
            //     context: context,
            //     builder: (context) {
            //       return AlertDialog(
            //         title: Text('TEST'),
            //       );
            //     });
            showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: true,
                backgroundColor: white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                builder: (BuildContext bc) {
                  return DraggableScrollableSheet(
                      initialChildSize: 0.98,
                      minChildSize: 0.2,
                      maxChildSize: 0.98,
                      builder: (context, scroll) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            cardCorrection(title: 'Date', value: '8 Feb 2021'),
                            lineCutObject(),
                            Padding(
                              padding: EdgeInsets.only(left: defaultMargin),
                              child: Text('Shift'),
                            ),
                            Divider(),
                            Container(
                              margin: EdgeInsets.only(left: defaultMargin),
                              width: double.infinity,
                              child:
                                  Text("Reason", style: blackFontStyleTitle2),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: defaultMargin,
                                  vertical: defaultMargin),
                              width: double.infinity,
                              child: TextField(
                                cursorColor: mainColor,
                                maxLines: 3,
                                decoration: InputDecoration(
                                    hintStyle: greyFontStyleSubtitle),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: defaultMargin),
                              child:
                                  Text('Before', style: blackFontStyleTitle2),
                            ),
                            cardListCorrection('Start Time', 'End Time',
                                style1: greyFontStyleSubtitle),
                            cardListCorrection('--:--', '--:--',
                                style1: greyFontStyleSubtitle),
                            SizedBox(height: defaultMargin),
                            Padding(
                              padding: EdgeInsets.only(left: defaultMargin),
                              child: Text('After', style: blackFontStyleTitle2),
                            ),
                            cardListCorrection('Start Time', 'End Time',
                                style1: greyFontStyleSubtitle),
                            cardListCorrection('--:--', '--:--',
                                style1: greyFontStyleSubtitle),
                            Divider(thickness: 1.8),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      height: 40,
                                      child: RaisedButton(
                                        onPressed: () {},
                                        elevation: 0,
                                        color: greyColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text('Update',
                                            style: whiteFontStyle),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Expanded(
                                    child: Container(
                                      width: double.infinity,
                                      height: 40,
                                      child: RaisedButton(
                                        onPressed: () {},
                                        elevation: 0,
                                        color: mainColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8)),
                                        child: Text('Delete',
                                            style: whiteFontStyle),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        );
                      });
                });
          },
          child: Container(
            color: white,
            child: Column(
              children: [
                cardListCorrection('08-02-2021', 'NO SHIF', color1: mainColor),
                cardListCorrection('--:-- | --:--', 'No Change',
                    color: greyColor),
              ],
            ),
          ),
        ),
        SizedBox(height: height * 0.2),
        Divider(thickness: 1.8),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {},
                    elevation: 0,
                    color: greyColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Text('Draft', style: whiteFontStyle),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  width: double.infinity,
                  height: 40,
                  child: RaisedButton(
                    onPressed: () {},
                    elevation: 0,
                    color: mainColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    child: Text('Submit', style: whiteFontStyle),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget cardCorrection({String? title, String? value}) {
    return Padding(
      padding: const EdgeInsets.only(left: defaultMargin, top: defaultMargin),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title!, style: blackFontStyleTitle2),
          Text(value!,
              style:
                  greyFontStyleSubtitle.copyWith(fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
