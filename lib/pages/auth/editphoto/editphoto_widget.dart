import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/upload_data.dart';
import 'package:flutter/material.dart';
import 'editphoto_model.dart';
export 'editphoto_model.dart';

class EditphotoWidget extends StatefulWidget {
  const EditphotoWidget({
    super.key,
    required this.person,
  });

  final bool? person;

  @override
  State<EditphotoWidget> createState() => _EditphotoWidgetState();
}

class _EditphotoWidgetState extends State<EditphotoWidget> {
  late EditphotoModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditphotoModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.7,
      child: Container(
        width: MediaQuery.sizeOf(context).width * 1.0,
        height: MediaQuery.sizeOf(context).height * 0.2,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).primaryBackground,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(0.0),
            bottomRight: Radius.circular(0.0),
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                final selectedMedia = await selectMedia(
                  multiImage: false,
                );
                if (selectedMedia != null &&
                    selectedMedia.every(
                        (m) => validateFileFormat(m.storagePath, context))) {
                  safeSetState(() => _model.isDataUploading1 = true);
                  var selectedUploadedFiles = <FFUploadedFile>[];

                  var downloadUrls = <String>[];
                  try {
                    showUploadMessage(
                      context,
                      'Uploading file...',
                      showLoading: true,
                    );
                    selectedUploadedFiles = selectedMedia
                        .map((m) => FFUploadedFile(
                              name: m.storagePath.split('/').last,
                              bytes: m.bytes,
                              height: m.dimensions?.height,
                              width: m.dimensions?.width,
                              blurHash: m.blurHash,
                            ))
                        .toList();

                    downloadUrls = (await Future.wait(
                      selectedMedia.map(
                        (m) async => await uploadData(m.storagePath, m.bytes),
                      ),
                    ))
                        .where((u) => u != null)
                        .map((u) => u!)
                        .toList();
                  } finally {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    _model.isDataUploading1 = false;
                  }
                  if (selectedUploadedFiles.length == selectedMedia.length &&
                      downloadUrls.length == selectedMedia.length) {
                    safeSetState(() {
                      _model.uploadedLocalFile1 = selectedUploadedFiles.first;
                      _model.uploadedFileUrl1 = downloadUrls.first;
                    });
                    showUploadMessage(context, 'Success!');
                  } else {
                    safeSetState(() {});
                    showUploadMessage(context, 'Failed to upload data');
                    return;
                  }
                }

                if (widget.person == true) {
                  FFAppState().imageurl = _model.uploadedFileUrl1;
                  FFAppState().profileimagechanged = true;
                  safeSetState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Profile Picture uploaded successfully!',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: const Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                } else {
                  FFAppState().schoolimage = _model.uploadedFileUrl1;
                  safeSetState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Profile Picture uploaded successfully!',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: const Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                }

                Navigator.pop(context);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/_Group_440.png',
                  width: MediaQuery.sizeOf(context).width * 0.1,
                  height: MediaQuery.sizeOf(context).height * 0.15,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: 120.0,
              child: VerticalDivider(
                thickness: 2.0,
                color: FlutterFlowTheme.of(context).secondaryText,
              ),
            ),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async {
                final selectedMedia = await selectMedia(
                  mediaSource: MediaSource.photoGallery,
                  multiImage: false,
                );
                if (selectedMedia != null &&
                    selectedMedia.every(
                        (m) => validateFileFormat(m.storagePath, context))) {
                  safeSetState(() => _model.isDataUploading2 = true);
                  var selectedUploadedFiles = <FFUploadedFile>[];

                  var downloadUrls = <String>[];
                  try {
                    showUploadMessage(
                      context,
                      'Uploading file...',
                      showLoading: true,
                    );
                    selectedUploadedFiles = selectedMedia
                        .map((m) => FFUploadedFile(
                              name: m.storagePath.split('/').last,
                              bytes: m.bytes,
                              height: m.dimensions?.height,
                              width: m.dimensions?.width,
                              blurHash: m.blurHash,
                            ))
                        .toList();

                    downloadUrls = (await Future.wait(
                      selectedMedia.map(
                        (m) async => await uploadData(m.storagePath, m.bytes),
                      ),
                    ))
                        .where((u) => u != null)
                        .map((u) => u!)
                        .toList();
                  } finally {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    _model.isDataUploading2 = false;
                  }
                  if (selectedUploadedFiles.length == selectedMedia.length &&
                      downloadUrls.length == selectedMedia.length) {
                    safeSetState(() {
                      _model.uploadedLocalFile2 = selectedUploadedFiles.first;
                      _model.uploadedFileUrl2 = downloadUrls.first;
                    });
                    showUploadMessage(context, 'Success!');
                  } else {
                    safeSetState(() {});
                    showUploadMessage(context, 'Failed to upload data');
                    return;
                  }
                }

                if (widget.person == true) {
                  FFAppState().imageurl = _model.uploadedFileUrl2;
                  FFAppState().profileimagechanged = true;
                  safeSetState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Profile Picture uploaded successfully!',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: const Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                  Navigator.pop(context);
                } else {
                  FFAppState().schoolimage = _model.uploadedFileUrl2;
                  safeSetState(() {});
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Profile Picture uploaded successfully!',
                        style: TextStyle(
                          color: FlutterFlowTheme.of(context).primaryText,
                        ),
                      ),
                      duration: const Duration(milliseconds: 4000),
                      backgroundColor: FlutterFlowTheme.of(context).secondary,
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  'assets/images/_Group_438.png',
                  width: MediaQuery.sizeOf(context).width * 0.1,
                  height: MediaQuery.sizeOf(context).height * 0.15,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
