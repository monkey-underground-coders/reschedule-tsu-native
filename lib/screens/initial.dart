import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:reschedule/api/client.dart';
import 'package:reschedule/constants.dart';
import 'package:reschedule/hive.dart';
import 'package:reschedule/repository/faculty_entity.dart';
import 'package:reschedule/repository/faculty_group_entity.dart';
import 'package:reschedule/strings.dart';

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

void showSettingsDialog<T>(
  BuildContext context,
  List<String> dialogOptions,
  String dialogTitle,
  Function dialogOptionPressHandler,
) {
  var renderedDialogOptions = dialogOptions
      .map(
        (o) => SimpleDialogOption(
          key: Key(o),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Text(o, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15)),
          ),
          onPressed: () {
            dialogOptionPressHandler(o);
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
  final Function onTap;
  final String label;
  final bool enabledPredicate;

  SettingsButtonInput({
    @required this.onTap,
    @required this.enabledPredicate,
    @required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.only(top: 18),
      padding: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
        color: secondaryBGColor,
        border: Border.all(width: 1, color: secondaryBGColor),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: ListTile(
        onTap: onTap,
        dense: true,
        title: Text(
          label,
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
  final userPrefsBox = Hive.box(HiveBoxes.userPrefs);

  String selectedLevel;
  FacultyEntity selectedFaculty;
  FacultyGroupEntity selectedGroup;

  List<FacultyGroupEntity> groups = [];
  List<FacultyEntity> faculties = [];
  List<String> appropriateGroups = [];
  List<String> levels = [];

  @override
  void initState() {
    super.initState();
    this.loadFaculties();

    setState(() {
      selectedGroup = userPrefsBox.get('selectedGroup', defaultValue: null);
      selectedLevel = userPrefsBox.get('selectedLevel', defaultValue: '');
      selectedFaculty = userPrefsBox.get('selectedFaculty', defaultValue: null);
      // appropriateGroups = userPrefsBox.get('appropriateGroups', defaultValue: []);
    });
  }

  loadFaculties() async {
    fetchFaculties(http.Client()).then((response) {
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body)['faculties'];
        final facultiesParsed = parsed.map<FacultyEntity>((json) => FacultyEntity(json)).toList();
        setState(() {
          faculties = facultiesParsed;
        });
      } else {
        print("TODO: Handle error here in the future...");
      }
    }).catchError((err) {
      // TODO: Catch error here.
      print(err);
    });
  }

  loadFacultyGroups() async {
    fetchFacultyGroups(http.Client(), selectedFaculty.title).then((response) {
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body)['groups'];
        List<FacultyGroupEntity> groupsParsed =
            parsed.map<FacultyGroupEntity>((json) => FacultyGroupEntity.fromJson(json)).toList();

        final List<String> levelsParsed = groupsParsed.fold<List<String>>([], (levels, group) {
          if (!levels.contains(group.level)) {
            levels.add(group.level);
          }
          return levels;
        }).toList();

        setState(() {
          groups = groupsParsed;
          levels = levelsParsed;
        });
      }
    }).catchError((err) {
      // TODO: Catch error here
      print(err);
    });
  }

  showFacultySelectionDialog() {
    showSettingsDialog(
      context,
      faculties.map((f) => f.title).toList(),
      Strings.chooseFaculty,
      (String facultyTitle) {
        var faculty = faculties.firstWhere((f) => f.title == facultyTitle);
        setState(() {
          selectedFaculty = faculty;
          selectedLevel = '';
          selectedGroup = null;
        });
        this.loadFacultyGroups();
        userPrefsBox.putAll({
          'selectedFaculty': faculty,
          'selectedLevel': '',
          'selectedGroup': null,
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
        var groupsList = groups.where((group) => group.level == level).map((e) => e.title).toList();
        setState(() {
          selectedLevel = level;
          selectedGroup = null;
          appropriateGroups = groupsList;
        });
        userPrefsBox.putAll({
          'selectedLevel': level,
          'appropriateGroups': groupsList,
          'selectedGroup': null,
        });
      },
    );
  }

  showFacultyGroupSelectionDialog() {
    showSettingsDialog(
      context,
      appropriateGroups,
      Strings.chooseGroup,
      (String groupTitle) {
        var group = groups.firstWhere((_group) => _group.title == groupTitle);
        setState(() {
          selectedGroup = group;
        });
        userPrefsBox.put('selectedGroup', group);
      },
    );
  }

  getContinueButtonOnPressHandler() {
    if (this.selectedFaculty != null && selectedGroup != null && selectedLevel.isNotEmpty) {
      return () {
        Navigator.of(context).pushReplacementNamed('/profile');
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
                    label: selectedFaculty == null
                        ? Strings.chooseFaculty
                        : "Факультет: ${selectedFaculty.title}",
                  ),
                  SettingsButtonInput(
                    onTap: showLevelSelectionDialog,
                    enabledPredicate: selectedFaculty != null,
                    label: selectedLevel.isEmpty ? Strings.chooseLevel : "Степень: $selectedLevel",
                  ),
                  SettingsButtonInput(
                    onTap: showFacultyGroupSelectionDialog,
                    enabledPredicate: selectedLevel != null,
                    label: selectedGroup == null
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
                                elevation: 0.2,
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
                              )
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
