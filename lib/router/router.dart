import 'package:changweiba/page/post/post_detail.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:go_router/go_router.dart';

import '../page/home/home.dart';

// GoRouter configuration
final router = GoRouter(
  observers: [FlutterSmartDialog.observer],
  initialLocation: '/',
  routes: [
    GoRoute(
      name: 'home', // Optional, add name to your routes.
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
        name: 'postDetail',
        path: '/post/:id',
        builder: (context, state) {
          final id = state.pathParameters['id'];
          final postID = int.tryParse(id ?? '') ?? 0;
          return PostDetailScreen(postID: postID);
        }),
  ],
);
