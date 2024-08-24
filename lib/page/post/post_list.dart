import 'package:flutter/material.dart';
import 'dart:math';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<Map<String, dynamic>> posts = [];
  bool isLoading = true;
  int currentPage = 1;
  int itemsPerPage = 10;
  int totalPosts = 55; // 总数据条数

  @override
  void initState() {
    super.initState();
    fetchPosts(currentPage);
  }

  Future<void> fetchPosts(int page) async {
    setState(() {
      isLoading = true;
    });

    // 模拟网络请求延迟
    // await Future.delayed(Duration(seconds: 1));

    // 生成假数据
    List<Map<String, dynamic>> fetchedPosts =
        generateFakePosts(page, itemsPerPage, totalPosts);

    setState(() {
      posts = fetchedPosts;
      isLoading = false;
    });
  }

  void _nextPage() {
    if ((currentPage * itemsPerPage) < totalPosts) {
      setState(() {
        currentPage++;
        fetchPosts(currentPage);
      });
    }
  }

  void _previousPage() {
    if (currentPage > 1) {
      setState(() {
        currentPage--;
        fetchPosts(currentPage);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
              backgroundColor: Colors.transparent,
            ))
          : ScrollConfiguration(
              behavior:
                  ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return PostItem(post: posts[index]);
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
            Text('第 $currentPage 页'),
            ElevatedButton(
              onPressed:
                  (currentPage * itemsPerPage) < totalPosts ? _nextPage : null,
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

List<Map<String, dynamic>> generateFakePosts(
    int page, int itemsPerPage, int totalPosts) {
  final random = Random();
  final List<String> authors = ['Alice', 'Bob', 'Charlie', 'David', 'Eve'];
  final List<String> contents = [
    'Hello, world!',
    'Flutter is awesome!',
    'Dart is a great language.',
    'Mobile development is fun!',
    'Learning Flutter is rewarding.'
  ];
  final List<String> avatars = [
    'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.7b6bd638.8RguHecVQPgJ7-sFdko6sQ?t=1633259905',
    'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.fb35b2a2.JhmaphYoWJySiF4Tu6x-yw?t=1586289123',
    'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.d0652a2e.DzE0ZDnup9Z6rfLMqvjSXg?t=1717806111',
    'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.43bde2c9.0RtX8gu1_avsgSCYqzoqqQ?t=1684009793',
    'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.16be06ae.obeb_CVyMn-W2SgELW3POg?t=1492740074'
  ];

  List<Map<String, dynamic>> fakePosts = [];

  int startIndex = (page - 1) * itemsPerPage;
  int endIndex = min(startIndex + itemsPerPage, totalPosts);

  for (int i = startIndex; i < endIndex; i++) {
    fakePosts.add({
      'id': i + 1,
      'author': authors[random.nextInt(authors.length)],
      'content': contents[random.nextInt(contents.length)],
      'avatar': avatars[random.nextInt(avatars.length)],
      'time': DateTime.now()
          .subtract(Duration(days: random.nextInt(30)))
          .toString(),
      'upvotes': random.nextInt(100),
      'replies': random.nextInt(50),
    });
  }

  return fakePosts;
}
