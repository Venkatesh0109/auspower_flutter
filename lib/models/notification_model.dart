import 'package:uuid/uuid.dart';

class NotificationModel {
  NotificationModel(this.title, this.description, this.dateTime)
      : id = const Uuid().v1();

  String? title;
  String? description;
  String? id;
  String? dateTime;

  // Constructor to create an object from a map (used when fetching from DB)
  NotificationModel.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    description = map['description']; // Changed 'body' to 'description'
    id = map['unique_id'].toString();
    dateTime = map['datetime'].toString();
  }

  // Convert object to map (used when inserting into DB)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description, // Changed 'body' to 'description'
      'unique_id': id,
      'datetime': dateTime,
    };
  }
}
