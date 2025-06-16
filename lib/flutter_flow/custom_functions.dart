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

List<String> combineImagePathsCopy(
  List<String> list1,
  List<String> list2,
) {
  return [...list1, ...list2];
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

List<String> startfromimageList(List<String> inputList) {
  List<String> modifiedList = [];

  // Add a dummy value (or any placeholder) at index 0 to maintain the +1 offset
  modifiedList.add(''); // Add an empty string or any placeholder value

  // Add the actual list elements starting from index 1
  modifiedList.addAll(inputList);

  return modifiedList;
}

List<String> converttoimagepathCopy(String image) {
  return [image];
}

int calculateAttendancePercentageCopy(
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

  // Calculate percentage and round it
  int percentage = ((presentCount / totalRecords) * 100).round();
  return percentage;
}

bool isValidFileFormatCopy(List<String> filePaths) {
  final List<String> allowedExtensions = [
    'pdf', 'doc', 'docx', // Document formats
    'jpg', 'jpeg', 'png', 'mp3', 'ppt', 'pptx', // Image formats
  ];

  for (var filePath in filePaths) {
    // Remove query parameters (everything after '?')
    String cleanPath = filePath.split('?').first;

    // Extract the file extension
    String fileExtension = cleanPath.split('.').last.toLowerCase();

    // Check if the extracted extension is in the allowed list
    if (!allowedExtensions.contains(fileExtension)) {
      return false; // If one file is invalid, return false
    }
  }

  return true; // All files are valid if no inva
}

List<String> convertintoListString(String singleValue) {
  // convert single value to list
  return [singleValue];
}

String combineStringsCopy(List<String> strings) {
  // Filter classDocuments where classRef is in classRefs

  // Join matching class names with commas
  return strings.join(', ');
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

List<StudentListStruct> updateStudentDataCopy(
  List<StudentListStruct> studentList,
  DocumentReference studentRef,
  String newName,
  String newImagePath,
  List<DocumentReference> parentlist,
  bool isAddedtoclass,
  List<DocumentReference>? classref,
  bool isDraft,
) {
  for (var student in studentList) {
    if (student.studentId == studentRef) {
      // Update the student data
      student.studentName = newName;
      student.studentImage = newImagePath;
      student.classref = classref;
      student.isAddedinClass = isAddedtoclass;
      student.parentList = parentlist;
      student.studentId = studentRef;
      student.isDraft = isDraft;
    }
  }

  return studentList;
}

String convertvideoPathToString(String videoPath) {
  return videoPath;
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

String converttovideo(String video) {
  return video;
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

String extractFileNameFromFirebaseLinkCopy(String firebaseLink) {
  if (firebaseLink.isEmpty) {
    return ''; // Return empty string if the link is empty.
  }

  try {
    // Split the URL by '/' to isolate the file path components.
    final parts = firebaseLink.split('/');

    // The file name is usually the last part of the URL before query parameters.
    final lastPart = parts.last;

    // Remove query parameters if any (e.g., '?alt=media').
    final fileName = lastPart.split('?').first;

    return fileName;
  } catch (e) {
    // Handle unexpected formats by returning an empty string or logging the error.
    return '';
  }
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
  // Determine new month and year
  int newMonth = next ? currentDate.month + 1 : currentDate.month - 1;
  int newYear = currentDate.year;

  if (newMonth > 12) {
    newMonth = 1;
    newYear += 1;
  } else if (newMonth < 1) {
    newMonth = 12;
    newYear -= 1;
  }

  // Get the last day of the new month to prevent overflow (e.g., Feb 31 issue)
  int lastDayOfNewMonth = DateTime(newYear, newMonth + 1, 0).day;

  // Ensure the day is within the valid range of the new month
  int newDay = math.min(currentDate.day, lastDayOfNewMonth);

  return DateTime(newYear, newMonth, newDay);
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
    return currentdate.add(Duration(days: 365));
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
  List<String>? files,
  DateTime date,
  String eventname,
  List<DocumentReference> classref,
) {
  for (var i = 0; i < notices.length; i++) {
    if (notices[i].eventId == eventId) {
      // Update the event details
      notices[i].eventTitle = name;
      notices[i].eventDescription = description;
      notices[i].eventDate = date;
      notices[i].eventName = eventname;
      notices[i].classref = classref;
      if (files != null) {
        notices[i].eventfiles = files; // Update the images if provided
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

  // Return only years if age is in years, or only months if age is in months
  if (years > 0) {
    return "$years years";
  } else if (months > 0) {
    return "$months months";
  } else {
    return "Less than a month"; // In case the date is very close to the birthday
  }
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
  return distance <= 50;
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

DateTime getAdjacentMonthDateCopy(
  bool next,
  DateTime currentDate,
) {
  int newYear = currentDate.year;
  int newMonth = next ? currentDate.month + 1 : currentDate.month - 1;

  if (newMonth > 12) {
    newYear++;
    newMonth = 1;
  } else if (newMonth < 1) {
    newYear--;
    newMonth = 12;
  }

  // Ensure the day is valid for the new month
  int newDay =
      math.min(currentDate.day, DateTime(newYear, newMonth + 1, 0).day);

  return DateTime(newYear, newMonth, newDay);
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

double calculateAttendancePercentage(
  List<ClassAttendanceStruct> attendanceRecords,
  DocumentReference studentRef,
) {
  if (attendanceRecords.isEmpty) {
    return 0.0; // No attendance records available
  }

  int totalClasses = attendanceRecords.length;
  int attendedClasses = attendanceRecords
      .where((record) => (record.studentPresentList ?? []).contains(studentRef))
      .length;

  return (attendedClasses / totalClasses)
      .clamp(0.0, 1.0); // Return as a fraction (0.0 to 1.0)
}

DateTime? noticedate(DateTime? currentdate) {
  // WAP to get next date of current date
  if (currentdate == null) {
    return null;
  }

  // Get the previous date
  final prevDate = currentdate.subtract(Duration(days: 1));

  // Set the time to 10:00 AM
  final prevDateWithTime =
      DateTime(prevDate.year, prevDate.month, prevDate.day, 11, 30, 0);
  return prevDateWithTime;
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

List<EventsNoticeStruct> filterEventsAfterTwoDays(
  List<EventsNoticeStruct> events,
  DateTime currentDate,
) {
  return events
      .where((event) =>
          event.eventDate!.isAfter(currentDate.add(Duration(days: 2))))
      .toList();
}

List<SearchitemsStruct> removeItemsByType(
  List<SearchitemsStruct> items,
  String searchTerm,
) {
// Find the type of the item with the given searchTerm
  return items.where((item) => item.searchterm != searchTerm).toList();
}

List<String> getClassNames(
  List<SchoolClassRecord> classCollections,
  List<DocumentReference> classRefs,
) {
  // Start with the "All" class name
  List<String> classNames = ["All"];

  // Iterate over the class collections
  for (var classCollection in classCollections) {
    // Check if the class reference exists in the provided class references
    if (classRefs.contains(classCollection.reference)) {
      classNames.add(classCollection.className);
    }
  }

  return classNames;
}

List<TeacherListStruct> sortTeachersByCheckInDate(
  List<TeacherListStruct> teachersList,
  List<UsersRecord> userDocs,
  DateTime dateToCheck,
) {
  final userDocsMap = {for (var user in userDocs) user.reference: user};

  teachersList.sort((a, b) {
    final userA = userDocsMap[a.userRef];
    final userB = userDocsMap[b.userRef];

    // Handle cases where user documents are not found.
    if (userA == null || userB == null) {
      return 0;
    }

    final checkInDateA = userA.checkin;
    final checkInDateB = userB.checkin;

    // Check if the check-in date matches the specified date.
    final isCheckInDateAOnTargetDate = checkInDateA != null &&
        DateFormat('yyyy-MM-dd').format(checkInDateA) ==
            DateFormat('yyyy-MM-dd').format(dateToCheck);
    final isCheckInDateBOnTargetDate = checkInDateB != null &&
        DateFormat('yyyy-MM-dd').format(checkInDateB) ==
            DateFormat('yyyy-MM-dd').format(dateToCheck);

    if (isCheckInDateAOnTargetDate && !isCheckInDateBOnTargetDate) {
      return -1; // Place `a` before `b` if `a` has the check-in date.
    }
    if (!isCheckInDateAOnTargetDate && isCheckInDateBOnTargetDate) {
      return 1; // Place `b` before `a` if `b` has the check-in date.
    }

    // Handle cases where both or neither match the target date.
    if (checkInDateA == null && checkInDateB == null) {
      // If both check-in dates are null, sort alphabetically by user name.
      return userA.displayName.compareTo(userB.displayName);
    }

    if (checkInDateA == null) {
      return 1; // Place `a` after `b` if `a` has no check-in date.
    }

    if (checkInDateB == null) {
      return -1; // Place `b` after `a` if `b` has no check-in date.
    }

    // Compare check-in dates when both are available.
    return checkInDateA.compareTo(checkInDateB);
  });

  return teachersList;
}

String extractFileNameFromFirebaseLink(String firebaseLink) {
  if (firebaseLink.isEmpty) {
    return ''; // Return empty string if the link is empty.
  }

  try {
    // Split the URL by '/' to isolate the file path components.
    final parts = firebaseLink.split('/');

    // The file name is usually the last part of the URL before query parameters.
    final lastPart = parts.last;

    // Remove query parameters if any (e.g., '?alt=media').
    final fileName = lastPart.split('?').first;

    return fileName;
  } catch (e) {
    // Handle unexpected formats by returning an empty string or logging the error.
    return '';
  }
}

List<ClassAttendanceStruct> updateattendance(
  List<ClassAttendanceStruct> oldattendance,
  DateTime datenew,
  List<DocumentReference> newstudnetlist,
  int totalnopresnt,
  int totalnoabsent,
  List<StudentAttendanceStruct> studentattendance,
  int totalstudents,
  bool checkin,
) {
  final dateFormat = DateFormat('dd-MM-yyyy');
  String newfDate = dateFormat.format(datenew);

  for (int i = 0; i < oldattendance.length; i++) {
    if (oldattendance[i].date != null) {
      String listDate = dateFormat.format(oldattendance[i].date!);

      // ✅ Update only if date matches & checkIn matches
      if (newfDate == listDate && oldattendance[i].checkIn == checkin) {
        oldattendance[i] = ClassAttendanceStruct(
          id: oldattendance[i].id,
          date: oldattendance[i].date,
          studentPresentList: newstudnetlist,
          totalPresent: totalnopresnt,
          totalAbsent: totalnoabsent,
          totalStudents: totalstudents,
          studenttimelines: studentattendance,
          checkIn: checkin,
        );
        break; // Stop after updating the first match
      }
    }
  }
  return oldattendance;
}

List<StudentAttendanceStruct> removeanstudent(
  DocumentReference studentref,
  List<StudentAttendanceStruct> studentlist,
) {
  return studentlist
      .where((student) => student.studentref != studentref)
      .toList();
}

bool isVideoFile(String fileUrl) {
  List<String> videoExtensions = ['.mp4', '.mov', '.avi', '.mkv', '.flv'];

  // Extract the path before any query parameters
  String cleanUrl = fileUrl.split('?').first;

  // Check if the cleaned URL ends with any of the video file extensions
  return videoExtensions.any((ext) => cleanUrl.toLowerCase().endsWith(ext));
}

List<StudentListStruct> startfromfirststudents(
    List<StudentListStruct> inputList) {
  List<StudentListStruct> modifiedList = [];

  // Add a dummy value (or any initial value) at index 0 to maintain the +1 offset
  modifiedList.add(StudentListStruct()); // Add dummy element or any placeholder

  // Add the actual list elements starting from index 1
  modifiedList.addAll(inputList);

  return modifiedList;
}

String converttoimagepath(String image) {
  return image;
}

List<String> removeaname(
  List<String> strings,
  String removename,
) {
  return strings.where((name) => name != removename).toList();
}

String getFormattedDate(
  DateTime inputDate,
  DateTime currentDate,
) {
  // Check if the input date is today
  if (inputDate.year == currentDate.year &&
      inputDate.month == currentDate.month &&
      inputDate.day == currentDate.day) {
    return "Today";
  }

  // Check if the input date is yesterday
  final yesterday = currentDate.subtract(const Duration(days: 1));
  if (inputDate.year == yesterday.year &&
      inputDate.month == yesterday.month &&
      inputDate.day == yesterday.day) {
    return "Yesterday";
  }

  // Otherwise, format the date as 'dd MMM, y'
  return DateFormat('dd MMM y').format(inputDate);
}

String convertToStringclass(List<String> towhom) {
  if (towhom == null || towhom.isEmpty) {
    return '';
  }
  // Join the list items with a comma and return the result
  return towhom.join(', ');
}

bool isValidFileFormat(String filePath) {
  final List<String> allowedExtensions = [
    'pdf', 'doc', 'docx', // Document formats
    'jpg', 'jpeg', 'png', // Image formats
  ];

  // Remove query parameters (everything after '?')
  String cleanPath = filePath.split('?').first;

  // Extract the file extension
  String fileExtension = cleanPath.split('.').last.toLowerCase();

  // Check if the extracted extension is in the allowed list
  return allowedExtensions.contains(fileExtension);
}

List<DocumentReference> updateStudentClassRef(
  StudentsRecord studentDoc,
  List<DocumentReference> studentRefs,
  DocumentReference classRef,
) {
  List<DocumentReference> classRefs = List.from(studentDoc.classref ?? []);

  if (studentRefs.contains(studentDoc.reference)) {
    if (!classRefs.contains(classRef)) {
      classRefs.add(classRef);
    }
  } else {
    if (classRefs.contains(classRef)) {
      classRefs.remove(classRef);
    }
  }

  return classRefs;
}

bool isCheckInOneDayPrior(
  DateTime checkInDate,
  DateTime passedDate,
) {
  DateTime yesterday = DateTime.now().subtract(Duration(days: 1));

  /// Extract only the date part (ignoring time) for accurate comparison
  DateTime checkDateOnly =
      DateTime(checkInDate.year, checkInDate.month, checkInDate.day);
  DateTime yesterdayOnly =
      DateTime(yesterday.year, yesterday.month, yesterday.day);

  /// Return true if check-in date is exactly yesterday
  return checkDateOnly == yesterdayOnly;
}

List<TeachersAttendanceStruct> fillMissingAttendance(
  List<TeachersAttendanceStruct> attendanceList,
  DateTime checkInDate,
  DateTime passingdate,
  DateTime checkOutTime,
) {
  String formatDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  // Convert attendance list to a map for quick lookup
  Map<String, TeachersAttendanceStruct> attendanceMap = {
    for (var record in attendanceList) formatDate(record.date!): record
  };

  List<TeachersAttendanceStruct> updatedAttendanceList =
      List.from(attendanceList);

  // Ensure last check-in date is recorded with provided check-in and check-out time
  String checkInFormatted = formatDate(checkInDate);
  if (!attendanceMap.containsKey(checkInFormatted)) {
    int uniqueId =
        math.Random().nextInt(10000) + DateTime.now().millisecondsSinceEpoch;

    updatedAttendanceList.add(TeachersAttendanceStruct(
      date: checkInDate,
      ispresent: true,
      id: uniqueId,
      checkInTime: checkInDate,
      checkOutTime: checkOutTime,
    ));
  }

  // Fill all missing dates between checkInDate and the day before passingDate as absent
  for (DateTime date = checkInDate.add(Duration(days: 1));
      date.isBefore(passingdate);
      date = date.add(Duration(days: 1))) {
    String formattedDate = formatDate(date);

    if (!attendanceMap.containsKey(formattedDate)) {
      int uniqueId =
          math.Random().nextInt(10000) + DateTime.now().millisecondsSinceEpoch;

      updatedAttendanceList.add(TeachersAttendanceStruct(
        date: date,
        ispresent: false,
        id: uniqueId,
        checkInTime: null,
        checkOutTime: null,
      ));
    }
  }

  return updatedAttendanceList;
}

List<TeacherListStruct> updateTeacherDetails(
  List<TeacherListStruct> teachersList,
  DocumentReference userRef,
  String name,
  String phoneNumber,
  String image,
) {
  // Create a new list to avoid modifying the original list directly
  List<TeacherListStruct> updatedTeachersList = List.from(teachersList);

  for (int i = 0; i < updatedTeachersList.length; i++) {
    if (updatedTeachersList[i].userRef == userRef) {
      // Create a new TeacherListStruct object with updated values
      updatedTeachersList[i] = TeacherListStruct(
        userRef: updatedTeachersList[i].userRef, // Keep the same reference
        teacherName: name, // Update name
        phoneNumber: phoneNumber, // Update phone number
        teacherImage: image, // Update image
        emailId: updatedTeachersList[i].emailId, // Keep existing data
        teachersId: updatedTeachersList[i].teachersId,
        // Keep existing data
        // Add any other existing fields here...
      );
      break; // Exit loop after updating the first match
    }
  }

  return updatedTeachersList;
}

String combineStrings(
  List<SchoolClassRecord> classDocuments,
  List<DocumentReference> classRefs,
) {
  // Filter classDocuments where classRef is in classRefs
  List<String> matchingClassNames = classDocuments
      .where((doc) => classRefs.contains(doc.reference))
      .map((doc) => doc.className)
      .toList();

  // Join matching class names with commas
  return matchingClassNames.join(', ');
}

bool containsFirebaseLink(String input) {
  if (input.isEmpty) {
    return false;
  }

  // Updated regex to match all Firebase Storage URL variations
  final firebaseUrlPattern = RegExp(
    r'https:\/\/firebasestorage\.(googleapis\.com|[a-zA-Z0-9-]+\.firebasestorage\.app)\/v0\/b\/[a-zA-Z0-9-]+\/o\/[^?]+',
    caseSensitive: false,
  );

  return input.isNotEmpty || firebaseUrlPattern.hasMatch(input);
}

List<TeacherListStruct> startfromfirst(List<TeacherListStruct> inputList) {
  List<TeacherListStruct> modifiedList = [];

  // Add a dummy value (or any initial value) at index 0 to maintain the +1 offset
  modifiedList.add(TeacherListStruct()); // Add dummy element or any placeholder

  // Add the actual list elements starting from index 1
  modifiedList.addAll(inputList);

  return modifiedList;
}

DateTime getPreviousDay(
  DateTime date,
  bool prev,
) {
  if (prev == true) {
    return date.subtract(Duration(days: 1));
  }

  return date.add(Duration(days: 1));
}

int middelindex(int numberitems) {
  return (numberitems / 2).floor();
}

List<ParentsDetailsStruct> placeUserRefInMiddle(
  List<ParentsDetailsStruct> parents,
  DocumentReference targetUserRef,
  int targetIndex,
) {
  ParentsDetailsStruct? targetParent;
  List<ParentsDetailsStruct> remainingParents = [];

  for (var parent in parents) {
    if (parent.userRef == targetUserRef) {
      targetParent = parent;
    } else {
      remainingParents.add(parent);
    }
  }

  if (targetParent == null) {
    return parents; // If targetUserRef is not found, return the original list.
  }

  // Ensure the targetIndex is within valid bounds
  targetIndex = targetIndex.clamp(0, remainingParents.length);

  // Insert the targetParent at the specified index
  remainingParents.insert(targetIndex, targetParent);

  return remainingParents;
}

List<ParentStudentStruct> updateStudentDetailsparent(
  List<ParentStudentStruct> studentList,
  DocumentReference studentRef,
  DateTime? dob,
  String? gender,
  String? address,
  String? allergy,
  String? docImage,
  String? doc,
  String? name,
) {
  return studentList.map((student) {
    if (student.docref == studentRef) {
      return ParentStudentStruct(
        name: name ?? student.name,
        dob: dob ?? student.dob,
        gender: gender ?? student.gender,
        address: address ?? student.address,
        allergy: allergy ?? student.allergy,
        image: docImage ?? student.image,
        docref: student.docref, // Ensure docref remains unchanged
        index: student.index, // Preserve the index
        doc: doc ?? student.doc, // Update document if provided
      );
    }
    return student;
  }).toList();
}

List<ParentsDetailsStruct> updateParentDetailsCopy(
  DocumentReference userRef,
  String name,
  String phoneNumber,
  String email,
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
      break; // Stop looping once the match is found
    }
  }
  return parentsList;
}

bool eventnumber(int number) {
  if (number % 2 == 0)
    return true;
  else
    return false;
}

bool isValidEmail(String email) {
  // Define the email regex pattern
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  return emailRegex.hasMatch(email);
}

int getParentIndex(
  List<ParentsDetailsStruct> parentList,
  int eventParentId,
) {
  for (int i = 0; i < parentList.length; i++) {
    if (parentList[i].parentsId == eventParentId) {
      return i; // Return the index where the parentId matches
    }
  }

  return -1; // Return -1 if no match is found
}

int getFileTypeFromUrl(String url) {
  Uri uri = Uri.parse(url);
  String path = uri.path;

  // Extract the file extension from the path
  String extension = path.split('.').last.toLowerCase();

  // Check the file extension and return the corresponding value
  if (extension == 'pdf') {
    return 1; // PDF
  } else if (extension == 'docx') {
    return 2; // DOCX
  } else if (extension == 'mp3') {
    return 3; // Video (add more extensions as needed)
  } else if (extension == 'jpg' || extension == 'jpeg' || extension == 'png') {
    return 4; // Image (add more extensions as needed)
  } else if (extension == 'ppt' || extension == 'pptx') {
    return 5; // PPT
  } else {
    return 0; // Unknown type
  }
}

List<String> converttostring(
  String? imagepath,
  String? videopath,
) {
  List<String> result = [];

  if (imagepath != null && imagepath.isNotEmpty) {
    result.add(imagepath);
  }
  if (videopath != null && videopath.isNotEmpty) {
    result.add(videopath);
  }

  return result;
}

int index(int index1) {
  return index1 - 1;
}

int plusIndex(int index) {
  return index + 1;
}

String getUsernameFromEmail(String email) {
  return email.split('@')[0];
}

List<ParentsDetailsStruct>? removeExactDuplicates(
    List<ParentsDetailsStruct>? parentList) {
  final seen = <String>{};
  final result = <ParentsDetailsStruct>[];

  if (parentList == null) return result;

  for (var parent in parentList) {
    final key =
        '${parent.parentsName}_${parent.parentsPhone}_${parent.parentsEmail}';
    if (!seen.contains(key)) {
      seen.add(key);
      result.add(parent);
    }
  }

  return result;
}

bool isValidLatLng(LatLng latLng) {
  if (latLng == null) {
    return false;
  }
  if (latLng.latitude < -90 || latLng.latitude > 90) {
    return false;
  }
  if (latLng.longitude < -180 || latLng.longitude > 180) {
    return false;
  }
  return true;
}

bool isBlank(String? input) {
  return input == null || input.trim().isEmpty;
}

List<TeacherListStruct> updateTeacherData(
  List<TeacherListStruct> teacherList,
  DocumentReference teacherRef,
  String newName,
  String newPhoneNumber,
  String newImagePath,
  DocumentReference teacherUserRef,
) {
  for (var teacher in teacherList) {
    if (teacher.teachersId == teacherRef) {
      teacher.teacherName = newName;
      teacher.phoneNumber = newPhoneNumber;
      teacher.teacherImage = newImagePath;
      teacher.userRef = teacherUserRef;
    }
  }

  return teacherList;
}

bool? isWithin30Days(
  DateTime currentDate,
  DateTime eventDate,
) {
  final difference = eventDate.difference(currentDate).inDays;
  return difference >= 0 && difference <= 30;
}

List<GalleryStruct> startFromGallery(List<GalleryStruct> inputList) {
  List<GalleryStruct> modifiedList = [];

  // Add a dummy GalleryStruct at the beginning
  modifiedList.add(GalleryStruct()); // Add default/placeholder if needed

  // Add the actual list elements starting from index 1
  modifiedList.addAll(inputList);

  return modifiedList;
}

int? newCustomFunction(String number) {
  return int.tryParse(number);
}
