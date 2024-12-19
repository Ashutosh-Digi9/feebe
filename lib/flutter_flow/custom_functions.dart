import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import 'uploaded_file.dart';
import '/backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '/backend/schema/structs/index.dart';
import '/auth/firebase_auth/auth_util.dart';

int serialnumber(int count) {
  return count + 1;
}

List<SchoolRecord>? filterprinciserachresults(
  List<String> searchResults,
  List<SchoolRecord> schoolDocs,
) {
  return schoolDocs.where((schoolDoc) {
    final schoolName = schoolDoc.principalDetails.principalName.toLowerCase();
    return searchResults.any((term) => schoolName.contains(term.toLowerCase()));
  }).toList();
}

List<SchoolRecord>? filterSchoolsBySearchResults(
  List<String> searchResults,
  List<SchoolRecord> schoolDocs,
) {
  return schoolDocs.where((schoolDoc) {
    final schoolName = schoolDoc.schoolDetails.schoolName.toLowerCase();
    return searchResults.any((term) => schoolName.contains(term.toLowerCase()));
  }).toList();
}

double calculateAttendancePercentageCopy(
  List<ClassAttendanceStruct> attendanceRecords,
  DocumentReference studentRef,
) {
  if (attendanceRecords.isEmpty) {
    return 0; // No records, return 0% attendance
  }

  int totalRecords = attendanceRecords.length;
  int presentCount = 0;

  for (var record in attendanceRecords) {
    if (record.studentPresentList != null &&
        record.studentPresentList.contains(studentRef)) {
      presentCount++;
    }
  }

  // Calculate percentage
  double percentage = (presentCount / totalRecords);
  return percentage;
}

List<String> convertintoListString(String singleValue) {
  // convert single value to list
  return [singleValue];
}

bool isEmailInUsersCollection(
  String email,
  List<UsersRecord>? users,
) {
  final normalizedEmail = email.toLowerCase();

  // Check if any user's email matches the provided email
  return users!.any((user) => user.email.toLowerCase() == normalizedEmail);
}

List<SchoolDetailsStruct>? removeSchoolAtIndex(
  List<SchoolDetailsStruct> schoolDocs,
  int index,
) {
  if (index < 0 || index >= schoolDocs.length) {
    print('Invalid index');
    return schoolDocs; // Return the original list if the index is invalid
  }

  // Create a new list with the item at the specified index removed
  List<SchoolDetailsStruct> updatedSchoolDocs = List.from(schoolDocs);
  updatedSchoolDocs.removeAt(index);

  return updatedSchoolDocs;
}

DateTime? prevDate(DateTime? currentdate) {
  // WAP to get next date of current date
  if (currentdate == null) {
    return null;
  }

  final nextDay = currentdate.add(Duration(days: -1));
  return nextDay;
}

bool isSchoolNameInDocuments(
  String nameToCheck,
  List<SchoolRecord> schoolDocs,
) {
  // Normalize and remove extra spaces from the nameToCheck
  final normalizedName =
      nameToCheck.toLowerCase().trim().replaceAll(RegExp(r'\s+'), ' ');

  // Check if any school document's school name matches the given name
  return schoolDocs.any((doc) {
    final schoolName = doc.schoolDetails.schoolName
        .toLowerCase()
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ');
    return schoolName == normalizedName;
  });
}

List<SchoolDetailsStruct> updateBranchDetailsAtIndex(
  int index,
  List<SchoolDetailsStruct> branchDetailsList,
  String schoolname,
  String address,
  int noofstudents,
  int nooffaculty,
  String? image,
) {
  if (index < 0 || index >= branchDetailsList.length) {
    print('Invalid index');
    return branchDetailsList; // Return the original list if the index is invalid
  }

  // Update only the fields with non-null values
  final branch = branchDetailsList[index];
  branch.schoolName = schoolname;
  branch.address = address;
  branch.noOfStudents = noofstudents;
  branch.noOfFaculties = nooffaculty;
  branch.schoolImage = image ?? branch.schoolImage;

  return branchDetailsList;
}

DateTime? nextDate(DateTime? currentdate) {
  // WAP to get next date of current date
  if (currentdate == null) {
    return null;
  }

  final nextDay = currentdate.add(Duration(days: 1));
  return nextDay;
}

