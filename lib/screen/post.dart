import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String name = '';
  String desc = '';
  String imageURL = '';
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Item', style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) => name = value,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(height: 10,),
            TextField(
              onChanged: (value) => desc = value,
              decoration: const InputDecoration(labelText: 'description'),
            ),
            const SizedBox(height: 10,),
            TextField(
              onChanged: (value) => imageURL = value,
              decoration: const InputDecoration(labelText: 'Image'),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              onPressed: addUser, 
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple,
            ),
            child: const Text(
              'Add Products',
              style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> addUser() async {
    setState(() => isLoading = true); 
    
    try {
      var response = await http.post(
        Uri.parse('https://reqres.in/api/users?'),
        body: {'name' : name, 'description' : desc, 'avatar' : imageURL}
      );
      if (response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Products added: ${jsonResponse['name']}')),
      );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add products: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred: $e')),
        );
    }
    

    setState (() => isLoading = false);
  }

}