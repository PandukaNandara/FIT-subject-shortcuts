import 'dart:convert';

import 'package:fit_shortcuts/components/subject_tile.dart';
import 'package:fit_shortcuts/constants/constants.dart';
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
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        } else {
          final data = snapshot.data!.module;
          final sharedPreferences = snapshot.data!.sharedPreferences;
          return Scaffold(
            appBar: AppBar(
              title: Text("Shortcuts"),
            ),
            body: ListView(
              padding: kDefaultPadding,
              children: [
                Column(
                  children: loadSubjects(data.three.one, sharedPreferences),
                ),
                ListTile(
                  leading: Icon(Icons.archive_outlined),
                  title: Text("Archived Subjects"),
                  onTap: () =>
                      _onTapHiddenList(context, data, sharedPreferences),
                )
              ],
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

    return subjects
        .where((element) => !hiddenList.contains(element.code))
        .map((e) => SubjectTile(
              e,
              onPressArchived: _onPressArchived,
            ))
        .toList();
  }

  Future<TempHolder> _loadModules() async {
    final json = await rootBundle.loadString('config/modules.json');
    final config = ConfigModule.fromJson(jsonDecode(json));
    return TempHolder(config, await SharedPreferences.getInstance());
  }

  void _onTapHiddenList(BuildContext context, ConfigModule configModule,
      SharedPreferences sharedPreferences) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => HiddenSubjectScreen(
            sharedPreferences: sharedPreferences, configModule: configModule),
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
    });
  }
}

class TempHolder {
  final ConfigModule module;
  final SharedPreferences sharedPreferences;

  const TempHolder(this.module, this.sharedPreferences);
}
