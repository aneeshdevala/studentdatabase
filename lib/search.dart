import 'package:flutter/material.dart';

import 'db/functions/db_functions.dart';
import 'db/models/data_model.dart';
import 'view_screen.dart';


class SearchProfile extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: (BuildContext context, List<StudentModel> studentData,
            Widget? child) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = studentData[index];
              if (query == data.name.toLowerCase() ||
                  query == data.name.toUpperCase()) {
                return ListTile(
                    leading: const Icon(Icons.person),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          (MaterialPageRoute(builder: (ctx) {
                            return ViewScreen(data: data, index: index);
                          })),
                          (route) => false);
                    },
                    title: Text(data.name.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        )));
              } else {
                return const SizedBox();
              }
            },
            separatorBuilder: (context, value) {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            },
            itemCount: studentData.length,
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentListNotifier,
        builder: (BuildContext context, List<StudentModel> studentData,
            Widget? child) {
          return ListView.separated(
            itemBuilder: (ctx, index) {
              final data = studentData[index];
              if (data.name.toLowerCase().contains(query)) {
                return ListTile(
                    leading: const Icon(Icons.person),
                    onTap: () {
                      Navigator.of(context).push(
                        (MaterialPageRoute(builder: (ctx) {
                          return ViewScreen(data: data, index: index);
                        })),
                      );
                    },
                    title: Text(data.name.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                        )));
              } else {
                return Container();
              }
            },
            separatorBuilder: (context, value) {
              return const SizedBox(
                height: 0,
                width: 0,
              );
            },
            itemCount: studentData.length,
          );
        });
  }
}
