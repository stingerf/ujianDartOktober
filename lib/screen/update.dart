import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateUserPage extends StatefulWidget {
  const UpdateUserPage({super.key});

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  TextEditingController idController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController avatarController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Item',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'id'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'desc'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: avatarController,
              decoration: const InputDecoration(labelText: 'Image Url'),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                updateUser(idController.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
              ),
              child: const Text(
                'Update Item',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> updateUser(String userId) async {
    if (userId.isEmpty || userId.length > 3 || int.tryParse(userId) == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Invalid user ID, please enter a valid user ID'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      var response = await http
          .put(Uri.parse('https://fakestoreapi.com/products/$userId'), body: {
        'name': nameController.text,
        'desc': descController.text,
        'avatar': avatarController.text
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Item Updated')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update item: ${response.body}')),
        );
      }
    } catch (e) {}

    setState(() {
      isLoading = false;
    });
  }
}