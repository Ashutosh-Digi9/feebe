import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/confirmationpages/eventedited/eventedited_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'class_calendar_edit_model.dart';
export 'class_calendar_edit_model.dart';

class ClassCalendarEditWidget extends StatefulWidget {
  const ClassCalendarEditWidget({
    super.key,
    required this.classref,
    required this.eventid,
    required this.school,
  });

  final DocumentReference? classref;
  final int? eventid;
  final DocumentReference? school;

  @override
  State<ClassCalendarEditWidget> createState() =>
      _ClassCalendarEditWidgetState();
}

class _ClassCalendarEditWidgetState extends State<ClassCalendarEditWidget>
    with TickerProviderStateMixin {
  late ClassCalendarEditModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassCalendarEditModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.classes =
          await SchoolClassRecord.getDocumentOnce(widget.classref!);
      _model.images12 = _model.classes!.calendar
          .where((e) => widget.eventid == e.eventId)
          .toList()
          .firstOrNull!
          .eventImages
          .toList()
          .cast<String>();
      _model.eventname1278 = _model.classes?.calendar
          .where((e) => widget.eventid == e.eventId)
          .toList()
          .firstOrNull
          ?.eventName;
      safeSetState(() {});
    });

    _model.eventnameFocusNode ??= FocusNode();

    _model.descriptionFocusNode ??= FocusNode();

    animationsMap.addAll({
      'containerOnPageLoadAnimation': AnimationInfo(
        trigger: AnimationTrigger.onPageLoad,
        effectsBuilder: () => [
          FadeEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: 0.0,
            end: 1.0,
          ),
          MoveEffect(
            curve: Curves.easeInOut,
            delay: 0.0.ms,
            duration: 600.0.ms,
            begin: const Offset(0.0, 30.0),
            end: const Offset(0.0, 0.0),
          ),
        ],
      ),
    });
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
      child: StreamBuilder<SchoolClassRecord>(
        stream: SchoolClassRecord.getDocument(widget.classref!),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }

          final containerSchoolClassRecord = snapshot.data!;

          return Material(
            color: Colors.transparent,
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).tertiary,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Form(
                key: _model.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              if (_model.eventname1278 == 'Event')
                                FFButtonWidget(
                                  onPressed: () async {
                                    _model.eventname1278 = 'Event';
                                    safeSetState(() {});
                                  },
                                  text: 'Event',
                                  icon: const Icon(
                                    Icons.bolt,
                                    color: Color(0xFFF8BA0B),
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.25,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.04,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: const Color(0xFFFFFCF0),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    elevation: 0.0,
                                    borderSide: const BorderSide(
                                      color: Color(0xFFF8BA0B),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              if (_model.eventname1278 == 'Holiday')
                                FFButtonWidget(
                                  onPressed: () async {
                                    _model.eventname1278 = 'Holiday';
                                    safeSetState(() {});
                                  },
                                  text: 'Holiday',
                                  icon: const Icon(
                                    Icons.celebration_sharp,
                                    color: Color(0xFF072F78),
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.25,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.04,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: const Color(0xFFFBFCFF),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    elevation: 0.0,
                                    borderSide: const BorderSide(
                                      color: Color(0xFF7DD7FE),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              if (_model.eventname1278 == 'Birthday')
                                FFButtonWidget(
                                  onPressed: () async {
                                    _model.eventname1278 = 'Birthday';
                                    safeSetState(() {});
                                  },
                                  text: 'Birthday',
                                  icon: const FaIcon(
                                    FontAwesomeIcons.birthdayCake,
                                    color: Color(0xFFB0A7FD),
                                    size: 15.0,
                                  ),
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.25,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.04,
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color: const Color(0xFFF0F0FF),
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
                                        ),
                                    elevation: 0.0,
                                    borderSide: const BorderSide(
                                      color: Color(0xFF635AAC),
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 0.0),
                          child: AuthUserStreamWidget(
                            builder: (context) => SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              child: TextFormField(
                                controller: _model.eventnameTextController ??=
                                    TextEditingController(
                                  text: containerSchoolClassRecord.calendar
                                      .where(
                                          (e) => widget.eventid == e.eventId)
                                      .toList()
                                      .firstOrNull
                                      ?.eventTitle,
                                ),
                                focusNode: _model.eventnameFocusNode,
                                autofocus: false,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                readOnly: (dateTimeFormat(
                                            "yMd",
                                            containerSchoolClassRecord.calendar
                                                .where((e) =>
                                                    e.eventId ==
                                                    widget.eventid)
                                                .toList()
                                                .firstOrNull
                                                ?.eventDate) ==
                                        dateTimeFormat(
                                            "yMd", getCurrentTimestamp)) ||
                                    (valueOrDefault(
                                            currentUserDocument?.userRole, 0) ==
                                        1),
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Title',
                                  labelStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: valueOrDefault<Color>(
                                          (_model.eventnameFocusNode
                                                      ?.hasFocus ??
                                                  false)
                                              ? FlutterFlowTheme.of(context)
                                                  .primary
                                              : FlutterFlowTheme.of(context)
                                                  .text,
                                          FlutterFlowTheme.of(context).text,
                                        ),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Event name',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .tertiaryText,
                                        fontSize: 12.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).dIsable,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                validator: _model
                                    .eventnameTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 5.0),
                          child: AuthUserStreamWidget(
                            builder: (context) => SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              child: TextFormField(
                                controller: _model.descriptionTextController ??=
                                    TextEditingController(
                                  text: containerSchoolClassRecord.calendar
                                      .where(
                                          (e) => widget.eventid == e.eventId)
                                      .toList()
                                      .firstOrNull
                                      ?.eventDescription,
                                ),
                                focusNode: _model.descriptionFocusNode,
                                autofocus: false,
                                readOnly: (dateTimeFormat(
                                            "yMd",
                                            containerSchoolClassRecord.calendar
                                                .where((e) =>
                                                    e.eventId ==
                                                    widget.eventid)
                                                .toList()
                                                .firstOrNull
                                                ?.eventDate) ==
                                        dateTimeFormat(
                                            "yMd", getCurrentTimestamp)) ||
                                    (valueOrDefault(
                                            currentUserDocument?.userRole, 0) ==
                                        1),
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
                                                  .text,
                                          FlutterFlowTheme.of(context).text,
                                        ),
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
                                        fontWeight: FontWeight.w500,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).dIsable,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).primary,
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
                        ),
                        if (valueOrDefault(currentUserDocument?.userRole, 0) !=
                            1)
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 10.0, 0.0, 10.0),
                            child: AuthUserStreamWidget(
                              builder: (context) => Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  if (dateTimeFormat(
                                          "yMd",
                                          containerSchoolClassRecord.calendar
                                              .where((e) =>
                                                  e.eventId == widget.eventid)
                                              .toList()
                                              .firstOrNull
                                              ?.eventDate) !=
                                      dateTimeFormat(
                                          "yMd", getCurrentTimestamp))
                                    FFButtonWidget(
                                      onPressed: () async {
                                        final datePickedDate =
                                            await showDatePicker(
                                          context: context,
                                          initialDate:
                                              (containerSchoolClassRecord.notice
                                                      .where((e) =>
                                                          e.eventId ==
                                                          widget.eventid)
                                                      .toList()
                                                      .firstOrNull
                                                      ?.eventDate ??
                                                  DateTime.now()),
                                          firstDate: (getCurrentTimestamp ??
                                              DateTime(1900)),
                                          lastDate: DateTime(2050),
                                          builder: (context, child) {
                                            return wrapInMaterialDatePickerTheme(
                                              context,
                                              child!,
                                              headerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              headerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              headerTextStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        fontSize: 32.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                              pickerBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              pickerForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              selectedDateTimeBackgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              selectedDateTimeForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .info,
                                              actionButtonForegroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
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
                                      text: 'Change Date',
                                      options: FFButtonOptions(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.05,
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            16.0, 0.0, 16.0, 0.0),
                                        iconPadding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                0.0, 0.0, 0.0, 0.0),
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
                                              fontFamily: 'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        elevation: 0.0,
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                  Text(
                                    _model.datePicked != null
                                        ? dateTimeFormat(
                                            "dd MMM , y", _model.datePicked)
                                        : dateTimeFormat(
                                            "dd MMM , y",
                                            containerSchoolClassRecord.calendar
                                                .where((e) =>
                                                    e.eventId ==
                                                    widget.eventid)
                                                .toList()
                                                .firstOrNull!
                                                .eventDate!),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (containerSchoolClassRecord.notice
                                .where((e) => widget.eventid == e.eventId)
                                .toList()
                                .firstOrNull
                                ?.eventImages.isNotEmpty)
                          Align(
                            alignment: const AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 10.0, 0.0, 10.0),
                              child: Builder(
                                builder: (context) {
                                  final images = _model.images12.toList();

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: List.generate(images.length,
                                          (imagesIndex) {
                                        final imagesItem = images[imagesIndex];
                                        return Stack(
                                          alignment:
                                              const AlignmentDirectional(1.0, -1.0),
                                          children: [
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  -1.0, 0.0),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 10.0, 0.0),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  child: Image.network(
                                                    imagesItem,
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.12,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.08,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Align(
                                              alignment: const AlignmentDirectional(
                                                  1.0, -1.0),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model
                                                      .removeAtIndexFromImages12(
                                                          imagesIndex);
                                                  safeSetState(() {});
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Image removed',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                },
                                                child: Icon(
                                                  Icons.remove_circle,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                  size: 24.0,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      }),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        Align(
                          alignment: const AlignmentDirectional(-1.0, 0.0),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 0.0, 10.0),
                            child: Builder(
                              builder: (context) {
                                final images =
                                    FFAppState().eventnoticeimage.toList();

                                return SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: List.generate(images.length,
                                        (imagesIndex) {
                                      final imagesItem = images[imagesIndex];
                                      return Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          child: Image.network(
                                            imagesItem,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.12,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.08,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        if (_model.isDataUploading1 || _model.isDataUploading2)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/Animation_-_1735217758165.gif',
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              height: MediaQuery.sizeOf(context).height * 0.2,
                              fit: BoxFit.contain,
                            ),
                          ),
                        if (valueOrDefault(currentUserDocument?.userRole, 0) !=
                            1)
                          AuthUserStreamWidget(
                            builder: (context) => Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                if (dateTimeFormat(
                                        "yMd",
                                        containerSchoolClassRecord.calendar
                                            .where((e) =>
                                                e.eventId == widget.eventid)
                                            .toList()
                                            .firstOrNull
                                            ?.eventDate) !=
                                    dateTimeFormat("yMd", getCurrentTimestamp))
                                  FlutterFlowIconButton(
                                    borderColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    borderRadius: 8.0,
                                    borderWidth: 0.2,
                                    buttonSize: 40.0,
                                    icon: Icon(
                                      Icons.attach_file,
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryText,
                                      size: 24.0,
                                    ),
                                    showLoadingIndicator: true,
                                    onPressed: () async {
                                      safeSetState(() {
                                        _model.isDataUploading1 = false;
                                        _model.uploadedLocalFiles1 = [];
                                        _model.uploadedFileUrls1 = [];
                                      });

                                      final selectedMedia = await selectMedia(
                                        imageQuality: 10,
                                        mediaSource: MediaSource.photoGallery,
                                        multiImage: true,
                                      );
                                      if (selectedMedia != null &&
                                          selectedMedia.every((m) =>
                                              validateFileFormat(
                                                  m.storagePath, context))) {
                                        safeSetState(() =>
                                            _model.isDataUploading1 = true);
                                        var selectedUploadedFiles =
                                            <FFUploadedFile>[];

                                        var downloadUrls = <String>[];
                                        try {
                                          selectedUploadedFiles = selectedMedia
                                              .map((m) => FFUploadedFile(
                                                    name: m.storagePath
                                                        .split('/')
                                                        .last,
                                                    bytes: m.bytes,
                                                    height:
                                                        m.dimensions?.height,
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
                                            downloadUrls.length ==
                                                selectedMedia.length) {
                                          safeSetState(() {
                                            _model.uploadedLocalFiles1 =
                                                selectedUploadedFiles;
                                            _model.uploadedFileUrls1 =
                                                downloadUrls;
                                          });
                                        } else {
                                          safeSetState(() {});
                                          return;
                                        }
                                      }

                                      FFAppState().eventnoticeimage = functions
                                          .combineImagePaths(
                                              FFAppState()
                                                  .eventnoticeimage
                                                  .toList(),
                                              _model.uploadedFileUrls1.toList())
                                          .toList()
                                          .cast<String>();
                                      safeSetState(() {});
                                    },
                                  ),
                                if (dateTimeFormat(
                                        "yMd",
                                        containerSchoolClassRecord.calendar
                                            .where((e) =>
                                                e.eventId == widget.eventid)
                                            .toList()
                                            .firstOrNull
                                            ?.eventDate) !=
                                    dateTimeFormat("yMd", getCurrentTimestamp))
                                  FlutterFlowIconButton(
                                    borderColor:
                                        FlutterFlowTheme.of(context).alternate,
                                    borderRadius: 8.0,
                                    borderWidth: 0.2,
                                    buttonSize: 40.0,
                                    icon: Icon(
                                      Icons.photo_camera_outlined,
                                      color: FlutterFlowTheme.of(context)
                                          .tertiaryText,
                                      size: 24.0,
                                    ),
                                    showLoadingIndicator: true,
                                    onPressed: () async {
                                      safeSetState(() {
                                        _model.isDataUploading2 = false;
                                        _model.uploadedLocalFile2 =
                                            FFUploadedFile(
                                                bytes: Uint8List.fromList([]));
                                        _model.uploadedFileUrl2 = '';
                                      });

                                      final selectedMedia = await selectMedia(
                                        imageQuality: 10,
                                        multiImage: false,
                                      );
                                      if (selectedMedia != null &&
                                          selectedMedia.every((m) =>
                                              validateFileFormat(
                                                  m.storagePath, context))) {
                                        safeSetState(() =>
                                            _model.isDataUploading2 = true);
                                        var selectedUploadedFiles =
                                            <FFUploadedFile>[];

                                        var downloadUrls = <String>[];
                                        try {
                                          showUploadMessage(
                                            context,
                                            'Uploading file...',
                                            showLoading: true,
                                          );
                                          selectedUploadedFiles = selectedMedia
                                              .map((m) => FFUploadedFile(
                                                    name: m.storagePath
                                                        .split('/')
                                                        .last,
                                                    bytes: m.bytes,
                                                    height:
                                                        m.dimensions?.height,
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
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          _model.isDataUploading2 = false;
                                        }
                                        if (selectedUploadedFiles.length ==
                                                selectedMedia.length &&
                                            downloadUrls.length ==
                                                selectedMedia.length) {
                                          safeSetState(() {
                                            _model.uploadedLocalFile2 =
                                                selectedUploadedFiles.first;
                                            _model.uploadedFileUrl2 =
                                                downloadUrls.first;
                                          });
                                          showUploadMessage(
                                              context, 'Success!');
                                        } else {
                                          safeSetState(() {});
                                          showUploadMessage(
                                              context, 'Failed to upload data');
                                          return;
                                        }
                                      }

                                      FFAppState().addToEventnoticeimage(
                                          _model.uploadedFileUrl2);
                                      safeSetState(() {});
                                    },
                                  ),
                                Builder(
                                  builder: (context) => FFButtonWidget(
                                    onPressed: () async {
                                      if (dateTimeFormat(
                                              "yMd",
                                              containerSchoolClassRecord
                                                  .calendar
                                                  .where((e) =>
                                                      e.eventId ==
                                                      widget.eventid)
                                                  .toList()
                                                  .firstOrNull
                                                  ?.eventDate) !=
                                          dateTimeFormat(
                                              "yMd", getCurrentTimestamp)) {
                                        if (_model.formKey.currentState ==
                                                null ||
                                            !_model.formKey.currentState!
                                                .validate()) {
                                          return;
                                        }

                                        await widget.classref!.update({
                                          ...mapToFirestore(
                                            {
                                              'calendar':
                                                  getEventsNoticeListFirestoreData(
                                                functions.updateEvent(
                                                    containerSchoolClassRecord
                                                        .calendar
                                                        .toList(),
                                                    widget.eventid!,
                                                    _model
                                                        .eventnameTextController
                                                        .text,
                                                    _model
                                                        .descriptionTextController
                                                        .text,
                                                    (FFAppState()
                                                                    .eventnoticeimage.isEmpty
                                                            ? _model.images12
                                                            : functions.combineImagePaths(
                                                                _model.images12
                                                                    .toList(),
                                                                FFAppState()
                                                                    .eventnoticeimage
                                                                    .toList()))
                                                        .toList(),
                                                    _model.datePicked != null
                                                        ? _model.datePicked!
                                                        : containerSchoolClassRecord
                                                            .calendar
                                                            .where((e) =>
                                                                e.eventId ==
                                                                widget.eventid)
                                                            .toList()
                                                            .firstOrNull!
                                                            .eventDate!,
                                                    _model.eventname1278!),
                                              ),
                                            },
                                          ),
                                        });
                                        await Future.wait([
                                          Future(() async {
                                            triggerPushNotification(
                                              notificationTitle:
                                                  'Event has been edited',
                                              notificationText: _model
                                                  .eventnameTextController.text,
                                              userRefs:
                                                  containerSchoolClassRecord
                                                      .listOfteachersUser
                                                      .toList(),
                                              initialPageName: 'Dashboard',
                                              parameterData: {},
                                            );

                                            await NotificationsRecord.collection
                                                .doc()
                                                .set({
                                              ...createNotificationsRecordData(
                                                content: _model
                                                    .eventnameTextController
                                                    .text,
                                                descri: _model
                                                    .descriptionTextController
                                                    .text,
                                                datetimeofevent: _model.datePicked ?? containerSchoolClassRecord
                                                        .calendar
                                                        .where((e) =>
                                                            e.eventId ==
                                                            widget.eventid)
                                                        .toList()
                                                        .firstOrNull
                                                        ?.eventDate,
                                                isread: false,
                                                notification:
                                                    updateNotificationStruct(
                                                  NotificationStruct(
                                                    notificationTitle: _model
                                                        .eventnameTextController
                                                        .text,
                                                    descriptions: _model
                                                        .descriptionTextController
                                                        .text,
                                                    timeStamp:
                                                        getCurrentTimestamp,
                                                    isRead: false,
                                                    eventDate: _model.datePicked ?? containerSchoolClassRecord
                                                            .calendar
                                                            .where((e) =>
                                                                e.eventId ==
                                                                widget.eventid)
                                                            .toList()
                                                            .firstOrNull
                                                            ?.eventDate,
                                                    notificationImages: functions
                                                        .combineImagePaths(
                                                            _model
                                                                .uploadedFileUrls1
                                                                .toList(),
                                                            _model.images12
                                                                .toList()),
                                                  ),
                                                  clearUnsetFields: false,
                                                  create: true,
                                                ),
                                                createDate: getCurrentTimestamp,
                                                tag: _model.eventname1278,
                                                addedby: currentUserReference,
                                                heading: 'Edited a event',
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'userref':
                                                      containerSchoolClassRecord
                                                          .listOfteachersUser,
                                                  'towhome': [
                                                    containerSchoolClassRecord
                                                        .className
                                                  ],
                                                },
                                              ),
                                            });
                                          }),
                                          Future(() async {
                                            _model.students =
                                                await queryStudentsRecordOnce();
                                            triggerPushNotification(
                                              notificationTitle:
                                                  'Event has been edited',
                                              notificationText: _model
                                                  .eventnameTextController.text,
                                              userRefs: functions
                                                  .extractParentUserRefs(_model
                                                      .students!
                                                      .where((e) =>
                                                          containerSchoolClassRecord
                                                              .studentsList
                                                              .contains(
                                                                  e.reference))
                                                      .toList())
                                                  .toList(),
                                              initialPageName: 'Dashboard',
                                              parameterData: {},
                                            );

                                            await NotificationsRecord.collection
                                                .doc()
                                                .set({
                                              ...createNotificationsRecordData(
                                                content: _model
                                                    .eventnameTextController
                                                    .text,
                                                descri: _model
                                                    .descriptionTextController
                                                    .text,
                                                datetimeofevent: _model.datePicked ?? containerSchoolClassRecord
                                                        .calendar
                                                        .where((e) =>
                                                            e.eventId ==
                                                            widget.eventid)
                                                        .toList()
                                                        .firstOrNull
                                                        ?.eventDate,
                                                isread: false,
                                                notification:
                                                    updateNotificationStruct(
                                                  NotificationStruct(
                                                    notificationTitle: _model
                                                        .eventnameTextController
                                                        .text,
                                                    descriptions: _model
                                                        .descriptionTextController
                                                        .text,
                                                    timeStamp:
                                                        getCurrentTimestamp,
                                                    isRead: false,
                                                    eventDate: _model.datePicked ?? containerSchoolClassRecord
                                                            .calendar
                                                            .where((e) =>
                                                                e.eventId ==
                                                                widget.eventid)
                                                            .toList()
                                                            .firstOrNull
                                                            ?.eventDate,
                                                    notificationImages: functions
                                                        .combineImagePaths(
                                                            _model
                                                                .uploadedFileUrls1
                                                                .toList(),
                                                            _model.images12
                                                                .toList()),
                                                  ),
                                                  clearUnsetFields: false,
                                                  create: true,
                                                ),
                                                createDate: getCurrentTimestamp,
                                                tag: _model.eventname1278,
                                                addedby: currentUserReference,
                                                heading: 'Edited a event',
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'userref': functions
                                                      .extractParentUserRefs(_model
                                                          .students!
                                                          .where((e) =>
                                                              containerSchoolClassRecord
                                                                  .studentsList
                                                                  .contains(e
                                                                      .reference))
                                                          .toList()),
                                                  'towhome': [
                                                    containerSchoolClassRecord
                                                        .className
                                                  ],
                                                },
                                              ),
                                            });
                                          }),
                                          Future(() async {
                                            _model.school = await SchoolRecord
                                                .getDocumentOnce(
                                                    widget.school!);
                                            triggerPushNotification(
                                              notificationTitle:
                                                  'Event has been edited.',
                                              notificationText: _model
                                                  .eventnameTextController.text,
                                              userRefs: [
                                                _model.school!.principalDetails
                                                    .principalId!
                                              ],
                                              initialPageName: 'Dashboard',
                                              parameterData: {},
                                            );

                                            await NotificationsRecord.collection
                                                .doc()
                                                .set({
                                              ...createNotificationsRecordData(
                                                content: _model
                                                    .eventnameTextController
                                                    .text,
                                                descri: _model
                                                    .descriptionTextController
                                                    .text,
                                                datetimeofevent: _model.datePicked ?? containerSchoolClassRecord
                                                        .calendar
                                                        .where((e) =>
                                                            e.eventId ==
                                                            widget.eventid)
                                                        .toList()
                                                        .firstOrNull
                                                        ?.eventDate,
                                                isread: false,
                                                notification:
                                                    updateNotificationStruct(
                                                  NotificationStruct(
                                                    notificationTitle: _model
                                                        .eventnameTextController
                                                        .text,
                                                    descriptions: _model
                                                        .descriptionTextController
                                                        .text,
                                                    timeStamp:
                                                        getCurrentTimestamp,
                                                    isRead: false,
                                                    eventDate: _model.datePicked ?? containerSchoolClassRecord
                                                            .calendar
                                                            .where((e) =>
                                                                e.eventId ==
                                                                widget.eventid)
                                                            .toList()
                                                            .firstOrNull
                                                            ?.eventDate,
                                                    notificationImages: functions
                                                        .combineImagePaths(
                                                            _model
                                                                .uploadedFileUrls1
                                                                .toList(),
                                                            _model.images12
                                                                .toList()),
                                                  ),
                                                  clearUnsetFields: false,
                                                  create: true,
                                                ),
                                                createDate: getCurrentTimestamp,
                                                tag: _model.eventname1278,
                                                addedby: currentUserReference,
                                                heading: 'Edited a event',
                                              ),
                                              ...mapToFirestore(
                                                {
                                                  'schoolref': [widget.school],
                                                  'towhome': [
                                                    containerSchoolClassRecord
                                                        .className
                                                  ],
                                                },
                                              ),
                                            });
                                          }),
                                        ]);
                                        FFAppState().eventnoticeimage = [];
                                        safeSetState(() {});
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment: const AlignmentDirectional(
                                                      0.0, -0.8)
                                                  .resolve(Directionality.of(
                                                      context)),
                                              child: SizedBox(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.08,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.6,
                                                child: const EventeditedWidget(),
                                              ),
                                            );
                                          },
                                        );

                                        Navigator.pop(context);
                                      } else {
                                        Navigator.pop(context);
                                      }

                                      safeSetState(() {});
                                    },
                                    text: dateTimeFormat(
                                                "yMd",
                                                containerSchoolClassRecord
                                                    .calendar
                                                    .where((e) =>
                                                        e.eventId ==
                                                        widget.eventid)
                                                    .toList()
                                                    .firstOrNull
                                                    ?.eventDate) ==
                                            dateTimeFormat(
                                                "yMd", getCurrentTimestamp)
                                        ? 'Close'
                                        : 'Save Event',
                                    options: FFButtonOptions(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.05,
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      elevation: 0.0,
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ].addToEnd(const SizedBox(height: 20.0)),
                    ),
                  ),
                ),
              ),
            ),
          ).animateOnPageLoad(animationsMap['containerOnPageLoadAnimation']!);
        },
      ),
    );
  }
}
