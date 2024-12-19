import '/admin_dashboard/edit_delete_notice/edit_delete_notice_widget.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/shimmer_effects/main_dashboard_shimmer/main_dashboard_shimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'add_calender_details_model.dart';
export 'add_calender_details_model.dart';

class AddCalenderDetailsWidget extends StatefulWidget {
  const AddCalenderDetailsWidget({
    super.key,
    required this.selectedDate,
    this.schoolclassref,
  });

  final DateTime? selectedDate;
  final DocumentReference? schoolclassref;

  @override
  State<AddCalenderDetailsWidget> createState() =>
      _AddCalenderDetailsWidgetState();
}

class _AddCalenderDetailsWidgetState extends State<AddCalenderDetailsWidget> {
  late AddCalenderDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddCalenderDetailsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.calendarDate = widget.selectedDate;
      safeSetState(() {});
      _model.school = await querySchoolRecordOnce(
        queryBuilder: (schoolRecord) => schoolRecord.where(
          'List_of_class',
          arrayContains: widget.schoolclassref,
        ),
        singleRecord: true,
      ).then((s) => s.firstOrNull);
      _model.schoolref = _model.school?.reference;
      safeSetState(() {});
    });

    _model.eventnameTextController ??= TextEditingController();
    _model.eventnameFocusNode ??= FocusNode();

    _model.descriptionNoticeTextController ??= TextEditingController();
    _model.descriptionNoticeFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SchoolClassRecord>(
      stream: SchoolClassRecord.getDocument(widget.schoolclassref!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: const MainDashboardShimmerWidget(),
          );
        }

        final addCalenderDetailsSchoolClassRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            appBar: AppBar(
              backgroundColor: FlutterFlowTheme.of(context).info,
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: Icon(
                  Icons.chevron_left,
                  color: FlutterFlowTheme.of(context).bgColor1,
                  size: 28.0,
                ),
                onPressed: () async {
                  context.pop();
                },
              ),
              title: Text(
                'Events',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            _model.calendarDate =
                                functions.prevDate(_model.calendarDate);
                            safeSetState(() {});
                          },
                          child: Icon(
                            Icons.chevron_left_outlined,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 28.0,
                          ),
                        ),
                        Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 0.0),
                            child: Text(
                              dateTimeFormat("yMMMd", _model.calendarDate),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    fontSize: 16.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
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
                            _model.calendarDate =
                                functions.nextDate(_model.calendarDate);
                            safeSetState(() {});
                          },
                          child: Icon(
                            Icons.navigate_next_rounded,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 28.0,
                          ),
                        ),
                      ],
                    ),
                    if (!functions.isDatePassed(_model.calendarDate!))
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Material(
                          color: Colors.transparent,
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        FFButtonWidget(
                                          onPressed: () async {
                                            _model.eventName = 'Event';
                                            safeSetState(() {});
                                          },
                                          text: 'Event',
                                          icon: const Icon(
                                            Icons.bolt,
                                            color: Color(0xFFC29800),
                                            size: 15.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.26,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.04,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Nunito',
                                                      color: _model.eventName ==
                                                              'Event'
                                                          ? const Color(0xFFC29800)
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: valueOrDefault<Color>(
                                                _model.eventName == 'Event'
                                                    ? const Color(0xFFC29800)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .text,
                                                FlutterFlowTheme.of(context)
                                                    .text,
                                              ),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            _model.eventName = 'Holiday';
                                            safeSetState(() {});
                                          },
                                          text: 'Holiday',
                                          icon: const Icon(
                                            Icons.celebration_sharp,
                                            color: Color(0xFFC29800),
                                            size: 15.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.26,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.04,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Nunito',
                                                      color: _model.eventName ==
                                                              'Holiday'
                                                          ? const Color(0xFFC29800)
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: valueOrDefault<Color>(
                                                _model.eventName == 'Holiday'
                                                    ? const Color(0xFFC29800)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .text,
                                                FlutterFlowTheme.of(context)
                                                    .text,
                                              ),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                        FFButtonWidget(
                                          onPressed: () async {
                                            _model.eventName = 'Birthday';
                                            safeSetState(() {});
                                          },
                                          text: 'Birthday',
                                          icon: const FaIcon(
                                            FontAwesomeIcons.birthdayCake,
                                            color: Color(0xFFC29800),
                                            size: 15.0,
                                          ),
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.26,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.04,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Nunito',
                                                      color: _model.eventName ==
                                                              'Birthday'
                                                          ? const Color(0xFFC29800)
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color: valueOrDefault<Color>(
                                                _model.eventName == 'Birthday'
                                                    ? const Color(0xFFC29800)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .text,
                                                FlutterFlowTheme.of(context)
                                                    .text,
                                              ),
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Form(
                                    key: _model.formKey,
                                    autovalidateMode: AutovalidateMode.disabled,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 10.0),
                                          child: SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.88,
                                            child: TextFormField(
                                              controller: _model
                                                  .eventnameTextController,
                                              focusNode:
                                                  _model.eventnameFocusNode,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelText: 'Event ',
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: valueOrDefault<
                                                              Color>(
                                                            (_model
                                                                        .eventnameFocusNode
                                                                        ?.hasFocus ??
                                                                    false)
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                          ),
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                hintText: 'Event',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .dIsable,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        letterSpacing: 0.0,
                                                      ),
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              validator: _model
                                                  .eventnameTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 5.0, 0.0, 0.0),
                                          child: SizedBox(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.9,
                                            child: TextFormField(
                                              controller: _model
                                                  .descriptionNoticeTextController,
                                              focusNode: _model
                                                  .descriptionNoticeFocusNode,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelText: 'Description',
                                                labelStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: valueOrDefault<
                                                              Color>(
                                                            (_model
                                                                        .descriptionNoticeFocusNode
                                                                        ?.hasFocus ??
                                                                    false)
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                          ),
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                hintText: 'Description',
                                                hintStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleLarge
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          fontSize: 12.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .dIsable,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .alternate,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                errorBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .error,
                                                    width: 1.0,
                                                  ),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                                filled: true,
                                                fillColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                              ),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                              maxLines: 4,
                                              maxLength: 60,
                                              buildCounter: (context,
                                                      {required currentLength,
                                                      required isFocused,
                                                      maxLength}) =>
                                                  null,
                                              cursorColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              validator: _model
                                                  .descriptionNoticeTextControllerValidator
                                                  .asValidator(context),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Builder(
                                    builder: (context) {
                                      final imagesview =
                                          _model.uploadedFileUrls.toList();

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
                                        itemBuilder:
                                            (context, imagesviewIndex) {
                                          final imagesviewItem =
                                              imagesview[imagesviewIndex];
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.network(
                                              imagesviewItem,
                                              fit: BoxFit.cover,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: FlutterFlowIconButton(
                                          borderColor: Colors.transparent,
                                          borderRadius: 8.0,
                                          buttonSize: 40.0,
                                          icon: Icon(
                                            Icons.attach_file,
                                            color: FlutterFlowTheme.of(context)
                                                .tertiaryText,
                                            size: 24.0,
                                          ),
                                          onPressed: () async {
                                            final selectedMedia =
                                                await selectMedia(
                                              mediaSource:
                                                  MediaSource.photoGallery,
                                              multiImage: true,
                                            );
                                            if (selectedMedia != null &&
                                                selectedMedia.every((m) =>
                                                    validateFileFormat(
                                                        m.storagePath,
                                                        context))) {
                                              safeSetState(() => _model
                                                  .isDataUploading = true);
                                              var selectedUploadedFiles =
                                                  <FFUploadedFile>[];

                                              var downloadUrls = <String>[];
                                              try {
                                                showUploadMessage(
                                                  context,
                                                  'Uploading file...',
                                                  showLoading: true,
                                                );
                                                selectedUploadedFiles =
                                                    selectedMedia
                                                        .map((m) =>
                                                            FFUploadedFile(
                                                              name: m
                                                                  .storagePath
                                                                  .split('/')
                                                                  .last,
                                                              bytes: m.bytes,
                                                              height: m
                                                                  .dimensions
                                                                  ?.height,
                                                              width: m
                                                                  .dimensions
                                                                  ?.width,
                                                              blurHash:
                                                                  m.blurHash,
                                                            ))
                                                        .toList();

                                                downloadUrls =
                                                    (await Future.wait(
                                                  selectedMedia.map(
                                                    (m) async =>
                                                        await uploadData(
                                                            m.storagePath,
                                                            m.bytes),
                                                  ),
                                                ))
                                                        .where((u) => u != null)
                                                        .map((u) => u!)
                                                        .toList();
                                              } finally {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                                _model.isDataUploading = false;
                                              }
                                              if (selectedUploadedFiles
                                                          .length ==
                                                      selectedMedia.length &&
                                                  downloadUrls.length ==
                                                      selectedMedia.length) {
                                                safeSetState(() {
                                                  _model.uploadedLocalFiles =
                                                      selectedUploadedFiles;
                                                  _model.uploadedFileUrls =
                                                      downloadUrls;
                                                });
                                                showUploadMessage(
                                                    context, 'Success!');
                                              } else {
                                                safeSetState(() {});
                                                showUploadMessage(context,
                                                    'Failed to upload data');
                                                return;
                                              }
                                            }

                                            _model.image = _model
                                                .uploadedFileUrls
                                                .toList()
                                                .cast<String>();
                                            safeSetState(() {});
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: FFButtonWidget(
                                          onPressed: () async {
                                            if (_model.eventName != '') {
                                              if (_model.formKey.currentState ==
                                                      null ||
                                                  !_model.formKey.currentState!
                                                      .validate()) {
                                                return;
                                              }

                                              await addCalenderDetailsSchoolClassRecord
                                                  .reference
                                                  .update({
                                                ...mapToFirestore(
                                                  {
                                                    'calendar':
                                                        FieldValue.arrayUnion([
                                                      getEventsNoticeFirestoreData(
                                                        updateEventsNoticeStruct(
                                                          EventsNoticeStruct(
                                                            eventId: functions
                                                                .generateUniqueId(),
                                                            eventName: _model
                                                                .eventName,
                                                            eventTitle: _model
                                                                .eventnameTextController
                                                                .text,
                                                            eventDescription: _model
                                                                .descriptionNoticeTextController
                                                                .text,
                                                            eventDate: _model
                                                                .calendarDate,
                                                            eventImages:
                                                                _model.image,
                                                          ),
                                                          clearUnsetFields:
                                                              false,
                                                        ),
                                                        true,
                                                      )
                                                    ]),
                                                  },
                                                ),
                                              });
                                              triggerPushNotification(
                                                notificationTitle:
                                                    _model.eventName,
                                                notificationText: _model
                                                    .eventnameTextController
                                                    .text,
                                                userRefs:
                                                    addCalenderDetailsSchoolClassRecord
                                                        .listOfteachersUser
                                                        .toList(),
                                                initialPageName: 'Class_view',
                                                parameterData: {
                                                  'schoolclassref':
                                                      widget.schoolclassref,
                                                },
                                              );

                                              await NotificationsRecord
                                                  .collection
                                                  .doc()
                                                  .set({
                                                ...createNotificationsRecordData(
                                                  content:
                                                      '${_model.eventName} : ${_model.eventnameTextController.text}for class${addCalenderDetailsSchoolClassRecord.className}on ${dateTimeFormat("yMMMd", _model.calendarDate)}',
                                                  descri: _model
                                                      .descriptionNoticeTextController
                                                      .text,
                                                  datetimeofevent:
                                                      widget.selectedDate,
                                                  isread: false,
                                                  notification:
                                                      updateNotificationStruct(
                                                    NotificationStruct(
                                                      notificationTitle: _model
                                                          .eventnameTextController
                                                          .text,
                                                      descriptions: _model
                                                          .descriptionNoticeTextController
                                                          .text,
                                                      timeStamp:
                                                          getCurrentTimestamp,
                                                      isRead: false,
                                                      eventDate:
                                                          _model.calendarDate,
                                                      notificationImages: _model
                                                          .uploadedFileUrls,
                                                    ),
                                                    clearUnsetFields: false,
                                                    create: true,
                                                  ),
                                                  createDate:
                                                      getCurrentTimestamp,
                                                  tag: _model.eventName,
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'userref':
                                                        addCalenderDetailsSchoolClassRecord
                                                            .listOfteachersUser,
                                                  },
                                                ),
                                              });
                                              _model.students =
                                                  await queryStudentsRecordOnce();
                                              triggerPushNotification(
                                                notificationTitle:
                                                    _model.eventName,
                                                notificationText: _model
                                                    .eventnameTextController
                                                    .text,
                                                userRefs: functions
                                                    .extractParentUserRefs(_model
                                                        .students!
                                                        .where((e) =>
                                                            addCalenderDetailsSchoolClassRecord
                                                                .studentsList
                                                                .contains(e
                                                                    .reference))
                                                        .toList())
                                                    .toList(),
                                                initialPageName: 'Dashboard',
                                                parameterData: {},
                                              );

                                              await NotificationsRecord
                                                  .collection
                                                  .doc()
                                                  .set({
                                                ...createNotificationsRecordData(
                                                  content:
                                                      '${_model.eventName} : ${_model.eventnameTextController.text}for class${addCalenderDetailsSchoolClassRecord.className}on ${dateTimeFormat("yMMMd", _model.calendarDate)}',
                                                  descri: _model
                                                      .descriptionNoticeTextController
                                                      .text,
                                                  datetimeofevent:
                                                      widget.selectedDate,
                                                  notification:
                                                      updateNotificationStruct(
                                                    NotificationStruct(
                                                      notificationTitle: _model
                                                          .eventnameTextController
                                                          .text,
                                                      descriptions: _model
                                                          .descriptionNoticeTextController
                                                          .text,
                                                      timeStamp:
                                                          getCurrentTimestamp,
                                                      isRead: false,
                                                      eventDate:
                                                          _model.calendarDate,
                                                      notificationImages: _model
                                                          .uploadedFileUrls,
                                                    ),
                                                    clearUnsetFields: false,
                                                    create: true,
                                                  ),
                                                  isread: false,
                                                  createDate:
                                                      getCurrentTimestamp,
                                                  tag: _model.eventName,
                                                ),
                                                ...mapToFirestore(
                                                  {
                                                    'userref': functions
                                                        .extractParentUserRefs(_model
                                                            .students!
                                                            .where((e) =>
                                                                addCalenderDetailsSchoolClassRecord
                                                                    .studentsList
                                                                    .contains(e
                                                                        .reference))
                                                            .toList()),
                                                  },
                                                ),
                                              });
                                              _model.image = [];
                                              safeSetState(() {});
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Calender updated',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  ),
                                                  duration: const Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                ),
                                              );

                                              context.pushNamed(
                                                'Class_view',
                                                queryParameters: {
                                                  'schoolclassref':
                                                      serializeParam(
                                                    addCalenderDetailsSchoolClassRecord
                                                        .reference,
                                                    ParamType.DocumentReference,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Please select name of the event ',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                    ),
                                                  ),
                                                  duration: const Duration(
                                                      milliseconds: 4000),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondary,
                                                ),
                                              );
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Create Event',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.3,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 16.0, 16.0, 16.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Nunito',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                                    .divide(const SizedBox(height: 10.0))
                                    .around(const SizedBox(height: 10.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: Builder(
                        builder: (context) {
                          final calendarlist =
                              addCalenderDetailsSchoolClassRecord.calendar
                                  .where(
                                      (e) => e.eventDate == _model.calendarDate)
                                  .toList();
                          if (calendarlist.isEmpty) {
                            return SizedBox(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              height: MediaQuery.sizeOf(context).height * 0.4,
                              child: const EmptyWidget(),
                            );
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
                              0,
                              0,
                              0,
                              20.0,
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: calendarlist.length,
                            itemBuilder: (context, calendarlistIndex) {
                              final calendarlistItem =
                                  calendarlist[calendarlistIndex];
                              return Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 10.0),
                                child: Material(
                                  color: Colors.transparent,
                                  elevation: 5.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 10.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 5.0, 0.0, 5.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.3,
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.04,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .success,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      if (calendarlistItem
                                                              .eventName ==
                                                          'Event')
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      5.0,
                                                                      0.0),
                                                          child: Icon(
                                                            Icons.bolt,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      if (calendarlistItem
                                                              .eventName ==
                                                          'Holiday')
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      5.0,
                                                                      0.0),
                                                          child: Icon(
                                                            Icons
                                                                .celebration_sharp,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      if (calendarlistItem
                                                              .eventName ==
                                                          'Birthday')
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      5.0,
                                                                      0.0),
                                                          child: Icon(
                                                            Icons.cake,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .warning,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      Text(
                                                        calendarlistItem
                                                            .eventName,
                                                        style: FlutterFlowTheme
                                                                .of(context)
                                                            .bodyMedium
                                                            .override(
                                                              fontFamily:
                                                                  'Inter',
                                                              fontSize: 14.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                if (!functions.isDatePassed(
                                                        calendarlistItem
                                                            .eventDate!) &&
                                                    (dateTimeFormat(
                                                            "yMMMd",
                                                            calendarlistItem
                                                                .eventDate) !=
                                                        dateTimeFormat("yMMMd",
                                                            getCurrentTimestamp)))
                                                  Builder(
                                                    builder: (context) =>
                                                        FlutterFlowIconButton(
                                                      borderColor:
                                                          const Color(0xFFCDCDCD),
                                                      borderRadius: 40.0,
                                                      borderWidth: 1.0,
                                                      buttonSize: 40.0,
                                                      icon: Icon(
                                                        Icons.more_vert,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        size: 20.0,
                                                      ),
                                                      onPressed: () async {
                                                        if (calendarlistItem
                                                                .eventImages.isEmpty) {
                                                          await showAlignedDialog(
                                                            context: context,
                                                            isGlobal: false,
                                                            avoidOverflow:
                                                                false,
                                                            targetAnchor:
                                                                const AlignmentDirectional(
                                                                        1.0,
                                                                        -1.0)
                                                                    .resolve(
                                                                        Directionality.of(
                                                                            context)),
                                                            followerAnchor:
                                                                const AlignmentDirectional(
                                                                        1.0,
                                                                        0.0)
                                                                    .resolve(
                                                                        Directionality.of(
                                                                            context)),
                                                            builder:
                                                                (dialogContext) {
                                                              return Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    FocusScope.of(
                                                                            dialogContext)
                                                                        .unfocus();
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        ?.unfocus();
                                                                  },
                                                                  child:
                                                                      SizedBox(
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.12,
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.45,
                                                                    child:
                                                                        EditDeleteNoticeWidget(
                                                                      classref:
                                                                          addCalenderDetailsSchoolClassRecord
                                                                              .reference,
                                                                      eventid:
                                                                          calendarlistItem
                                                                              .eventId,
                                                                      classEvent:
                                                                          true,
                                                                      event:
                                                                          EventsNoticeStruct(
                                                                        eventId:
                                                                            calendarlistItem.eventId,
                                                                        eventName:
                                                                            calendarlistItem.eventName,
                                                                        eventTitle:
                                                                            calendarlistItem.eventTitle,
                                                                        eventDescription:
                                                                            calendarlistItem.eventDescription,
                                                                        eventDate:
                                                                            calendarlistItem.eventDate,
                                                                      ),
                                                                      noticebool:
                                                                          false,
                                                                      schoolref:
                                                                          _model
                                                                              .schoolref!,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        } else {
                                                          await showAlignedDialog(
                                                            context: context,
                                                            isGlobal: false,
                                                            avoidOverflow:
                                                                false,
                                                            targetAnchor:
                                                                const AlignmentDirectional(
                                                                        1.0,
                                                                        -1.0)
                                                                    .resolve(
                                                                        Directionality.of(
                                                                            context)),
                                                            followerAnchor:
                                                                const AlignmentDirectional(
                                                                        1.0,
                                                                        0.0)
                                                                    .resolve(
                                                                        Directionality.of(
                                                                            context)),
                                                            builder:
                                                                (dialogContext) {
                                                              return Material(
                                                                color: Colors
                                                                    .transparent,
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    FocusScope.of(
                                                                            dialogContext)
                                                                        .unfocus();
                                                                    FocusManager
                                                                        .instance
                                                                        .primaryFocus
                                                                        ?.unfocus();
                                                                  },
                                                                  child:
                                                                      SizedBox(
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.12,
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.45,
                                                                    child:
                                                                        EditDeleteNoticeWidget(
                                                                      classref:
                                                                          addCalenderDetailsSchoolClassRecord
                                                                              .reference,
                                                                      eventid:
                                                                          calendarlistItem
                                                                              .eventId,
                                                                      classEvent:
                                                                          true,
                                                                      noticebool:
                                                                          false,
                                                                      eventImage:
                                                                          EventsNoticeStruct(
                                                                        eventId:
                                                                            calendarlistItem.eventId,
                                                                        eventName:
                                                                            calendarlistItem.eventName,
                                                                        eventTitle:
                                                                            calendarlistItem.eventTitle,
                                                                        eventDescription:
                                                                            calendarlistItem.eventDescription,
                                                                        eventDate:
                                                                            calendarlistItem.eventDate,
                                                                        eventImages:
                                                                            calendarlistItem.eventImages,
                                                                      ),
                                                                      schoolref:
                                                                          _model
                                                                              .schoolref!,
                                                                    ),
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                          );
                                                        }
                                                      },
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 10.0),
                                            child: Text(
                                              dateTimeFormat("yMMMd",
                                                  calendarlistItem.eventDate!),
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 10.0),
                                            child: Text(
                                              calendarlistItem.eventTitle,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.85,
                                            decoration: const BoxDecoration(),
                                            child: Text(
                                              calendarlistItem.eventDescription,
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Builder(
                                              builder: (context) {
                                                final uploadedImages =
                                                    calendarlistItem.eventImages
                                                        .toList();

                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: List.generate(
                                                      uploadedImages.length,
                                                      (uploadedImagesIndex) {
                                                    final uploadedImagesItem =
                                                        uploadedImages[
                                                            uploadedImagesIndex];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  5.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Container(
                                                        width: 50.0,
                                                        height: 50.0,
                                                        decoration:
                                                            const BoxDecoration(),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await Navigator
                                                                .push(
                                                              context,
                                                              PageTransition(
                                                                type:
                                                                    PageTransitionType
                                                                        .fade,
                                                                child:
                                                                    FlutterFlowExpandedImageView(
                                                                  image: Image
                                                                      .network(
                                                                    uploadedImagesItem,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                  allowRotation:
                                                                      false,
                                                                  tag:
                                                                      uploadedImagesItem,
                                                                  useHeroAnimation:
                                                                      true,
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                          child: Hero(
                                                            tag:
                                                                uploadedImagesItem,
                                                            transitionOnUserGestures:
                                                                true,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.network(
                                                                uploadedImagesItem,
                                                                width: 50.0,
                                                                height: 50.0,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                                );
                                              },
                                            ),
                                          ),
                                        ].addToEnd(const SizedBox(height: 10.0)),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
