// class that represents a user's goal
class Goal { // TODO add the date of goal
  final int id;
  final String title;
  final String description;
  final bool isComplete;

  Goal({this.id, this.title, this.description, this.isComplete});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'description': this.description,
      // boolean doesn't exist in sqlite; represented as integers
      // 0 --> false, 1 --> true
      'is_complete': this.isComplete,
    };
  }
}
