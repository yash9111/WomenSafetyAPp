import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final String userName = "John Doe";
  final String userImageURL =
      "https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D"; // Replace with your user's image URL

  final List<InstagramPost> posts = [
    InstagramPost(
      userName: "johndoe",
      userImageURL:
          "https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D",
      postImageURL:
          "https://images.unsplash.com/photo-1633332755192-727a05c4013d?auto=format&fit=crop&q=80&w=1000&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D",
      postDescription: "This is a great day!",
    ),
    InstagramPost(
      userName: "Yash",
      userImageURL:
          // "https://unsplash.com/photos/man-in-black-button-up-shirt-ZHvM3XIOHoE",
          "https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=1286",
      postImageURL:
          "https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=1286",
      // "https://unsplash.com/photos/man-in-black-button-up-shirt-ZHvM3XIOHoE",
      postDescription: "This is a great day!",
    ),
    InstagramPost(
      userName: "Darshan",
      userImageURL:
          "https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=1286",
      postImageURL:
          "https://wac-cdn.atlassian.com/dam/jcr:ba03a215-2f45-40f5-8540-b2015223c918/Max-R_Headshot%20(1).jpg?cdnVersion=1286",
      // "https://unsplash.com/photos/closeup-photography-of-woman-smiling-mEZ3PoFGs_k",
      postDescription: "This is a great day!",
    ),
    // Add more posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(userImageURL),
                ),
                SizedBox(height: 10),
                Text(userName, style: TextStyle(fontSize: 20)),
              ],
            ),
          ),
          // Separator Line
          Divider(
            color: Colors.black,
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
      ),
    );
  }
}

class InstagramPost {
  final String userName;
  final String userImageURL;
  final String postImageURL;
  final String postDescription;

  InstagramPost({
    required this.userName,
    required this.userImageURL,
    required this.postImageURL,
    required this.postDescription,
  });
}

class InstagramPostWidget extends StatelessWidget {
  final InstagramPost post;

  InstagramPostWidget({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Information
          ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(post.userImageURL),
            ),
            title: Text(post.userName),
          ),
          // Post Image
          Image.network(post.postImageURL),
          // Like Button
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.favorite_border),
                onPressed: () {
                  // Handle liking the post
                },
              ),
              Text("Like"),
            ],
          ),
          // Post Description
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(post.postDescription),
          ),
        ],
      ),
    );
  }
}
