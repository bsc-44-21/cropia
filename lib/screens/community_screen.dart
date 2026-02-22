import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<Map<String, dynamic>> posts = [];
  final TextEditingController postController = TextEditingController();

  void addPost(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      posts.insert(0, {
        "user": "Farmer",
        "content": text,
        "comments": <Map<String, String>>[],
        "likes": 0,
      });
    });

    postController.clear();
  }

  void addComment(int index, String comment) {
    if (comment.trim().isEmpty) return;

    setState(() {
      posts[index]["comments"].add({"user": "Member", "text": comment});
    });
  }

  void likePost(int index) {
    setState(() {
      posts[index]["likes"]++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Community"),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          // Create Post Box
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: postController,
                    decoration: const InputDecoration(
                      hintText: "Share farming experience or ask question...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => addPost(postController.text),
                  child: const Text("Post"),
                ),
              ],
            ),
          ),

          // Posts List
          Expanded(
            child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                var post = posts[index];
                TextEditingController commentController =
                    TextEditingController();

                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post["user"],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(post["content"]),
                        const SizedBox(height: 10),

                        // Like & Comment Row
                        Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.thumb_up),
                              onPressed: () => likePost(index),
                            ),
                            Text("${post["likes"]}"),
                          ],
                        ),

                        const Divider(),

                        // Comments
                        ...post["comments"].map<Widget>((c) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Text(
                              "${c["user"]}: ${c["text"]}",
                              style: const TextStyle(color: Colors.black87),
                            ),
                          );
                        }).toList(),

                        // Add Comment
                        Row(
                          children: [
                            Expanded(
                              child: TextField(
                                controller: commentController,
                                decoration: const InputDecoration(
                                  hintText: "Write a comment...",
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                addComment(index, commentController.text);
                                commentController.clear();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
