import '/admin_dashboard/edit_delete_notice/edit_delete_notice_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/empty_widget.dart';
import '/confirmationpages/eventpostedsuccessfully/eventpostedsuccessfully_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/shimmer_effects/main_dashboard_shimmer/main_dashboard_shimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_calender_details_model.dart';
export 'add_calender_details_model.dart';

class AddCalenderDetailsWidget extends StatefulWidget {
  const AddCalenderDetailsWidget({
    super.key,
    required this.selectedDate,
    this.schoolclassref,
    required this.tabindex,
    required this.classname,
    bool? classpage,
  }) : this.classpage = classpage ?? false;

  final DateTime? selectedDate;
  final DocumentReference? schoolclassref;
  final int? tabindex;
  final String? classname;
  final bool classpage;

  static String routeName = 'add_calender_details';
  static String routePath = '/addCalenderDetails';

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
      FFAppState().eventfiles = [];
      safeSetState(() {});
      _model.calendarDate = widget.selectedDate;
      _model.addToClassref(widget.schoolclassref!);
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
    context.watch<FFAppState>();

    return StreamBuilder<SchoolClassRecord>(
      stream: SchoolClassRecord.getDocument(widget.schoolclassref!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: MainDashboardShimmerWidget(),
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
            appBar: responsiveVisibility(
              context: context,
              tablet: false,
              tabletLandscape: false,
              desktop: false,
            )
                ? AppBar(
                    backgroundColor: FlutterFlowTheme.of(context).info,
                    automaticallyImplyLeading: false,
                    leading: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      icon: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).alternate,
                        size: 28.0,
                      ),
                      onPressed: () async {
                        if ((_model.eventnameTextController.text != '') ||
                            (_model.descriptionNoticeTextController.text !=
                                    '')) {
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    content: Text(
                                        ' Are you sure you want to leave?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, false),
                                        child: Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(
                                            alertDialogContext, true),
                                        child: Text('Confirm'),
                                      ),
                                    ],
                                  );
                                },
                              ) ??
                              false;
                          if (confirmDialogResponse) {
                            context.pop();
                          }
                        } else {
                          context.pop();
                        }
                      },
                    ),
                    title: Text(
                      '${addCalenderDetailsSchoolClassRecord.className} - Events',
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                font: GoogleFonts.nunito(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.bold,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                    ),
                    actions: [],
                    centerTitle: false,
                    elevation: 2.0,
                  )
                : null,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if ((functions
                                .isDatePassed(_model.calendarDate!) ==
                            false) &&
                        (valueOrDefault(currentUserDocument?.userRole, 0) !=
                            4) &&
                        (valueOrDefault(currentUserDocument?.userRole, 0) != 1))
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: Color(0xFFF2F2F2),
                                width: 1.0,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        'New Event',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              font: GoogleFonts.nunito(
                                                fontWeight: FontWeight.w600,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color: Color(0xFF222B45),
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.w600,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
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
                                      final _datePickedDate =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: (widget.selectedDate ??
                                            DateTime.now()),
                                        firstDate: DateTime(1900),
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
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .fontStyle,
                                                      ),
                                                      fontSize: 32.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
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
                                                FlutterFlowTheme.of(context)
                                                    .info,
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
                                          _model.datePicked =
                                              widget.selectedDate;
                                        });
                                      }
                                      if (_model.datePicked != null) {
                                        _model.calendarDate = _model.datePicked;
                                        safeSetState(() {});
                                      } else {
                                        _model.calendarDate =
                                            _model.calendarDate;
                                        safeSetState(() {});
                                      }
                                    },
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          FFIcons.kvector2x,
                                          color: Color(0xFFD6E1FA),
                                          size: 24.0,
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(0.0, 0.0),
                                          child: Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 10.0, 0.0),
                                            child: Text(
                                              dateTimeFormat("dd MMM y",
                                                  _model.calendarDate),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .text2,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                          child: Image.asset(
                                            'assets/images/mynaui_edit.png',
                                            width: 30.0,
                                            height: 30.0,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.9,
                                      decoration: BoxDecoration(),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.eventName = 'Event';
                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .event,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.59),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .eventborder,
                                                    width:
                                                        valueOrDefault<double>(
                                                      _model.eventName ==
                                                              'Event'
                                                          ? 3.0
                                                          : 1.0,
                                                      2.0,
                                                    ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/typcn--flash-removebg-preview.png',
                                                        width: 15.5,
                                                        height: 15.5,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      Text(
                                                        'Event',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .eventtext,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            width: 5.0))
                                                        .around(SizedBox(
                                                            width: 5.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.eventName = 'Holiday';
                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .holiday,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.59),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .holidayborder,
                                                    width:
                                                        valueOrDefault<double>(
                                                      _model.eventName ==
                                                              'Holiday'
                                                          ? 3.0
                                                          : 1.0,
                                                      2.0,
                                                    ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/fxemoji--confetti-removebg-preview.png',
                                                        width: 15.5,
                                                        height: 15.5,
                                                        fit: BoxFit.contain,
                                                      ),
                                                      Text(
                                                        'Holiday',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .holidaytext,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            width: 5.0))
                                                        .around(SizedBox(
                                                            width: 5.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                _model.eventName = 'Birthday';
                                                safeSetState(() {});
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .birthdayfill,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.59),
                                                  border: Border.all(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .birthdayborder,
                                                    width:
                                                        valueOrDefault<double>(
                                                      _model.eventName ==
                                                              'Birthday'
                                                          ? 3.0
                                                          : 1.0,
                                                      2.0,
                                                    ),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Image.asset(
                                                        'assets/images/noto--birthday-cake-removebg-preview.png',
                                                        width: 15.5,
                                                        height: 15.5,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      Text(
                                                        'Birthday',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .birthdaytext,
                                                                  fontSize:
                                                                      14.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                    ]
                                                        .divide(SizedBox(
                                                            width: 5.0))
                                                        .around(SizedBox(
                                                            width: 5.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ].divide(SizedBox(width: 10.0)),
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
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 10.0),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.9,
                                            child: TextFormField(
                                              controller: _model
                                                  .eventnameTextController,
                                              focusNode:
                                                  _model.eventnameFocusNode,
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelText: 'Event\'s name *',
                                                labelStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleLarge
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontStyle,
                                                      ),
                                                      color: (_model
                                                                  .eventnameFocusNode
                                                                  ?.hasFocus ??
                                                              false)
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primary
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .textfieldText,
                                                      fontSize: (_model
                                                                  .eventnameFocusNode
                                                                  ?.hasFocus ??
                                                              false)
                                                          ? 12.0
                                                          : 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontStyle,
                                                    ),
                                                hintText: 'Event\'s name',
                                                hintStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleLarge
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .textfieldText,
                                                      fontSize: 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontStyle,
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .textfieldDisable,
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
                                                        .primary,
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
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .text2,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
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
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 10.0),
                                          child: Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.9,
                                            child: TextFormField(
                                              controller: _model
                                                  .descriptionNoticeTextController,
                                              focusNode: _model
                                                  .descriptionNoticeFocusNode,
                                              onFieldSubmitted: (_) async {
                                                _model.last = true;
                                                safeSetState(() {});
                                              },
                                              autofocus: false,
                                              obscureText: false,
                                              decoration: InputDecoration(
                                                isDense: true,
                                                labelText: 'Description ',
                                                labelStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleLarge
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontStyle,
                                                      ),
                                                      color: (_model
                                                                  .descriptionNoticeFocusNode
                                                                  ?.hasFocus ??
                                                              false)
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primary
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .textfieldText,
                                                      fontSize: (_model
                                                                  .descriptionNoticeFocusNode
                                                                  ?.hasFocus ??
                                                              false)
                                                          ? 12.0
                                                          : 16.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontStyle,
                                                    ),
                                                hintText: 'Description',
                                                hintStyle: FlutterFlowTheme.of(
                                                        context)
                                                    .titleLarge
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleLarge
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .textfieldText,
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleLarge
                                                              .fontStyle,
                                                    ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .textfieldDisable,
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
                                                        .primary,
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
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .text2,
                                                    letterSpacing: 0.0,
                                                    fontWeight:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontWeight,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                              maxLines: 3,
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
                                  if (FFAppState().eventfiles.isNotEmpty)
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 0.0, 10.0),
                                      child: Builder(
                                        builder: (context) {
                                          final imagesview =
                                              FFAppState().eventfiles.toList();

                                          return SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              children: List.generate(
                                                  imagesview.length,
                                                  (imagesviewIndex) {
                                                final imagesviewItem =
                                                    imagesview[imagesviewIndex];
                                                return Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    if (functions
                                                            .getFileTypeFromUrl(
                                                                imagesviewItem) ==
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
                                                              imagesviewItem);
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.asset(
                                                            'assets/images/download.png',
                                                            width: 46.0,
                                                            height: 41.0,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    if (functions
                                                            .getFileTypeFromUrl(
                                                                imagesviewItem) ==
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
                                                              imagesviewItem);
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.asset(
                                                            'assets/images/download_(1).png',
                                                            width: 46.0,
                                                            height: 41.0,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    if (functions
                                                            .getFileTypeFromUrl(
                                                                imagesviewItem) ==
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
                                                              imagesviewItem);
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.asset(
                                                            'assets/images/download_(2).png',
                                                            width: 46.0,
                                                            height: 41.0,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    if (functions
                                                            .getFileTypeFromUrl(
                                                                imagesviewItem) ==
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
                                                              imagesviewItem);
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.asset(
                                                            'assets/images/clarity_image-gallery-line.png',
                                                            width: 46.0,
                                                            height: 41.0,
                                                            fit: BoxFit.contain,
                                                          ),
                                                        ),
                                                      ),
                                                    if (functions
                                                            .getFileTypeFromUrl(
                                                                imagesviewItem) ==
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
                                                              imagesviewItem);
                                                        },
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
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
                                                      .divide(
                                                          SizedBox(width: 5.0))
                                                      .around(
                                                          SizedBox(width: 5.0)),
                                                );
                                              }),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FlutterFlowIconButton(
                                        borderColor:
                                            FlutterFlowTheme.of(context).stroke,
                                        borderRadius: 10.0,
                                        borderWidth: 1.0,
                                        buttonSize: 50.0,
                                        icon: Icon(
                                          Icons.attach_file,
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryText,
                                          size: 18.0,
                                        ),
                                        showLoadingIndicator: true,
                                        onPressed: () async {
                                          safeSetState(() {
                                            _model.isDataUploading_uploadData4us =
                                                false;
                                            _model.uploadedLocalFiles_uploadData4us =
                                                [];
                                            _model.uploadedFileUrls_uploadData4us =
                                                [];
                                          });

                                          final selectedFiles =
                                              await selectFiles(
                                            multiFile: true,
                                          );
                                          if (selectedFiles != null) {
                                            safeSetState(() => _model
                                                    .isDataUploading_uploadData4us =
                                                true);
                                            var selectedUploadedFiles =
                                                <FFUploadedFile>[];

                                            var downloadUrls = <String>[];
                                            try {
                                              selectedUploadedFiles =
                                                  selectedFiles
                                                      .map(
                                                          (m) => FFUploadedFile(
                                                                name: m
                                                                    .storagePath
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
                                              _model.isDataUploading_uploadData4us =
                                                  false;
                                            }
                                            if (selectedUploadedFiles.length ==
                                                    selectedFiles.length &&
                                                downloadUrls.length ==
                                                    selectedFiles.length) {
                                              safeSetState(() {
                                                _model.uploadedLocalFiles_uploadData4us =
                                                    selectedUploadedFiles;
                                                _model.uploadedFileUrls_uploadData4us =
                                                    downloadUrls;
                                              });
                                            } else {
                                              safeSetState(() {});
                                              return;
                                            }
                                          }

                                          if (functions.isValidFileFormatCopy(
                                              _model
                                                  .uploadedFileUrls_uploadData4us
                                                  .toList())) {
                                            FFAppState().eventfiles = functions
                                                .combineImagePathsCopy(
                                                    FFAppState()
                                                        .eventfiles
                                                        .toList(),
                                                    _model
                                                        .uploadedFileUrls_uploadData4us
                                                        .toList())
                                                .toList()
                                                .cast<String>();
                                            safeSetState(() {});
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  'only pdf , docx , jpeg , png , jpg , mp3, ppt , pptx files are allowed ',
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                  ),
                                                ),
                                                duration: Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryText,
                                              ),
                                            );
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
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryText,
                                          size: 18.0,
                                        ),
                                        showLoadingIndicator: true,
                                        onPressed: () async {
                                          safeSetState(() {
                                            _model.isDataUploading_uploadData123 =
                                                false;
                                            _model.uploadedLocalFile_uploadData123 =
                                                FFUploadedFile(
                                                    bytes:
                                                        Uint8List.fromList([]));
                                            _model.uploadedFileUrl_uploadData123 =
                                                '';
                                          });

                                          final selectedMedia =
                                              await selectMedia(
                                            imageQuality: 10,
                                            multiImage: false,
                                          );
                                          if (selectedMedia != null &&
                                              selectedMedia.every((m) =>
                                                  validateFileFormat(
                                                      m.storagePath,
                                                      context))) {
                                            safeSetState(() => _model
                                                    .isDataUploading_uploadData123 =
                                                true);
                                            var selectedUploadedFiles =
                                                <FFUploadedFile>[];

                                            var downloadUrls = <String>[];
                                            try {
                                              selectedUploadedFiles =
                                                  selectedMedia
                                                      .map(
                                                          (m) => FFUploadedFile(
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
                                              _model.isDataUploading_uploadData123 =
                                                  false;
                                            }
                                            if (selectedUploadedFiles.length ==
                                                    selectedMedia.length &&
                                                downloadUrls.length ==
                                                    selectedMedia.length) {
                                              safeSetState(() {
                                                _model.uploadedLocalFile_uploadData123 =
                                                    selectedUploadedFiles.first;
                                                _model.uploadedFileUrl_uploadData123 =
                                                    downloadUrls.first;
                                              });
                                            } else {
                                              safeSetState(() {});
                                              return;
                                            }
                                          }

                                          if (_model.uploadedFileUrl_uploadData123 !=
                                                  '') {
                                            FFAppState().addToEventfiles(_model
                                                .uploadedFileUrl_uploadData123);
                                            safeSetState(() {});
                                          }
                                        },
                                      ),
                                      Builder(
                                        builder: (context) => FFButtonWidget(
                                          onPressed: () async {
                                            _model.id =
                                                functions.generateUniqueId();
                                            safeSetState(() {});
                                            if (valueOrDefault(
                                                    currentUserDocument
                                                        ?.userRole,
                                                    0) ==
                                                3) {
                                              if ((dateTimeFormat(
                                                          "yMMMd",
                                                          currentUserDocument
                                                              ?.checkin) !=
                                                      dateTimeFormat("yMMMd",
                                                          getCurrentTimestamp)) ||
                                                  (currentUserDocument
                                                          ?.checkin ==
                                                      null)) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      'Please CheckIn ',
                                                      style: TextStyle(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                              } else {
                                                if (_model.eventName != '') {
                                                  if (_model.formKey
                                                              .currentState ==
                                                          null ||
                                                      !_model
                                                          .formKey.currentState!
                                                          .validate()) {
                                                    return;
                                                  }
                                                  triggerPushNotification(
                                                    notificationTitle:
                                                        _model.eventName,
                                                    notificationText: _model
                                                        .eventnameTextController
                                                        .text,
                                                    notificationSound:
                                                        'default',
                                                    userRefs:
                                                        addCalenderDetailsSchoolClassRecord
                                                            .listOfteachersUser
                                                            .toList(),
                                                    initialPageName:
                                                        'Class_view',
                                                    parameterData: {
                                                      'schoolclassref': widget
                                                          .schoolclassref,
                                                      'datePick':
                                                          getCurrentTimestamp,
                                                    },
                                                  );

                                                  await NotificationsRecord
                                                      .collection
                                                      .doc()
                                                      .set({
                                                    ...createNotificationsRecordData(
                                                      content: _model
                                                          .eventnameTextController
                                                          .text,
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
                                                          eventDate: _model
                                                              .calendarDate,
                                                          notificationFiles:
                                                              FFAppState()
                                                                  .eventfiles,
                                                        ),
                                                        clearUnsetFields: false,
                                                        create: true,
                                                      ),
                                                      createDate:
                                                          getCurrentTimestamp,
                                                      tag: _model.eventName,
                                                      addedby:
                                                          currentUserReference,
                                                      heading: 'Added a event',
                                                    ),
                                                    ...mapToFirestore(
                                                      {
                                                        'userref':
                                                            addCalenderDetailsSchoolClassRecord
                                                                .listOfteachersUser,
                                                        'towhome': [
                                                          addCalenderDetailsSchoolClassRecord
                                                              .className
                                                        ],
                                                      },
                                                    ),
                                                  });
                                                  _model.useref =
                                                      NotificationUSerefStruct(
                                                    noticeUsref:
                                                        addCalenderDetailsSchoolClassRecord
                                                            .listOfteachersUser,
                                                  );
                                                  safeSetState(() {});
                                                  _model.students1 =
                                                      await queryStudentsRecordOnce();
                                                  triggerPushNotification(
                                                    notificationTitle:
                                                        _model.eventName,
                                                    notificationText: _model
                                                        .eventnameTextController
                                                        .text,
                                                    notificationSound:
                                                        'default',
                                                    userRefs: functions
                                                        .extractParentUserRefs(_model
                                                            .students1!
                                                            .where((e) =>
                                                                addCalenderDetailsSchoolClassRecord
                                                                    .studentsList
                                                                    .contains(e
                                                                        .reference))
                                                            .toList())
                                                        .toList(),
                                                    initialPageName:
                                                        'Dashboard',
                                                    parameterData: {},
                                                  );
                                                  _model.school123566 =
                                                      await querySchoolRecordOnce(
                                                    queryBuilder:
                                                        (schoolRecord) =>
                                                            schoolRecord.where(
                                                      'List_of_class',
                                                      arrayContains: widget
                                                          .schoolclassref,
                                                    ),
                                                    singleRecord: true,
                                                  ).then((s) => s.firstOrNull);
                                                  if (functions.isWithin30Days(
                                                      getCurrentTimestamp,
                                                      _model.calendarDate!)!) {
                                                    var notificationsRecordReference2 =
                                                        NotificationsRecord
                                                            .collection
                                                            .doc();
                                                    await notificationsRecordReference2
                                                        .set({
                                                      ...createNotificationsRecordData(
                                                        content: _model
                                                            .eventnameTextController
                                                            .text,
                                                        descri: _model
                                                            .descriptionNoticeTextController
                                                            .text,
                                                        datetimeofevent: widget
                                                            .selectedDate,
                                                        notification:
                                                            updateNotificationStruct(
                                                          NotificationStruct(
                                                            notificationTitle:
                                                                _model
                                                                    .eventnameTextController
                                                                    .text,
                                                            descriptions: _model
                                                                .descriptionNoticeTextController
                                                                .text,
                                                            timeStamp:
                                                                getCurrentTimestamp,
                                                            isRead: false,
                                                            eventDate: _model
                                                                .calendarDate,
                                                            notificationFiles:
                                                                FFAppState()
                                                                    .eventfiles,
                                                          ),
                                                          clearUnsetFields:
                                                              false,
                                                          create: true,
                                                        ),
                                                        isread: false,
                                                        createDate:
                                                            getCurrentTimestamp,
                                                        tag: _model.eventName,
                                                        addedby:
                                                            currentUserReference,
                                                        heading:
                                                            'Added a event',
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'userref': functions
                                                              .extractParentUserRefs(_model
                                                                  .students1!
                                                                  .where((e) => addCalenderDetailsSchoolClassRecord
                                                                      .studentsList
                                                                      .contains(
                                                                          e.reference))
                                                                  .toList()),
                                                          'towhome': [
                                                            addCalenderDetailsSchoolClassRecord
                                                                .className
                                                          ],
                                                        },
                                                      ),
                                                    });
                                                    _model.studentsk =
                                                        NotificationsRecord
                                                            .getDocumentFromData({
                                                      ...createNotificationsRecordData(
                                                        content: _model
                                                            .eventnameTextController
                                                            .text,
                                                        descri: _model
                                                            .descriptionNoticeTextController
                                                            .text,
                                                        datetimeofevent: widget
                                                            .selectedDate,
                                                        notification:
                                                            updateNotificationStruct(
                                                          NotificationStruct(
                                                            notificationTitle:
                                                                _model
                                                                    .eventnameTextController
                                                                    .text,
                                                            descriptions: _model
                                                                .descriptionNoticeTextController
                                                                .text,
                                                            timeStamp:
                                                                getCurrentTimestamp,
                                                            isRead: false,
                                                            eventDate: _model
                                                                .calendarDate,
                                                            notificationFiles:
                                                                FFAppState()
                                                                    .eventfiles,
                                                          ),
                                                          clearUnsetFields:
                                                              false,
                                                          create: true,
                                                        ),
                                                        isread: false,
                                                        createDate:
                                                            getCurrentTimestamp,
                                                        tag: _model.eventName,
                                                        addedby:
                                                            currentUserReference,
                                                        heading:
                                                            'Added a event',
                                                      ),
                                                      ...mapToFirestore(
                                                        {
                                                          'userref': functions
                                                              .extractParentUserRefs(_model
                                                                  .students1!
                                                                  .where((e) => addCalenderDetailsSchoolClassRecord
                                                                      .studentsList
                                                                      .contains(
                                                                          e.reference))
                                                                  .toList()),
                                                          'towhome': [
                                                            addCalenderDetailsSchoolClassRecord
                                                                .className
                                                          ],
                                                        },
                                                      ),
                                                    }, notificationsRecordReference2);
                                                  }

                                                  await addCalenderDetailsSchoolClassRecord
                                                      .reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'calendar': FieldValue
                                                            .arrayUnion([
                                                          getEventsNoticeFirestoreData(
                                                            createEventsNoticeStruct(
                                                              eventId:
                                                                  _model.id,
                                                              eventName: _model
                                                                  .eventName,
                                                              eventTitle: _model
                                                                  .eventnameTextController
                                                                  .text,
                                                              eventDescription:
                                                                  _model
                                                                      .descriptionNoticeTextController
                                                                      .text,
                                                              eventDate: _model
                                                                  .calendarDate,
                                                              fieldValues: {
                                                                'classref': _model
                                                                    .classref,
                                                                'eventfiles':
                                                                    FFAppState()
                                                                        .eventfiles,
                                                              },
                                                              clearUnsetFields:
                                                                  false,
                                                            ),
                                                            true,
                                                          )
                                                        ]),
                                                      },
                                                    ),
                                                  });

                                                  await _model.school!.reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'Calendar_list':
                                                            FieldValue
                                                                .arrayUnion([
                                                          getEventsNoticeFirestoreData(
                                                            createEventsNoticeStruct(
                                                              eventId:
                                                                  _model.id,
                                                              eventName: _model
                                                                  .eventName,
                                                              eventTitle: _model
                                                                  .eventnameTextController
                                                                  .text,
                                                              eventDescription:
                                                                  _model
                                                                      .descriptionNoticeTextController
                                                                      .text,
                                                              eventDate: _model
                                                                  .calendarDate,
                                                              fieldValues: {
                                                                'eventfiles':
                                                                    FFAppState()
                                                                        .eventfiles,
                                                                'classref': _model
                                                                    .classref,
                                                              },
                                                              clearUnsetFields:
                                                                  false,
                                                            ),
                                                            true,
                                                          )
                                                        ]),
                                                      },
                                                    ),
                                                  });
                                                  FFAppState().eventfiles = [];
                                                  FFAppState().update(() {});
                                                  if (widget.tabindex == 2) {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: AlignmentDirectional(
                                                                  0.0, -0.8)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
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
                                                            child: Container(
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.08,
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.6,
                                                              child:
                                                                  EventpostedsuccessfullyWidget(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );

                                                    context.goNamed(
                                                      ClassDashboardWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'schoolref':
                                                            serializeParam(
                                                          _model.school123566
                                                              ?.reference,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                        'tabindex':
                                                            serializeParam(
                                                          2,
                                                          ParamType.int,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  } else {
                                                    await showDialog(
                                                      context: context,
                                                      builder: (dialogContext) {
                                                        return Dialog(
                                                          elevation: 0,
                                                          insetPadding:
                                                              EdgeInsets.zero,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          alignment: AlignmentDirectional(
                                                                  0.0, -0.8)
                                                              .resolve(
                                                                  Directionality.of(
                                                                      context)),
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
                                                            child: Container(
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .height *
                                                                  0.08,
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.6,
                                                              child:
                                                                  EventpostedsuccessfullyWidget(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );

                                                    if (Navigator.of(context)
                                                        .canPop()) {
                                                      context.pop();
                                                    }
                                                    context.pushNamed(
                                                      CalenderClassWidget
                                                          .routeName,
                                                      queryParameters: {
                                                        'schoolclassref':
                                                            serializeParam(
                                                          widget
                                                              .schoolclassref,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                        'mainpage':
                                                            serializeParam(
                                                          false,
                                                          ParamType.bool,
                                                        ),
                                                        'studentpage':
                                                            serializeParam(
                                                          false,
                                                          ParamType.bool,
                                                        ),
                                                        'schoolref':
                                                            serializeParam(
                                                          _model.schoolref,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                      }.withoutNulls,
                                                    );
                                                  }
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Please select name of the event ',
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
                                                }
                                              }
                                            } else {
                                              if (_model.eventName != '') {
                                                if (_model.formKey
                                                            .currentState ==
                                                        null ||
                                                    !_model
                                                        .formKey.currentState!
                                                        .validate()) {
                                                  return;
                                                }
                                                triggerPushNotification(
                                                  notificationTitle:
                                                      _model.eventName,
                                                  notificationText: _model
                                                      .eventnameTextController
                                                      .text,
                                                  notificationSound: 'default',
                                                  userRefs:
                                                      addCalenderDetailsSchoolClassRecord
                                                          .listOfteachersUser
                                                          .toList(),
                                                  initialPageName: 'Class_view',
                                                  parameterData: {
                                                    'schoolclassref':
                                                        widget.schoolclassref,
                                                    'datePick':
                                                        getCurrentTimestamp,
                                                  },
                                                );

                                                await NotificationsRecord
                                                    .collection
                                                    .doc()
                                                    .set({
                                                  ...createNotificationsRecordData(
                                                    content: _model
                                                        .eventnameTextController
                                                        .text,
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
                                                        notificationFiles:
                                                            FFAppState()
                                                                .eventfiles,
                                                      ),
                                                      clearUnsetFields: false,
                                                      create: true,
                                                    ),
                                                    createDate:
                                                        getCurrentTimestamp,
                                                    tag: _model.eventName,
                                                    addedby:
                                                        currentUserReference,
                                                    heading: 'Added a event',
                                                  ),
                                                  ...mapToFirestore(
                                                    {
                                                      'userref':
                                                          addCalenderDetailsSchoolClassRecord
                                                              .listOfteachersUser,
                                                      'towhome': [
                                                        addCalenderDetailsSchoolClassRecord
                                                            .className
                                                      ],
                                                    },
                                                  ),
                                                });
                                                _model.useref =
                                                    NotificationUSerefStruct(
                                                  noticeUsref:
                                                      addCalenderDetailsSchoolClassRecord
                                                          .listOfteachersUser,
                                                );
                                                safeSetState(() {});
                                                _model.students =
                                                    await queryStudentsRecordOnce();
                                                triggerPushNotification(
                                                  notificationTitle:
                                                      _model.eventName,
                                                  notificationText: _model
                                                      .eventnameTextController
                                                      .text,
                                                  notificationSound: 'default',
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
                                                if (functions.isWithin30Days(
                                                    getCurrentTimestamp,
                                                    _model.calendarDate!)!) {
                                                  await NotificationsRecord
                                                      .collection
                                                      .doc()
                                                      .set({
                                                    ...createNotificationsRecordData(
                                                      content: _model
                                                          .eventnameTextController
                                                          .text,
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
                                                          eventDate: _model
                                                              .calendarDate,
                                                          notificationFiles:
                                                              FFAppState()
                                                                  .eventfiles,
                                                        ),
                                                        clearUnsetFields: false,
                                                        create: true,
                                                      ),
                                                      isread: false,
                                                      createDate:
                                                          getCurrentTimestamp,
                                                      tag: _model.eventName,
                                                      addedby:
                                                          currentUserReference,
                                                      heading: 'Added a event',
                                                    ),
                                                    ...mapToFirestore(
                                                      {
                                                        'userref': functions
                                                            .extractParentUserRefs(_model
                                                                .students!
                                                                .where((e) => addCalenderDetailsSchoolClassRecord
                                                                    .studentsList
                                                                    .contains(e
                                                                        .reference))
                                                                .toList()),
                                                        'towhome': [
                                                          addCalenderDetailsSchoolClassRecord
                                                              .className
                                                        ],
                                                      },
                                                    ),
                                                  });
                                                }
                                                _model.school12356 =
                                                    await querySchoolRecordOnce(
                                                  queryBuilder:
                                                      (schoolRecord) =>
                                                          schoolRecord.where(
                                                    'List_of_class',
                                                    arrayContains:
                                                        widget.schoolclassref,
                                                  ),
                                                  singleRecord: true,
                                                ).then((s) => s.firstOrNull);

                                                await addCalenderDetailsSchoolClassRecord
                                                    .reference
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'calendar': FieldValue
                                                          .arrayUnion([
                                                        getEventsNoticeFirestoreData(
                                                          createEventsNoticeStruct(
                                                            eventId: _model.id,
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
                                                            fieldValues: {
                                                              'classref': _model
                                                                  .classref,
                                                              'eventfiles':
                                                                  FFAppState()
                                                                      .eventfiles,
                                                            },
                                                            clearUnsetFields:
                                                                false,
                                                          ),
                                                          true,
                                                        )
                                                      ]),
                                                    },
                                                  ),
                                                });

                                                await _model.school!.reference
                                                    .update({
                                                  ...mapToFirestore(
                                                    {
                                                      'Calendar_list':
                                                          FieldValue
                                                              .arrayUnion([
                                                        getEventsNoticeFirestoreData(
                                                          createEventsNoticeStruct(
                                                            eventId: _model.id,
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
                                                            fieldValues: {
                                                              'eventfiles':
                                                                  FFAppState()
                                                                      .eventfiles,
                                                              'classref': _model
                                                                  .classref,
                                                            },
                                                            clearUnsetFields:
                                                                false,
                                                          ),
                                                          true,
                                                        )
                                                      ]),
                                                    },
                                                  ),
                                                });
                                                FFAppState().eventfiles = [];
                                                FFAppState().update(() {});
                                                if (widget.tabindex == 2) {
                                                  await showDialog(
                                                    context: context,
                                                    builder: (dialogContext) {
                                                      return Dialog(
                                                        elevation: 0,
                                                        insetPadding:
                                                            EdgeInsets.zero,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        alignment:
                                                            AlignmentDirectional(
                                                                    0.0, -0.8)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    dialogContext)
                                                                .unfocus();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child: Container(
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.08,
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.6,
                                                            child:
                                                                EventpostedsuccessfullyWidget(),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );

                                                  context.goNamed(
                                                    ClassDashboardWidget
                                                        .routeName,
                                                    queryParameters: {
                                                      'schoolref':
                                                          serializeParam(
                                                        _model.school12356
                                                            ?.reference,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                      'tabindex':
                                                          serializeParam(
                                                        2,
                                                        ParamType.int,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                } else {
                                                  await showDialog(
                                                    context: context,
                                                    builder: (dialogContext) {
                                                      return Dialog(
                                                        elevation: 0,
                                                        insetPadding:
                                                            EdgeInsets.zero,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        alignment:
                                                            AlignmentDirectional(
                                                                    0.0, -0.8)
                                                                .resolve(
                                                                    Directionality.of(
                                                                        context)),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            FocusScope.of(
                                                                    dialogContext)
                                                                .unfocus();
                                                            FocusManager
                                                                .instance
                                                                .primaryFocus
                                                                ?.unfocus();
                                                          },
                                                          child: Container(
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.08,
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.6,
                                                            child:
                                                                EventpostedsuccessfullyWidget(),
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );

                                                  if (Navigator.of(context)
                                                      .canPop()) {
                                                    context.pop();
                                                  }
                                                  context.pushNamed(
                                                    CalenderClassWidget
                                                        .routeName,
                                                    queryParameters: {
                                                      'schoolclassref':
                                                          serializeParam(
                                                        widget.schoolclassref,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                      'mainpage':
                                                          serializeParam(
                                                        false,
                                                        ParamType.bool,
                                                      ),
                                                      'studentpage':
                                                          serializeParam(
                                                        false,
                                                        ParamType.bool,
                                                      ),
                                                      'schoolref':
                                                          serializeParam(
                                                        _model.schoolref,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                }
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
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .secondary,
                                                  ),
                                                );
                                              }
                                            }

                                            safeSetState(() {});
                                          },
                                          text: 'Create Event',
                                          options: FFButtonOptions(
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.55,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.055,
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondaryBackground,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .fontStyle,
                                                      ),
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .fontStyle,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                              width: 1.0,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ]
                                    .divide(SizedBox(height: 10.0))
                                    .addToEnd(SizedBox(height: 5.0)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: Builder(
                        builder: (context) {
                          final calendarlist =
                              addCalenderDetailsSchoolClassRecord.calendar
                                  .where(
                                      (e) => e.eventDate == _model.calendarDate)
                                  .toList()
                                  .sortedList(
                                      keyOf: (e) => dateTimeFormat(
                                          "relative", e.eventDate!),
                                      desc: false)
                                  .toList();
                          if (calendarlist.isEmpty) {
                            return Center(
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: MediaQuery.sizeOf(context).height * 0.4,
                                child: EmptyWidget(),
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: EdgeInsets.fromLTRB(
                              0,
                              0,
                              0,
                              20.0,
                            ),
                            primary: false,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: calendarlist.length,
                            itemBuilder: (context, calendarlistIndex) {
                              final calendarlistItem =
                                  calendarlist[calendarlistIndex];
                              return Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 10.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      EventDetailsWidget.routeName,
                                      queryParameters: {
                                        'eventDetails': serializeParam(
                                          calendarlistItem,
                                          ParamType.DataStruct,
                                        ),
                                        'classRef': serializeParam(
                                          addCalenderDetailsSchoolClassRecord
                                              .className,
                                          ParamType.String,
                                        ),
                                      }.withoutNulls,
                                    );
                                  },
                                  child: Material(
                                    color: Colors.transparent,
                                    elevation: 2.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 20.0,
                                            color: Color(0x08000000),
                                            offset: Offset(
                                              0.0,
                                              0.0,
                                            ),
                                            spreadRadius: 0.0,
                                          )
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 10.0, 10.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 5.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    10.0,
                                                                    0.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.35,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                          ),
                                                          child: Text(
                                                            calendarlistItem
                                                                .eventTitle,
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                                  color: Color(
                                                                      0xFF151E28),
                                                                  fontSize:
                                                                      16.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    5.0),
                                                        child: Text(
                                                          dateTimeFormat(
                                                              "dd MMM y",
                                                              calendarlistItem
                                                                  .eventDate!),
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
                                                                fontSize: 14.0,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    10.0,
                                                                    0.0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: () {
                                                              if (calendarlistItem
                                                                      .eventName ==
                                                                  'Event') {
                                                                return FlutterFlowTheme.of(
                                                                        context)
                                                                    .event;
                                                              } else if (calendarlistItem
                                                                      .eventName ==
                                                                  'Birthday') {
                                                                return FlutterFlowTheme.of(
                                                                        context)
                                                                    .birthdayfill;
                                                              } else {
                                                                return FlutterFlowTheme.of(
                                                                        context)
                                                                    .holiday;
                                                              }
                                                            }(),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        3.59),
                                                            border: Border.all(
                                                              color: () {
                                                                if (calendarlistItem
                                                                        .eventName ==
                                                                    'Event') {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .eventborder;
                                                                } else if (calendarlistItem
                                                                        .eventName ==
                                                                    'Birthday') {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .birthdayborder;
                                                                } else {
                                                                  return FlutterFlowTheme.of(
                                                                          context)
                                                                      .holidayborder;
                                                                }
                                                              }(),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.0),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                if (calendarlistItem
                                                                        .eventName ==
                                                                    'Event')
                                                                  Image.asset(
                                                                    'assets/images/typcn--flash-removebg-preview.png',
                                                                    width: 15.5,
                                                                    height:
                                                                        15.5,
                                                                    fit: BoxFit
                                                                        .contain,
                                                                  ),
                                                                if (calendarlistItem
                                                                        .eventName ==
                                                                    'Holiday')
                                                                  Image.asset(
                                                                    'assets/images/fxemoji--confetti-removebg-preview.png',
                                                                    width: 15.5,
                                                                    height:
                                                                        15.5,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                if (calendarlistItem
                                                                        .eventName ==
                                                                    'Birthday')
                                                                  Image.asset(
                                                                    'assets/images/noto--birthday-cake-removebg-preview.png',
                                                                    width: 15.5,
                                                                    height:
                                                                        15.5,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    calendarlistItem
                                                                        .eventName,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.inter(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              () {
                                                                            if (calendarlistItem.eventName ==
                                                                                'Event') {
                                                                              return FlutterFlowTheme.of(context).eventtext;
                                                                            } else if (calendarlistItem.eventName ==
                                                                                'Holiday') {
                                                                              return FlutterFlowTheme.of(context).holidaytext;
                                                                            } else {
                                                                              return FlutterFlowTheme.of(context).birthdaytext;
                                                                            }
                                                                          }(),
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ]
                                                                  .divide(SizedBox(
                                                                      width:
                                                                          5.0))
                                                                  .around(SizedBox(
                                                                      width:
                                                                          5.0)),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if (!functions.isDatePassed(
                                                              calendarlistItem
                                                                  .eventDate!) &&
                                                          (dateTimeFormat(
                                                                  "yMMMd",
                                                                  calendarlistItem
                                                                      .eventDate) !=
                                                              dateTimeFormat(
                                                                  "yMMMd",
                                                                  getCurrentTimestamp)) &&
                                                          (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.userRole,
                                                                  0) !=
                                                              4) &&
                                                          (valueOrDefault(
                                                                  currentUserDocument
                                                                      ?.userRole,
                                                                  0) !=
                                                              1))
                                                        Builder(
                                                          builder: (context) =>
                                                              AuthUserStreamWidget(
                                                            builder: (context) =>
                                                                FlutterFlowIconButton(
                                                              borderRadius:
                                                                  20.0,
                                                              borderWidth: 1.0,
                                                              buttonSize: 40.0,
                                                              icon: Icon(
                                                                Icons.more_vert,
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                size: 20.0,
                                                              ),
                                                              onPressed:
                                                                  () async {
                                                                if (calendarlistItem
                                                                        .eventfiles
                                                                        .length ==
                                                                    0) {
                                                                  await showAlignedDialog(
                                                                    context:
                                                                        context,
                                                                    isGlobal:
                                                                        false,
                                                                    avoidOverflow:
                                                                        false,
                                                                    targetAnchor: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    followerAnchor: AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    builder:
                                                                        (dialogContext) {
                                                                      return Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            FocusScope.of(dialogContext).unfocus();
                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 0.12,
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.45,
                                                                            child:
                                                                                EditDeleteNoticeWidget(
                                                                              classref: addCalenderDetailsSchoolClassRecord.reference,
                                                                              eventid: calendarlistItem.eventId,
                                                                              classEvent: true,
                                                                              event: EventsNoticeStruct(
                                                                                eventId: calendarlistItem.eventId,
                                                                                eventName: calendarlistItem.eventName,
                                                                                eventTitle: calendarlistItem.eventTitle,
                                                                                eventDescription: calendarlistItem.eventDescription,
                                                                                eventDate: calendarlistItem.eventDate,
                                                                                classref: calendarlistItem.classref,
                                                                              ),
                                                                              noticebool: false,
                                                                              schoolref: _model.schoolref!,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      );
                                                                    },
                                                                  );
                                                                } else {
                                                                  await showAlignedDialog(
                                                                    context:
                                                                        context,
                                                                    isGlobal:
                                                                        false,
                                                                    avoidOverflow:
                                                                        false,
                                                                    targetAnchor: AlignmentDirectional(
                                                                            0.0,
                                                                            0.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    followerAnchor: AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    builder:
                                                                        (dialogContext) {
                                                                      return Material(
                                                                        color: Colors
                                                                            .transparent,
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            FocusScope.of(dialogContext).unfocus();
                                                                            FocusManager.instance.primaryFocus?.unfocus();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 0.12,
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.45,
                                                                            child:
                                                                                EditDeleteNoticeWidget(
                                                                              classref: addCalenderDetailsSchoolClassRecord.reference,
                                                                              eventid: calendarlistItem.eventId,
                                                                              classEvent: true,
                                                                              noticebool: false,
                                                                              eventImage: EventsNoticeStruct(
                                                                                eventId: calendarlistItem.eventId,
                                                                                eventName: calendarlistItem.eventName,
                                                                                eventTitle: calendarlistItem.eventTitle,
                                                                                eventDescription: calendarlistItem.eventDescription,
                                                                                eventDate: calendarlistItem.eventDate,
                                                                                eventfiles: calendarlistItem.eventfiles,
                                                                              ),
                                                                              schoolref: _model.schoolref!,
                                                                              event: EventsNoticeStruct(
                                                                                eventId: calendarlistItem.eventId,
                                                                                eventName: calendarlistItem.eventName,
                                                                                eventTitle: calendarlistItem.eventTitle,
                                                                                eventDescription: calendarlistItem.eventDescription,
                                                                                eventDate: calendarlistItem.eventDate,
                                                                                eventfiles: calendarlistItem.eventfiles,
                                                                                classref: _model.classref,
                                                                              ),
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
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.85,
                                              decoration: BoxDecoration(),
                                              child: Text(
                                                calendarlistItem
                                                    .eventDescription,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontWeight,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color: Color(0xFF363F49),
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontWeight,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 0.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  if (calendarlistItem
                                                          .eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              1)
                                                          .toList()
                                                          .length !=
                                                      0)
                                                    badges.Badge(
                                                      badgeContent: Text(
                                                        calendarlistItem
                                                            .eventfiles
                                                            .where((e) =>
                                                                functions
                                                                    .getFileTypeFromUrl(
                                                                        e) ==
                                                                1)
                                                            .toList()
                                                            .length
                                                            .toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      showBadge: true,
                                                      shape: badges
                                                          .BadgeShape.circle,
                                                      badgeColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      elevation: 5.0,
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      position:
                                                          badges.BadgePosition
                                                              .topEnd(),
                                                      animationType: badges
                                                          .BadgeAnimationType
                                                          .scale,
                                                      toAnimate: true,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/download.png',
                                                          width: 46.0,
                                                          height: 41.0,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  if (calendarlistItem
                                                          .eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              2)
                                                          .toList()
                                                          .length !=
                                                      0)
                                                    badges.Badge(
                                                      badgeContent: Text(
                                                        calendarlistItem
                                                            .eventfiles
                                                            .where((e) =>
                                                                functions
                                                                    .getFileTypeFromUrl(
                                                                        e) ==
                                                                2)
                                                            .toList()
                                                            .length
                                                            .toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      showBadge: true,
                                                      shape: badges
                                                          .BadgeShape.circle,
                                                      badgeColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      elevation: 0.0,
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      position:
                                                          badges.BadgePosition
                                                              .topEnd(),
                                                      animationType: badges
                                                          .BadgeAnimationType
                                                          .scale,
                                                      toAnimate: true,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/download_(1).png',
                                                          width: 46.0,
                                                          height: 41.0,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  if (calendarlistItem
                                                          .eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              3)
                                                          .toList()
                                                          .length !=
                                                      0)
                                                    badges.Badge(
                                                      badgeContent: Text(
                                                        calendarlistItem
                                                            .eventfiles
                                                            .where((e) =>
                                                                functions
                                                                    .getFileTypeFromUrl(
                                                                        e) ==
                                                                3)
                                                            .toList()
                                                            .length
                                                            .toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      showBadge: true,
                                                      shape: badges
                                                          .BadgeShape.circle,
                                                      badgeColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      elevation: 0.0,
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      position:
                                                          badges.BadgePosition
                                                              .topEnd(),
                                                      animationType: badges
                                                          .BadgeAnimationType
                                                          .scale,
                                                      toAnimate: true,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/download_(2).png',
                                                          width: 46.0,
                                                          height: 41.0,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  if (calendarlistItem
                                                          .eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              4)
                                                          .toList()
                                                          .length !=
                                                      0)
                                                    badges.Badge(
                                                      badgeContent: Text(
                                                        calendarlistItem
                                                            .eventfiles
                                                            .where((e) =>
                                                                functions
                                                                    .getFileTypeFromUrl(
                                                                        e) ==
                                                                4)
                                                            .toList()
                                                            .length
                                                            .toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      showBadge: true,
                                                      shape: badges
                                                          .BadgeShape.circle,
                                                      badgeColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      elevation: 0.0,
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      position:
                                                          badges.BadgePosition
                                                              .topEnd(),
                                                      animationType: badges
                                                          .BadgeAnimationType
                                                          .scale,
                                                      toAnimate: true,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/clarity_image-gallery-line.png',
                                                          width: 46.0,
                                                          height: 41.0,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  if (calendarlistItem
                                                          .eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              5)
                                                          .toList()
                                                          .length !=
                                                      0)
                                                    badges.Badge(
                                                      badgeContent: Text(
                                                        calendarlistItem
                                                            .eventfiles
                                                            .where((e) =>
                                                                functions
                                                                    .getFileTypeFromUrl(
                                                                        e) ==
                                                                5)
                                                            .toList()
                                                            .length
                                                            .toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      showBadge: true,
                                                      shape: badges
                                                          .BadgeShape.circle,
                                                      badgeColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      elevation: 0.0,
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      position:
                                                          badges.BadgePosition
                                                              .topEnd(),
                                                      animationType: badges
                                                          .BadgeAnimationType
                                                          .scale,
                                                      toAnimate: true,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/download-removebg-preview.png',
                                                          width: 46.0,
                                                          height: 41.0,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                ]
                                                    .divide(
                                                        SizedBox(width: 18.0))
                                                    .around(
                                                        SizedBox(width: 18.0)),
                                              ),
                                            ),
                                          ].addToEnd(SizedBox(height: 10.0)),
                                        ),
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
