class SubGoal {
  final int gid;
  final int id;
  final DateTime date;
  final bool completed;
  final String comment;
  final String pathToPicture;

  SubGoal({this.gid, this.id, this.date, this.completed, this.comment, this.pathToPicture});

  Map<String, dynamic> toMap() {
    return {
      'gid': this.gid,
      'id': this.id,
      'date': this.date.toIso8601String(),
      'completed': this.completed,
      'comment': this.comment,
      'pathToPicture': this.pathToPicture
    };
  }

  Map<String, dynamic> formattedMapForDatabase() {
    return {
      'gid': this.gid,
      'id': this.id,
      'date': this.date.toIso8601String(),
      'completed': this.completed ? 1 : 0,
      'comment': this.comment,
      'path_to_picture': this.pathToPicture
    };
  }

}