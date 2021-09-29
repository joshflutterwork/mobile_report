part of '../pages.dart';

class PostDetailPage extends StatefulWidget {
  final String? postID, username, userImage, userPost;
  final int? currentUserId;
  PostDetailPage(
      {this.postID,
      this.currentUserId,
      this.username,
      this.userImage,
      this.userPost});

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference post = firestore.collection('users');
    CollectionReference comment =
        firestore.collection('users').doc(widget.postID).collection('comment');
    CollectionReference likes =
        firestore.collection('users').doc(widget.postID).collection('like');

    TextEditingController commentTC = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('postingan ${widget.userPost!.toLowerCase()}'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(2, 2, 2, 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder<DocumentSnapshot>(
                          stream: post.doc(widget.postID).snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              return Card(
                                child: Column(children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 50,
                                        width: 50,
                                        margin: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 2,
                                              color: Colors.grey.shade100),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: NetworkImage(
                                                  ((snapshot.data!.data()
                                                      as dynamic))['image']),
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            (snapshot.data!.data()
                                                as dynamic)['name'],
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(readTimestamp((snapshot.data!
                                                  .data()
                                              as dynamic)['postTimeStamp'])),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 24, horizontal: 12),
                                      child: Text((snapshot.data!.data()
                                          as dynamic)['text']),
                                    ),
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      StreamBuilder<QuerySnapshot>(
                                        stream: likes.snapshots(),
                                        builder: (_, snapshot) {
                                          if (snapshot.hasData) {
                                            int lenght =
                                                snapshot.data!.docs.length;
                                            return Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(lenght == 0
                                                  ? ''
                                                  : '$lenght Suka'),
                                            );
                                          } else {
                                            return SizedBox();
                                          }
                                        },
                                      ),
                                      StreamBuilder<QuerySnapshot>(
                                        stream: comment.snapshots(),
                                        builder: (_, snapshot) {
                                          if (snapshot.hasData) {
                                            int lenght =
                                                snapshot.data!.docs.length;
                                            return Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(lenght == 0
                                                  ? ''
                                                  : '$lenght Komentar'),
                                            );
                                          } else {
                                            return SizedBox();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ]),
                              );
                            } else {
                              return SizedBox();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('users')
                        .doc(widget.postID)
                        .collection('comment')
                        .orderBy('postTimeStamp', descending: false)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data!.docs.length > 0
                            ? Column(
                                children: snapshot.data!.docs
                                    .map(
                                      (e) => CommentCard(
                                        (e.data() as dynamic)['createName'],
                                        (e.data() as dynamic)['createImage'],
                                        (e.data() as dynamic)['commentText'],
                                        (e.data() as dynamic)['postTimeStamp'],
                                        idDB: widget.currentUserId,
                                        idFB:
                                            (e.data() as dynamic)['commentBy'],
                                        onDelete: () {
                                          comment.doc(e.id).delete();
                                          Get.back();
                                          Get.back();
                                        },
                                        onUpdate: () {
                                          Get.to(
                                            () => EditPostPage(
                                              (e.data()
                                                  as dynamic)['createImage'],
                                              (e.data()
                                                  as dynamic)['commentText'],
                                              widget.postID!,
                                              e.id,
                                            ),
                                          );
                                        },
                                      ),
                                    )
                                    .toList(),
                              )
                            : Column(
                                children: [
                                  SizedBox(height: height * 0.05),
                                  Icon(Icons.forum_outlined,
                                      size: 175, color: greyColor),
                                  Text(
                                    'Belum Ada Komentar\nJadi yang pertama berkomentar',
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 30),
                                ],
                              );
                      } else {
                        return loadingMainIndicator;
                      }
                    },
                  )
                ],
              ),
            ),
          ),

          ///BOTTOM COMMENT
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            decoration: BoxDecoration(color: white, boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ]),
            child: Row(
              children: [
                Flexible(
                  child: TextField(
                    controller: commentTC,
                    cursorColor: mainColor,
                    decoration: InputDecoration.collapsed(
                        hintText: "Tulis komentar publik ..."),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 2.0),
                  child: IconButton(
                      icon: Icon(MdiIcons.sendCheck, color: mainColor),
                      onPressed: () {
                        comment.add({
                          "commentBy": widget.currentUserId,
                          "createName": widget.username,
                          "createImage": widget.userImage,
                          "commentText": commentTC.text,
                          'postTimeStamp':
                              DateTime.now().millisecondsSinceEpoch,
                        });
                        setState(() => commentTC.clear());
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
