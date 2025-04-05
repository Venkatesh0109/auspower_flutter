import 'dart:convert';

// class AuthUser {
//   int employeeId;
//   String companyId;
//   String buId;
//   String plantId;
//   int userLevelId;
//   String employeeCode;
//   String employeeName;
//   String employeeType;
//   String employeeImage;
//   String mobileNo;
//   String email;
//   String designation;
//   String notificationTopic;
//   String isLogin;
//   String passwordLogin;
//   String status;
//   DateTime? lastlogin;
//   String isFirstPassword;
//   String createdOn;
//   int createdBy;
//   DateTime? modifiedOn;
//   int modifiedBy;
//   String syncStatus;
//   String isCampus;
//   String companyName;
//   String companyCode;
//   String buName;
//   String buCode;
//   String plantName;
//   String plantCode;
//   int campusId;
//   String campusName;

//   AuthUser({
//     required this.employeeId,
//     required this.companyId,
//     required this.buId,
//     required this.plantId,
//     required this.userLevelId,
//     required this.employeeCode,
//     required this.employeeName,
//     required this.employeeType,
//     required this.employeeImage,
//     required this.mobileNo,
//     required this.email,
//     required this.designation,
//     required this.notificationTopic,
//     required this.isLogin,
//     required this.passwordLogin,
//     required this.status,
//     this.lastlogin,
//     required this.isFirstPassword,
//     required this.createdOn,
//     required this.createdBy,
//     this.modifiedOn,
//     required this.modifiedBy,
//     required this.syncStatus,
//     required this.isCampus,
//     required this.companyName,
//     required this.companyCode,
//     required this.buName,
//     required this.buCode,
//     required this.plantName,
//     required this.plantCode,
//     required this.campusId,
//     required this.campusName,
//   });

//   /// Factory method to convert JSON String to an AuthUser instance.
//   factory AuthUser.fromRawJson(String str) =>
//       AuthUser.fromJson(json.decode(str));

//   /// Convert AuthUser instance to a JSON String.
//   String toRawJson() => json.encode(toJson());

//   /// Factory method to create an instance from JSON data.
//   factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
//         employeeId: json["employee_id"],
//         companyId: json["company_id"],
//         buId: json["bu_id"],
//         plantId: json["plant_id"],
//         userLevelId: json["user_level_id"],
//         employeeCode: json["employee_code"],
//         employeeName: json["employee_name"],
//         employeeType: json["employee_type"],
//         employeeImage: json["employee_image"],
//         mobileNo: json["mobile_no"],
//         email: json["email"],
//         designation: json["designation"],
//         notificationTopic: json["notification_topic"], // ✅ Fixed key mismatch
//         isLogin: json["is_login"],
//         passwordLogin: json["password_login"],
//         status: json["status"],
//         lastlogin: json["lastlogin"] != null && json["lastlogin"].isNotEmpty
//             ? DateTime.tryParse(json["lastlogin"])
//             : null, // ✅ Safe date parsing
//         isFirstPassword: json["is_first_password"],
//         createdOn: json["created_on"],
//         createdBy: json["created_by"],
//         modifiedOn: json["modified_on"] != null && json["modified_on"].isNotEmpty
//             ? DateTime.tryParse(json["modified_on"])
//             : null, // ✅ Safe date parsing
//         modifiedBy: json["modified_by"],
//         syncStatus: json["sync_status"],
//         isCampus: json["is_campus"],
//         companyName: json["company_name"],
//         companyCode: json["company_code"],
//         buName: json["bu_name"],
//         buCode: json["bu_code"],
//         plantName: json["plant_name"],
//         plantCode: json["plant_code"],
//         campusId: json["campus_id"],
//         campusName: json["campus_name"],
//       );

//   /// Convert AuthUser instance to JSON format.
//   Map<String, dynamic> toJson() => {
//         "employee_id": employeeId,
//         "company_id": companyId,
//         "bu_id": buId,
//         "plant_id": plantId,
//         "user_level_id": userLevelId,
//         "employee_code": employeeCode,
//         "employee_name": employeeName,
//         "employee_type": employeeType,
//         "employee_image": employeeImage,
//         "mobile_no": mobileNo,
//         "email": email,
//         "designation": designation,
//         "notification_topic": notificationTopic, // ✅ Fixed key mismatch
//         "is_login": isLogin,
//         "password_login": passwordLogin,
//         "status": status,
//         "lastlogin": lastlogin?.toIso8601String(), // ✅ Convert to string safely
//         "is_first_password": isFirstPassword,
//         "created_on": createdOn,
//         "created_by": createdBy,
//         "modified_on": modifiedOn?.toIso8601String(), // ✅ Convert to string safely
//         "modified_by": modifiedBy,
//         "sync_status": syncStatus,
//         "is_campus": isCampus,
//         "company_name": companyName,
//         "company_code": companyCode,
//         "bu_name": buName,
//         "bu_code": buCode,
//         "plant_name": plantName,
//         "plant_code": plantCode,
//         "campus_id": campusId,
//         "campus_name": campusName,
//       };
// }

