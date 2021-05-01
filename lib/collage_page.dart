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
            var listOfSubgoals = snapshot.data;
            goalManager.sampleQuery();
            if (snapshot.hasData) {
              return SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(children: [
                    ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: listOfSubgoals.length,
                      itemBuilder: (context, index) {
                        return Image.file(File(listOfSubgoals
                            .elementAt(index)
                            .pathToPicture
                            .toString()));
                      },
                    )
                  ]));
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
