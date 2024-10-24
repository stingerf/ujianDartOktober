import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DeletePage extends StatefulWidget {
  const DeletePage({super.key});

  @override
  State<DeletePage> createState() => _DeletePageState();
}

class _DeletePageState extends State<DeletePage> {
  // yang menampung nampung di atas overide
  final TextEditingController idController = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Delete Products',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.lightBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Delete Product',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'yakin mau di delete bang?',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20,),
            TextField(
              controller: idController,
              decoration: const InputDecoration(labelText: 'Enter User ID'),
            ),
            const SizedBox(
              height: 30,
            ),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: deletUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                    ),
                    child: const Text(
                      'Delete User',
                      style: TextStyle(color: Colors.white),
                    )),
          ],
        ),
      ),
    );
  }

  Future<void> deletUser() async {
    setState(() => isLoading = true);

    try {
      final response = await http.delete(
        Uri.parse('https://fakestoreapi.com/products/${idController.text}'),
      );

      final message = response.statusCode == 204
          ? 'User deleted succesfully'
          : 'Succes';

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
    setState(() => isLoading = false);
  }
}
