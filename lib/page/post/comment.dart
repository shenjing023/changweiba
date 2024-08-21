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

  CommentList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        return CommentItem(comment: comments[index]);
      },
    );
  }
}

class CommentItem extends StatelessWidget {
  final Map<String, dynamic> comment;

  const CommentItem({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(comment['avatar']),
                ),
                const SizedBox(width: 8),
                Text(
                  comment['author'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(comment['content']),
            const SizedBox(height: 8),
            Text(
              comment['time'],
              style: const TextStyle(color: Colors.grey),
            ),
            if (comment['replies'].isNotEmpty) ...[
              const SizedBox(height: 8),
              ...comment['replies'].map((reply) => Padding(
                    padding: const EdgeInsets.only(left: 16, top: 8),
                    child: CommentItem(comment: reply),
                  )),
            ],
          ],
        ),
      ),
    );
  }
}
