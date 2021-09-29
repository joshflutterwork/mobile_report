part of '../pages.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserController());
    final postController = Get.put(PostController());
    TextEditingController? updateCT;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        Container(
          height: 80,
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Profile',
                          style: blackFontStyleTitle.copyWith(
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          '${userController.user.value.job}',
                          style:
                              greyFontStyleSubtitle.copyWith(color: greyColor),
                        )
                      ]),
                  IconButton(
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () => openAlertBox(
                      context,
                      onConfirm: () => Get.find<AuthController>().logout(),
                    ),
                  ),
                ]),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ElevatedButton.icon(
            onPressed: () => Get.to(() => ProfileDetailPage()),
            style: ElevatedButton.styleFrom(
                primary: mainColor,
                shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(15)))),
            label: Icon(Icons.arrow_forward_rounded),
            icon: Text('Detail'),
          ),
        ),
        Container(
          width: 110,
          height: 110,
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/icons/photo_border.png'),
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage('${userController.user.value.image}'),
                  fit: BoxFit.cover),
            ),
          ),
        ),
        Column(children: [
          SizedBox(height: 8),
          Text('${userController.user.value.name}'),
          Text('${userController.user.value.departmnet}'),
        ]),
        // Align(
        //   alignment: Alignment.centerLeft,
        //   child: Padding(
        //     padding: EdgeInsets.only(left: defaultMargin, top: defaultMargin),
        //     child: Text('Actions',
        //         style: blackFontStyleTitle.copyWith(fontSize: 16)),
        //   ),
        // ),
        // Padding(
        //   padding: const EdgeInsets.symmetric(horizontal: 8),
        //   child: GridView(
        //     physics: NeverScrollableScrollPhysics(),
        //     gridDelegate:
        //         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        //     scrollDirection: Axis.vertical,
        //     children: <Widget>[
        //       IconsMenu("Permintaan", Icons.request_quote_outlined,
        //           onTap: () {}),
        //       IconsMenu("Klaim", Icons.spa_outlined, onTap: () {}),
        //       IconsMenu("Tugas", Icons.history_edu_outlined, onTap: () {}),
        //       IconsMenu("Kehadiran", Icons.hail, onTap: () {}),
        //       IconsMenu("Persetujuan", Icons.approval, onTap: () {}),
        //       IconsMenu("Bagan Organisasi", Icons.account_tree_outlined,
        //           onTap: () {}),
        //       IconsMenu("Obrolan", Icons.chat_bubble_outline, onTap: () {}),
        //       IconsMenu("Karir", Icons.assignment_ind_outlined, onTap: () {}),
        //     ],
        //   ),
        // ),
        SizedBox(height: 50),
        Obx(
          () => Column(
            children: [
              ...postController.posted.map((e) {
                return (e.id == userController.user.value.id)
                    ? StatusPage(
                        name: '${e.name}',
                        title: '${e.title}',
                        image: '${e.image}',
                        idFB: e.id,
                        idDB: userController.user.value.id,
                        time: e.postTime,
                        onUpdate: () {
                          updateCT = TextEditingController(text: e.title);
                          Get.bottomSheet(
                            GetBottomSheet.postSheet(
                              controller: updateCT,
                              name: '${userController.user.value.name}',
                              imageProfile:
                                  '${userController.user.value.image}',
                              department:
                                  '${userController.user.value.departmnet}',
                              onPost: () => postController.updatePost(
                                  e.postId!, updateCT!),
                            ),
                          );
                        },
                        onDelete: () => postController.deletePost(e.postId!),
                        onComment: () {
                          Get.to(
                            () => PostDetailPage(
                              postID: e.postId,
                              currentUserId: userController.user.value.id,
                              username: '${userController.user.value.name}',
                              userImage: '${userController.user.value.image}',
                              userPost: e.name,
                            ),
                          );
                        },
                        onClick: () {},
                        onLike: () {},
                        child: Builder(
                          builder: (_) {
                            DocumentReference likes = FirebaseFirestore.instance
                                .collection('users')
                                .doc(e.postId)
                                .collection('like')
                                .doc('${userController.user.value.id}');
                            return StreamBuilder<DocumentSnapshot>(
                                stream: likes.snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return snapshot.data!.data() != null
                                        ? btnLike(
                                            userController.user.value.id!,
                                            false,
                                            e.postId!,
                                            'suka',
                                            Icons.thumb_up,
                                            Colors.blue.shade600,
                                            textColor: Colors.blue[600])
                                        : btnLike(
                                            userController.user.value.id!,
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
                      )
                    : SizedBox();
              }),
            ],
          ),
        ),
      ]),
    );
  }

  Widget btnLike(int userId, bool isLiked, String postId, String text,
      IconData icon, Color color,
      {Color? textColor}) {
    return InkWell(
      onTap: () {
        Get.find<PostController>()
            .onLikeButtonClicked(userId, postId, isLiked: isLiked);
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
