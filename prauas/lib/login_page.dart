import 'package:flutter/material.dart';
import 'user_list_page.dart';

class LoginPage extends StatelessWidget {
  final userC = TextEditingController();
  final passC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: userC,
              decoration: InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: passC,
              obscureText: true,
              decoration: InputDecoration(labelText: "Password"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Login"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => UserListPage()),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
