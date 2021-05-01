import 'dart:io';

import 'package:flutter/material.dart';
import 'package:motivateme_mobile_app/service/goal_manager.dart';

class CollagePage extends StatefulWidget {
  @override
  CollagePageState createState() => CollagePageState();
}

class CollagePageState extends State<CollagePage> {
  final goalManager = GoalManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: goalManager.retrieveSubGoalsForWeek(DateTime.now()),
          builder: (context, snapshot) {
            List<Widget> completedGoalsToDisplay = [];
            List<Widget> incompleteGoalsToDisplay = [];
            var listOfSubgoals = snapshot.data;
            if (snapshot.hasData) {
              for (var subGoal in listOfSubgoals.entries) {
                List<Widget> images = [];
                for (var goal in subGoal.value) {
                  if (goal.completed && goal.pathToPicture != null) {
                    images.add(Image.file(File(goal.pathToPicture)));
                    images.add(
                        Text('You completed ' + subGoal.key + ' this week!'));
                    completedGoalsToDisplay.add(Column(
                      children: images,
                    ));
                  } else if(goal.completed) {
                    completedGoalsToDisplay.add(Text('You completed ' + goal.title + ' this week!'));
                  } else if(!goal.completed && goal.comment != null) {
                    incompleteGoalsToDisplay.add(Text("You didn't complete " + goal.title +' due to ' + goal.comment + ' this week.'));
                  } else {
                    incompleteGoalsToDisplay.add(Text("You weren't able to complete " + goal.title + ' this week.'));
                  }
                }
              }
              return SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(children: [
                    Text('You completed the following!'),
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: completedGoalsToDisplay.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Column(
                              children: [
                                Padding(padding: EdgeInsets.only(top: 50.0)),
                                completedGoalsToDisplay.elementAt(index),
                                Padding(padding: EdgeInsets.only(bottom: 50.0)),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                    Text("You weren't able to complete these goals")
                  ]));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
