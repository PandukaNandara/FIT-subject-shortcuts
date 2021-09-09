import 'package:fit_shortcuts/constants/constants.dart';
import 'package:fit_shortcuts/models/models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SubjectTile extends StatelessWidget {
  final Subject subject;
  final bool isArchived;
  final int? index;
  final Function(bool isArchived, Subject subject) onPressArchived;
  const SubjectTile(
    this.subject, {
    Key? key,
    this.isArchived = false,
    required this.onPressArchived,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mode = subject.mode;
    final child = Card(
      child: ListTile(
        title: Text(subject.name),
        subtitle: RichText(
          text: TextSpan(
            text: subject.code,
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(color: Colors.grey[400]),
            children: [
              TextSpan(
                text: mode == SubjectMode.C ? " C" : " E",
                style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: mode == SubjectMode.C
                          ? Colors.blue[400]
                          : Colors.orange[400],
                          fontWeight: FontWeight.w900
                    ),
              )
            ],
          ),
        ),
        leading: index != null
        ? ReorderableDragStartListener(index: index!, child: Icon(Icons.drag_handle))
        : null,
        trailing: IconButton(
          icon: Icon(!isArchived ? Icons.archive : Icons.unarchive),
          tooltip: 'Archive',
          onPressed: _onPressArchive,
        ),
        onTap: _onTap,
      ),
    );

    return child;
  }

  void _onTap() async {
    launch(subject.url);
  }

  Future<void> _onPressArchive() async {
    onPressArchived(isArchived, subject);
  }
}
