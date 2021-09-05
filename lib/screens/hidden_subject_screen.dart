import 'package:fit_shortcuts/components/subject_tile.dart';
import 'package:fit_shortcuts/models/models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fit_shortcuts/constants/constants.dart';

class HiddenSubjectScreen extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  final ConfigModule configModule;
  const HiddenSubjectScreen(
      {Key? key, required this.sharedPreferences, required this.configModule})
      : super(key: key);

  @override
  _HiddenSubjectScreenState createState() => _HiddenSubjectScreenState();
}

class _HiddenSubjectScreenState extends State<HiddenSubjectScreen> {
  @override
  Widget build(BuildContext context) {
    final subjects = widget.sharedPreferences
            .getStringList(SharedPreferencesConstants.hiddenSubject) ??
        [];
    return Scaffold(
      appBar: AppBar(
        title: Text("Hidden Subjects"),
      ),
      body: subjects.length > 0
          ? ListView(
              padding: kDefaultPadding,
              children: (subjects).map(
                (e) {
                  final subject = widget.configModule.getSubject(e);
                  if (subject == null)
                    return SizedBox.shrink();
                  else
                    return SubjectTile(
                      subject,
                      isArchived: true,
                      onPressArchived: _onPressArchived,
                    );
                },
              ).toList(),
            )
          : Center(child: Text("There is no hidden subject")),
    );
  }

  _onPressArchived(bool isArchived, Subject subject) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final hiddenSubject = sharedPreferences
            .getStringList(SharedPreferencesConstants.hiddenSubject) ??
        [];
    setState(() {
      hiddenSubject.remove(subject.code);
      sharedPreferences.setStringList(
          SharedPreferencesConstants.hiddenSubject, hiddenSubject);
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('${subject.name} unarchived')));
  }
}
