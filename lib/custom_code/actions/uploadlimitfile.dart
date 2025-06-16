// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'index.dart'; // Imports other custom actions

import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

Future<QuickActionDatatypeStruct> uploadlimitfile(BuildContext context) async {
  final picker = ImagePicker();

  // Show bottom sheet to choose an option
  final choice = await showModalBottomSheet<int>(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
    ),
    builder: (context) => Wrap(
      children: [
        ListTile(
          leading: Icon(Icons.camera_alt),
          title: Text('Camera (Photo/Video)'),
          onTap: () => Navigator.of(context).pop(0),
        ),
        ListTile(
          leading: Icon(Icons.image),
          title: Text('Choose Image'),
          onTap: () => Navigator.of(context).pop(1),
        ),
        ListTile(
          leading: Icon(Icons.video_collection),
          title: Text('Choose Video'),
          onTap: () => Navigator.of(context).pop(2),
        ),
      ],
    ),
  );

  if (choice == null) {
    return QuickActionDatatypeStruct(
      isUploading: false,
      errorMessage: 'No file selected',
      videoUrl: '',
      imageUrl: '',
    );
  }

  XFile? file;
  int mediaChoice = -1; // Initialize mediaChoice to avoid undefined issues

  if (choice == 0) {
    // User chose Camera - Show another bottom sheet for photo or video
    mediaChoice = await showModalBottomSheet<int>(
          context: context,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
          ),
          builder: (context) => Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('Capture Photo'),
                onTap: () => Navigator.of(context).pop(0),
              ),
              ListTile(
                leading: Icon(Icons.videocam),
                title: Text('Capture Video'),
                onTap: () => Navigator.of(context).pop(1),
              ),
            ],
          ),
        ) ??
        -1; // Default to -1 if null to prevent errors

    if (mediaChoice == -1) {
      return QuickActionDatatypeStruct(
        isUploading: false,
        errorMessage: 'No file selected',
        videoUrl: '',
        imageUrl: '',
      );
    }

    // Capture image or video from camera
    if (mediaChoice == 0) {
      file = await picker.pickImage(source: ImageSource.camera);
    } else {
      file = await picker.pickVideo(source: ImageSource.camera);
    }
  } else if (choice == 1) {
    file = await picker.pickImage(source: ImageSource.gallery);
  } else if (choice == 2) {
    file = await picker.pickVideo(source: ImageSource.gallery);
  }

  if (file == null) {
    return QuickActionDatatypeStruct(
      isUploading: false,
      errorMessage: 'No file selected',
      videoUrl: '',
      imageUrl: '',
    );
  }

  // Convert to File type
  File mediaFile = File(file.path);

  // Print file path for debugging
  print('Selected file path: ${mediaFile.path}');

  // Check file size (limit to 40MB)
  final fileSize = await mediaFile.length();
  if (fileSize > 40 * 1024 * 1024) {
    return QuickActionDatatypeStruct(
      isUploading: false,
      errorMessage: 'File size exceeds 40MB limit',
      videoUrl: '',
      imageUrl: '',
    );
  }

  // Notify UI that upload is in progress
  QuickActionDatatypeStruct uploadingState = QuickActionDatatypeStruct(
    isUploading: true,
    errorMessage: '',
    videoUrl: '',
    imageUrl: '',
  );

  try {
    String fileName = basename(mediaFile.path);
    Reference storageRef =
        FirebaseStorage.instance.ref().child('uploads/$fileName');
    UploadTask uploadTask = storageRef.putFile(mediaFile);

    // Wait for upload to complete
    TaskSnapshot snapshot = await uploadTask;

    if (snapshot.state == TaskState.success) {
      String downloadUrl = await snapshot.ref.getDownloadURL();
      print('File uploaded successfully: $downloadUrl');

      // Debugging: Print video URL
      if (choice == 2 || (choice == 0 && mediaChoice == 1)) {
        print('Uploaded video URL: $downloadUrl');
      }

      return QuickActionDatatypeStruct(
        isUploading: false,
        errorMessage: '',
        videoUrl: (choice == 2 || (choice == 0 && mediaChoice == 1))
            ? downloadUrl
            : '',
        imageUrl: (choice == 1 || (choice == 0 && mediaChoice == 0))
            ? downloadUrl
            : '',
      );
    } else {
      print('Error uploading file: ${snapshot.state}');
      return QuickActionDatatypeStruct(
        isUploading: false,
        errorMessage: 'Error uploading file',
        videoUrl: '',
        imageUrl: '',
      );
    }
  } catch (e) {
    print('Error uploading file: $e');
    return QuickActionDatatypeStruct(
      isUploading: false,
      errorMessage: 'Error uploading file: $e',
      videoUrl: '',
      imageUrl: '',
    );
  }
}
