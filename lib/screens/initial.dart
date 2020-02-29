import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../domain/faculty.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Расписание ТвГУ'),
          leading: Icon(Icons.view_list),
        ),
        body: FacultyList(),
      ),
    );
  }
}

class FacultyList extends StatefulWidget {
  FacultyList({Key key}) : super(key: key);

  @override
  _FacultyListState createState() => _FacultyListState();
}

class _FacultyListState extends State<FacultyList> {
  List<Faculty> faculties = [];

  @override
  void initState() {
    super.initState();
    this._loadFaculties();
  }

  void _loadFaculties() async {
    final request = await http
        .get('https://rts.a6raywa1cher.com/reschedule-tsu-spring/faculties');

    if (request.statusCode == 200) {
      final facultiesList =
          (json.decode(request.body) as Map)['faculties'] as List<dynamic>;
      setState(() {
        faculties =
            facultiesList.map((value) => Faculty(title: value)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView.builder(
          itemCount: faculties.length,
          itemBuilder: (context, i) {
            return GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed('/faculty', arguments: faculties[i].title);
              },
              child: Card(
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(50, 65, 85, 0.85),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    leading: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          right: BorderSide(width: 1, color: Colors.white24),
                        ),
                      ),
                      padding: EdgeInsets.only(right: 12),
                      child: Icon(
                        Icons.album,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),
                    title: Text(
                      faculties[i].title,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).textTheme.headline6.color,
                      ),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Theme.of(context).textTheme.headline6.color),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
