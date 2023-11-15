import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:women_safety_app/DBhelper/consts.dart';
import 'package:women_safety_app/Widgets/blogPost.dart';

class dbConnection {
  static var db, userConnection;
  static connect() async {
    db = await Db.create(DB_CONNECTION_URL);
    db.open();
    inspect(db);
    print("???????????????????DB?????????????????????????");
    userConnection = db.collection(USER_COLLECTION);
  }

  static Future<List<Map<String, dynamic>>> getPosts() async {
    final arrPosts = await userConnection.find().toList();
    return arrPosts;
  }

  static insertPost(Post post) async {
    try {
      var result = await userConnection.insertOne(post.toMap());
      print("Everything great , working fine now , inserted everything");

      print(result.toString());
    } catch (e) {
      log(e.toString(), error: e);
      print(e);
      print("Something went wrong, Kuch toh gadbad hai daya ");
    }
  }

  static updateLikeCount(String postId, int newLikeCount) async {
    try {
      var result = await userConnection.updateOne(
        where.eq('id', postId),
        modify.set('likeCount', newLikeCount),
      );
      print("Like count modified successfullt");
    } catch (e) {
      log(e.toString(), error: e);
      print("Failed to update like count");
      print(e);
    }
  }
}