class AuthUser {
  final int? employeeId;
  final String? companyId;
  final String? buId;
  final String? plantId;
  final int? userLevelId;
  final String? employeeCode;
  final String? employeeName;
  final String? employeeType;
  final String? employeeImage;
  final String? mobileNo;
  final String? email;
  final String? designation;
  final String? isLogin;
  final String? passwordLogin;
  final String? status;
  final DateTime? lastlogin;
  final String? isFirstPassword;
  final String? createdOn;
  final int? createdBy;
  final DateTime? modifiedOn;
  final int? modifiedBy;
  final String? syncStatus;
  final String? isCampus;
  final String? companyName;
  final String? companyCode;
  final String? buName;
  final String? buCode;
  final String? plantName;
  final String? plantCode;
  final int? campusId;
  final String? campusName;

  AuthUser({
    this.employeeId,
    this.companyId,
    this.buId,
    this.plantId,
    this.userLevelId,
    this.employeeCode,
    this.employeeName,
    this.employeeType,
    this.employeeImage,
    this.mobileNo,
    this.email,
    this.designation,
    this.isLogin,
    this.passwordLogin,
    this.status,
    this.lastlogin,
    this.isFirstPassword,
    this.createdOn,
    this.createdBy,
    this.modifiedOn,
    this.modifiedBy,
    this.syncStatus,
    this.isCampus,
    this.companyName,
    this.companyCode,
    this.buName,
    this.buCode,
    this.plantName,
    this.plantCode,
    this.campusId,
    this.campusName,
  });

  factory AuthUser.fromRawJson(String str) =>
      AuthUser.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AuthUser.fromJson(Map<String, dynamic> json) => AuthUser(
        employeeId: json["employee_id"],
        companyId: json["company_id"],
        buId: json["bu_id"],
        plantId: json["plant_id"],
        userLevelId: json["user_level_id"],
        employeeCode: json["employee_code"],
        employeeName: json["employee_name"],
        employeeType: json["employee_type"],
        employeeImage: json["employee_image"],
        mobileNo: json["mobile_no"],
        email: json["email"],
        designation: json["designation"],
        isLogin: json["is_login"],
        passwordLogin: json["password_login"],
        status: json["status"],
        lastlogin: json["lastlogin"] == null
            ? null
            : DateTime.parse(json["lastlogin"]),
        isFirstPassword: json["is_first_password"],
        createdOn: json["created_on"],
        createdBy: json["created_by"],
        modifiedOn: json["modified_on"] == null
            ? null
            : DateTime.parse(json["modified_on"]),
        modifiedBy: json["modified_by"],
        syncStatus: json["sync_status"],
        isCampus: json["is_campus"],
        companyName: json["company_name"],
        companyCode: json["company_code"],
        buName: json["bu_name"],
        buCode: json["bu_code"],
        plantName: json["plant_name"],
        plantCode: json["plant_code"],
        campusId: json["campus_id"],
        campusName: json["campus_name"],
      );

  Map<String, dynamic> toJson() => {
        "employee_id": employeeId,
        "company_id": companyId,
        "bu_id": buId,
        "plant_id": plantId,
        "user_level_id": userLevelId,
        "employee_code": employeeCode,
        "employee_name": employeeName,
        "employee_type": employeeType,
        "employee_image": employeeImage,
        "mobile_no": mobileNo,
        "email": email,
        "designation": designation,
        "is_login": isLogin,
        "password_login": passwordLogin,
        "status": status,
        "lastlogin": lastlogin?.toIso8601String(),
        "is_first_password": isFirstPassword,
        "created_on": createdOn,
        "created_by": createdBy,
        "modified_on": modifiedOn?.toIso8601String(),
        "modified_by": modifiedBy,
        "sync_status": syncStatus,
        "is_campus": isCampus,
        "company_name": companyName,
        "company_code": companyCode,
        "bu_name": buName,
        "bu_code": buCode,
        "plant_name": plantName,
        "plant_code": plantCode,
        "campus_id": campusId,
        "campus_name": campusName,
      };
}
