part of 'models.dart';

class Profile {
  String? image;
  String? desc;
  Profile({this.image, this.desc});
  factory Profile.fromJson(Map<String, dynamic> json) =>
      Profile(image: json['image'], desc: json['description']);
}

class PolicyAnnoun {
  int? id;
  int? uId;
  int? userId;
  String? desc;
  String? title;
  String? uName;
  String? createdAt;

  PolicyAnnoun({
    this.id,
    this.uId,
    this.desc,
    this.uName,
    this.title,
    this.userId,
    this.createdAt,
  });
  factory PolicyAnnoun.fromJson(Map<String, dynamic> json) => PolicyAnnoun(
        id: json['id'],
        title: json['title'],
        uId: json['user']['id'],
        userId: json['user_id'],
        desc: json['description'],
        uName: json['user']['name'],
        createdAt: json['created_at'],
      );
}
