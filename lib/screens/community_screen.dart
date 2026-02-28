import 'package:flutter/material.dart';
import '../theme.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final List<Map<String, dynamic>> posts = [
    {
      "user": "Dr. Sarah Phiri",
      "isVerified": true,
      "time": "2h ago",
      "content": "MAIZE ALERT: I'm seeing a lot of Fall Armyworm in the Central Region. Please check your fields and use targeted pesticides immediately. 🌽🚫",
      "likes": 24,
      "comments": [
        {"user": "John K.", "text": "Thanks for the heads up, Doctor!"},
      ],
      "media": null,
    },
    {
      "user": "Banda Green Farms",
      "isVerified": false,
      "time": "5h ago",
      "content": "Just harvested our first crop of organic tomatoes. The yield is incredible this year! 🍅✨ #FarmingSuccess",
      "likes": 56,
      "comments": [],
      "media": "tomato", // Simulated media name
    }
  ];

  final List<String> categories = [
    "All Posts",
    "Pests & Diseases",
    "Fertilizers",
    "Market Prices",
    "Success Stories",
    "Irrigation",
  ];

  String selectedCategory = "All Posts";
  final TextEditingController postController = TextEditingController();
  String? _attachedMedia; // Simulated attached media state (photo/video)

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null) {
        if (args.containsKey('sharedText')) {
          setState(() {
            postController.text = args['sharedText'];
          });
        }
        if (args.containsKey('sharedImage')) {
          setState(() {
            _attachedMedia = args['sharedImage'];
          });
        }
      }
    });
  }

  void addPost(String text) {
    if (text.trim().isEmpty && _attachedMedia == null) return;

    setState(() {
      posts.insert(0, {
        "user": "You",
        "isVerified": false,
        "time": "Just now",
        "content": text,
        "comments": <Map<String, String>>[],
        "likes": 0,
        "media": _attachedMedia,
      });
      _attachedMedia = null;
    });

    postController.clear();
  }

  void deletePost(int index) {
    setState(() {
      posts.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Post deleted")),
    );
  }

  void editPost(int index, String newContent) {
    setState(() {
      posts[index]["content"] = newContent;
      posts[index]["time"] = "Edited • Just now";
    });
  }

  void addComment(int index, String comment) {
    if (comment.trim().isEmpty) return;

    setState(() {
      posts[index]["comments"].add({"user": "You", "text": comment});
    });
  }

  void likePost(int index) {
    setState(() {
      posts[index]["likes"]++;
    });
  }

  void _simulateMediaSelect(String type) {
    setState(() {
      _attachedMedia = type; // "photo" or "video"
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("$type attached!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? null : const Color(0xFFF0F2F5),
      appBar: AppBar(
        title: const Text(
          "Cropia Community",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: isDark ? Colors.grey[900] : Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
            icon: Icon(Icons.person_outline, color: isDark ? Colors.white : Colors.black),
            onPressed: () => Navigator.pushNamed(context, '/profile'),
          ),
        ],
      ),
      body: Column(
        children: [
          const Divider(height: 1),
          _buildCategoryBar(isDark),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(bottom: 20),
              itemCount: posts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return _buildCreatePostBox(isDark);
                }
                return _buildPostItem(index - 1, isDark);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryBar(bool isDark) {
    return Container(
      height: 60,
      color: isDark ? Colors.grey[900] : Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          bool isSelected = categories[index] == selectedCategory;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: InkWell(
              onTap: () => setState(() => selectedCategory = categories[index]),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected ? AppTheme.primary : (isDark ? Colors.grey[800] : Colors.grey[100]),
                  borderRadius: BorderRadius.circular(20),
                ),
                alignment: Alignment.center,
                child: Text(
                  categories[index],
                  style: TextStyle(
                    color: isSelected ? Colors.white : (isDark ? Colors.grey[400] : Colors.grey[700]),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCreatePostBox(bool isDark) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(16),
      color: isDark ? Colors.grey[900] : Colors.white,
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: AppTheme.primary.withOpacity(0.1),
                child: const Icon(Icons.person, color: AppTheme.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: postController,
                    decoration: const InputDecoration(
                      hintText: "What's happening in your field?",
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    minLines: 3,
                    maxLines: null,
                    onSubmitted: (val) => addPost(val),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: () => addPost(postController.text),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text("Post", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          if (_attachedMedia != null) ...[
            const SizedBox(height: 16),
            Stack(
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[300]!),
                    image: _attachedMedia!.endsWith('.jpg') 
                      ? DecorationImage(
                          image: AssetImage('lib/assets/images/$_attachedMedia'),
                          fit: BoxFit.cover,
                        )
                      : null,
                  ),
                  child: (_attachedMedia == "photo" || _attachedMedia == "video") 
                    ? Center(
                        child: Icon(
                          _attachedMedia == "photo" ? Icons.image : Icons.videocam,
                          size: 60,
                          color: _attachedMedia == "photo" ? Colors.green : Colors.blue,
                        ),
                      )
                    : null,
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => setState(() => _attachedMedia = null),
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                      child: const Icon(Icons.close, color: Colors.white, size: 16),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 12),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildPostTypeBtn(Icons.image, "Photo", Colors.green, () => _simulateMediaSelect("photo")),
              _buildPostTypeBtn(Icons.videocam, "Video", Colors.blue, () => _simulateMediaSelect("video")),
              _buildPostTypeBtn(Icons.location_on, "Location", Colors.orange, () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPostTypeBtn(IconData icon, String label, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 4),
          Text(label, style: TextStyle(
            fontWeight: FontWeight.w500, 
            fontSize: 13,
            color: Theme.of(context).brightness == Brightness.dark ? Colors.grey[300] : Colors.black87,
          )),
        ],
      ),
    );
  }

  Widget _buildPostItem(int index, bool isDark) {
    var post = posts[index];
    final commentController = TextEditingController();

    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(16),
      color: isDark ? Colors.grey[900] : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                child: post["user"] == "You" ? const Icon(Icons.person, color: Colors.grey) : Text(post["user"][0]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post["user"],
                          style: TextStyle(
                            fontWeight: FontWeight.bold, 
                            fontSize: 15,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        if (post["isVerified"])
                          const Padding(
                            padding: EdgeInsets.only(left: 4),
                            child: Icon(Icons.verified, color: Colors.blue, size: 14),
                          ),
                      ],
                    ),
                    Text(
                      post["time"],
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                icon: const Icon(Icons.more_horiz),
                onSelected: (value) {
                  if (value == 'delete') {
                    deletePost(index);
                  } else if (value == 'edit') {
                    _showEditDialog(index, post["content"]);
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text("Edit Post")),
                  const PopupMenuItem(value: 'delete', child: Text("Delete Post", style: TextStyle(color: Colors.red))),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            post["content"],
            style: TextStyle(
              fontSize: 15, 
              height: 1.4,
              color: isDark ? Colors.grey[300] : Colors.black,
            ),
          ),
          if (post["media"] != null) ...[
            const SizedBox(height: 12),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[100],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? Colors.grey[700]! : Colors.grey[300]!),
              ),
              child: post["media"].toString().endsWith('.jpg')
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        'lib/assets/images/${post["media"]}',
                        fit: BoxFit.cover,
                      ),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          post["media"] == "video" ? Icons.play_circle_outline : Icons.image_outlined,
                          size: 60,
                          color: AppTheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          post["media"] == "video" ? "Simulated Video Content" : "Simulated Photo Content",
                          style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
            ),
          ],
          const SizedBox(height: 12),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildEngagementBtn(Icons.thumb_up_alt_outlined, "${post["likes"]}", () => likePost(index)),
              _buildEngagementBtn(Icons.chat_bubble_outline, "${post["comments"].length}", () {}),
              _buildEngagementBtn(Icons.share_outlined, "Share", () {}),
            ],
          ),
          if (post["comments"].isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[800] : Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: post["comments"].map<Widget>((c) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: isDark ? Colors.white : Colors.black, fontSize: 13),
                        children: [
                          TextSpan(text: "${c["user"]} ", style: const TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: c["text"]),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
          const SizedBox(height: 12),
          Row(
            children: [
              CircleAvatar(
                radius: 14,
                backgroundColor: isDark ? Colors.grey[800] : Colors.grey[200],
                child: const Icon(Icons.person, size: 14, color: Colors.grey),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: isDark ? Colors.grey[800] : Colors.grey[100],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: commentController,
                    style: const TextStyle(fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: "Write a comment...",
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    onSubmitted: (val) {
                      addComment(index, val);
                      commentController.clear();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showEditDialog(int index, String currentContent) {
    final editController = TextEditingController(text: currentContent);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Edit Post"),
        content: TextField(
          controller: editController,
          maxLines: 4,
          decoration: const InputDecoration(border: OutlineInputBorder()),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              editPost(index, editController.text);
              Navigator.pop(context);
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementBtn(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(icon, size: 20, color: Colors.grey[600]),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}