int? generateUniqueId() {
  // WAP to generate unique Id
  // Generate a random number
  int random = math.Random().nextInt(10000);

  // Get the current timestamp
  int timestamp = DateTime.now().millisecondsSinceEpoch;

  // Combine the random number and timestamp to create a unique ID
  int uniqueId = random + timestamp;

  return uniqueId;
}

int findTotalAbsent(
  int totalNOPresent,
  int tOtalNoofstudents,
) {
  return tOtalNoofstudents - totalNOPresent;
}

DateTime getAdjacentMonthDate(
  bool next,
  DateTime currentDate,
) {
  return next
      ? DateTime(currentDate.year + (currentDate.month == 12 ? 1 : 0),
          currentDate.month == 12 ? 1 : currentDate.month + 1, currentDate.day)
      : DateTime(currentDate.year - (currentDate.month == 1 ? 1 : 0),
          currentDate.month == 1 ? 12 : currentDate.month - 1, currentDate.day);
}

String calculateAgeInYears(DateTime dateofbirth) {
  // Get the current date
  DateTime today = DateTime.now();

  // Calculate the difference in years
  int age = today.year - dateofbirth.year;

  // Adjust for cases where the birthday hasn't occurred this year
  if (today.month < dateofbirth.month ||
      (today.month == dateofbirth.month && today.day < dateofbirth.day)) {
    age--;
  }

  // Return age with the "years" label
  return "$age years";
}

DateTime? return30day(DateTime? currentdate) {
  // WAP to return date after 30 day
  if (currentdate != null) {
    return currentdate.add(Duration(days: 30));
  }
  return null;
}

DateTime getAdjacentDate(
  bool next,
  DateTime currentDate,
) {
  return next
      ? currentDate.add(Duration(days: 1)) // Add one day for next
      : currentDate
          .subtract(Duration(days: 1)); // Subtract one day for previous
}

List<String> combineImagePaths(
  List<String> list1,
  List<String> list2,
) {
  return [...list1, ...list2];
}

List<int> convertintoList(int singleValue) {
  // convert single value to list
  return [singleValue];
}

DateTime formatDate(DateTime dateValue) {
  // return date into one format
  final DateFormat formatter = DateFormat('yyyy-MM-dd 00:00:00');
  final String formatted = formatter.format(dateValue);
  return formatter.parse(formatted);
}

List<EventsNoticeStruct> updateEvent(
  List<EventsNoticeStruct> notices,
  int eventId,
  String name,
  String description,
  List<String>? images,
  DateTime date,
  String eventname,
) {
  for (var i = 0; i < notices.length; i++) {
    if (notices[i].eventId == eventId) {
      // Update the event details
      notices[i].eventTitle = name;
      notices[i].eventDescription = description;
      notices[i].eventDate = date;
      notices[i].eventName = eventname;
      if (images != null) {
        notices[i].eventImages = images; // Update the images if provided
      }
      break; // Exit the loop once the event is updated
    }
  }
  return notices;
}

String calculateAge(DateTime dob) {
  final DateTime today = DateTime.now();

  // Calculate years
  int years = today.year - dob.year;

  // Adjust years if the current date is before the birthday this year
  if (today.month < dob.month ||
      (today.month == dob.month && today.day < dob.day)) {
    years--;
  }

  // Calculate months
  int months = today.month - dob.month;
  if (months < 0) {
    months += 12;
  } else if (today.day < dob.day) {
    months--;
  }

  return "$years years and $months months";
}

String convertImagePathToString(String imagePath) {
  return imagePath;
}

bool isWithin300kMeters(
  LatLng point1,
  LatLng point2,
) {
  const earthRadiusMeters = 6371000; // Radius of Earth in meters

  // Convert degrees to radians
  double toRadians(double degree) => degree * math.pi / 180;

  // Extract latitude and longitude from points
  final lat1 = toRadians(point1.latitude);
  final lon1 = toRadians(point1.longitude);
  final lat2 = toRadians(point2.latitude);
  final lon2 = toRadians(point2.longitude);

  // Haversine formula
  final dLat = lat2 - lat1;
  final dLon = lon2 - lon1;
  final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
      math.cos(lat1) * math.cos(lat2) * math.sin(dLon / 2) * math.sin(dLon / 2);
  final c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
  final distance = earthRadiusMeters * c;

  // Check if the distance is within 2 kilometers
  return distance <= 2000;
}

