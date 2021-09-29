part of 'controllers.dart';

class PostController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TextEditingController textController = TextEditingController();
  RxList<Posted> posted = <Posted>[].obs;
  String currentTime = Jiffy().yMMMMEEEEdjm;

  @override
  void onInit() {
    posted.bindStream(listPost());
    super.onInit();
  }

  Future<int?> getId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('id');
  }

  Stream<List<Posted>> listPost() {
    Stream<QuerySnapshot> stream = firestore
        .collection('users')
        .orderBy('postTimeStamp', descending: true)
        .snapshots();
    return stream.map((event) => event.docs
        .map(
          (e) => Posted(
              postId: e.id,
              id: (e.data() as dynamic)['id'],
              name: (e.data() as dynamic)['name'],
              image: (e.data() as dynamic)['image'],
              title: (e.data() as dynamic)['text'],
              postTime: (e.data() as dynamic)['postTimeStamp']),
        )
        .toList());
  }

  void addPost({String? name, String? image}) async {
    CollectionReference users = firestore.collection('users');
    int? userId = await getId();
    try {
      users.add({
        'postID': getRandomString(8) + Random().nextInt(500).toString(),
        'id': userId,
        'name': name,
        'text': textController.text,
        'image': image,
        'time': currentTime,
        'postTimeStamp': DateTime.now().millisecondsSinceEpoch,
        'postLikeCount': 0,
        'postCommentCount': 0,
      });
    } finally {
      Get.back();
      textController.clear();
    }
  }

  void updatePost(String id, TextEditingController title) {
    CollectionReference users = firestore.collection('users');
    try {
      users.doc(id).update({'text': title.text});
    } finally {
      textController.clear();
      Get.back();
    }
  }

  void deletePost(String id) {
    CollectionReference users = firestore.collection('users');
    users.doc(id).delete();
  }

  Future onLikeButtonClicked(int userId, String postId,
      {bool? isLiked, String? likeId}) async {
    // print('??? $isLiked');
    DocumentReference likes = firestore
        .collection('users')
        .doc(postId)
        .collection('like')
        .doc('$userId');
    return isLiked == true
        ? likes.set({
            "status": true,
          })
        : likes.delete();
  }
}
