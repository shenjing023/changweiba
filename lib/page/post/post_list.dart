import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';

import '../../api/post.dart';
import '../../constant/style.dart';
import '../../model/post.dart';
import '../../util/shared_preferences.dart';
import '../../util/time.dart';
import '../../widget/empty.dart';
import '../../widget/text_editor.dart';
import '../login/login.dart';

class PostList extends StatefulWidget {
  @override
  _PostListState createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  List<Post> posts = [];
  bool isLoading = true;
  int currentPage = 1;
  int itemsPerPage = 50;
  int totalPosts = 0; // 总数据条数

  @override
  void initState() {
    super.initState();
    fetchPosts(currentPage);
  }

  Future<List<Post>> _fetchPosts(int page, int pageSize) async {
    SmartDialog.showLoading();
    List<Post> items = [];
    try {
      isLoading = true;
      // 模拟网络请求延迟
      // await Future.delayed(Duration(seconds: Random().nextInt(3)));

      var resp = await getAllPosts(page, pageSize);
      if (resp.code == 200) {
        if (resp.data.nodes != null) {
          if (resp.data.nodes!.isNotEmpty) {
            for (var item in resp.data.nodes!) {
              items.add(item);
            }
          }
          totalPosts = resp.data.totalCount!;
        }
      } else {
        SmartDialog.showToast(resp.message);
      }
    } catch (e) {
      debugPrint(e.toString());
      SmartDialog.showToast("internal server or network error");
    } finally {
      SmartDialog.dismiss();
      isLoading = false;
    }
    return items;
  }

  Future<void> fetchPosts(int page) async {
    List<Post> fetchedPosts = await _fetchPosts(page, itemsPerPage);

    setState(() {
      posts = fetchedPosts;
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

  Future<void> addNewPost(Map<String, dynamic> request) async {
    newPost(
      request['title'],
      request['content'],
    ).then((value) {
      if (value.code == 200) {
        SmartDialog.showToast("新建帖子成功");
        if (currentPage == 1) {
          fetchPosts(currentPage);
        }
      } else {
        // if (value.code == 600 || value.code == 603) {
        //   SmartDialog.showToast("请重新登录");
        // showLoginDialog();
        // } else {
        SmartDialog.showToast("新建帖子失败");
        // }
      }
    }).onError((error, stackTrace) {
      print("error: $error");
      SmartDialog.showToast("新建帖子失败");
    });
  }

  Future<void> _showCreatePostDialog() async {
    await showLoginDialog();
    bool isAuthenticated = Storage().prefs.getBool("isAuthenticated") ?? false;
    if (!isAuthenticated) {
      return;
    }
    SmartDialog.show(builder: (_) {
      return LayoutBuilder(builder: (context, constraints) {
        return Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 1200,
              maxHeight: 800,
            ),
            child: TextEditor(
              onCreated: (result) {
                SmartDialog.dismiss();
                addNewPost(result);
              },
              needTitleBar: true,
              title: "创建新帖子",
            ),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(child: Container())
          : posts.isEmpty
              ? const EmptyWidget()
              : ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      return PostItem(post: posts[index]);
                    },
                  ),
                ),
      // body: posts.isEmpty
      //     ? const EmptyWidget()
      //     : ScrollConfiguration(
      //         behavior:
      //             ScrollConfiguration.of(context).copyWith(scrollbars: false),
      //         child: ListView.builder(
      //           itemCount: posts.length,
      //           itemBuilder: (context, index) {
      //             return PostItem(post: posts[index]);
      //           },
      //         ),
      //       ),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        mini: true,
        onPressed: () {
          _showCreatePostDialog();
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) =>
          //           CreatePostPage(onPostCreated: addNewPost)),
          // );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: InkWell(
        onTap: () {
          // Navigator.pushNamed(context, '/post', arguments: post.id);
          context.go('/post/${post.id}');
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // CachedNetworkImage(
                  //   imageUrl: post.user!.avatar!,
                  //   placeholder: (context, url) => CircularProgressIndicator(),
                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                  // ),
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                      post.user!.avatar!,
                      // headers: {
                      //   'Access-Control-Allow-Origin': '*',
                      // },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    post.user!.nickname,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(post.title!),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(RelativeDateFormat.timeStamp2Str(post.updatedAt!),
                      style: commentTimeStyle),
                  Row(
                    children: [
                      // IconButton(
                      //   icon: const Icon(Icons.thumb_up),
                      //   onPressed: () {
                      //     // TODO: Implement upvote functionality
                      //   },
                      // ),
                      // Text('${post.upvotes!}'),
                      const SizedBox(width: 16),
                      const Icon(Icons.comment),
                      Text('${post.replyCount!}'),
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
    // 'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.7b6bd638.8RguHecVQPgJ7-sFdko6sQ?t=1633259905',
    // 'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.fb35b2a2.JhmaphYoWJySiF4Tu6x-yw?t=1586289123',
    // 'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.d0652a2e.DzE0ZDnup9Z6rfLMqvjSXg?t=1717806111',
    // 'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.43bde2c9.0RtX8gu1_avsgSCYqzoqqQ?t=1684009793',
    // 'https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/tb.1.16be06ae.obeb_CVyMn-W2SgELW3POg?t=1492740074',
    'https://images2.imgbox.com/2b/7b/oSiwD7s7_o.jpg',
    'https://thumbs2.imgbox.com/10/b9/QczUmHlM_t.jpg',
    'https://thumbs2.imgbox.com/41/50/gky4xYjJ_t.jpg',
    'https://thumbs2.imgbox.com/fd/ea/4OD0kAmq_t.jpg',
    'https://thumbs2.imgbox.com/45/78/A105RLJe_t.jpg'
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
