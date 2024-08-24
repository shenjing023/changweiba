import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'post.g.dart';

@Riverpod(keepAlive: true)
class CommentExpanded extends _$CommentExpanded {
  @override
  bool build() => false;

  switchExpanded() {
    state = !state;
  }
}
