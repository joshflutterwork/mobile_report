part of 'pages.dart';

class HomePage extends StatelessWidget {
  final userCT = Get.find<UserController>();
  final postCT = Get.put(PostController());
  @override
  Widget build(BuildContext context) {
    TextEditingController? updateCT;
    return Obx(
      () => (userCT.user.value.name != null)
          ? GeneralPage(
              title: 'Selamat Datang,',
              sub: true,
              childSub: Shimmer(
                gradient: LinearGradient(
                    stops: [0.45, 0.5, 0.55],
                    colors: [Colors.white, Colors.grey.shade500, Colors.white]),
                child: Text('Hi, ${userCT.user.value.name}',
                    style: whiteFontStyle.copyWith(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              backgroundColor: mainColor,
              lineColor: mainColor,
              titleColor: white,
              subtitleColor: white,
              tabBarColor: mainColor,
              child: Column(
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: CustomShapeClippers(),
                        child: Container(
                          height: 200,
                          decoration: BoxDecoration(color: mainColor),
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          width: double.infinity,
                          height: 65,
                          margin: EdgeInsets.symmetric(
                              horizontal: 24, vertical: 24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(13),
                            color: white,
                          ),
                          child: Row(
                            children: [
                              Container(
                                height: 50,
                                width: 50,
                                margin: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      width: 2, color: Colors.grey.shade100),
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          '${userCT.user.value.image}'),
                                      fit: BoxFit.cover),
                                ),
                              ),
                              Text("Share something great today...")
                            ],
                          ),
                        ),
                        onTap: () {
                          Get.bottomSheet(
                            GetBottomSheet.postSheet(
                              controller: postCT.textController,
                              name: '${userCT.user.value.name}',
                              imageProfile: '${userCT.user.value.image}',
                              department: '${userCT.user.value.departmnet}',
                              onPost: () => postCT.addPost(
                                name: '${userCT.user.value.name}',
                                image: '${userCT.user.value.image}',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      ...postCT.posted.map((e) {
                        return StatusPage(
                          name: '${e.name}',
                          title: '${e.title}',
                          image: '${e.image}',
                          idFB: e.id,
                          idDB: userCT.user.value.id,
                          time: e.postTime,
                          onUpdate: () {
                            updateCT = TextEditingController(text: e.title);
                            Get.bottomSheet(
                              GetBottomSheet.postSheet(
                                controller: updateCT,
                                name: '${userCT.user.value.name}',
                                imageProfile: '${userCT.user.value.image}',
                                department: '${userCT.user.value.departmnet}',
                                onPost: () =>
                                    postCT.updatePost(e.postId!, updateCT!),
                              ),
                            );
                          },
                          onDelete: () => postCT.deletePost(e.postId!),
                          onComment: () {
                            Get.to(
                              () => PostDetailPage(
                                postID: e.postId,
                                currentUserId: userCT.user.value.id,
                                username: '${userCT.user.value.name}',
                                userImage: '${userCT.user.value.image}',
                                userPost: e.name,
                              ),
                            );
                          },
                          onClick: () {},
                          onLike: () {},
                          child: Builder(
                            builder: (_) {
                              DocumentReference likes = FirebaseFirestore
                                  .instance
                                  .collection('users')
                                  .doc(e.postId)
                                  .collection('like')
                                  .doc('${userCT.user.value.id}');
                              return StreamBuilder<DocumentSnapshot>(
                                  stream: likes.snapshots(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return snapshot.data!.data() != null
                                          ? btnLike(
                                              userCT.user.value.id!,
                                              false,
                                              e.postId!,
                                              'suka',
                                              Icons.thumb_up,
                                              Colors.blue.shade600,
                                              textColor: Colors.blue[600])
                                          : btnLike(
                                              userCT.user.value.id!,
                                              true,
                                              e.postId!,
                                              'suka',
                                              Icons.thumb_up_alt_outlined,
                                              Colors.black);
                                    }
                                    return loadingMinIndicator;
                                  });
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(height: 35),
                  Text('${packageInfo!.appName} v${packageInfo!.version}'),
                  SizedBox(height: 55)
                ],
              ),
            )
          : loadingCircleRed,
    );
  }

  Widget btnLike(int userId, bool isLiked, String postId, String text,
      IconData icon, Color color,
      {Color? textColor}) {
    return InkWell(
      onTap: () {
        postCT.onLikeButtonClicked(userId, postId, isLiked: isLiked);
      },
      child: Row(
        children: [
          SizedBox(width: 12),
          Icon(icon, color: color),
          SizedBox(width: 8),
          Text(text, style: TextStyle(color: textColor)),
        ],
      ),
    );
  }
}
