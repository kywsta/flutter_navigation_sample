import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScreenA extends StatelessWidget {
  const ScreenA({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen A')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Go to a route
            context.go('/b');
          },
          child: const Text('Go to Second B'),
        ),
      ),
    );
  }
}

class ScreenB extends StatelessWidget {
  const ScreenB({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second B')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Go to a route with path parameters
            ElevatedButton(
              onPressed: () {
                context.push('/c/1');
              },
              child: const Text('Go to Screen C'),
            ),
            // Pop the current route
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenC extends StatelessWidget {
  final int? id;

  const ScreenC({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen C')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Id: ${id ?? 'Not provided in the pathParameters'}",
              style: TextStyle(fontSize: 24),
            ),
            // Go to a route with query parameters
            ElevatedButton(
              onPressed: () {
                context.go('/d?keyword=flutter');
              },
              child: const Text('Go to Screen D'),
            ),
            // Pop the current route
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}

class ScreenD extends StatelessWidget {
  final String? keyword;

  const ScreenD({super.key, this.keyword});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen D')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Keyword: ${keyword ?? 'Not provided in the uri.queryParameters'}",
              style: TextStyle(fontSize: 24),
            ),
            // Push to a route with extra data
            ElevatedButton(
              onPressed: () {
                context.push(
                  '/e',
                  extra: User(userId: 1, userName: 'John Doe').toJson(),
                );
              },
              child: const Text('Go to Screen E'),
            ),
            // Skip the /c route and go to /b
            ElevatedButton(
              onPressed: () {
                context.go('/b');
              },
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  final int userId;
  final String userName;

  User({required this.userId, required this.userName});

  static User fromJson(Map<String, dynamic> json) {
    return User(userId: json['userId'], userName: json['userName']);
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'userName': userName};
  }
}

class ScreenE extends StatefulWidget {
  final User? user;

  const ScreenE({super.key, required this.user});

  @override
  State<ScreenE> createState() => _ScreenEState();
}

class _ScreenEState extends State<ScreenE> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen E')),
      body: Center(
        child: Column(
          children: [
            Text("Name: ${widget.user?.userName ?? "Undefined"}"),
            Text("Id: ${widget.user?.userId ?? "Undefined"}"),
            ElevatedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Go back'),
            ),
          ],
        ),
      ),
    );
  }
}
