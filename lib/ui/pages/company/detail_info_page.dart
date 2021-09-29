part of '../pages.dart';

class DetailInfoPage extends StatelessWidget {
  final PolicyAnnoun model;
  DetailInfoPage({required this.model});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(model.title!),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            SizedBox(height: 12),
            Text(model.createdAt!,
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.end),
            SizedBox(height: 8),
            Text(model.desc!, textAlign: TextAlign.justify),
          ],
        ),
      ),
    );
  }
}
