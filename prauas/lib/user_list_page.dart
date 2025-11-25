import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserListPage extends StatefulWidget {
  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  List users = [];

  @override
  void initState() {
    super.initState();
    loadLocalData();
    fetchUsers();
  }

  // Ambil data dari local storage
  Future<void> loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString("users");
    if (saved != null) {
      setState(() {
        users = jsonDecode(saved);
      });
    }
  }

  // Fetch API + simpan ke local
  Future<void> fetchUsers() async {
    final res = await http.get(
      Uri.parse("https://jsonplaceholder.typicode.com/users"),
    );

    if (res.statusCode == 200) {
      List data = jsonDecode(res.body);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString("users", jsonEncode(data));

      setState(() {
        users = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daftar Pengguna"),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: fetchUsers,
          )
        ],
      ),
      body: users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, i) {
                final u = users[i];
                return ListTile(
                  title: Text(u["name"]),
                  subtitle:
                      Text("${u["email"]}\nKota: ${u["address"]["city"]}"),
                );
              },
            ),
    );
  }
}
