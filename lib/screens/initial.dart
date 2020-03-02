import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/strings.dart';
import 'package:http/http.dart' as http;
import '../domain/faculty.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.white,
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

  Future<void> _askedToLead() async {
    switch (await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: const Text('Выберите факультет'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "Sex with Tanya");
                },
                child: const Text('Факультет ПМиК'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "Go smoke");
                },
                child: const Text('Факультет ИнЯЗ'),
              ),
               SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "Go smoke");
                },
                child: const Text('Факультет Психологии'),
              ),
               SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, "Go smoke");
                },
                child: const Text('Факультет не твоих собачьих дел'),
              ),
            ],
          );
        })) {
      case "Sex with Tanya":
        // Let's go.
        // ...
        break;
      case "Go smoke":
        // ...
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              margin: EdgeInsets.only(top: 15),
              child: ListView(
                children: [
                  Center(
                    child: Column(children: [
                      Image.asset('assets/tvsu_logo.png'),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          Strings.mainHeadline.toUpperCase(),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: secondaryColor,
                            // letterSpacing: 0.75,
                          ),
                        ),
                      ),
                    ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 45, left: 5),
                    child: Text(
                      Strings.mainFillData,
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                      color: secondaryBGColor,
                      border: Border.all(width: 1, color: secondaryBGColor2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      onTap: () {
                        _askedToLead();
                      },
                      dense: true,
                      title: Text(
                        "Выберите факультет",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.caption.color,
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 18),
                    padding: EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                      color: secondaryBGColor,
                      border: Border.all(width: 1, color: secondaryBGColor2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      onTap: () {
                        _askedToLead();
                      },
                      dense: true,
                      title: Text(
                        "Выберите степень",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.caption.color,
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                      enabled: false,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 18),
                    padding: EdgeInsets.only(top: 0),
                    decoration: BoxDecoration(
                      color: secondaryBGColor,
                      border: Border.all(width: 1, color: secondaryBGColor2),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: ListTile(
                      onTap: () {
                        _askedToLead();
                      },
                      dense: true,
                      title: Text(
                        "Выберите группу",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Theme.of(context).textTheme.caption.color,
                        ),
                      ),
                      trailing: Icon(
                        Icons.keyboard_arrow_right,
                        color: Theme.of(context).textTheme.caption.color,
                      ),
                      enabled: false,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 25),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              RaisedButton(
                                onPressed: () {},
                                textColor: Colors.white,
                                color: backgroundColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      "Продолжить",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: Image.asset('assets/arrow_1.png'),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 15),
            child: Image.asset('assets/muc_logo.png'),
          )
        ],
      ),
    );
  }
}
