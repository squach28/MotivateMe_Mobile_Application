// class that represents a user's goal
class Goal {
  final int id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime startTime;
  final DateTime endTime;
  final Map<String, bool>
      goalDays; // map of the goal day and whether it is active on that day
  final bool isComplete;

  Goal({this.id, this.title, this.description, this.startDate, this.endDate, this.startTime, this.endTime, this.goalDays, this.isComplete});

  Map<String, dynamic> toMap() {
    var basicGoalInfo = {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'start_date': this.startDate.toIso8601String(),
      'end_date': this.endDate.toIso8601String(),
      'start_time': this.startTime.toIso8601String(),
      'end_time': this.endTime.toIso8601String(),
      'is_complete': this.isComplete,
    };

    basicGoalInfo.addAll(
        this.goalDays); // combine the basicGoalInfo map and the goalDays map

    return basicGoalInfo;
  }

  Map<String, dynamic> formatForDatabase() {
    var basicGoalInfo = {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      'start_date': this.startDate.toIso8601String(),
      'end_date': this.endDate.toIso8601String(),
      'start_time': this.startTime.toIso8601String(),
      'end_time': this.endTime.toIso8601String(),
      'is_complete': this.isComplete ? 1 : 0,
    };

    var formattedGoalDays = {
      'monday': this.goalDays['Monday'] ? 1 : 0,
      'tuesday': this.goalDays['Tuesday'] ? 1 : 0,
      'wednesday': this.goalDays['Wednesday'] ? 1 : 0,
      'thursday': this.goalDays['Thursday'] ? 1 : 0,
      'friday': this.goalDays['Friday'] ? 1 : 0,
      'saturday': this.goalDays['Saturday'] ? 1 : 0,
      'sunday': this.goalDays['Sunday'] ? 1 : 0
    };

    basicGoalInfo.addAll(formattedGoalDays);
    return basicGoalInfo;


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
