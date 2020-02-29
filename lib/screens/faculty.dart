import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutterapp/domain/facultygroup.dart';

class FacultyPage extends StatelessWidget {
  final String facultyTitle;

  const FacultyPage({Key key, @required this.facultyTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          title: Text('Факультет $facultyTitle'),
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: FacultyGroupList(
          facultyTitle: this.facultyTitle,
        ),
      ),
    );
  }
}

class FacultyGroupList extends StatefulWidget {
  FacultyGroupList({Key key, @required this.facultyTitle}) : super(key: key);

  final String facultyTitle;

  @override
  FacultyGroupListState createState() => FacultyGroupListState();
}

class FacultyGroupListState extends State<FacultyGroupList> {
  List<FacultyGroup> groups = [];

  @override
  void initState() {
    super.initState();
    this._loadFacultyGroups();
  }

  void _loadFacultyGroups() async {
    final title = widget.facultyTitle;

    final request = await http.get(
        'https://rts.a6raywa1cher.com/reschedule-tsu-spring/faculties/$title/groups?full_table=false');

    if (request.statusCode == 200) {
      print((json.decode(request.body) as Map));
      final groupsList =
          (json.decode(request.body) as Map)['groups'] as List<dynamic>;
      print(groupsList);
      setState(() {
        groups = groupsList
            .map((value) => FacultyGroup(
                title: value['name'] + " (" + value['level'] + ")"))
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ListView.builder(
          itemCount: groups.length,
          itemBuilder: (context, i) {
            return Card(
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
                      Icons.insert_emoticon,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                  title: Text(
                    groups[i].title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.headline6.color,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right,
                      color: Theme.of(context).textTheme.headline6.color),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
