// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:women_safety_app/DBhelper/db_connection.dart';
import 'package:women_safety_app/Widgets/ExpendedText.dart';
import 'package:women_safety_app/Widgets/blogPost.dart';
import 'package:women_safety_app/DBhelper/consts.dart';

import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String username = "John Doe";
  final String image =
      "https://raw.githubusercontent.com/yash9111/Datastore/master/images/default.png";

  List<Post> posts = [];
  // final dbConnection dbConnection = dbConnection();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // Simulating fetching data from a database using dbConnection.getPosts()
      List<Map<String, dynamic>> fetchedPosts = await dbConnection.getPosts();

      setState(() {
        posts = fetchedPosts
            .map((postMap) => Post(
                  id: postMap['id'],
                  username: postMap['username'],
                  image: postMap['image'],
                  description: postMap['description'],
                  likeCount: postMap['likeCount'],
                  title: postMap['title'],
                ))
            .toList();
      });
      print(posts);
      // To simulate a delay, you can use a sleep function (remove in real use)
      // await Future.delayed(Duration(seconds: 1));

      // Print to show that data has been fetched after refresh
      print('Data fetched successfully after refresh');
    } catch (error) {
      print('Error fetching data: $error');
      // Handle errors here, if any
    }
  }

  XFile? _image = null;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });

      // Upload the image to GitHub
    }
  }

  Future<String> uploadImageToGitHub(XFile image) async {
    String file_name = DateTime.now().millisecondsSinceEpoch.toString();
    final String apiUrl =
        'https://api.github.com/repos/yash9111/Datastore/contents/images/${file_name}.png';

    String base64Image = base64Encode(File(image.path).readAsBytesSync());

    final response = await http.put(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $GITHUB_TOKEN',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'message': 'Upload image',
        'content': base64Image,
      }),
    );

    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: "Post Uploaded!");

      print('Image uploaded successfully.');
      return file_name;
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
      print('Failed to upload image. Status code: ${response.statusCode}');
      return "Something went wrong";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _fetchData,
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: dbConnection.getPosts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While data is being fetched, display a circular progress indicator
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              // If an error occurs during fetching, display an error message
              return Center(
                child: Text('Error fetching posts: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              // If no data is available, display a message indicating no posts
              return Center(
                child: Text('No posts available.'),
              );
            } else {
              // Data has been successfully fetched, update the posts list
              posts = snapshot.data!
                  .map((postMap) => Post(
                        id: postMap['id'],
                        username: postMap['username'],
                        image: postMap['image'],
                        description: postMap['description'],
                        likeCount: postMap['likeCount'],
                        title: postMap['title'],
                      ))
                  .toList();
              posts = posts.reversed.toList();

              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        boxShadow: [BoxShadow(blurRadius: 5)],
                        color: Colors.white),
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
                        Text(
                          "Meri Kahani",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        ),
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: NetworkImage(image),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
                        return InstagramPostWidget(post: post);
                      },
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: Colors.pink,
        backgroundColor: Colors.pink,
        onPressed: () {
          _showNewPostDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showNewPostDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SingleChildScrollView(
          child: Center(
            child: AlertDialog(
              title: Text('New Post'),
              content: Positioned(
                top: 1500,
                child: Container(
                  height: 300,
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: usernameController,
                        decoration: InputDecoration(labelText: 'Username'),
                      ),
                      // TextField(
                      //   controller: imageController,
                      //   decoration: InputDecoration(labelText: 'Image URL'),
                      // ),

                      TextField(
                        controller: titleController,
                        decoration: InputDecoration(labelText: 'Title'),
                      ),
                      TextField(
                        controller: descriptionController,
                        decoration: InputDecoration(labelText: 'Description'),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      OutlinedButton(
                          onPressed: () {
                            _getImage();
                          },
                          child: Text("Choose Image")),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    if (_image == null) {
                      _addNewPost();
                      Fluttertoast.showToast(msg: "Post Uploaded!");
                    } else {
                      imageController.text = await uploadImageToGitHub(_image!);
                      _addNewPost();
                    }

                    Navigator.pop(context);
                  },
                  child: Text('Post'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _addNewPost() {
    String image_name = imageController.text;
    String enteredUsername = usernameController.text;
    String enteredImage;
    if (_image != null) {
      enteredImage =
          'https://raw.githubusercontent.com/yash9111/Datastore/master/images/$image_name.png';
    } else {
      enteredImage =
          'https://raw.githubusercontent.com/yash9111/Datastore/master/images/default.png';
    }
    String enteredTitle = titleController.text;
    String enteredDescription = descriptionController.text;

    var id = M.ObjectId();
    Post newPost = Post(
      id: id.toString(),
      username: enteredUsername,
      image: enteredImage,
      title: enteredTitle,
      description: enteredDescription,
      likeCount: 0,
    );

    dbConnection.insertPost(newPost);
    posts.add(newPost);
    setState(() {});

    // Clear the controllers
    usernameController.clear();
    imageController.clear();
    titleController.clear();
    descriptionController.clear();
  }
}

class InstagramPostWidget extends StatefulWidget {
  final Post post;

  InstagramPostWidget({required this.post});

  @override
  _InstagramPostWidgetState createState() => _InstagramPostWidgetState();
}

class _InstagramPostWidgetState extends State<InstagramPostWidget> {
  bool isLiked = false;
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(widget.post.image),
          SizedBox(height: 7.0),
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(widget.post.image),
            ),
            title: Text(widget.post.username),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              widget.post.title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: ExpandableText(
                text: widget.post.description,
                maxLines: 3,
                expandText: 'Read more',
                collapseText: 'Read less',
                expanded: isExpanded,
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                }

                // style: TextStyle(
                //     fontSize: 15,
                //     fontWeight: FontWeight.w100,
                //     color: Colors.grey),
                ),
          ),
          Row(
            children: [
              IconButton(
                icon: isLiked
                    ? Icon(Icons.favorite, color: Colors.red)
                    : Icon(Icons.favorite_border),
                onPressed: () {
                  _handleLikeButton();
                },
              ),
              Text("${widget.post.likeCount} Likes"),
            ],
          ),
        ],
      ),
    );
  }

  void _handleLikeButton() {
    setState(() {
      if (isLiked) {
        // Unlike post
        widget.post.likeCount -= 1;
      } else {
        // Like post
        widget.post.likeCount += 1;
      }
      isLiked = !isLiked;

      dbConnection.updateLikeCount(widget.post.id, widget.post.likeCount);
    });
  }
}
