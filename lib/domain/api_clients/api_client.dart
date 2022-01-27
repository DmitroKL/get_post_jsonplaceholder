/*import 'dart:convert';
import 'dart:io';

import 'package:server_test_get_post/domain/entity/post.dart';

class ApiClient{
  final client = HttpClient();

  Future<List<Post>> getPosts()async{
   // final url =  Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final url =  Uri.parse('https://jsonplaceholder.typicode.com/posts');
    //Uri(scheme: 'https', host: 'jsonplaceholder.typicode.com', path: 'posts');
    final request = await client.getUrl(url);  //делаем запрос
    final responce = await request.close(); //отправляе в сеть и aweit-ом ждем пока прийдет ответ
    
    /*
    responce.listen((event) {
      print(event);
      print(1111111111111111111);
    });
    */

    /*
    responce.transform(utf8.decoder).listen((event) {
      print(event);
      print(1111111111111111111);
    });
    */
    
    final jsonStrings = await responce.transform(utf8.decoder).toList(); // (преобразовуем стрим байтов в стрим строк) [[ будут две кавычки если не будет нижней строки
    final jsonString = jsonStrings.join(); //склеиваем масив в строку будет без [[
    final json = jsonDecode(jsonString) as List<dynamic>; //декодируем строку как джейсон

    final posts = json
        .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
    return posts;
  }
}

 */


import 'dart:convert';
import 'dart:io';
import 'package:test_app_tooserver/domain/entity/post.dart';

class ApiClient{
  final client = HttpClient();


  Future<List<Post>> getPosts()async{
    final json = await get('https://jsonplaceholder.typicode.com/posts')
    as List<dynamic>;

    final posts = json
        .map((dynamic e) => Post.fromJson(e as Map<String, dynamic>))
        .toList();
    return posts;
  }

  Future<Post> createPost({ required String title, required String body}) async{
    final url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    final parameters = <String, dynamic>{
      'title' : title,
      'body' : body,
      'userId': 109,
    };
    final request = await client.postUrl(url);  //делаем запрос
    request.headers.set('Content-type', 'application/json; charset=UTF-8');
    request.write(jsonEncode(parameters));
    final response = await request.close();
    final jsonStrings = await response.transform(utf8.decoder).toList();
    final jsonString = jsonStrings.join();
   // print(jsonString);

    final json = jsonDecode(jsonString) as Map<String,dynamic>;

    final post = Post.fromJson(json);
    return post; // ставим *стоп - breakpoint* тут и проверяем, для этого запускаем Flutter Attach
  }

  Future<dynamic> get(String ulr) async{
    final url =  Uri.parse(ulr);
    final request = await client.getUrl(url);  //делаем запрос
    final response = await request.close(); //отправляе в сеть и aweit-ом ждем пока прийдет ответ

    final jsonStrings = await response.transform(utf8.decoder).toList(); // (преобразовуем стрим байтов в стрим строк) [[ будут две кавычки если не будет нижней строки
    final jsonString = jsonStrings.join(); //склеиваем масив в строку будет без [[
    final dynamic json = jsonDecode(jsonString); //декодируем строку как джейсон
    return json;

  }

}