import 'package:flutter/material.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
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
      'author': '胜天半23子K°F',
      'avatar': 'https://example.com/avatar3.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一23篇测试文章',
      'replies': 1112,
      'upvotes': 122,
    },

    {
      'id': 4,
      'author': '胜天半1231子K°F',
      'avatar': 'https://example.com/avatar4.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 1232,
      'upvotes': 1122,
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
      'author': '胜天半123子K°F',
      'avatar': 'https://example.com/avatar9.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 123,
      'upvotes': 122,
    },

    {
      'id': 10,
      'author': '胜天半131子K°F',
      'avatar': 'https://example.com/avatar10.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 12,
    },

    {
      'id': 11,
      'author': '胜天1231半子K°F',
      'avatar': 'https://example.com/avatar11.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 112312,
      'upvotes': 13212,
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
      'author': '胜天半13子K°F',
      'avatar': 'https://example.com/avatar14.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 1132,
      'upvotes': 1132,
    },

    {
      'id': 15,
      'author': '胜天半子K°F',
      'avatar': 'https://example.com/avatar15.jpg',
      'time': '2024-08-15 21:30',
      'ip': '山东',
      'content': '这是一篇测试文章',
      'replies': 12,
      'upvotes': 1132,
    },

    {
      'id': 16,
      'author': '胜天半1231子K°F',
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

  int currentPage = 1; // 当前页数
  int get totalPages => (posts.length / 10).ceil(); // 计算总页数
  final int itemsPerPage = 10; // 每页显示的最大帖子数

  void _nextPage() {
    if (currentPage < totalPages) {
      setState(() {
        currentPage++;
      });
    }
  }

  void _previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // 计算当前页要显示的帖子索引范围
    int startIndex = (currentPage - 1) * itemsPerPage;
    int endIndex = startIndex + itemsPerPage;
    List<Map<String, dynamic>> currentPosts = posts.sublist(
      startIndex,
      endIndex > posts.length ? posts.length : endIndex,
    );

    return Scaffold(
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
          itemCount: currentPosts.length,
          itemBuilder: (context, index) {
            return PostItem(post: currentPosts[index]);
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: currentPage > 1 ? _previousPage : null,
              child: const Text('上一页'),
            ),
            Text('第 $currentPage 页 / 共 $totalPages 页'),
            ElevatedButton(
              onPressed: currentPage < totalPages ? _nextPage : null,
              child: const Text('下一页'),
            ),
          ],
        ),
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final Map<String, dynamic> post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/post', arguments: post['id']);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(post['avatar']),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    post['author'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  // Text(
                  //   'IP属地: ${post['ip']}',
                  //   style: TextStyle(color: Colors.grey),
                  // ),
                ],
              ),
              const SizedBox(height: 8),
              Text(post['content']),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    post['time'],
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.thumb_up),
                        onPressed: () {
                          // TODO: Implement upvote functionality
                        },
                      ),
                      Text('${post['upvotes']}'),
                      const SizedBox(width: 16),
                      const Icon(Icons.comment),
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
