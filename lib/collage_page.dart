import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:motivateme_mobile_app/service/goal_manager.dart';

class CollagePage extends StatefulWidget {
  @override
  CollagePageState createState() => CollagePageState();
}

class CollagePageState extends State<CollagePage> {
  final goalManager = GoalManager();

  String retrieveDatesForCurrentWeek() {
    DateTime now = DateTime.now();
    int daysUntilMonday = now.weekday - DateTime.monday;
    int daysUntilSunday = DateTime.sunday - now.weekday;
    DateTime startOfWeek = now.subtract(Duration(days: daysUntilMonday));
    DateTime endOfWeek = now.add(Duration(days: daysUntilSunday));

    return DateFormat.yMd().format(startOfWeek) +
        ' to ' +
        DateFormat.yMd().format(endOfWeek);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
            child: Container(
          child: FutureBuilder(
              future: goalManager.retrieveSubGoalsForWeek(DateTime.now()),
              builder: (context, snapshot) {
                List<Widget> completedGoalsToDisplay = [];
                List<Widget> incompleteGoalsToDisplay = [];
                var listOfSubgoals = snapshot.data;
                if (snapshot.hasData) {
                  for (var subGoal in listOfSubgoals.entries) {
                    List<Widget> images = [];

                    for (var goal in subGoal.value) {
                      if (goal.completed == null) {
                        continue;
                      } else if (goal.completed && goal.pathToPicture != null) {
                        File(goal.pathToPicture).exists().then((value) {
                          if (value) {
                            images.add(Image.file(File(goal.pathToPicture)));
                            images.add(Text(
                                'You completed ' + subGoal.key + ' this week!',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18.0)));
                            completedGoalsToDisplay.add(Column(
                              children: images,
                            ));
                          } else {
                            completedGoalsToDisplay.add(Text(
                                'You completed ' + goal.title + ' this week!',
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18.0)));
                          }
                        });
                      } else if (goal.completed) {
                        completedGoalsToDisplay.add(Text(
                            'You completed ' + goal.title + ' this week!',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18.0)));
                      } else if (!goal.completed && goal.comment != null) {
                        incompleteGoalsToDisplay.add(Text(
                            "You didn't complete " +
                                goal.title +
                                ' due to ' +
                                goal.comment +
                                ' this week.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18.0)));
                      } else {
                        incompleteGoalsToDisplay.add(Text(
                            "You weren't able to complete " +
                                goal.title +
                                ' this week.',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18.0)));
                      }
                    }
                  }
                  return SingleChildScrollView(
                      physics: ScrollPhysics(),
                      child: Column(children: [
                        Padding(padding: EdgeInsets.only(top: 25.0)),
                        Text(retrieveDatesForCurrentWeek(),
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.bold)),
                        Padding(
                            padding: EdgeInsets.only(top: 10.0, bottom: 10.0)),
                        completedGoalsToDisplay.length == 0 &&
                                incompleteGoalsToDisplay.length == 0
                            ? Text(
                                'Nothing to see here 	╮(￣ω￣;)╭',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            : Container(height: 0, width: 0),
                        completedGoalsToDisplay.length == 0
                            ? Container(height: 0, width: 0)
                            : Text(
                                'You completed the following!',
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: completedGoalsToDisplay.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 50.0)),
                                    completedGoalsToDisplay.elementAt(index),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 50.0)),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        incompleteGoalsToDisplay.length == 0
                            ? Container(height: 0, width: 0)
                            : Text("You weren't able to complete these goals",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold)),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: incompleteGoalsToDisplay.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                        padding: EdgeInsets.only(top: 50.0)),
                                    incompleteGoalsToDisplay.elementAt(index),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: 50.0)),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        incompleteGoalsToDisplay.length == 0
                            ? Container(height: 0, width: 0)
                            : Center(
                                child: Text(
                                    "Let's work hard to complete these goals! (* ^ ω ^)",
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold))),
                      ]));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        )));
  }
}
