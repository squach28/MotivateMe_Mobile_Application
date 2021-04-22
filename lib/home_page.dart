import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';
import 'package:motivateme_mobile_app/add_goals_page.dart';
import 'package:motivateme_mobile_app/login_page.dart';
import 'package:motivateme_mobile_app/service/inspire_me.dart';
import 'package:motivateme_mobile_app/subgoal_widget.dart';
import 'model/goal.dart';
import 'model/subgoal.dart';
import 'service/goal_manager.dart';
import 'signup_page.dart';
import 'service/auth.dart';
import 'model/sign_up_result.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthService authService = AuthService();
  final InspireMeService inspireMeService = InspireMeService();
  List<int> items = List<int>.generate(20, (int index) => index);

  final GoalManager goalManager = GoalManager();

  @override
  Widget build(BuildContext context) {
    // 2
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              authService.logout();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => LoginPage()));
            },
            child: Text('Sign Out'),
          ),
        ],
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [const Color(0xffB7F8DB), const Color(0xff50A7C2)],
          )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => AddGoalsPage()));
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment
                .centerRight, // 10% of the width, so there are ten blinds.
            colors: [
              const Color(0xffB7F8DB),
              const Color(0xff50A7C2)
            ], // red to yellow
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Center(
              child: Column(children: [
            Container(
              padding: EdgeInsets.only(top: 10.0),
              alignment: Alignment.topCenter,
              child: TextButton(
                onPressed: () async {
                  var url =
                      await inspireMeService.inspireMe(); // TODO delete this
                  return showDialog<void>(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('AWS Test'),
                          content:
                              SingleChildScrollView(child: Image.network(url)),
                          actions: [
                            TextButton(
                                child: Text('Very Nice'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                })
                          ],
                        );
                      });
                },
                child: new Text(
                  'Inspire Me',
                  style: new TextStyle(fontSize: 16.0, color: Colors.black),
                ),
              ),
            ),
            FutureBuilder<List<SubGoal>>(
                future: goalManager.retrieveSubGoalsForToday(),
                builder:
                    (BuildContext context, AsyncSnapshot<List<SubGoal>> snapshot) {
                  if (snapshot.hasData) {
                    List<SubGoal> subGoals = snapshot.data;
                    return ListView.builder(
                      // physics: const AlwaysScrollableScrollPhysics(),
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: subGoals.length,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      itemBuilder: (BuildContext context, int index) {
                        return Dismissible(
                          child: SubGoalWidget(subgoal: subGoals.elementAt(index),
                          title: subGoals.elementAt(index).title,
                          description: subGoals.elementAt(index).description),
                          background: Container(
                              padding: EdgeInsets.only(left: 60.0),
                              alignment: Alignment.centerLeft,
                              color: Colors.green,
                              child: Icon(Icons.check)),
                          secondaryBackground:
                              Container(color: Colors.red, child: Text("left")),
                          key: UniqueKey(),
                          onDismissed: (DismissDirection direction) {
                            setState(() {
                              goalManager.markGoalAsComplete(subGoals.elementAt(index));
                            });
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Colors.green),
                    );
                  }
                })
          ])),
        ),
      ),
    );
  }
}
