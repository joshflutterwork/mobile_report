part of 'widgets.dart';

class CommentCard extends StatelessWidget {
  final String? comment, username, userImage;
  final Function() onDelete, onUpdate;
  final int? time, idDB, idFB;
  CommentCard(this.username, this.userImage, this.comment, this.time,
      {required this.onDelete, required this.onUpdate, this.idDB, this.idFB});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(userImage!),
              backgroundColor: Colors.transparent),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: (idDB == idFB)
                    ? () {
                        Get.bottomSheet(
                          Container(
                            height: 100,
                            color: white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FlatButton.icon(
                                  onPressed: onUpdate,
                                  icon: Icon(Icons.edit_outlined),
                                  label: Text('Edit'),
                                ),
                                FlatButton.icon(
                                  onPressed: () => getOpenAlert(
                                    'Alert',
                                    'Anda yakin akan menghapus komentar ini ?',
                                    'Hapus',
                                    onConfirm: onDelete,
                                    onCancel: () {},
                                  ),
                                  icon: Icon(Icons.delete_outline_rounded),
                                  label: Text('Hapus'),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                    : () {},
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username!,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(comment!),
                      ],
                    ),
                  ),
                  width: width * 0.7,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                ),
              ),
              Text(readTimestamp(time!)),
            ],
          ),
        ],
      ),
    );
  }
}
