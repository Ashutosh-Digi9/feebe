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
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'edit_calender_school_model.dart';
export 'edit_calender_school_model.dart';

class EditCalenderSchoolWidget extends StatefulWidget {
  const EditCalenderSchoolWidget({
    super.key,
    required this.school,
    required this.eventid,
    required this.eventdata,
  });

  final DocumentReference? school;
  final int? eventid;
  final EventsNoticeStruct? eventdata;

  @override
  State<EditCalenderSchoolWidget> createState() =>
      _EditCalenderSchoolWidgetState();
}

class _EditCalenderSchoolWidgetState extends State<EditCalenderSchoolWidget>
    with TickerProviderStateMixin {
  late EditCalenderSchoolModel _model;

  final animationsMap = <String, AnimationInfo>{};

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditCalenderSchoolModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.school = await SchoolRecord.getDocumentOnce(widget.school!);
      _model.images23 = _model.school!.calendarList
          .where((e) => widget.eventid == e.eventId)
          .toList()
          .firstOrNull!
          .eventfiles
          .toList()
          .cast<String>();
      _model.eventname = _model.school?.calendarList
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
            begin: Offset(0.0, 30.0),
            end: Offset(0.0, 0.0),
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
      padding: EdgeInsets.all(5.0),
      child: StreamBuilder<SchoolRecord>(
        stream: SchoolRecord.getDocument(widget.school!),
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

          final containerSchoolRecord = snapshot.data!;

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
                  padding: EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Align(
                          alignment: AlignmentDirectional(1.0, 0.0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 0.0),
                            child: FlutterFlowIconButton(
                              borderRadius: 30.0,
                              buttonSize: 30.0,
                              fillColor:
                                  FlutterFlowTheme.of(context).secondaryText,
                              hoverColor: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              hoverIconColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              icon: Icon(
                                Icons.close,
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                size: 14.0,
                              ),
                              onPressed: () async {
                                FFAppState().eventfiles = [];
                                safeSetState(() {});
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              5.0, 0.0, 5.0, 0.0),
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      _model.eventname = 'Event';
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                            FlutterFlowTheme.of(context).event,
                                        borderRadius:
                                            BorderRadius.circular(3.59),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .eventborder,
                                          width: valueOrDefault<double>(
                                            _model.eventname == 'Event'
                                                ? 3.0
                                                : 1.0,
                                            2.0,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                              'assets/images/typcn--flash-removebg-preview.png',
                                              width: 15.5,
                                              height: 15.5,
                                              fit: BoxFit.contain,
                                            ),
                                            Text(
                                              'Event',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .eventtext,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ]
                                              .divide(SizedBox(width: 5.0))
                                              .around(SizedBox(width: 5.0)),
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
                                      _model.eventname = 'Holiday';
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .holiday,
                                        borderRadius:
                                            BorderRadius.circular(3.59),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .holidayborder,
                                          width: valueOrDefault<double>(
                                            _model.eventname == 'Holiday'
                                                ? 3.0
                                                : 1.0,
                                            2.0,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                              'assets/images/fxemoji--confetti-removebg-preview.png',
                                              width: 15.5,
                                              height: 15.5,
                                              fit: BoxFit.cover,
                                            ),
                                            Text(
                                              'Holiday',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .holidaytext,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ]
                                              .divide(SizedBox(width: 5.0))
                                              .around(SizedBox(width: 5.0)),
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
                                      _model.eventname = 'Birthday';
                                      safeSetState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .birthdayfill,
                                        borderRadius:
                                            BorderRadius.circular(3.59),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .birthdayborder,
                                          width: valueOrDefault<double>(
                                            _model.eventname == 'Birthday'
                                                ? 3.0
                                                : 1.0,
                                            2.0,
                                          ),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Image.asset(
                                              'assets/images/noto--birthday-cake-removebg-preview.png',
                                              width: 15.5,
                                              height: 15.5,
                                              fit: BoxFit.contain,
                                            ),
                                            Text(
                                              'Birthday',
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .birthdaytext,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ]
                                              .divide(SizedBox(width: 5.0))
                                              .around(SizedBox(width: 5.0)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(width: 10.0)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 5.0, 0.0, 10.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            child: TextFormField(
                              controller: _model.eventnameTextController ??=
                                  TextEditingController(
                                text: containerSchoolRecord.calendarList
                                    .where((e) => widget.eventid == e.eventId)
                                    .toList()
                                    .firstOrNull
                                    ?.eventTitle,
                              ),
                              focusNode: _model.eventnameFocusNode,
                              autofocus: false,
                              textCapitalization: TextCapitalization.sentences,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Title *',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.nunito(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: valueOrDefault<Color>(
                                        (_model.eventnameFocusNode?.hasFocus ??
                                                false)
                                            ? FlutterFlowTheme.of(context)
                                                .primary
                                            : FlutterFlowTheme.of(context)
                                                .textfieldText,
                                        FlutterFlowTheme.of(context)
                                            .textfieldText,
                                      ),
                                      fontSize: (_model.eventnameFocusNode
                                                  ?.hasFocus ??
                                              false)
                                          ? 12.0
                                          : 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                hintText: 'Title',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.nunito(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .textfieldText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .textfieldDisable,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
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
                                    font: GoogleFonts.nunito(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context).text2,
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                              cursorColor:
                                  FlutterFlowTheme.of(context).primaryText,
                              validator: _model.eventnameTextControllerValidator
                                  .asValidator(context),
                              inputFormatters: [
                                if (!isAndroid && !isiOS)
                                  TextInputFormatter.withFunction(
                                      (oldValue, newValue) {
                                    return TextEditingValue(
                                      selection: newValue.selection,
                                      text: newValue.text.toCapitalization(
                                          TextCapitalization.sentences),
                                    );
                                  }),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            child: TextFormField(
                              controller: _model.descriptionTextController ??=
                                  TextEditingController(
                                text: containerSchoolRecord.calendarList
                                    .where((e) => widget.eventid == e.eventId)
                                    .toList()
                                    .firstOrNull
                                    ?.eventDescription,
                              ),
                              focusNode: _model.descriptionFocusNode,
                              autofocus: false,
                              obscureText: false,
                              decoration: InputDecoration(
                                isDense: true,
                                labelText: 'Description *',
                                labelStyle: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      font: GoogleFonts.nunito(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .fontStyle,
                                      ),
                                      color: valueOrDefault<Color>(
                                        (_model.descriptionFocusNode
                                                    ?.hasFocus ??
                                                false)
                                            ? FlutterFlowTheme.of(context)
                                                .primary
                                            : FlutterFlowTheme.of(context)
                                                .textfieldText,
                                        FlutterFlowTheme.of(context)
                                            .textfieldText,
                                      ),
                                      fontSize: (_model.descriptionFocusNode
                                                  ?.hasFocus ??
                                              false)
                                          ? 12.0
                                          : 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .fontStyle,
                                    ),
                                hintText: 'Description',
                                hintStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      font: GoogleFonts.nunito(
                                        fontWeight: FontWeight.normal,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context)
                                          .textfieldText,
                                      fontSize: 16.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.normal,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .fontStyle,
                                    ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .textfieldDisable,
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
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
                                    font: GoogleFonts.nunito(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    letterSpacing: 0.0,
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
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
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 20.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  final _datePickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: (containerSchoolRecord
                                            .calendarList
                                            .where((e) =>
                                                e.eventId == widget.eventid)
                                            .toList()
                                            .firstOrNull
                                            ?.eventDate ??
                                        DateTime.now()),
                                    firstDate:
                                        (getCurrentTimestamp ?? DateTime(1900)),
                                    lastDate: DateTime(2050),
                                    builder: (context, child) {
                                      return wrapInMaterialDatePickerTheme(
                                        context,
                                        child!,
                                        headerBackgroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                        headerForegroundColor:
                                            FlutterFlowTheme.of(context).info,
                                        headerTextStyle: FlutterFlowTheme.of(
                                                context)
                                            .headlineLarge
                                            .override(
                                              font: GoogleFonts.nunito(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .headlineLarge
                                                        .fontStyle,
                                              ),
                                              fontSize: 32.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .headlineLarge
                                                      .fontStyle,
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
                                            FlutterFlowTheme.of(context).info,
                                        actionButtonForegroundColor:
                                            FlutterFlowTheme.of(context)
                                                .primaryText,
                                        iconSize: 24.0,
                                      );
                                    },
                                  );

                                  if (_datePickedDate != null) {
                                    safeSetState(() {
                                      _model.datePicked = DateTime(
                                        _datePickedDate.year,
                                        _datePickedDate.month,
                                        _datePickedDate.day,
                                      );
                                    });
                                  } else if (_model.datePicked != null) {
                                    safeSetState(() {
                                      _model.datePicked = containerSchoolRecord
                                          .calendarList
                                          .where((e) =>
                                              e.eventId == widget.eventid)
                                          .toList()
                                          .firstOrNull
                                          ?.eventDate;
                                    });
                                  }
                                },
                                text: 'Change Date',
                                options: FFButtonOptions(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.05,
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context).secondary,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                        font: GoogleFonts.nunito(
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .fontStyle,
                                      ),
                                  elevation: 0.0,
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              Text(
                                _model.datePicked != null
                                    ? dateTimeFormat(
                                        "dd MMM y", _model.datePicked)
                                    : dateTimeFormat(
                                        "dd MMM y",
                                        containerSchoolRecord.calendarList
                                            .where((e) =>
                                                e.eventId == widget.eventid)
                                            .toList()
                                            .firstOrNull!
                                            .eventDate!),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.nunito(
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      letterSpacing: 0.0,
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                              ),
                            ].divide(SizedBox(width: 12.0)),
                          ),
                        ),
                        if (containerSchoolRecord.calendarList
                                .where((e) => widget.eventid == e.eventId)
                                .toList()
                                .firstOrNull
                                ?.eventfiles
                                .length !=
                            0)
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
                              child: Builder(
                                builder: (context) {
                                  final images = _model.images23.toList();

                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: List.generate(images.length,
                                          (imagesIndex) {
                                        final imagesItem = images[imagesIndex];
                                        return Stack(
                                          alignment:
                                              AlignmentDirectional(1.0, -1.0),
                                          children: [
                                            if ((dateTimeFormat(
                                                        "yMd",
                                                        containerSchoolRecord
                                                            .calendarList
                                                            .where((e) =>
                                                                e.eventId ==
                                                                widget.eventid)
                                                            .toList()
                                                            .firstOrNull
                                                            ?.eventDate) !=
                                                    dateTimeFormat("yMd",
                                                        getCurrentTimestamp)) &&
                                                (valueOrDefault(
                                                        currentUserDocument
                                                            ?.userRole,
                                                        0) !=
                                                    1))
                                              AuthUserStreamWidget(
                                                builder: (context) => InkWell(
                                                  splashColor:
                                                      Colors.transparent,
                                                  focusColor:
                                                      Colors.transparent,
                                                  hoverColor:
                                                      Colors.transparent,
                                                  highlightColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    _model
                                                        .removeAtIndexFromImages23(
                                                            imagesIndex);
                                                    safeSetState(() {});
                                                    ScaffoldMessenger.of(
                                                            context)
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
                                                        duration: Duration(
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
                                                        .text1,
                                                    size: 15.0,
                                                  ),
                                                ),
                                              ),
                                            Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                if (functions
                                                        .getFileTypeFromUrl(
                                                            imagesItem) ==
                                                    1)
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await launchURL(
                                                          imagesItem);
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/images/download-removebg-preview_(1).png',
                                                        width: 46.0,
                                                        height: 41.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                if (functions
                                                        .getFileTypeFromUrl(
                                                            imagesItem) ==
                                                    2)
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await launchURL(
                                                          imagesItem);
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/images/download__1_-removebg-preview.png',
                                                        width: 46.0,
                                                        height: 41.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                if (functions
                                                        .getFileTypeFromUrl(
                                                            imagesItem) ==
                                                    3)
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await launchURL(
                                                          imagesItem);
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/images/download__2_-removebg-preview.png',
                                                        width: 46.0,
                                                        height: 41.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                if (functions
                                                        .getFileTypeFromUrl(
                                                            imagesItem) ==
                                                    4)
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await launchURL(
                                                          imagesItem);
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/images/clarity_image-gallery-line-removebg-preview.png',
                                                        width: 46.0,
                                                        height: 41.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                                if (functions
                                                        .getFileTypeFromUrl(
                                                            imagesItem) ==
                                                    5)
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await launchURL(
                                                          imagesItem);
                                                    },
                                                    child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.asset(
                                                        'assets/images/download-removebg-preview.png',
                                                        width: 46.0,
                                                        height: 41.0,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    ),
                                                  ),
                                              ]
                                                  .divide(SizedBox(width: 5.0))
                                                  .around(SizedBox(width: 5.0)),
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
                        Container(
                          decoration: BoxDecoration(),
                          child: Builder(
                            builder: (context) {
                              final imagesview =
                                  FFAppState().eventfiles.toList();

                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                children: List.generate(imagesview.length,
                                    (imagesviewIndex) {
                                  final imagesviewItem =
                                      imagesview[imagesviewIndex];
                                  return Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (functions.getFileTypeFromUrl(
                                              imagesviewItem) ==
                                          1)
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await launchURL(imagesviewItem);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/download-removebg-preview_(1).png',
                                              width: 46.0,
                                              height: 41.0,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      if (functions.getFileTypeFromUrl(
                                              imagesviewItem) ==
                                          2)
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await launchURL(imagesviewItem);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/download__1_-removebg-preview.png',
                                              width: 46.0,
                                              height: 41.0,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      if (functions.getFileTypeFromUrl(
                                              imagesviewItem) ==
                                          3)
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await launchURL(imagesviewItem);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/download__2_-removebg-preview.png',
                                              width: 46.0,
                                              height: 41.0,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      if (functions.getFileTypeFromUrl(
                                              imagesviewItem) ==
                                          4)
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await launchURL(imagesviewItem);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/clarity_image-gallery-line-removebg-preview.png',
                                              width: 46.0,
                                              height: 41.0,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      if (functions.getFileTypeFromUrl(
                                              imagesviewItem) ==
                                          5)
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            await launchURL(imagesviewItem);
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                            child: Image.asset(
                                              'assets/images/download-removebg-preview.png',
                                              width: 46.0,
                                              height: 41.0,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                    ]
                                        .divide(SizedBox(width: 5.0))
                                        .around(SizedBox(width: 5.0)),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                        if (_model.isDataUploading_uploadDataRms ||
                            _model.isDataUploading_cameraupload)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset(
                              'assets/images/Animation_-_1735217758165.gif',
                              width: MediaQuery.sizeOf(context).width * 0.3,
                              height: MediaQuery.sizeOf(context).height * 0.2,
                              fit: BoxFit.contain,
                            ),
                          ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              10.0, 0.0, 10.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              FlutterFlowIconButton(
                                borderColor:
                                    FlutterFlowTheme.of(context).stroke,
                                borderRadius: 10.0,
                                borderWidth: 1.0,
                                buttonSize: 50.0,
                                icon: Icon(
                                  Icons.attach_file,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 18.0,
                                ),
                                onPressed: () async {
                                  safeSetState(() {
                                    _model.isDataUploading_uploadDataRms =
                                        false;
                                    _model.uploadedLocalFiles_uploadDataRms =
                                        [];
                                    _model.uploadedFileUrls_uploadDataRms = [];
                                  });

                                  final selectedFiles = await selectFiles(
                                    multiFile: true,
                                  );
                                  if (selectedFiles != null) {
                                    safeSetState(() => _model
                                        .isDataUploading_uploadDataRms = true);
                                    var selectedUploadedFiles =
                                        <FFUploadedFile>[];

                                    var downloadUrls = <String>[];
                                    try {
                                      showUploadMessage(
                                        context,
                                        'Uploading file...',
                                        showLoading: true,
                                      );
                                      selectedUploadedFiles = selectedFiles
                                          .map((m) => FFUploadedFile(
                                                name: m.storagePath
                                                    .split('/')
                                                    .last,
                                                bytes: m.bytes,
                                              ))
                                          .toList();

                                      downloadUrls = (await Future.wait(
                                        selectedFiles.map(
                                          (f) async => await uploadData(
                                              f.storagePath, f.bytes),
                                        ),
                                      ))
                                          .where((u) => u != null)
                                          .map((u) => u!)
                                          .toList();
                                    } finally {
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      _model.isDataUploading_uploadDataRms =
                                          false;
                                    }
                                    if (selectedUploadedFiles.length ==
                                            selectedFiles.length &&
                                        downloadUrls.length ==
                                            selectedFiles.length) {
                                      safeSetState(() {
                                        _model.uploadedLocalFiles_uploadDataRms =
                                            selectedUploadedFiles;
                                        _model.uploadedFileUrls_uploadDataRms =
                                            downloadUrls;
                                      });
                                      showUploadMessage(
                                        context,
                                        'Success!',
                                      );
                                    } else {
                                      safeSetState(() {});
                                      showUploadMessage(
                                        context,
                                        'Failed to upload file',
                                      );
                                      return;
                                    }
                                  }

                                  if (_model.uploadedFileUrls_uploadDataRms
                                          .length !=
                                      0) {
                                    if (functions.isValidFileFormatCopy(_model
                                        .uploadedFileUrls_uploadDataRms
                                        .toList())) {
                                      FFAppState().eventfiles = functions
                                          .combineImagePathsCopy(
                                              FFAppState().eventfiles.toList(),
                                              _model
                                                  .uploadedFileUrls_uploadDataRms
                                                  .toList())
                                          .toList()
                                          .cast<String>();
                                      safeSetState(() {});
                                    } else {
                                      await showDialog(
                                        context: context,
                                        builder: (alertDialogContext) {
                                          return AlertDialog(
                                            content: Text(
                                                'only pdf , docx , jpeg , png , jpg , mp3, ppt , pptx files are allowed '),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    alertDialogContext),
                                                child: Text('Ok'),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    }
                                  }
                                },
                              ),
                              FlutterFlowIconButton(
                                borderColor:
                                    FlutterFlowTheme.of(context).stroke,
                                borderRadius: 10.0,
                                borderWidth: 1.0,
                                buttonSize: 50.0,
                                icon: Icon(
                                  Icons.photo_camera_outlined,
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  size: 18.0,
                                ),
                                onPressed: () async {
                                  safeSetState(() {
                                    _model.isDataUploading_cameraupload = false;
                                    _model.uploadedLocalFile_cameraupload =
                                        FFUploadedFile(
                                            bytes: Uint8List.fromList([]));
                                    _model.uploadedFileUrl_cameraupload = '';
                                  });

                                  final selectedMedia = await selectMedia(
                                    imageQuality: 10,
                                    multiImage: false,
                                  );
                                  if (selectedMedia != null &&
                                      selectedMedia.every((m) =>
                                          validateFileFormat(
                                              m.storagePath, context))) {
                                    safeSetState(() => _model
                                        .isDataUploading_cameraupload = true);
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
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      _model.isDataUploading_cameraupload =
                                          false;
                                    }
                                    if (selectedUploadedFiles.length ==
                                            selectedMedia.length &&
                                        downloadUrls.length ==
                                            selectedMedia.length) {
                                      safeSetState(() {
                                        _model.uploadedLocalFile_cameraupload =
                                            selectedUploadedFiles.first;
                                        _model.uploadedFileUrl_cameraupload =
                                            downloadUrls.first;
                                      });
                                      showUploadMessage(context, 'Success!');
                                    } else {
                                      safeSetState(() {});
                                      showUploadMessage(
                                          context, 'Failed to upload data');
                                      return;
                                    }
                                  }

                                  if (_model.uploadedFileUrl_cameraupload !=
                                          '') {
                                    FFAppState().addToEventfiles(
                                        _model.uploadedFileUrl_cameraupload);
                                    safeSetState(() {});
                                  }
                                },
                              ),
                              Builder(
                                builder: (context) => FFButtonWidget(
                                  onPressed: () async {
                                    if (_model.formKey.currentState == null ||
                                        !_model.formKey.currentState!
                                            .validate()) {
                                      return;
                                    }

                                    await widget.school!.update({
                                      ...mapToFirestore(
                                        {
                                          'Calendar_list':
                                              getEventsNoticeListFirestoreData(
                                            functions.updateEvent(
                                                containerSchoolRecord.calendarList
                                                    .toList(),
                                                widget.eventid!,
                                                _model
                                                    .eventnameTextController.text,
                                                _model.descriptionTextController
                                                    .text,
                                                (FFAppState().eventfiles.length == 0
                                                        ? _model.images23
                                                        : functions
                                                            .combineImagePathsCopy(
                                                                _model.images23
                                                                    .toList(),
                                                                FFAppState()
                                                                    .eventfiles
                                                                    .toList()))
                                                    .toList(),
                                                _model.datePicked != null
                                                    ? _model.datePicked!
                                                    : containerSchoolRecord
                                                        .calendarList
                                                        .where((e) =>
                                                            e.eventId ==
                                                            widget.eventid)
                                                        .toList()
                                                        .firstOrNull!
                                                        .eventDate!,
                                                _model.eventname!,
                                                containerSchoolRecord
                                                    .calendarList
                                                    .where((e) =>
                                                        e.eventId == widget.eventid)
                                                    .toList()
                                                    .firstOrNull!
                                                    .classref
                                                    .toList()),
                                          ),
                                        },
                                      ),
                                    });
                                    while (FFAppState().loopmin <
                                        containerSchoolRecord
                                            .listOfClass.length) {
                                      _model.classref = await SchoolClassRecord
                                          .getDocumentOnce(containerSchoolRecord
                                              .listOfClass
                                              .elementAtOrNull(
                                                  FFAppState().loopmin)!);

                                      await _model.classref!.reference.update({
                                        ...mapToFirestore(
                                          {
                                            'calendar':
                                                getEventsNoticeListFirestoreData(
                                              functions.updateEvent(
                                                  _model.classref!.calendar
                                                      .toList(),
                                                  widget.eventid!,
                                                  _model.eventnameTextController
                                                      .text,
                                                  _model
                                                      .descriptionTextController
                                                      .text,
                                                  (FFAppState().eventfiles.length == 0
                                                          ? _model.images23
                                                          : functions
                                                              .combineImagePathsCopy(
                                                                  _model.images23
                                                                      .toList(),
                                                                  FFAppState()
                                                                      .eventfiles
                                                                      .toList()))
                                                      .toList(),
                                                  _model.datePicked != null
                                                      ? _model.datePicked!
                                                      : containerSchoolRecord
                                                          .calendarList
                                                          .where((e) =>
                                                              e.eventId ==
                                                              widget.eventid)
                                                          .toList()
                                                          .firstOrNull!
                                                          .eventDate!,
                                                  _model.eventname!,
                                                  containerSchoolRecord
                                                      .calendarList
                                                      .where((e) => e.eventId == widget.eventid)
                                                      .toList()
                                                      .firstOrNull!
                                                      .classref
                                                      .toList()),
                                            ),
                                          },
                                        ),
                                      });
                                      FFAppState().loopmin =
                                          FFAppState().loopmin + 1;
                                      safeSetState(() {});
                                    }
                                    FFAppState().loopmin = 0;
                                    safeSetState(() {});
                                    triggerPushNotification(
                                      notificationTitle:
                                          'The event has been edited.',
                                      notificationText:
                                          '${FFAppState().eventDetails.eventTitle} has been edited.',
                                      userRefs: containerSchoolRecord
                                          .listOfteachersuser
                                          .toList(),
                                      initialPageName: 'Notification_Teacher',
                                      parameterData: {
                                        'schoolref': widget.school,
                                      },
                                    );

                                    await NotificationsRecord.collection
                                        .doc()
                                        .set({
                                      ...createNotificationsRecordData(
                                        content:
                                            _model.eventnameTextController.text,
                                        descri: _model
                                            .descriptionTextController.text,
                                        datetimeofevent: _model.datePicked !=
                                                null
                                            ? _model.datePicked
                                            : containerSchoolRecord.calendarList
                                                .where((e) =>
                                                    e.eventId ==
                                                    widget.eventid)
                                                .toList()
                                                .firstOrNull
                                                ?.eventDate,
                                        isread: false,
                                        notification: updateNotificationStruct(
                                          NotificationStruct(
                                            notificationTitle: _model
                                                .eventnameTextController.text,
                                            descriptions: _model
                                                .descriptionTextController.text,
                                            timeStamp: getCurrentTimestamp,
                                            isRead: false,
                                            eventDate: _model.datePicked != null
                                                ? _model.datePicked
                                                : containerSchoolRecord
                                                    .calendarList
                                                    .where((e) =>
                                                        e.eventId ==
                                                        widget.eventid)
                                                    .toList()
                                                    .firstOrNull
                                                    ?.eventDate,
                                            schoolRef: widget.school,
                                            notificationFiles:
                                                functions.combineImagePathsCopy(
                                                    FFAppState()
                                                        .eventfiles
                                                        .toList(),
                                                    _model.images23.toList()),
                                          ),
                                          clearUnsetFields: false,
                                          create: true,
                                        ),
                                        createDate: getCurrentTimestamp,
                                        tag: _model.eventname,
                                        addedby: currentUserReference,
                                        heading: 'Edited a event',
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'userref': containerSchoolRecord
                                              .listOfteachersuser,
                                          'towhome': ['Everyone'],
                                        },
                                      ),
                                    });
                                    _model.students =
                                        await queryStudentsRecordOnce();
                                    triggerPushNotification(
                                      notificationTitle:
                                          'The event has been edited.',
                                      notificationText:
                                          '${FFAppState().eventDetails.eventTitle} has been edited.',
                                      userRefs: functions
                                          .extractParentUserRefs(_model
                                              .students!
                                              .where((e) =>
                                                  containerSchoolRecord
                                                      .listOfStudents
                                                      .contains(e.reference))
                                              .toList())
                                          .toList(),
                                      initialPageName: 'Notification_Teacher',
                                      parameterData: {
                                        'schoolref': widget.school,
                                      },
                                    );

                                    await NotificationsRecord.collection
                                        .doc()
                                        .set({
                                      ...createNotificationsRecordData(
                                        content:
                                            _model.eventnameTextController.text,
                                        descri: _model
                                            .descriptionTextController.text,
                                        datetimeofevent: _model.datePicked !=
                                                null
                                            ? _model.datePicked
                                            : containerSchoolRecord.calendarList
                                                .where((e) =>
                                                    e.eventId ==
                                                    widget.eventid)
                                                .toList()
                                                .firstOrNull
                                                ?.eventDate,
                                        isread: false,
                                        notification: updateNotificationStruct(
                                          NotificationStruct(
                                            notificationTitle: _model
                                                .eventnameTextController.text,
                                            descriptions: _model
                                                .descriptionTextController.text,
                                            timeStamp: getCurrentTimestamp,
                                            isRead: false,
                                            eventDate: _model.datePicked != null
                                                ? _model.datePicked
                                                : containerSchoolRecord
                                                    .calendarList
                                                    .where((e) =>
                                                        e.eventId ==
                                                        widget.eventid)
                                                    .toList()
                                                    .firstOrNull
                                                    ?.eventDate,
                                            schoolRef: widget.school,
                                            notificationFiles:
                                                functions.combineImagePathsCopy(
                                                    FFAppState()
                                                        .eventfiles
                                                        .toList(),
                                                    _model.images23.toList()),
                                          ),
                                          clearUnsetFields: false,
                                          create: true,
                                        ),
                                        createDate: getCurrentTimestamp,
                                        tag: _model.eventname,
                                        addedby: currentUserReference,
                                        heading: 'Edited a event',
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'userref': functions
                                              .extractParentUserRefs(_model
                                                  .students!
                                                  .where((e) =>
                                                      containerSchoolRecord
                                                          .listOfStudents
                                                          .contains(
                                                              e.reference))
                                                  .toList()),
                                          'towhome': ['Everyone'],
                                          'schoolref': [widget.school],
                                        },
                                      ),
                                    });
                                    FFAppState().eventfiles = [];
                                    FFAppState().loopmin = 0;
                                    safeSetState(() {});
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: AlignmentDirectional(
                                                  0.0, -0.8)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.08,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.6,
                                            child: EventeditedWidget(),
                                          ),
                                        );
                                      },
                                    );

                                    context.pushNamed(
                                      ClassDashboardWidget.routeName,
                                      queryParameters: {
                                        'schoolref': serializeParam(
                                          widget.school,
                                          ParamType.DocumentReference,
                                        ),
                                        'tabindex': serializeParam(
                                          2,
                                          ParamType.int,
                                        ),
                                      }.withoutNulls,
                                    );

                                    safeSetState(() {});
                                  },
                                  text: 'Save event',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.55,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.055,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16.0, 0.0, 16.0, 0.0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0.0, 0.0, 0.0, 0.0),
                                    color:
                                        FlutterFlowTheme.of(context).secondary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          font: GoogleFonts.nunito(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .titleSmall
                                                  .fontStyle,
                                        ),
                                    elevation: 0.0,
                                    borderSide: BorderSide(
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
