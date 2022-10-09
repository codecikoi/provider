import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class MyCountPage extends StatelessWidget {
  const MyCountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myStyle = Theme.of(context).textTheme.headline4;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'ChangeNotifierProvider example',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 50.0),
            Text('0', style: myStyle),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  color: Colors.red,
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  color: Colors.green,
                  onPressed: () {},
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MyUserPage extends StatelessWidget {
  const MyUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'FutureProvider example, users load from File',
            style: TextStyle(fontSize: 17),
          ),
        ),
        Expanded(
          child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Container(
                  height: 50,
                  color: Colors.grey[(index * 200) % 400],
                  child: Center(
                    child: Text('text'.toUpperCase()),
                  ),
                );
              }),
        )
      ],
    );
  }
}

class MyEventPage extends StatelessWidget {
  const MyEventPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myStyle = Theme.of(context).textTheme.headline4;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('StreamProvider Example', style: TextStyle(fontSize: 20.0)),
          SizedBox(height: 50.0),
          Text(
            '0',
            style: myStyle,
          )
        ],
      ),
    );
  }
}

// user provider (future)

class UserProvider {
  final String _dataPath = 'assets/users.json';

  List<User> users = [];

  Future<String> loadAsset() async {
    return await Future.delayed(Duration(seconds: 2), () async {
      return await rootBundle.loadString(_dataPath);
    });
  }

  Future<List<User>> loadUserData() async {
    var dataString = await loadAsset();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    users = UserList.fromJson(jsonUserData['users']).users;
    return users;
  }
}

// EventProvider (Stream)

class EventProvider {
  Stream<int> intStream() {
    Duration interval = const Duration(seconds: 2);
    return Stream<int>.periodic(interval, (int count) => count++);
  }
}

// User model

class User {
  final String firstName, lastName, website;
  const User(this.firstName, this.lastName, this.website);

  User.fromJson(Map<String, dynamic> json)
      : firstName = json['first_name'],
        lastName = json['last_name'],
        website = json['website'];
}

// User List Model

class UserList {
  final List<User> users;
  UserList(this.users);

  UserList.fromJson(List<dynamic> usersJson)
      : users = usersJson.map((user) => User.fromJson(user)).toList();
}
