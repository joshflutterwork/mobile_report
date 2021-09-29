part of '../pages.dart';

class EditPostPage extends StatelessWidget {
  final String postID, commentID, userImage, commentText;
  EditPostPage(this.userImage, this.commentText, this.postID, this.commentID);
  @override
  Widget build(BuildContext context) {
    TextEditingController commentTC = TextEditingController(text: commentText);
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference comment =
        firestore.collection('users').doc(postID).collection('comment');
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit'),
        centerTitle: true,
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 24, 8, 0),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(userImage),
                    backgroundColor: Colors.transparent),
                Container(
                  width: width * 0.7,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      minLines: 1,
                      maxLines: 10,
                      controller: commentTC,
                      cursorColor: mainColor,
                      decoration: InputDecoration.collapsed(hintText: ""),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: Text(
                    'Batalkan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 12),
                RaisedButton(
                  color: mainColor,
                  onPressed: () => getOpenAlert(
                      'Alert',
                      'Apakah Anda yakin akan memperbaharui komentar ini ?',
                      'perbaharui', onConfirm: () {
                    comment.doc(commentID).update({
                      "commentText": commentTC.text,
                      'postTimeStamp': DateTime.now().millisecondsSinceEpoch,
                    });
                    Get.back();
                    Get.back();
                    Get.back();
                  }, onCancel: () {
                    Get.back();
                    Get.back();
                  }),
                  child: Text(
                    'Perbarui',
                    style: TextStyle(fontWeight: FontWeight.bold, color: white),
                  ),
                ),
                SizedBox(width: 24),
              ],
            )
          ])),
    );
  }
}
