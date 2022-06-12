import 'package:flutter/material.dart';
import 'package:melhor_negocio/views/conversa.dart';
import 'package:melhor_negocio/views/login.dart';
import 'package:melhor_negocio/views/posts.dart';
import 'package:melhor_negocio/views/register.dart';
import 'package:melhor_negocio/views/chats.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      case "":
        return MaterialPageRoute(builder: (_) => const Posts());
      case "/login":
        return MaterialPageRoute(builder: (_) => const Login());
      case "/register":
        return MaterialPageRoute(builder: (_) => const Register());
      case "/chats":
        return MaterialPageRoute(builder: (_) => const Chats());
      case "/conversa":
      return MaterialPageRoute(builder: (_) => const Conversa());
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
