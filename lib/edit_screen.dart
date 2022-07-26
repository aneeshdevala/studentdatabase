import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'db/functions/db_functions.dart';
import 'db/models/data_model.dart';
import 'home_screen.dart';
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class EditPage extends StatefulWidget {
  StudentModel data;
  int? index;
  EditPage({Key? key, required this.data, required this.index})
      : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final formkey = GlobalKey<FormState>();

  final _name = TextEditingController();

  final _age = TextEditingController();

  final _domain = TextEditingController();

  final _phone = TextEditingController();
  final ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    _name.text = widget.data.name.toString();
    _age.text = widget.data.age.toString();
    _domain.text = widget.data.domain.toString();
    _phone.text = widget.data.phone.toString();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit student'),
      ),
      body: Form(
          child: ListView(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: CircleAvatar(
                  backgroundImage: MemoryImage(
                      const Base64Decoder().convert(widget.data.image)),
                  radius: 50,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invald Username';
                } else {
                  return null;
                }
              },
              controller: _name,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid age';
                } else {
                  return null;
                }
              },
              controller: _age,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Age',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid domain';
                } else {
                  return null;
                }
              },
              controller: _domain,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Domain'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Invalid Phone';
                } else {
                  return null;
                }
              },
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Phone',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
                onPressed: () {
                  checkValidation();
                  formkey.currentState?.validate();
                },
                child: const Text('Update')),
          )
        ],
      )),
    );
  }

  String _image = '';

  String imageToString = '';

  pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    } else {
      final imageTemporary = File(image.path).readAsBytesSync();
      imageToString = base64Encode(imageTemporary);
    }

    setState(() {
      _image = imageToString;
    });
  }

  checkValidation() async {
    final name = _name.text.trim();
    final age = _age.text.trim();
    final domain = _domain.text.trim();
    final phone = _phone.text.trim();
    final student = StudentModel(
        age: age, name: name, domain: domain, phone: phone, image: _image);

    if (name.isEmpty || age.isEmpty || domain.isEmpty || phone.isEmpty) {
      return;
    } else {
      updateDetails(data: student, index: widget.index);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const HomeScreen()));
      getAllStudents();
    }
  }
}
