import 'package:flutter/material.dart';
import 'package:test_app_tooserver/domain/api_clients/api_client.dart';
import 'package:test_app_tooserver/domain/entity/post.dart';

class ExampleWidgetModel extends ChangeNotifier {
  final apiClinet = ApiClient();
  var _posts = const <Post>[];

  List<Post> get posts => _posts;

  Future<void> reloadPosts() async {
    final posts = await apiClinet.getPosts();
    _posts += posts; // += - добавить посты
    notifyListeners(); //обновить у подписчиков
  }

  Future<void> createPosts() async {
    final posts = await apiClinet.createPost(
            title: 'newtitle',
            body: 'newbody',
    );
  }
}

class ExampleModelProvider extends InheritedNotifier {
  // InheritedWidget
  final ExampleWidgetModel model;

  const ExampleModelProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static ExampleModelProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ExampleModelProvider>();
  }

  static ExampleModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ExampleModelProvider>()
        ?.widget;
    return widget is ExampleModelProvider ? widget : null;
  }
}
