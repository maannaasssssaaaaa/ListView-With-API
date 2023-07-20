import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> users = [];

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('http://www.mocky.io/v2/5d565297300000680030a986'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        users = data.map((item) => Person.fromJson(item)).toList();
      });
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee List',
          style: TextStyle(
            fontSize: 20, // Text size
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final person = users[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(person.profileImage ?? ''),
              radius: 25, // Set the radius of the CircleAvatar
            ),
            title: Text(person.name ?? ''),
            subtitle: Text(person.username ?? ''),
          );
        },
      ),
    );
  }
}

class DetailListTile extends StatefulWidget {
  final Person person;

  const DetailListTile({Key? key, required this.person}) : super(key: key);

  @override
  State<DetailListTile> createState() => _DetailListTileState();
}

class _DetailListTileState extends State<DetailListTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(widget.person.profileImage ?? ''),
        radius: 25, // Set the radius of the CircleAvatar
      ),
      title: Text(widget.person.name ?? ''),
      subtitle: Text(widget.person.username ?? ''),
    );
  }
}
