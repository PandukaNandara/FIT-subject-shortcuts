import 'dart:convert';

import 'package:fit_shortcuts/components/subject_tile.dart';
import 'package:fit_shortcuts/config/it_modules.dart';
import 'package:fit_shortcuts/constants/constants.dart';
import 'package:fit_shortcuts/constants/shared_preferences_constants.dart';
import 'package:fit_shortcuts/dialog/info_dialog.dart';
import 'package:fit_shortcuts/models/models.dart';
import 'package:fit_shortcuts/screens/hidden_subject_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final String semCode = "L3_S1";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TempHolder>(
      future: _loadModules(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(body: Center(child: Text(snapshot.error.toString())));
        }
        if (!snapshot.hasData) {
          return Scaffold();
        } else {
          final data = snapshot.data!.module;
          final sharedPreferences = snapshot.data!.sharedPreferences;
          final list = _loadOrderedList(data.three.one, sharedPreferences);
          return Scaffold(
            appBar: AppBar(
              title: Text("Shortcuts"),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 30.0),
                  child: IconButton(
                    onPressed: _onPressedInfo,
                    icon: Icon(Icons.info),
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      _onTapHiddenList(context, data, sharedPreferences),
                  icon: Icon(Icons.archive_outlined),
                  tooltip: "Archived Subjects",
                ),
              ],
            ),
            body: ReorderableListView(
              padding: kDefaultPadding,
              buildDefaultDragHandles: false,
              onReorder: (o, n) =>
                  _onChangeOrder(o, n, data.three.one, sharedPreferences),
              children: loadSubjects(data.three.one, sharedPreferences),
            ),
          );
        }
      },
    );
  }

  List<Widget> loadSubjects(
      List<Subject> subjects, SharedPreferences sharedPreferences) {
    final hiddenList = sharedPreferences
            .getStringList(SharedPreferencesConstants.hiddenSubject) ??
        [];
    final list = _loadOrderedList(subjects, sharedPreferences);
    int index = 0;
    return list
        .where((element) => !hiddenList.contains(element))
        .map((e) => subjects.singleWhere((element) => element.code == e))
        .map((e) => SubjectTile(
              e,
              key: ValueKey(e.code),
              onPressArchived: _onPressArchived,
              index: index++,
            ))
        .toList();
  }

  List<String> _loadOrderedList(
    List<Subject> subjects,
    SharedPreferences sharedPreferences,
  ) {
    var orderedList = sharedPreferences
        .getStringList(SharedPreferencesConstants.orderedSubjects(semCode));
    if (orderedList == null) {
      orderedList = subjects.map((e) => e.code).toList();
      sharedPreferences.setStringList(
          SharedPreferencesConstants.orderedSubjects(semCode), orderedList);
    }
    return orderedList;
  }

  Future<TempHolder> _loadModules() async {
    return TempHolder(kItModules, await SharedPreferences.getInstance());
  }

  void _onTapHiddenList(BuildContext context, ConfigModule configModule,
      SharedPreferences sharedPreferences) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HiddenSubjectScreen(
          sharedPreferences: sharedPreferences,
          configModule: configModule,
          onUnArchived: () => setState(() {}),
          semCode: semCode,
        ),
      ),
    );
  }

  _onPressArchived(bool isArchived, Subject subject) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final hiddenSubject = sharedPreferences
            .getStringList(SharedPreferencesConstants.hiddenSubject) ??
        [];
    setState(() {
      hiddenSubject.add(subject.code);
      sharedPreferences.setStringList(
          SharedPreferencesConstants.hiddenSubject, hiddenSubject);
      final ordered = sharedPreferences.getStringList(
        SharedPreferencesConstants.orderedSubjects(semCode),
      );
      ordered!.removeWhere((element) => element == subject.code);
      sharedPreferences.setStringList(
          SharedPreferencesConstants.orderedSubjects(semCode), ordered);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${subject.name} archived')));
  }

  void _onPressedInfo() {
    showDialog(
      context: context,
      builder: (context) {
        return InfoDialog();
      },
    );
  }

  void _onChangeOrder(
    int oldIndex,
    int newIndex,
    List<Subject> subjects,
    SharedPreferences sharedPreferences,
  ) {
    final orderedList = _loadOrderedList(subjects, sharedPreferences);
    if (oldIndex < newIndex) {
      // removing the item at oldIndex will shorten the list by 1.
      newIndex -= 1;
    }
    final element = orderedList.removeAt(oldIndex);
    orderedList.insert(newIndex, element);
    setState(() {
      sharedPreferences.setStringList(
          SharedPreferencesConstants.orderedSubjects(semCode), orderedList);
    });
  }
}

class TempHolder {
  final ConfigModule module;
  final SharedPreferences sharedPreferences;

  const TempHolder(this.module, this.sharedPreferences);
}
