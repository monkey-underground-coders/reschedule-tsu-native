import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:flutterapp/domain/facultygroup.dart';
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
        body: InitialPageContent(),
      ),
    );
  }
}

class InitialPageContent extends StatefulWidget {
  InitialPageContent({Key key}) : super(key: key);

  @override
  InitialPageContentState createState() => InitialPageContentState();
}

void showSettingsDialog(
  BuildContext context,
  List<String> dialogOptions,
  String dialogTitle,
  Function dialogOptionPressHandler,
) {
  final renderedDialogOptions = dialogOptions
      .map(
        (e) => SimpleDialogOption(
          key: Key(e),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(
              e,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
            ),
          ),
          onPressed: () {
            dialogOptionPressHandler(e);
            Navigator.pop(context);
          },
        ),
      )
      .toList();

  showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return SimpleDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          dialogTitle,
          style: TextStyle(fontWeight: FontWeight.bold, color: backgroundColor),
        ),
        children: renderedDialogOptions,
      );
    },
  );
}

class SettingsButtonInput extends StatelessWidget {
  SettingsButtonInput({
    @required this.onTap,
    @required this.enabledPredicate,
    @required this.title,
  });

  final Function onTap;
  final bool enabledPredicate;
  final String title;

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 18),
      padding: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
        color: secondaryBGColor,
        border: Border.all(width: 1, color: secondaryBGColor2),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        onTap: onTap,
        dense: true,
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).textTheme.caption.color,
          ),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Theme.of(context).textTheme.caption.color,
        ),
        enabled: enabledPredicate,
      ),
    );
  }
}

class InitialPageContentState extends State<InitialPageContent> {
  List<Faculty> faculties = [];
  List<FacultyGroup> groups = [];
  List<String> appropriateGroups = [];
  List<String> levels = [];

  String selectedFaculty = '';
  String selectedLevel = '';
  FacultyGroup selectedGroup;

  @override
  void initState() {
    super.initState();
    this.loadFaculties();
  }

  loadFaculties() async {
    final request = await http.get('https://rts.a6raywa1cher.com/reschedule-tsu-spring/faculties');

    if (request.statusCode == 200) {
      final facultiesList = (json.decode(request.body) as Map)['faculties'] as List<dynamic>;
      setState(() {
        faculties = facultiesList.map((value) => Faculty(title: value)).toList();
      });
    } else {
      print("TODO: Handle error here in the future...");
    }
  }

  loadFacultyGroups() async {
    final request = await http.get(
      'https://rts.a6raywa1cher.com/reschedule-tsu-spring/faculties/$selectedFaculty/groups?full_table=false',
    );

    if (request.statusCode == 200) {
      final groupsList = (json.decode(request.body) as Map)['groups'] as List<dynamic>;

      final constructedGroupsList = groupsList
          .map(
            (value) => FacultyGroup(
              title: value['name'],
              course: value['course'],
              level: value['level'],
              subgroups: value['subgroups'],
            ),
          )
          .toList();

      final List<String> constructedLevelList = constructedGroupsList.fold(
        [],
        (acc, group) {
          if (!acc.contains(group.level)) {
            acc.add(group.level);
          }
          return acc;
        },
      );

      setState(() {
        groups = constructedGroupsList;
        levels = constructedLevelList;
      });
    } else {
      print("TODO: Handle error here in the future...");
    }
  }

  showFacultySelectionDialog() {
    showSettingsDialog(
      context,
      faculties.map((e) => e.title).toList(),
      Strings.chooseFaculty,
      (String faculty) {
        setState(() {
          selectedFaculty = faculty;
          selectedLevel = '';
          selectedGroup = null;
          this.loadFacultyGroups();
        });
      },
    );
  }

  showLevelSelectionDialog() {
    showSettingsDialog(
      context,
      levels,
      Strings.chooseLevel,
      (String level) {
        setState(() {
          selectedLevel = level;
          selectedGroup = null;
          appropriateGroups =
              groups.where((group) => group.level == level).map((e) => e.title).toList();
        });
      },
    );
  }

  showFacultyGroupSelectionDialog() {
    showSettingsDialog(
      context,
      appropriateGroups,
      Strings.chooseGroup,
      (String group) {
        setState(() {
          selectedGroup = groups.firstWhere((_group) => _group.title == group);
        });
      },
    );
  }

  getContinueButtonOnPressHandler() {
    if (this.selectedFaculty.isNotEmpty && selectedGroup != null && selectedLevel.isNotEmpty) {
      return () {
        print("Motherfucker!?");
      };
    }
    return null;
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
                      Image.asset(
                        'assets/tvsu_logo.png',
                        height: 200,
                        width: 209,
                      ),
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
                  SettingsButtonInput(
                    onTap: showFacultySelectionDialog,
                    enabledPredicate: true,
                    title: selectedFaculty.isEmpty
                        ? Strings.chooseFaculty
                        : "Факультет: $selectedFaculty",
                  ),
                  SettingsButtonInput(
                    onTap: showLevelSelectionDialog,
                    enabledPredicate: selectedFaculty.isNotEmpty,
                    title: selectedLevel.isEmpty ? Strings.chooseLevel : "Степень: $selectedLevel",
                  ),
                  SettingsButtonInput(
                    onTap: showFacultyGroupSelectionDialog,
                    enabledPredicate: selectedLevel.isNotEmpty,
                    title: selectedGroup == null
                        ? Strings.chooseGroup
                        : "Группа: ${selectedGroup.title}",
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
                                onPressed: getContinueButtonOnPressHandler(),
                                textColor: Colors.white,
                                color: backgroundColor,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                                disabledColor: secondaryBGColor,
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
            child: Image.asset(
              'assets/muc_logo.png',
              height: 26,
              width: 182,
            ),
          )
        ],
      ),
    );
  }
}
