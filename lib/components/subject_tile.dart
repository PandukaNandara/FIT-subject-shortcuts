import 'package:fit_shortcuts/constants/constants.dart';
import 'package:fit_shortcuts/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SubjectTile extends StatelessWidget {
  final Subject subject;
  final bool isArchived;
  final Function(bool isArchived, Subject subject) onPressArchived;
  const SubjectTile(
    this.subject, {
    Key? key,
    this.isArchived = false,
    required this.onPressArchived,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mode = subject.mode;
    return ListTile(
      leading: CircleAvatar(
        child: Text(mode == SubjectMode.C ? "C" : "E"),
        backgroundColor: mode == SubjectMode.C ? Colors.blue[400] : Colors.orange[400],
      ),
      title: Text(subject.name),
      subtitle: Text(subject.code),
      trailing: IconButton(
        icon: Icon(!isArchived ? Icons.archive : Icons.unarchive),
        tooltip: 'Archive',
        onPressed: _onPressArchive,
      ),
      onTap: _onTap,
    );
  }

  void _onTap() async {
    launch(subject.url);
  }

  Future<void> _onPressArchive() async {
    onPressArchived(isArchived, subject);
  }
}
