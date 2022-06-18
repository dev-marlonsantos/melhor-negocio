import 'package:flutter/material.dart';
import 'package:melhor_negocio/views/chat.dart';
import 'package:melhor_negocio/views/login.dart';
import 'package:melhor_negocio/views/my_posts.dart';
import 'package:melhor_negocio/views/new_post.dart';
import 'package:melhor_negocio/views/posts.dart';
import 'package:melhor_negocio/views/register.dart';
import 'package:melhor_negocio/views/chat_list.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "":
        return MaterialPageRoute(builder: (_) => const Posts());
      case "/login":
        return MaterialPageRoute(builder: (_) => const Login());
      case "/register":
        return MaterialPageRoute(builder: (_) => const Register());
      case "/my-posts":
        return MaterialPageRoute(builder: (_) => const MyPosts());
      case "/new-post":
        return MaterialPageRoute(builder: (_) => const NewPost());
      case "/chat-list":
        return MaterialPageRoute(builder: (_) => const ChatList());
      case "/chat":
        return MaterialPageRoute(builder: (_) => Chat());
      default:
        throw _routeError;
    }
  }

  static Route<dynamic> _routeError() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text("Tela não encontrada")),
        body: const Center(
          child: Text("Tela não encontrada!"),
        ),
      );
    });
  }
}
