import 'package:flutter/material.dart';

class PostList extends StatelessWidget {
  final List<Map<String, dynamic>> posts = [
    {
      'id': 1,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar1.jpg',
      'content': '你记住一句话就行，强的韩国人不会留LPL\n现在打IMSI的都是两个全华班了',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'replies': 12,
      'upvotes': 12,
    },
    {
      'id': 2,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar2.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },
    {
      'id': 3,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar3.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 4,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar4.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 5,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar5.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 6,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar6.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 7,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar7.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 8,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar8.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 9,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar9.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 10,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar10.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 11,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar11.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 12,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar12.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 13,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar13.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 14,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar14.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 15,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar15.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 16,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar16.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 17,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar17.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 18,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar18.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 19,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar19.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 20,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar20.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 21,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar21.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    }
    // Add more mock posts here
  ];

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostItem(post: posts[index]);
        },
      ),
    );
    // return ListView.builder(
    //   itemCount: posts.length,
    //   itemBuilder: (context, index) {
    //     return PostItem(post: posts[index]);
    //   },
    // );
  }
}

class PostItem extends StatelessWidget {
  final Map<String, dynamic> post;

  PostItem({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/post', arguments: post['id']);
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(post['avatar']),
                  ),
                  SizedBox(width: 8),
                  Text(
                    post['author'],
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
                  // Text(
                  //   'IP属地: ${post['ip']}',
                  //   style: TextStyle(color: Colors.grey),
                  // ),
                ],
              ),
              SizedBox(height: 8),
              Text(post['content']),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    post['time'],
                    style: TextStyle(color: Colors.grey),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up),
                        onPressed: () {
                          // TODO: Implement upvote functionality
                        },
                      ),
                      Text('${post['upvotes']}'),
                      SizedBox(width: 16),
                      Icon(Icons.comment),
                      Text('${post['replies']}'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