List<TeachersAttendanceStruct> updateCheckoutTime(
  List<TeachersAttendanceStruct> attendanceList,
  DateTime checkOutTime,
) {
  String formattedTodayDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  for (var attendance in attendanceList) {
    // Format the attendance date
    String formattedAttendanceDate =
        DateFormat('yyyy-MM-dd').format(attendance.date!);

    // Check if the attendance date matches today's date
    if (formattedAttendanceDate == formattedTodayDate) {
      // Assign the checkout time
      attendance.checkOutTime = checkOutTime;
    }
  }

  return attendanceList;
}

DateTime getDateThreeYearsBack(DateTime today) {
  return DateTime(today.year - 3, today.month, today.day);
}

bool isDatePassed(DateTime dateToCheck) {
  DateTime today = DateTime.now();
  // Compare only the date part by stripping the time
  DateTime currentDate = DateTime(today.year, today.month, today.day);

  return dateToCheck.isBefore(currentDate);
}

List<TeachersAttendanceStruct> filterAttendanceByMonthAndYear(
  DateTime dateToCheck,
  List<TeachersAttendanceStruct> attendanceList,
) {
  return attendanceList.where((attendance) {
    if (attendance.date == null) return false; // Skip if date is null
    return attendance.date!.year == dateToCheck.year &&
        attendance.date!.month == dateToCheck.month;
  }).toList();
}

double calculatePercentage(
  int loopmin,
  int total,
) {
  return (loopmin / total).toDouble(); // Calculate the percentage
  // Format to 2 decimal places
}

List<ParentsDetailsStruct> updateParentDetails(
  DocumentReference userRef,
  String name,
  String phoneNumber,
  String email,
  String profileImage,
  List<ParentsDetailsStruct> parentsList,
) {
  for (var parent in parentsList) {
    if (parent.userRef == userRef) {
      // Update fields only if they are provided (non-null)
      if (name != null) {
        parent.parentsName = name;
      }
      if (phoneNumber != null) {
        parent.parentsPhone = phoneNumber;
      }
      if (email != null) {
        parent.parentsEmail = email;
      }
      if (profileImage != null) {
        parent.parentImage = profileImage;
      }
    }
  }
  return parentsList;
}

List<StudentListStruct> updateIsPresentStatus(
  List<StudentListStruct> studentlist,
  List<StudentListStruct> appstatestudent,
  DocumentReference classref,
) {
  // Create a set of references (student IDs) from the second list for quick lookup

  // Create a set of references (student IDs) from the second list for quick lookup
  final studentRefsInList2 =
      appstatestudent.map((student) => student.studentId).toSet();

  // Update `isPresent` and add `classref` to the `classref` list if the reference exists
  return studentlist.map((student) {
    if (studentRefsInList2.contains(student.studentId)) {
      // Ensure the `classref` list is updated properly
      final updatedClassRefList =
          List<DocumentReference>.from(student.classref ?? []);
      if (!updatedClassRefList.contains(classref)) {
        updatedClassRefList.add(classref);
      }

      return StudentListStruct(
        studentId: student.studentId,
        studentName: student.studentName,
        studentImage: student.studentImage,
        parentList: student.parentList,
        isAddedinClass: true,
        classref: updatedClassRefList,
        // Add other fields from StudentListStruct here if necessary
      );
    }
    return student;
  }).toList();
}

int multiplyByhundred(double percentageNumber) {
  // write a function to multiyply by 10
  return (percentageNumber * 100).toInt();
}

int calculateAttendancePercentage(
  List<ClassAttendanceStruct> attendanceRecords,
  DocumentReference studentRef,
) {
  if (attendanceRecords.isEmpty) {
    return 0; // No records, return 0% attendance
  }

  int totalRecords = attendanceRecords.length;
  int presentCount = 0;

  for (var record in attendanceRecords) {
    if (record.studentPresentList != null &&
        record.studentPresentList.contains(studentRef)) {
      presentCount++;
    }
  }

  // Calculate percentage
  double percentage = (presentCount / totalRecords) * 100;
  return percentage.round();
}

