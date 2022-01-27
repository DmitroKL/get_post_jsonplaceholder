import 'package:flutter/material.dart';
import 'package:test_app_tooserver/example/example_model.dart';


class Example extends StatefulWidget {
 const Example({Key? key}) : super(key: key);

  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final model = ExampleWidgetModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ExampleModelProvider(
          model: model,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const ReloadButton(),
              const CreateButton(),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: PostsWidget(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReloadButton extends StatelessWidget {
  const ReloadButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => ExampleModelProvider.read(context)?.model.reloadPosts(),
      //read - получает данные но неподписывается на изменения
      child: const Text('Обновить посты'),
    );
  }
}

class CreateButton extends StatelessWidget {
  const CreateButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => ExampleModelProvider.read(context)?.model.createPosts(),
      child: const Text('Сосдать пост'),
    );
  }
}

class PostsWidget extends StatelessWidget {
  const PostsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: ExampleModelProvider.watch(context)?.model.posts.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return PostsRowWidget(index: index);
      },
    );
  }
}

class PostsRowWidget extends StatelessWidget {
  final int index;

  const PostsRowWidget({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final post = ExampleModelProvider.read(context)!.model.posts[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(post.id.toString()),
        const SizedBox(height: 10),
        Text(post.title),
        const SizedBox(height: 10),
        Text(post.body),
        const SizedBox(height: 40),
      ],
    );
  }
}


