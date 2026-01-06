import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const NetworkAppScreen());
}

class NetworkAppScreen extends StatelessWidget {
  const NetworkAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: UserInfoScreen(userId: 'manolito-01'));
  }
}

class UserInfoScreen extends StatelessWidget {
  final String userId;
  final TextEditingController _controllerUserInfo = TextEditingController();
  final TextEditingController _controllerPostResponse = TextEditingController();

  UserInfoScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Informacion de usuario')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Pedir datos al usuario'),
                Padding(padding: EdgeInsets.all(10)),
                ElevatedButton(
                  onPressed: () {
                    getUserInfo('1');
                  },
                  child: const Text('Consultar datos'),
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  controller: _controllerUserInfo,
                  maxLines: 10,
                  minLines: 4,
                ),
                Padding(padding: EdgeInsets.all(10)),
                UserDataWidget(),
                Padding(padding: EdgeInsets.all(20)),
                ElevatedButton(
                  onPressed: () {
                    createPost('mi nuevo Post');
                  },
                  child: const Text('Crear Post'),
                ),
                TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  controller: _controllerPostResponse,
                  maxLines: 10,
                  minLines: 4,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void createPost(String title) async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/posts/");
    var newPost = jsonEncode(<String, String>{
      'title': title,
      'body': 'este es mi nuevo post',
      'userId': '1',
    });
    var postHeaders = <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    };

    var response = await http.post(url, body: newPost, headers: postHeaders);
    _controllerPostResponse.value = TextEditingValue(text: response.body);
  }

  void getUserInfo(String userId) async {
    var url = Uri.parse("https://jsonplaceholder.typicode.com/users/$userId");
    var response = await http.get(url);

    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    _controllerUserInfo.value = TextEditingValue(text: response.body);
  }
}

class UserDataWidget extends StatefulWidget {
  const UserDataWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return UserDataState();
  }
}

class UserDataState extends State {
  late Future<User> futureUserData;
  final TextEditingController _controllerUserName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();

  @override
  void initState() {
    super.initState;
    futureUserData = fillUserInfoFromJson('1');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: futureUserData,
      builder: (context, snapshot) {
        //Snapshot es la info devuelta por futureUserData
        if (snapshot.hasData) {
          return Column(
            children: [
              Text('Datos obtenidos del usuario'),
              TextField(
                controller: TextEditingController(
                  text: snapshot.data!.username,
                ),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
              TextField(
                controller: TextEditingController(text: snapshot.data!.email),
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Email',
                ),
              ),
            ],
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Future<User> fillUserInfoFromJson(String userId) async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/users/$userId');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      return Future.delayed(const Duration(seconds: 3), () {
        return User.fromJson(jsonDecode(response.body));
      });
    } else {
      throw Exception('Error al obtener datos del usuario');
    }
  }
}

class User {
  final int id;
  final String name;
  final String username;
  final String email;

  User(this.id, this.name, this.username, this.email);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(json['id'], json['name'], json['username'], json['email']);
  }
}
