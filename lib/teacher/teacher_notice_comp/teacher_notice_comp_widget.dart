import '/admin_dashboard/select_teacher_notice/select_teacher_notice_widget.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'teacher_notice_comp_model.dart';
export 'teacher_notice_comp_model.dart';

class TeacherNoticeCompWidget extends StatefulWidget {
  const TeacherNoticeCompWidget({
    super.key,
    required this.school,
  });

  final DocumentReference? school;

  @override
  State<TeacherNoticeCompWidget> createState() =>
      _TeacherNoticeCompWidgetState();
}

class _TeacherNoticeCompWidgetState extends State<TeacherNoticeCompWidget> {
  late TeacherNoticeCompModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TeacherNoticeCompModel());

    _model.eventnameTextController ??= TextEditingController();
    _model.eventnameFocusNode ??= FocusNode();

    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Material(
        color: Colors.transparent,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          width: MediaQuery.sizeOf(context).width * 1.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).tertiary,
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                        child: InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            final datePickedDate = await showDatePicker(
                              context: context,
                              initialDate: getCurrentTimestamp,
                              firstDate: getCurrentTimestamp,
                              lastDate: DateTime(2050),
                              builder: (context, child) {
                                return wrapInMaterialDatePickerTheme(
                                  context,
                                  child!,
                                  headerBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  headerForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  headerTextStyle: FlutterFlowTheme.of(context)
                                      .headlineLarge
                                      .override(
                                        fontFamily: 'Nunito',
                                        fontSize: 32.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                  pickerBackgroundColor:
                                      FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                  pickerForegroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  selectedDateTimeBackgroundColor:
                                      FlutterFlowTheme.of(context).primary,
                                  selectedDateTimeForegroundColor:
                                      FlutterFlowTheme.of(context).info,
                                  actionButtonForegroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  iconSize: 24.0,
                                );
                              },
                            );

                            if (datePickedDate != null) {
                              safeSetState(() {
                                _model.datePicked = DateTime(
                                  datePickedDate.year,
                                  datePickedDate.month,
                                  datePickedDate.day,
                                );
                              });
                            }
                          },
                          child: Icon(
                            Icons.date_range_outlined,
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            size: 24.0,
                          ),
                        ),
                      ),
                      if (_model.datePicked != null)
                        Text(
                          dateTimeFormat("dd MMM , y", _model.datePicked),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Nunito',
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                    ],
                  ),
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    decoration: const BoxDecoration(),
                    child: Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.teachernotice = 'Notice';
                                safeSetState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: valueOrDefault<Color>(
                                    _model.teachernotice == 'Notice'
                                        ? const Color(0xFFFFFCF0)
                                        : const Color(0xFFF5F2F2),
                                    const Color(0xFFF5F2F2),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: valueOrDefault<Color>(
                                      _model.teachernotice == 'Notice'
                                          ? const Color(0xFFB0FF6A)
                                          : FlutterFlowTheme.of(context).text,
                                      FlutterFlowTheme.of(context).text,
                                    ),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.push_pin,
                                        color: valueOrDefault<Color>(
                                          _model.teachernotice == 'Notice'
                                              ? FlutterFlowTheme.of(context)
                                                  .checkBg
                                              : FlutterFlowTheme.of(context)
                                                  .warning,
                                          FlutterFlowTheme.of(context).warning,
                                        ),
                                        size: 20.0,
                                      ),
                                      Text(
                                        'Notice',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color: valueOrDefault<Color>(
                                                _model.teachernotice == 'Notice'
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                FlutterFlowTheme.of(context)
                                                    .text,
                                              ),
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ]
                                        .divide(const SizedBox(width: 10.0))
                                        .around(const SizedBox(width: 10.0)),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.teachernotice = 'Reminder';
                                safeSetState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: valueOrDefault<Color>(
                                    _model.teachernotice == 'Reminder'
                                        ? const Color(0xC3FBF0FF)
                                        : const Color(0xFFF5F2F2),
                                    const Color(0xFFF5F2F2),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: valueOrDefault<Color>(
                                      _model.teachernotice == 'Reminder'
                                          ? const Color(0xFFADA6EB)
                                          : FlutterFlowTheme.of(context).text,
                                      FlutterFlowTheme.of(context).text,
                                    ),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.alarm_on,
                                        color: valueOrDefault<Color>(
                                          _model.teachernotice == 'Reminder'
                                              ? FlutterFlowTheme.of(context)
                                                  .error
                                              : FlutterFlowTheme.of(context)
                                                  .warning,
                                          FlutterFlowTheme.of(context).warning,
                                        ),
                                        size: 20.0,
                                      ),
                                      Text(
                                        'Reminder',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color: valueOrDefault<Color>(
                                                _model.teachernotice ==
                                                        'Reminder'
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                FlutterFlowTheme.of(context)
                                                    .text,
                                              ),
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ]
                                        .divide(const SizedBox(width: 10.0))
                                        .around(const SizedBox(width: 10.0)),
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.teachernotice = 'General';
                                safeSetState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: valueOrDefault<Color>(
                                    _model.teachernotice == 'General'
                                        ? const Color(0xFFFFFCF0)
                                        : const Color(0xFFF5F2F2),
                                    const Color(0xFFF5F2F2),
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                  border: Border.all(
                                    color: valueOrDefault<Color>(
                                      _model.teachernotice == 'General'
                                          ? const Color(0xFFFF976A)
                                          : FlutterFlowTheme.of(context).text,
                                      FlutterFlowTheme.of(context).text,
                                    ),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 10.0, 0.0, 10.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(
                                        Icons.mode_comment,
                                        color: valueOrDefault<Color>(
                                          _model.teachernotice == 'General'
                                              ? FlutterFlowTheme.of(context)
                                                  .warning
                                              : FlutterFlowTheme.of(context)
                                                  .warning,
                                          FlutterFlowTheme.of(context).warning,
                                        ),
                                        size: 20.0,
                                      ),
                                      Text(
                                        'General',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color: valueOrDefault<Color>(
                                                _model.teachernotice ==
                                                        'General'
                                                    ? FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                FlutterFlowTheme.of(context)
                                                    .text,
                                              ),
                                              fontSize: 12.0,
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                    ]
                                        .divide(const SizedBox(width: 10.0))
                                        .around(const SizedBox(width: 10.0)),
                                  ),
                                ),
                              ),
                            ),
                          ].divide(const SizedBox(width: 10.0)),
                        ),
                      ),
                    ),
                  ),
                  Form(
                    key: _model.formKey,
                    autovalidateMode: AutovalidateMode.disabled,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 0.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            child: TextFormField(
                              controller: _model.eventnameTextController,
                              focusNode: _model.eventnameFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Title',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: valueOrDefault<Color>(
                                        (_model.eventnameFocusNode?.hasFocus ??
                                                false)
                                            ? FlutterFlowTheme.of(context)
                                                .primary
                                            : FlutterFlowTheme.of(context)
                                                .alternate,
                                        FlutterFlowTheme.of(context).alternate,
                                      ),
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Title',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryText,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).dIsable,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    letterSpacing: 0.0,
                                  ),
                              maxLength: 25,
                              buildCounter: (context,
                                      {required currentLength,
                                      required isFocused,
                                      maxLength}) =>
                                  null,
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: _model.eventnameTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: SizedBox(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            child: TextFormField(
                              controller: _model.descriptionTextController,
                              focusNode: _model.descriptionFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Description',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: valueOrDefault<Color>(
                                        (_model.descriptionFocusNode
                                                    ?.hasFocus ??
                                                false)
                                            ? FlutterFlowTheme.of(context)
                                                .primary
                                            : FlutterFlowTheme.of(context)
                                                .alternate,
                                        FlutterFlowTheme.of(context).alternate,
                                      ),
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                    ),
                                hintText: 'Description',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryText,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).dIsable,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).error,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                filled: true,
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                              ),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    letterSpacing: 0.0,
                                  ),
                              maxLines: 4,
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: _model
                                  .descriptionTextControllerValidator
                                  .asValidator(context),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    child: Builder(
                      builder: (context) {
                        final imagesview =
                            FFAppState().eventnoticeimage.toList();

                        return GridView.builder(
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 5,
                            crossAxisSpacing: 10.0,
                            mainAxisSpacing: 10.0,
                            childAspectRatio: 1.0,
                          ),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: imagesview.length,
                          itemBuilder: (context, imagesviewIndex) {
                            final imagesviewItem = imagesview[imagesviewIndex];
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.network(
                                imagesviewItem,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(),
                    child: Container(
                      decoration: const BoxDecoration(),
                      child: Visibility(
                        visible:
                            _model.isDataUploading1 || _model.isDataUploading2,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/Animation_-_1735217758165.gif',
                            width: MediaQuery.sizeOf(context).width * 0.3,
                            height: MediaQuery.sizeOf(context).height * 0.2,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 0.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FlutterFlowIconButton(
                          borderColor: const Color(0xFFEDF1F3),
                          borderRadius: 8.0,
                          borderWidth: 1.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.attach_file,
                            color: FlutterFlowTheme.of(context).tertiaryText,
                            size: 22.0,
                          ),
                          showLoadingIndicator: true,
                          onPressed: () async {
                            safeSetState(() {
                              _model.isDataUploading1 = false;
                              _model.uploadedLocalFiles1 = [];
                              _model.uploadedFileUrls1 = [];
                            });

                            final selectedMedia = await selectMedia(
                              mediaSource: MediaSource.photoGallery,
                              multiImage: true,
                            );
                            if (selectedMedia != null &&
                                selectedMedia.every((m) => validateFileFormat(
                                    m.storagePath, context))) {
                              safeSetState(
                                  () => _model.isDataUploading1 = true);
                              var selectedUploadedFiles = <FFUploadedFile>[];

                              var downloadUrls = <String>[];
                              try {
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
                                    (m) async => await uploadData(
                                        m.storagePath, m.bytes),
                                  ),
                                ))
                                    .where((u) => u != null)
                                    .map((u) => u!)
                                    .toList();
                              } finally {
                                _model.isDataUploading1 = false;
                              }
                              if (selectedUploadedFiles.length ==
                                      selectedMedia.length &&
                                  downloadUrls.length == selectedMedia.length) {
                                safeSetState(() {
                                  _model.uploadedLocalFiles1 =
                                      selectedUploadedFiles;
                                  _model.uploadedFileUrls1 = downloadUrls;
                                });
                              } else {
                                safeSetState(() {});
                                return;
                              }
                            }

                            if (_model.uploadedFileUrls1.isNotEmpty) {
                              FFAppState().eventnoticeimage = functions
                                  .combineImagePaths(
                                      FFAppState().eventnoticeimage.toList(),
                                      _model.uploadedFileUrls1.toList())
                                  .toList()
                                  .cast<String>();
                              safeSetState(() {});
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'File uploaded',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).secondary,
                                ),
                              );
                            }
                          },
                        ),
                        FlutterFlowIconButton(
                          borderColor: const Color(0xFFEDF1F3),
                          borderRadius: 8.0,
                          borderWidth: 1.0,
                          buttonSize: 40.0,
                          icon: Icon(
                            Icons.camera_enhance_outlined,
                            color: FlutterFlowTheme.of(context).tertiaryText,
                            size: 22.0,
                          ),
                          showLoadingIndicator: true,
                          onPressed: () async {
                            safeSetState(() {
                              _model.isDataUploading2 = false;
                              _model.uploadedLocalFile2 =
                                  FFUploadedFile(bytes: Uint8List.fromList([]));
                              _model.uploadedFileUrl2 = '';
                            });

                            final selectedMedia = await selectMedia(
                              imageQuality: 10,
                              multiImage: false,
                            );
                            if (selectedMedia != null &&
                                selectedMedia.every((m) => validateFileFormat(
                                    m.storagePath, context))) {
                              safeSetState(
                                  () => _model.isDataUploading2 = true);
                              var selectedUploadedFiles = <FFUploadedFile>[];

                              var downloadUrls = <String>[];
                              try {
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
                                    (m) async => await uploadData(
                                        m.storagePath, m.bytes),
                                  ),
                                ))
                                    .where((u) => u != null)
                                    .map((u) => u!)
                                    .toList();
                              } finally {
                                _model.isDataUploading2 = false;
                              }
                              if (selectedUploadedFiles.length ==
                                      selectedMedia.length &&
                                  downloadUrls.length == selectedMedia.length) {
                                safeSetState(() {
                                  _model.uploadedLocalFile2 =
                                      selectedUploadedFiles.first;
                                  _model.uploadedFileUrl2 = downloadUrls.first;
                                });
                              } else {
                                safeSetState(() {});
                                return;
                              }
                            }

                            if (_model.uploadedFileUrl2 != '') {
                              FFAppState().addToEventnoticeimage(
                                  _model.uploadedFileUrl2);
                              safeSetState(() {});
                            }
                          },
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              return;
                            }
                            if ((_model.datePicked != null) &&
                                (_model.teachernotice != null &&
                                    _model.teachernotice != '')) {
                              if (FFAppState().eventnoticeimage.isEmpty) {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: SelectTeacherNoticeWidget(
                                        eventtitle:
                                            _model.eventnameTextController.text,
                                        description: _model
                                            .descriptionTextController.text,
                                        datetime: _model.datePicked!,
                                        scoolref: widget.school!,
                                        eventname: _model.teachernotice!,
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              } else {
                                await showModalBottomSheet(
                                  isScrollControlled: true,
                                  backgroundColor: Colors.transparent,
                                  enableDrag: false,
                                  context: context,
                                  builder: (context) {
                                    return Padding(
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: SelectTeacherNoticeWidget(
                                        eventtitle:
                                            _model.eventnameTextController.text,
                                        description: _model
                                            .descriptionTextController.text,
                                        datetime: _model.datePicked!,
                                        scoolref: widget.school!,
                                        images: FFAppState().eventnoticeimage,
                                        eventname: _model.teachernotice!,
                                      ),
                                    );
                                  },
                                ).then((value) => safeSetState(() {}));
                              }
                            } else {
                              await showDialog(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title: const Text('Alert!'),
                                    content:
                                        const Text('Pick up date and event type'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(alertDialogContext),
                                        child: const Text('Ok'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          text: 'Create notice',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            height: MediaQuery.sizeOf(context).height * 0.04,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).secondary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Nunito',
                                  color:
                                      FlutterFlowTheme.of(context).primaryText,
                                  letterSpacing: 0.0,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ].divide(const SizedBox(height: 10.0)).around(const SizedBox(height: 10.0)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
