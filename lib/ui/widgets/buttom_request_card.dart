part of 'widgets.dart';

class ButtonRequestCard extends StatelessWidget {
  final Function() onTap;
  final bool isLoading;
  final String? title;
  ButtonRequestCard({required this.onTap, this.isLoading = false, this.title});
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(-5, 0),
                  blurRadius: 15,
                  spreadRadius: 3)
            ],
          ),
          width: double.infinity,
          height: 45,
          child: isLoading
              ? loadingMainIndicator
              : Center(
                  child: Text(title!, style: mainFontStyle),
                ),
        ),
      ),
    );
  }
}
