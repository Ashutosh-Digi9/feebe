import '/admin_dashboard/edit_delete_school/edit_delete_school_widget.dart';
import '/admin_dashboard/select_class_calender/select_class_calender_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/components/empty_widget.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_events_details_model.dart';
export 'add_events_details_model.dart';

class AddEventsDetailsWidget extends StatefulWidget {
  const AddEventsDetailsWidget({
    super.key,
    required this.selectedDate,
    this.schoolRef,
  });

  final DateTime? selectedDate;
  final DocumentReference? schoolRef;

  static String routeName = 'add_events_details';
  static String routePath = '/addEventsDetails';

  @override
  State<AddEventsDetailsWidget> createState() => _AddEventsDetailsWidgetState();
}

class _AddEventsDetailsWidgetState extends State<AddEventsDetailsWidget> {
  late AddEventsDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddEventsDetailsModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.calendarDate = widget.selectedDate;
      safeSetState(() {});
      FFAppState().eventfiles = [];
      safeSetState(() {});
    });

    _model.titleNoticeTextController ??= TextEditingController();
    _model.titleNoticeFocusNode ??= FocusNode();

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

    return StreamBuilder<SchoolRecord>(
      stream: SchoolRecord.getDocument(widget.schoolRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: MainDashboardShimmerWidget(),
          );
        }

        final addEventsDetailsSchoolRecord = snapshot.data!;

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
                        color: FlutterFlowTheme.of(context).bgColor1,
                        size: 28.0,
                      ),
                      onPressed: () async {
                        if ((_model.titleNoticeTextController.text != '') ||
                            (_model.descriptionNoticeTextController.text !=
                                    '')) {
                          var confirmDialogResponse = await showDialog<bool>(
                                context: context,
                                builder: (alertDialogContext) {
                                  return AlertDialog(
                                    title:
                                        Text('Are you sure you want to leave?'),
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
                            context.safePop();
                          }
                        } else {
                          context.safePop();
                        }
                      },
                    ),
                    title: Text(
                      'Add Event ',
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
                    elevation: 0.0,
                  )
                : null,
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (!functions.isDatePassed(_model.calendarDate!) &&
                        (valueOrDefault(currentUserDocument?.userRole, 0) != 1))
                      Padding(
                        padding: EdgeInsets.all(12.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => Material(
                            color: Colors.transparent,
                            elevation: 0.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(10.0),
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
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
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
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 5.0, 0.0, 0.0),
                                      child: InkWell(
                                        splashColor: Colors.transparent,
                                        focusColor: Colors.transparent,
                                        hoverColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onTap: () async {
                                          final _datePickedDate =
                                              await showDatePicker(
                                            context: context,
                                            initialDate:
                                                (widget.selectedDate ??
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
                                                          font: GoogleFonts
                                                              .nunito(
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
                                          } else if (_model.datePicked !=
                                              null) {
                                            safeSetState(() {
                                              _model.datePicked =
                                                  widget.selectedDate;
                                            });
                                          }
                                          if (_model.datePicked == null) {
                                            _model.calendarDate =
                                                _model.calendarDate;
                                            safeSetState(() {});
                                          } else {
                                            _model.calendarDate =
                                                _model.datePicked;
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
                                              alignment: AlignmentDirectional(
                                                  0.0, 0.0),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        10.0, 0.0, 10.0, 0.0),
                                                child: Text(
                                                  dateTimeFormat("dd MMM y",
                                                      _model.calendarDate),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
                                                          fontWeight:
                                                              FontWeight.normal,
                                                          fontStyle:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontStyle,
                                                        ),
                                                        color:
                                                            FlutterFlowTheme.of(
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
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
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
                                    ),
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.9,
                                        decoration: BoxDecoration(),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 10.0, 0.0, 10.0),
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .eventborder,
                                                      width: valueOrDefault<
                                                          double>(
                                                        _model.eventName ==
                                                                'Event'
                                                            ? 3.0
                                                            : 1.0,
                                                        2.0,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/typcn--flash-removebg-preview.png',
                                                          width: 15.5,
                                                          height: 15.5,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Text(
                                                          'Event',
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
                                                                    .eventtext,
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
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .holidayborder,
                                                      width: valueOrDefault<
                                                          double>(
                                                        _model.eventName ==
                                                                'Holiday'
                                                            ? 3.0
                                                            : 1.0,
                                                        2.0,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/fxemoji--confetti-removebg-preview.png',
                                                          width: 15.5,
                                                          height: 15.5,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Text(
                                                          'Holiday',
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
                                                                    .holidaytext,
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
                                                            5.0),
                                                    border: Border.all(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .birthdayborder,
                                                      width: valueOrDefault<
                                                          double>(
                                                        _model.eventName ==
                                                                'Birthday'
                                                            ? 3.0
                                                            : 1.0,
                                                        2.0,
                                                      ),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Image.asset(
                                                          'assets/images/noto--birthday-cake-removebg-preview.png',
                                                          width: 15.5,
                                                          height: 15.5,
                                                          fit: BoxFit.cover,
                                                        ),
                                                        Text(
                                                          'Birthday',
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
                                                                    .birthdaytext,
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
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      child: Align(
                                        alignment:
                                            AlignmentDirectional(-1.0, -1.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 10.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.9,
                                                child: TextFormField(
                                                  controller: _model
                                                      .titleNoticeTextController,
                                                  focusNode: _model
                                                      .titleNoticeFocusNode,
                                                  autofocus: false,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .sentences,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    labelText:
                                                        'Event\'s name *',
                                                    labelStyle:
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
                                                              color: (_model.titleNoticeFocusNode
                                                                          ?.hasFocus ??
                                                                      false)
                                                                  ? FlutterFlowTheme.of(
                                                                          context)
                                                                      .primary
                                                                  : FlutterFlowTheme.of(
                                                                          context)
                                                                      .textfieldText,
                                                              fontSize: (_model
                                                                          .titleNoticeFocusNode
                                                                          ?.hasFocus ??
                                                                      false)
                                                                  ? 12.0
                                                                  : 16.0,
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                            ),
                                                    hintText: 'Event\'s name',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                        color: FlutterFlowTheme
                                                                .of(context)
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .text2,
                                                        fontSize: 16.0,
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
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  validator: _model
                                                      .titleNoticeTextControllerValidator
                                                      .asValidator(context),
                                                  inputFormatters: [
                                                    if (!isAndroid && !isiOS)
                                                      TextInputFormatter
                                                          .withFunction(
                                                              (oldValue,
                                                                  newValue) {
                                                        return TextEditingValue(
                                                          selection: newValue
                                                              .selection,
                                                          text: newValue.text
                                                              .toCapitalization(
                                                                  TextCapitalization
                                                                      .sentences),
                                                        );
                                                      }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 0.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.9,
                                                child: TextFormField(
                                                  controller: _model
                                                      .descriptionNoticeTextController,
                                                  focusNode: _model
                                                      .descriptionNoticeFocusNode,
                                                  autofocus: false,
                                                  textCapitalization:
                                                      TextCapitalization
                                                          .sentences,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    labelText: 'Description ',
                                                    labelStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .titleLarge
                                                            .override(
                                                              font: GoogleFonts
                                                                  .nunito(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .fontStyle,
                                                              ),
                                                              color: (_model.descriptionNoticeFocusNode
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
                                                              letterSpacing:
                                                                  0.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal,
                                                              fontStyle:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleLarge
                                                                      .fontStyle,
                                                            ),
                                                    hintText: 'Description',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleLarge
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleLarge
                                                                    .fontStyle,
                                                          ),
                                                          color: FlutterFlowTheme
                                                                  .of(context)
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
                                                        color: FlutterFlowTheme
                                                                .of(context)
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .text2,
                                                        fontSize: 16.0,
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
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  validator: _model
                                                      .descriptionNoticeTextControllerValidator
                                                      .asValidator(context),
                                                  inputFormatters: [
                                                    if (!isAndroid && !isiOS)
                                                      TextInputFormatter
                                                          .withFunction(
                                                              (oldValue,
                                                                  newValue) {
                                                        return TextEditingValue(
                                                          selection: newValue
                                                              .selection,
                                                          text: newValue.text
                                                              .toCapitalization(
                                                                  TextCapitalization
                                                                      .sentences),
                                                        );
                                                      }),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: BoxDecoration(),
                                      child: Visibility(
                                        visible:
                                            FFAppState().eventfiles.isNotEmpty,
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 10.0),
                                          child: Builder(
                                            builder: (context) {
                                              final imagesview = FFAppState()
                                                  .eventfiles
                                                  .toList();

                                              return SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: List.generate(
                                                      imagesview.length,
                                                      (imagesviewIndex) {
                                                    final imagesviewItem =
                                                        imagesview[
                                                            imagesviewIndex];
                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        if (functions
                                                                .getFileTypeFromUrl(
                                                                    imagesviewItem) ==
                                                            1)
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await launchURL(
                                                                  imagesviewItem);
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/download.png',
                                                                width: 46.0,
                                                                height: 41.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                        if (functions
                                                                .getFileTypeFromUrl(
                                                                    imagesviewItem) ==
                                                            2)
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await launchURL(
                                                                  imagesviewItem);
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/download_(1).png',
                                                                width: 46.0,
                                                                height: 41.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                        if (functions
                                                                .getFileTypeFromUrl(
                                                                    imagesviewItem) ==
                                                            3)
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await launchURL(
                                                                  imagesviewItem);
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/download_(2).png',
                                                                width: 46.0,
                                                                height: 41.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                        if (functions
                                                                .getFileTypeFromUrl(
                                                                    imagesviewItem) ==
                                                            4)
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await launchURL(
                                                                  imagesviewItem);
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/clarity_image-gallery-line.png',
                                                                width: 46.0,
                                                                height: 41.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                        if (functions
                                                                .getFileTypeFromUrl(
                                                                    imagesviewItem) ==
                                                            5)
                                                          InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await launchURL(
                                                                  imagesviewItem);
                                                            },
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/download-removebg-preview.png',
                                                                width: 46.0,
                                                                height: 41.0,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                            ),
                                                          ),
                                                      ]
                                                          .divide(SizedBox(
                                                              width: 5.0))
                                                          .around(SizedBox(
                                                              width: 5.0)),
                                                    );
                                                  }),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 5.0, 0.0, 5.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          FlutterFlowIconButton(
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .stroke,
                                            borderRadius: 10.0,
                                            borderWidth: 1.0,
                                            buttonSize: 50.0,
                                            icon: Icon(
                                              Icons.attach_file,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryText,
                                              size: 18.0,
                                            ),
                                            showLoadingIndicator: true,
                                            onPressed: () async {
                                              safeSetState(() {
                                                _model.isDataUploading_uploadData1qw =
                                                    false;
                                                _model.uploadedLocalFiles_uploadData1qw =
                                                    [];
                                                _model.uploadedFileUrls_uploadData1qw =
                                                    [];
                                              });

                                              final selectedFiles =
                                                  await selectFiles(
                                                multiFile: true,
                                              );
                                              if (selectedFiles != null) {
                                                safeSetState(() => _model
                                                        .isDataUploading_uploadData1qw =
                                                    true);
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];

                                                var downloadUrls = <String>[];
                                                try {
                                                  selectedUploadedFiles =
                                                      selectedFiles
                                                          .map((m) =>
                                                              FFUploadedFile(
                                                                name: m
                                                                    .storagePath
                                                                    .split('/')
                                                                    .last,
                                                                bytes: m.bytes,
                                                              ))
                                                          .toList();

                                                  downloadUrls =
                                                      (await Future.wait(
                                                    selectedFiles.map(
                                                      (f) async =>
                                                          await uploadData(
                                                              f.storagePath,
                                                              f.bytes),
                                                    ),
                                                  ))
                                                          .where(
                                                              (u) => u != null)
                                                          .map((u) => u!)
                                                          .toList();
                                                } finally {
                                                  _model.isDataUploading_uploadData1qw =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                            .length ==
                                                        selectedFiles.length &&
                                                    downloadUrls.length ==
                                                        selectedFiles.length) {
                                                  safeSetState(() {
                                                    _model.uploadedLocalFiles_uploadData1qw =
                                                        selectedUploadedFiles;
                                                    _model.uploadedFileUrls_uploadData1qw =
                                                        downloadUrls;
                                                  });
                                                } else {
                                                  safeSetState(() {});
                                                  return;
                                                }
                                              }

                                              if (functions
                                                  .isValidFileFormatCopy(_model
                                                      .uploadedFileUrls_uploadData1qw
                                                      .toList())) {
                                                FFAppState().eventfiles = functions
                                                    .combineImagePathsCopy(
                                                        FFAppState()
                                                            .eventfiles
                                                            .toList(),
                                                        _model
                                                            .uploadedFileUrls_uploadData1qw
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
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                      ),
                                                    ),
                                                    duration: Duration(
                                                        milliseconds: 4000),
                                                    backgroundColor:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                  ),
                                                );
                                              }
                                            },
                                          ),
                                          FlutterFlowIconButton(
                                            borderColor:
                                                FlutterFlowTheme.of(context)
                                                    .stroke,
                                            borderRadius: 10.0,
                                            borderWidth: 1.0,
                                            buttonSize: 50.0,
                                            icon: Icon(
                                              Icons.photo_camera_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryText,
                                              size: 18.0,
                                            ),
                                            showLoadingIndicator: true,
                                            onPressed: () async {
                                              safeSetState(() {
                                                _model.isDataUploading_uploadcamera =
                                                    false;
                                                _model.uploadedLocalFile_uploadcamera =
                                                    FFUploadedFile(
                                                        bytes:
                                                            Uint8List.fromList(
                                                                []));
                                                _model.uploadedFileUrl_uploadcamera =
                                                    '';
                                              });

                                              final selectedMedia =
                                                  await selectMedia(
                                                multiImage: false,
                                              );
                                              if (selectedMedia != null &&
                                                  selectedMedia.every((m) =>
                                                      validateFileFormat(
                                                          m.storagePath,
                                                          context))) {
                                                safeSetState(() => _model
                                                        .isDataUploading_uploadcamera =
                                                    true);
                                                var selectedUploadedFiles =
                                                    <FFUploadedFile>[];

                                                var downloadUrls = <String>[];
                                                try {
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
                                                          .where(
                                                              (u) => u != null)
                                                          .map((u) => u!)
                                                          .toList();
                                                } finally {
                                                  _model.isDataUploading_uploadcamera =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                            .length ==
                                                        selectedMedia.length &&
                                                    downloadUrls.length ==
                                                        selectedMedia.length) {
                                                  safeSetState(() {
                                                    _model.uploadedLocalFile_uploadcamera =
                                                        selectedUploadedFiles
                                                            .first;
                                                    _model.uploadedFileUrl_uploadcamera =
                                                        downloadUrls.first;
                                                  });
                                                } else {
                                                  safeSetState(() {});
                                                  return;
                                                }
                                              }

                                              if (_model.uploadedFileUrl_uploadcamera !=
                                                      '') {
                                                FFAppState().addToEventfiles(_model
                                                    .uploadedFileUrl_uploadcamera);
                                                safeSetState(() {});
                                              }
                                            },
                                          ),
                                          FFButtonWidget(
                                            onPressed:
                                                (addEventsDetailsSchoolRecord
                                                            .listOfStudents
                                                            .length ==
                                                        0)
                                                    ? null
                                                    : () async {
                                                        if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.userRole,
                                                                0) ==
                                                            2) {
                                                          if (_model.formKey
                                                                      .currentState ==
                                                                  null ||
                                                              !_model.formKey
                                                                  .currentState!
                                                                  .validate()) {
                                                            return;
                                                          }
                                                          if (_model.eventName !=
                                                                  '') {
                                                            FFAppState()
                                                                    .eventDetails =
                                                                EventsNoticeStruct(
                                                              eventId: functions
                                                                  .generateUniqueId(),
                                                              eventTitle: _model
                                                                  .titleNoticeTextController
                                                                  .text,
                                                              eventDescription:
                                                                  _model
                                                                      .descriptionNoticeTextController
                                                                      .text,
                                                              eventDate: _model
                                                                  .calendarDate,
                                                              eventName: _model
                                                                  .eventName,
                                                              eventfiles:
                                                                  FFAppState()
                                                                      .eventfiles,
                                                            );
                                                            safeSetState(() {});
                                                            if (FFAppState()
                                                                    .eventfiles
                                                                    .length ==
                                                                0) {
                                                              safeSetState(() {
                                                                _model
                                                                    .titleNoticeTextController
                                                                    ?.clear();
                                                                _model
                                                                    .descriptionNoticeTextController
                                                                    ?.clear();
                                                              });
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                isDismissible:
                                                                    false,
                                                                enableDrag:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus();
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          Container(
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.75,
                                                                        child:
                                                                            SelectClassCalenderWidget(
                                                                          schoolref:
                                                                              widget.schoolRef!,
                                                                          eventtitle: FFAppState()
                                                                              .eventDetails
                                                                              .eventTitle,
                                                                          eventname: FFAppState()
                                                                              .eventDetails
                                                                              .eventName,
                                                                          description: FFAppState()
                                                                              .eventDetails
                                                                              .eventDescription,
                                                                          datetime: FFAppState()
                                                                              .eventDetails
                                                                              .eventDate!,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));
                                                            } else {
                                                              safeSetState(() {
                                                                _model
                                                                    .titleNoticeTextController
                                                                    ?.clear();
                                                                _model
                                                                    .descriptionNoticeTextController
                                                                    ?.clear();
                                                              });
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                isDismissible:
                                                                    false,
                                                                enableDrag:
                                                                    false,
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return GestureDetector(
                                                                    onTap: () {
                                                                      FocusScope.of(
                                                                              context)
                                                                          .unfocus();
                                                                      FocusManager
                                                                          .instance
                                                                          .primaryFocus
                                                                          ?.unfocus();
                                                                    },
                                                                    child:
                                                                        Padding(
                                                                      padding: MediaQuery
                                                                          .viewInsetsOf(
                                                                              context),
                                                                      child:
                                                                          Container(
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.75,
                                                                        child:
                                                                            SelectClassCalenderWidget(
                                                                          schoolref:
                                                                              widget.schoolRef!,
                                                                          eventtitle: FFAppState()
                                                                              .eventDetails
                                                                              .eventTitle,
                                                                          eventname: FFAppState()
                                                                              .eventDetails
                                                                              .eventName,
                                                                          description: FFAppState()
                                                                              .eventDetails
                                                                              .eventDescription,
                                                                          datetime: FFAppState()
                                                                              .eventDetails
                                                                              .eventDate!,
                                                                          files:
                                                                              FFAppState().eventfiles,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));
                                                            }
                                                          } else {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Make sure you select event name ',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                              ),
                                                            );
                                                          }
                                                        } else if (valueOrDefault(
                                                                currentUserDocument
                                                                    ?.userRole,
                                                                0) ==
                                                            3) {
                                                          if ((dateTimeFormat(
                                                                      "yMMMd",
                                                                      currentUserDocument
                                                                          ?.checkin) !=
                                                                  dateTimeFormat(
                                                                      "yMMMd",
                                                                      getCurrentTimestamp)) ||
                                                              (currentUserDocument
                                                                      ?.checkin ==
                                                                  null)) {
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  'Please check in',
                                                                  style:
                                                                      TextStyle(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryText,
                                                                  ),
                                                                ),
                                                                duration: Duration(
                                                                    milliseconds:
                                                                        4000),
                                                                backgroundColor:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondary,
                                                              ),
                                                            );
                                                          } else {
                                                            if (_model.formKey
                                                                        .currentState ==
                                                                    null ||
                                                                !_model.formKey
                                                                    .currentState!
                                                                    .validate()) {
                                                              return;
                                                            }
                                                            if (_model.eventName !=
                                                                    '') {
                                                              FFAppState()
                                                                      .eventDetails =
                                                                  EventsNoticeStruct(
                                                                eventId: functions
                                                                    .generateUniqueId(),
                                                                eventTitle: _model
                                                                    .titleNoticeTextController
                                                                    .text,
                                                                eventDescription:
                                                                    _model
                                                                        .descriptionNoticeTextController
                                                                        .text,
                                                                eventDate: _model
                                                                    .calendarDate,
                                                                eventName: _model
                                                                    .eventName,
                                                                eventfiles:
                                                                    FFAppState()
                                                                        .eventfiles,
                                                              );
                                                              safeSetState(
                                                                  () {});
                                                              if (FFAppState()
                                                                      .eventfiles
                                                                      .length ==
                                                                  0) {
                                                                safeSetState(
                                                                    () {
                                                                  _model
                                                                      .titleNoticeTextController
                                                                      ?.clear();
                                                                  _model
                                                                      .descriptionNoticeTextController
                                                                      ?.clear();
                                                                });
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  isDismissible:
                                                                      false,
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.75,
                                                                          child:
                                                                              SelectClassCalenderWidget(
                                                                            schoolref:
                                                                                widget.schoolRef!,
                                                                            eventtitle:
                                                                                FFAppState().eventDetails.eventTitle,
                                                                            eventname:
                                                                                FFAppState().eventDetails.eventName,
                                                                            description:
                                                                                FFAppState().eventDetails.eventDescription,
                                                                            datetime:
                                                                                FFAppState().eventDetails.eventDate!,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(
                                                                        () {}));
                                                              } else {
                                                                safeSetState(
                                                                    () {
                                                                  _model
                                                                      .titleNoticeTextController
                                                                      ?.clear();
                                                                  _model
                                                                      .descriptionNoticeTextController
                                                                      ?.clear();
                                                                });
                                                                await showModalBottomSheet(
                                                                  isScrollControlled:
                                                                      true,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .transparent,
                                                                  isDismissible:
                                                                      false,
                                                                  enableDrag:
                                                                      false,
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) {
                                                                    return GestureDetector(
                                                                      onTap:
                                                                          () {
                                                                        FocusScope.of(context)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            MediaQuery.viewInsetsOf(context),
                                                                        child:
                                                                            Container(
                                                                          height:
                                                                              MediaQuery.sizeOf(context).height * 0.75,
                                                                          child:
                                                                              SelectClassCalenderWidget(
                                                                            schoolref:
                                                                                widget.schoolRef!,
                                                                            eventtitle:
                                                                                FFAppState().eventDetails.eventTitle,
                                                                            eventname:
                                                                                FFAppState().eventDetails.eventName,
                                                                            description:
                                                                                FFAppState().eventDetails.eventDescription,
                                                                            datetime:
                                                                                FFAppState().eventDetails.eventDate!,
                                                                            files:
                                                                                FFAppState().eventfiles,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                ).then((value) =>
                                                                    safeSetState(
                                                                        () {}));
                                                              }
                                                            } else {
                                                              ScaffoldMessenger
                                                                      .of(context)
                                                                  .showSnackBar(
                                                                SnackBar(
                                                                  content: Text(
                                                                    'Make sure you select event name ',
                                                                    style:
                                                                        TextStyle(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText,
                                                                    ),
                                                                  ),
                                                                  duration: Duration(
                                                                      milliseconds:
                                                                          4000),
                                                                  backgroundColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                ),
                                                              );
                                                            }
                                                          }
                                                        }
                                                      },
                                            text: 'Create Event',
                                            options: FFButtonOptions(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.55,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.055,
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
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
                                                    color: FlutterFlowTheme.of(
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
                                                color: valueOrDefault<Color>(
                                                  addEventsDetailsSchoolRecord
                                                              .listOfStudents
                                                              .length ==
                                                          0
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .secondary
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .primary,
                                                  FlutterFlowTheme.of(context)
                                                      .primary,
                                                ),
                                                width: 1.0,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              disabledColor:
                                                  FlutterFlowTheme.of(context)
                                                      .dIsable,
                                              disabledTextColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ]
                                      .divide(SizedBox(height: 10.0))
                                      .addToEnd(SizedBox(height: 5.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
                      child: Builder(
                        builder: (context) {
                          final calendarlist = addEventsDetailsSchoolRecord
                              .calendarList
                              .where((e) => e.eventDate == _model.calendarDate)
                              .toList()
                              .sortedList(
                                  keyOf: (e) =>
                                      dateTimeFormat("relative", e.eventDate!),
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
                                        border: Border.all(
                                          color: Color(0xFFDDF1F6),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            10.0, 10.0, 10.0, 10.0),
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
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.39,
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
                                                                font:
                                                                    GoogleFonts
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
                                                                fontSize: 16.0,
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
                                                      Text(
                                                        dateTimeFormat(
                                                            "dd MMM y",
                                                            calendarlistItem
                                                                .eventDate!),
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
                                                                      .tertiaryText,
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
                                                                      .spaceBetween,
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
                                                    ],
                                                  ),
                                                  if (!functions.isDatePassed(
                                                          calendarlistItem
                                                              .eventDate!) &&
                                                      (dateTimeFormat(
                                                              "yMd",
                                                              calendarlistItem
                                                                  .eventDate) !=
                                                          dateTimeFormat("yMd",
                                                              getCurrentTimestamp)) &&
                                                      (valueOrDefault(
                                                              currentUserDocument
                                                                  ?.userRole,
                                                              0) ==
                                                          2))
                                                    Builder(
                                                      builder: (context) =>
                                                          AuthUserStreamWidget(
                                                        builder: (context) =>
                                                            FlutterFlowIconButton(
                                                          borderRadius: 20.0,
                                                          borderWidth: 1.0,
                                                          buttonSize: 40.0,
                                                          icon: Icon(
                                                            Icons.more_vert,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .tertiaryText,
                                                            size: 24.0,
                                                          ),
                                                          onPressed: () async {
                                                            if (calendarlistItem
                                                                    .eventfiles
                                                                    .length ==
                                                                0) {
                                                              await showAlignedDialog(
                                                                context:
                                                                    context,
                                                                isGlobal: false,
                                                                avoidOverflow:
                                                                    false,
                                                                targetAnchor:
                                                                    AlignmentDirectional(
                                                                            0.0,
                                                                            0.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                followerAnchor:
                                                                    AlignmentDirectional(
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
                                                                        FocusScope.of(dialogContext)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.12,
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.45,
                                                                        child:
                                                                            EditDeleteSchoolWidget(
                                                                          eventid:
                                                                              calendarlistItem.eventId,
                                                                          event:
                                                                              EventsNoticeStruct(
                                                                            eventId:
                                                                                calendarlistItem.eventId,
                                                                            eventTitle:
                                                                                calendarlistItem.eventTitle,
                                                                            eventDescription:
                                                                                calendarlistItem.eventDescription,
                                                                            eventDate:
                                                                                calendarlistItem.eventDate,
                                                                            eventName:
                                                                                calendarlistItem.eventName,
                                                                          ),
                                                                          noticebool:
                                                                              false,
                                                                          schoolref:
                                                                              addEventsDetailsSchoolRecord.reference,
                                                                          schoolcal:
                                                                              true,
                                                                          classref:
                                                                              calendarlistItem.classref,
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
                                                                isGlobal: false,
                                                                avoidOverflow:
                                                                    false,
                                                                targetAnchor:
                                                                    AlignmentDirectional(
                                                                            0.0,
                                                                            0.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                followerAnchor:
                                                                    AlignmentDirectional(
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
                                                                        FocusScope.of(dialogContext)
                                                                            .unfocus();
                                                                        FocusManager
                                                                            .instance
                                                                            .primaryFocus
                                                                            ?.unfocus();
                                                                      },
                                                                      child:
                                                                          Container(
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.12,
                                                                        width: MediaQuery.sizeOf(context).width *
                                                                            0.45,
                                                                        child:
                                                                            EditDeleteSchoolWidget(
                                                                          eventid:
                                                                              calendarlistItem.eventId,
                                                                          noticebool:
                                                                              false,
                                                                          schoolref:
                                                                              addEventsDetailsSchoolRecord.reference,
                                                                          schoolcal:
                                                                              true,
                                                                          eventImages:
                                                                              EventsNoticeStruct(
                                                                            eventId:
                                                                                calendarlistItem.eventId,
                                                                            eventTitle:
                                                                                calendarlistItem.eventTitle,
                                                                            eventDescription:
                                                                                calendarlistItem.eventDescription,
                                                                            eventDate:
                                                                                calendarlistItem.eventDate,
                                                                            eventName:
                                                                                calendarlistItem.eventName,
                                                                            eventfiles:
                                                                                calendarlistItem.eventfiles,
                                                                          ),
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
                                                                            eventfiles:
                                                                                calendarlistItem.eventfiles,
                                                                          ),
                                                                          classref:
                                                                              calendarlistItem.classref,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            }

                                                            Navigator.pop(
                                                                context);

                                                            context.pushNamed(
                                                              AddEventsDetailsWidget
                                                                  .routeName,
                                                              queryParameters: {
                                                                'selectedDate':
                                                                    serializeParam(
                                                                  calendarlistItem
                                                                      .eventDate,
                                                                  ParamType
                                                                      .DateTime,
                                                                ),
                                                                'schoolRef':
                                                                    serializeParam(
                                                                  addEventsDetailsSchoolRecord
                                                                      .reference,
                                                                  ParamType
                                                                      .DocumentReference,
                                                                ),
                                                              }.withoutNulls,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.9,
                                              decoration: BoxDecoration(),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 10.0),
                                                child: Text(
                                                  calendarlistItem
                                                      .eventDescription,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        font:
                                                            GoogleFonts.nunito(
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
                                                        color:
                                                            Color(0xFF363F49),
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
