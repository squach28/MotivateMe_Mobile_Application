// class that represents a user's goal
class Goal {
  final int id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final Map<String, bool>
      goalDays; // map of the goal day and whether it is active on that day
  final bool isComplete;

  Goal(
      {this.id,
      this.title,
      this.description,
      this.startTime,
      this.endTime,
      this.goalDays,
      this.isComplete});

  Map<String, dynamic> toMap() {
    var basicGoalInfo = {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'start_time': this.startTime.toIso8601String(),
      'end_time': this.endTime.toIso8601String(),
      'is_complete': this.isComplete,
    };

    basicGoalInfo.addAll(
        this.goalDays); // combine the basicGoalInfo map and the goalDays map

    return basicGoalInfo;
  }

  @override
  int get hashCode =>
      this.id.hashCode +
      this.title.hashCode +
      this.description.hashCode +
      this.startTime.hashCode +
      this.endTime.hashCode;

  @override
  bool operator ==(Object other) {
    // TODO: implement ==
    return identical(this, other) && runtimeType == other.runtimeType;
  }
}
