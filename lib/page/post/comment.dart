import 'package:flutter/material.dart';

class CommentList extends StatelessWidget {
  final List<Map<String, dynamic>> comments = [
    {
      'id': 1,
      'author': 'ssssssxc920',
      'avatar': 'https://example.com/avatar2.jpg',
      'content': '你的意思是滔博、宋圣，大b这些人不强了是吧？没他们lpl拿什么冠军',
      'time': '2024-8-15 21:33',
      'replies': [],
    },
    // Add more mock comments here
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return CommentItem(comment: comments[index]);
      },
    );
  }
}

class CommentItem extends StatelessWidget {
  final Map<String, dynamic> comment;

  CommentItem({required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(comment['avatar']),
                ),
                SizedBox(width: 8),
                Text(
                  comment['author'],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(comment['content']),
            SizedBox(height: 8),
            Text(
              comment['time'],
              style: TextStyle(color: Colors.grey),
            ),
            if (comment['replies'].isNotEmpty) ...[
              SizedBox(height: 8),
              ...comment['replies'].map((reply) => Padding(
                    padding: EdgeInsets.only(left: 16, top: 8),
                    child: CommentItem(comment: reply),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
