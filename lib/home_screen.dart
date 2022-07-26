import 'package:flutter/material.dart';
import 'add_student.dart';
import 'db/functions/db_functions.dart';
import 'search.dart';
import 'student_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddStudent()));
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Student List'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddStudent()));
              },
              icon: const Icon(Icons.add)),
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: SearchProfile());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: const StudentList(),
    );
  }
}
