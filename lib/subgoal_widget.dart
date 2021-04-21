import 'package:flutter/material.dart';
import 'package:motivateme_mobile_app/model/subgoal.dart';

import 'model/goal.dart';

// represents a subgoal widget
class SubGoalWidget extends StatefulWidget {
  final SubGoal subgoal;
  final String title;
  final String description;
  SubGoalWidget({Key key, this.subgoal, this.title, this.description}) : super(key: key);

  @override
  SubGoalWidgetState createState() => SubGoalWidgetState();
}

class SubGoalWidgetState extends State<SubGoalWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.album),
            title: Text(widget.title),
            subtitle: Text(widget.description),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('BUY TICKETS'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('LISTEN'),
                onPressed: () {/* ... */},
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