List<StudentListStruct> updateStudentsInClass(
    List<StudentListStruct> studentlist) {
  // Create a new list to store updated students
  List<StudentListStruct> updatedStudents = [];

  // Iterate through each student in the list
  // Iterate through each student in the list
  for (var student in studentlist) {
    // Check if the student is not in the class (isAddedinClass is false)
    if (student.isAddedinClass == false) {
      // Update the student's isAddedinClass to true
      student.isAddedinClass = true;
    }
  }

  // Return the updated student list
  return studentlist;
}

List<DocumentReference> getParentRefsFromStudents(
  List<StudentsRecord> studentDocuments,
  List<DocumentReference> studentDocumentRefs,
) {
  Set<DocumentReference> userRefs = {};

  // Loop through each student document
  for (var studentDocument in studentDocuments) {
    // Check if the student document reference is in the provided reference list
    if (studentDocumentRefs.contains(studentDocument.reference)) {
      // Check if parentsList is not null and is a list of DocumentReferences
      if (studentDocument.parentsList != null &&
          studentDocument.parentsList is List<DocumentReference>) {
        // Add all parent references to the set (avoiding duplicates)
        userRefs.addAll(studentDocument.parentsList!);
      }
    }
  }

  // Convert the set to a list and return
  return userRefs.toList();
}

List<DocumentReference> filterClassesByReferences(
    List<SchoolClassRecord> classDocs) {
  // Use a set to store unique user references
  final Set<DocumentReference> userRefs = {};

  // Collect all user references from class documents
  for (var classDoc in classDocs) {
    if (classDoc.listOfteachersUser != null) {
      userRefs.addAll(classDoc.listOfteachersUser!);
    }
  }

  return userRefs.toList();
}

List<EventsNoticeStruct> deleteEvent(
  int eventId,
  List<EventsNoticeStruct> notices,
) {
  notices.removeWhere((event) => event.eventId == eventId);

  return notices;
}

List<DocumentReference> extractParentUserRefs(
    List<StudentsRecord> studentDocs) {
  final Set<DocumentReference> parentRefs = {};

  // Collect parent references from each student document
  for (var studentDoc in studentDocs) {
    if (studentDoc.parentsList != null) {
      parentRefs.addAll(studentDoc.parentsList!);
    }
  }

  return parentRefs.toList();
}

String getCommaSeparatedClassNames(List<String> classNames) {
  return classNames.join(', ');
}

List<StudentListStruct> updateStudentData(
  List<StudentListStruct> studentList,
  DocumentReference studentRef,
  String newName,
  String newImagePath,
) {
  for (var student in studentList) {
    if (student.studentId == studentRef) {
      // Update the student data
      student.studentName = newName;
      student.studentImage = newImagePath;
    }
  }

  return studentList;
}

bool checknumberofbranches(
  int branchnumber,
  int noofBranches,
) {
  if (branchnumber + 1 < noofBranches) {
    return true;
  } else
    return false;
}

NotificationStruct updateNotificationDatatype(
    NotificationStruct newNotification) {
  // WAP to update isRead to true in data type
  newNotification.isRead = true;
  return newNotification;
}

List<NotificationsRecord> filterOldNotifications(
    List<NotificationsRecord> notifications) {
  final now = DateTime.now();

  // Return a new list with notifications that are less than 1 month old
  return notifications.where((notification) {
    final createdDate = notification.createDate; // Accessing the class property
    if (createdDate != null) {
      final int monthDifference =
          (now.year - createdDate.year) * 12 + (now.month - createdDate.month);
      final int dayDifference = now.day - createdDate.day;

      // Keep notifications created within the last month
      if (monthDifference > 1) {
        return false;
      } else if (monthDifference == 1 && dayDifference >= 0) {
        return false;
      }
      return true;
    }
    return false; // Exclude if 'createdDate' is null or invalid
  }).toList();
}

List<StudentListStruct> removeStudentByRef(
  List<StudentListStruct> studentList,
  DocumentReference studentRef,
) {
  return studentList
      .where((student) => student.studentId != studentRef)
      .toList();
}

List<TeacherListStruct> removeTeacherByRef(
  List<TeacherListStruct> teacherList,
  DocumentReference teacherRef,
) {
  return teacherList
      .where((teacher) => teacher.teachersId != teacherRef)
      .toList();
}
