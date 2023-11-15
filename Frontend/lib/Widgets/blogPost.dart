import 'package:mongo_dart/mongo_dart.dart';

class Post {
  String id;
  String username;
  String image;
  String title;
  String description;
  int likeCount;

  Post({
    required this.id,
    required this.username,
    required this.image,
    required this.title,
    required this.description,
    required this.likeCount,
  });
  Future<void> insertPost(Db db, Post post) async {
    final collection = db.collection('posts');
    await collection.insert(post.toMap());
  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'username': username,
      'image': image,
      'title': title,
      'description': description,
      'likeCount': likeCount,
    };
  }
}
