import 'package:auspower_flutter/models/notification_model.dart';
import 'package:auspower_flutter/providers/providers.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDbRepository {
  static const String _databaseName = "notification.db";
  static const String _tableName = "Notification";

  // Initialize Database
  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, _databaseName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          '''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            unique_id TEXT NOT NULL,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            datetime TEXT NOT NULL
          )
          ''',
        );
      },
    );
  }

  // Insert Notification
  Future<void> createItem(NotificationModel notification) async {
    final db = await _initDatabase();
    try {
      await db.insert(
        _tableName,
        notification.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint("Error inserting notification: $e");
    }
  }

  // Get All Notifications
  Future<void> getNotificationList() async {
    final db = await _initDatabase();
    try {
      final List<Map<String, dynamic>> queryResult = await db.query(_tableName);
      sqlProvider.notificationList = queryResult.map((data) {
        return NotificationModel.fromMap(data);
      }).toList();
    } catch (e) {
      debugPrint("Error fetching notifications: $e");
    }
  }

  // Delete Notification by unique_id
  Future<void> deleteItem(String uniqueId) async {
    final db = await _initDatabase();
    try {
      await db.delete(
        _tableName,
        where: "unique_id = ?",
        whereArgs: [uniqueId],
      );
    } catch (e) {
      debugPrint("Error deleting notification: $e");
    }
  }

  // Delete All Notifications
  Future<void> deleteAll() async {
    final db = await _initDatabase();
    try {
      await db.delete(_tableName);
    } catch (e) {
      debugPrint("Error deleting all notifications: $e");
    }
  }

  // Close Database (optional)
  Future<void> closeDatabase() async {
    final db = await _initDatabase();
    await db.close();
  }
}
