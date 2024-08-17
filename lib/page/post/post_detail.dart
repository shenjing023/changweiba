import 'package:flutter/material.dart';
import 'comment.dart';

class PostDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postId = ModalRoute.of(context)!.settings.arguments as int;
    // TODO: Fetch post details using postId

    return Scaffold(
      appBar: AppBar(
        title: Text('帖子详情'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                '你记住一句话就行，强的韩国人不会留LPL\n现在打IMSI的都是两个全华班了',
                style: TextStyle(fontSize: 18),
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '评论',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            CommentList(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement new comment creation
        },
        child: Icon(Icons.add_comment),
      ),
    );
  }
}
