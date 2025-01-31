import '/admin_dashboard/edit_delete_notice/edit_delete_notice_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/empty_widget.dart';
import '/confirmationpages/eventpostedsuccessfully/eventpostedsuccessfully_widget.dart';
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
  });

  final DateTime? selectedDate;
  final DocumentReference? schoolclassref;
  final int? tabindex;
  final String? classname;

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
    context.watch<FFAppState>();

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
                  context.safePop();
                },
              ),
              title: Text(
                '${addCalenderDetailsSchoolClassRecord.className} - Events',
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
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              final datePickedDate = await showDatePicker(
                                context: context,
                                initialDate:
                                    (widget.selectedDate ?? DateTime.now()),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(2050),
                                builder: (context, child) {
                                  return wrapInMaterialDatePickerTheme(
                                    context,
                                    child!,
                                    headerBackgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    headerForegroundColor:
                                        FlutterFlowTheme.of(context).info,
                                    headerTextStyle:
                                        FlutterFlowTheme.of(context)
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
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                    selectedDateTimeBackgroundColor:
                                        FlutterFlowTheme.of(context).primary,
                                    selectedDateTimeForegroundColor:
                                        FlutterFlowTheme.of(context).info,
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
                              _model.calendarDate = _model.datePicked;
                              safeSetState(() {});
                            },
                            child: Icon(
                              Icons.date_range_outlined,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 26.0,
                            ),
                          ),
                          Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  10.0, 0.0, 10.0, 0.0),
                              child: Text(
                                dateTimeFormat(
                                    "dd MMM , y", _model.calendarDate),
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
                        ],
                      ),
                    ),
                    if ((functions
                                .isDatePassed(_model.calendarDate!) ==
                            false) &&
                        (valueOrDefault(currentUserDocument?.userRole, 0) !=
                            4) &&
                        (valueOrDefault(currentUserDocument?.userRole, 0) != 1))
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: AuthUserStreamWidget(
                          builder: (context) => Material(
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
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-1.0, -1.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 0.0, 0.0),
                                        child: Text(
                                          'New Event',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Nunito',
                                                fontSize: 16.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ),
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
                                            icon: Icon(
                                              Icons.bolt,
                                              color: valueOrDefault<Color>(
                                                _model.eventName == 'Event'
                                                    ? const Color(0xFFC29800)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .warning,
                                                FlutterFlowTheme.of(context)
                                                    .warning,
                                              ),
                                              size: 15.0,
                                            ),
                                            options: FFButtonOptions(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.26,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.04,
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: valueOrDefault<Color>(
                                                _model.eventName == 'Event'
                                                    ? const Color(0xFFFFFCF0)
                                                    : const Color(0xFFF5F2F2),
                                                const Color(0xFFF5F2F2),
                                              ),
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
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
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: valueOrDefault<Color>(
                                                  _model.eventName == 'Event'
                                                      ? const Color(0xFFFFE26A)
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
                                              _model.eventName = 'Holiday';
                                              safeSetState(() {});
                                            },
                                            text: 'Holiday',
                                            icon: Icon(
                                              Icons.celebration_sharp,
                                              color: valueOrDefault<Color>(
                                                _model.eventName == 'Holiday'
                                                    ? const Color(0xFF072F78)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .warning,
                                                FlutterFlowTheme.of(context)
                                                    .warning,
                                              ),
                                              size: 15.0,
                                            ),
                                            options: FFButtonOptions(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.26,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.04,
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: valueOrDefault<Color>(
                                                _model.eventName == 'Holiday'
                                                    ? const Color(0xFFF0FCFF)
                                                    : const Color(0xFFF5F2F2),
                                                const Color(0xFFF5F2F2),
                                              ),
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Nunito',
                                                    color: _model.eventName ==
                                                            'Holiday'
                                                        ? const Color(0xFF072F78)
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: valueOrDefault<Color>(
                                                  _model.eventName == 'Holiday'
                                                      ? const Color(0xFFFFE26A)
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
                                            icon: FaIcon(
                                              FontAwesomeIcons.birthdayCake,
                                              color: valueOrDefault<Color>(
                                                _model.eventName == 'Birthday'
                                                    ? const Color(0xFFB0A7FD)
                                                    : FlutterFlowTheme.of(
                                                            context)
                                                        .warning,
                                                FlutterFlowTheme.of(context)
                                                    .warning,
                                              ),
                                              size: 15.0,
                                            ),
                                            options: FFButtonOptions(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.26,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.04,
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      16.0, 0.0, 16.0, 0.0),
                                              iconPadding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 0.0, 0.0, 0.0),
                                              color: valueOrDefault<Color>(
                                                _model.eventName == 'Birthday'
                                                    ? const Color(0xFFFBF0FF)
                                                    : const Color(0xFFF5F2F2),
                                                const Color(0xFFF5F2F2),
                                              ),
                                              textStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .titleSmall
                                                  .override(
                                                    fontFamily: 'Nunito',
                                                    color: _model.eventName ==
                                                            'Birthday'
                                                        ? const Color(0xFF4E0B6B)
                                                        : FlutterFlowTheme.of(
                                                                context)
                                                            .primaryText,
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: valueOrDefault<Color>(
                                                  _model.eventName == 'Birthday'
                                                      ? const Color(0xFFFFE26A)
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
                                      autovalidateMode:
                                          AutovalidateMode.disabled,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 0.0, 10.0),
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
                                                  labelText: 'Event\'s name',
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            color: (_model
                                                                        .eventnameFocusNode
                                                                        ?.hasFocus ??
                                                                    false)
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                  hintText: 'Event\'s name',
                                                  hintStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
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
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
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
                                                    10.0, 5.0, 10.0, 0.0),
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
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleLarge
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            color: (_model
                                                                        .descriptionNoticeFocusNode
                                                                        ?.hasFocus ??
                                                                    false)
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            fontSize: 12.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                  hintText: 'Description',
                                                  hintStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleLarge
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          FlutterFlowTheme.of(
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
                                                  fillColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .secondaryBackground,
                                                ),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          letterSpacing: 0.0,
                                                        ),
                                                maxLines: 3,
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
                                        final imagesview = FFAppState()
                                            .eventnoticeimage
                                            .toList();

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
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                          child: FlutterFlowIconButton(
                                            borderColor: const Color(0xFFEDF1F3),
                                            borderRadius: 8.0,
                                            buttonSize: 40.0,
                                            icon: Icon(
                                              Icons.attach_file,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryText,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              safeSetState(() {
                                                _model.isDataUploading1 = false;
                                                _model.uploadedLocalFiles1 = [];
                                                _model.uploadedFileUrls1 = [];
                                              });

                                              final selectedMedia =
                                                  await selectMedia(
                                                imageQuality: 10,
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
                                                    .isDataUploading1 = true);
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
                                                          .where(
                                                              (u) => u != null)
                                                          .map((u) => u!)
                                                          .toList();
                                                } finally {
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                  _model.isDataUploading1 =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                            .length ==
                                                        selectedMedia.length &&
                                                    downloadUrls.length ==
                                                        selectedMedia.length) {
                                                  safeSetState(() {
                                                    _model.uploadedLocalFiles1 =
                                                        selectedUploadedFiles;
                                                    _model.uploadedFileUrls1 =
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

                                              FFAppState().eventnoticeimage =
                                                  functions
                                                      .combineImagePaths(
                                                          FFAppState()
                                                              .eventnoticeimage
                                                              .toList(),
                                                          _model
                                                              .uploadedFileUrls1
                                                              .toList())
                                                      .toList()
                                                      .cast<String>();
                                              safeSetState(() {});
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 0.0, 0.0),
                                          child: FlutterFlowIconButton(
                                            borderColor: const Color(0xFFEDF1F3),
                                            borderRadius: 8.0,
                                            buttonSize: 40.0,
                                            icon: Icon(
                                              Icons.photo_camera_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryText,
                                              size: 24.0,
                                            ),
                                            onPressed: () async {
                                              safeSetState(() {
                                                _model.isDataUploading2 = false;
                                                _model.uploadedLocalFile2 =
                                                    FFUploadedFile(
                                                        bytes:
                                                            Uint8List.fromList(
                                                                []));
                                                _model.uploadedFileUrl2 = '';
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
                                                    .isDataUploading2 = true);
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
                                                          .where(
                                                              (u) => u != null)
                                                          .map((u) => u!)
                                                          .toList();
                                                } finally {
                                                  ScaffoldMessenger.of(context)
                                                      .hideCurrentSnackBar();
                                                  _model.isDataUploading2 =
                                                      false;
                                                }
                                                if (selectedUploadedFiles
                                                            .length ==
                                                        selectedMedia.length &&
                                                    downloadUrls.length ==
                                                        selectedMedia.length) {
                                                  safeSetState(() {
                                                    _model.uploadedLocalFile2 =
                                                        selectedUploadedFiles
                                                            .first;
                                                    _model.uploadedFileUrl2 =
                                                        downloadUrls.first;
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

                                              FFAppState()
                                                  .addToEventnoticeimage(
                                                      _model.uploadedFileUrl2);
                                              safeSetState(() {});
                                            },
                                          ),
                                        ),
                                        Builder(
                                          builder: (context) => Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 10.0, 0.0),
                                            child: FFButtonWidget(
                                              onPressed: () async {
                                                if (_model.eventName != '') {
                                                  if (_model.formKey
                                                              .currentState ==
                                                          null ||
                                                      !_model
                                                          .formKey.currentState!
                                                          .validate()) {
                                                    return;
                                                  }

                                                  await addCalenderDetailsSchoolClassRecord
                                                      .reference
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'calendar': FieldValue
                                                            .arrayUnion([
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
                                                                eventDescription:
                                                                    _model
                                                                        .descriptionNoticeTextController
                                                                        .text,
                                                                eventDate: _model
                                                                    .calendarDate,
                                                                eventImages:
                                                                    FFAppState()
                                                                        .eventnoticeimage,
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
                                                    scheduledTime: functions
                                                        .noticedate(_model
                                                            .calendarDate)!,
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
                                                          notificationImages:
                                                              FFAppState()
                                                                  .eventnoticeimage,
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
                                                    scheduledTime: functions
                                                        .noticedate(_model
                                                            .calendarDate)!,
                                                    notificationSound:
                                                        'default',
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
                                                    initialPageName:
                                                        'Dashboard',
                                                    parameterData: {},
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
                                                          notificationImages:
                                                              FFAppState()
                                                                  .eventnoticeimage,
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
                                                  FFAppState()
                                                      .eventnoticeimage = [];
                                                  FFAppState().update(() {});
                                                  _model.school12356 =
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
                                                          alignment: const AlignmentDirectional(
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
                                                            child: SizedBox(
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
                                                                  const EventpostedsuccessfullyWidget(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );

                                                    context.goNamed(
                                                      'class_dashboard',
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
                                                          0,
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
                                                          alignment: const AlignmentDirectional(
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
                                                            child: SizedBox(
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
                                                                  const EventpostedsuccessfullyWidget(),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    );

                                                    context.goNamed(
                                                      'Class_view',
                                                      queryParameters: {
                                                        'schoolclassref':
                                                            serializeParam(
                                                          widget
                                                              .schoolclassref,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                        'schoolref':
                                                            serializeParam(
                                                          _model.school12356
                                                              ?.reference,
                                                          ParamType
                                                              .DocumentReference,
                                                        ),
                                                        'datePick':
                                                            serializeParam(
                                                          widget.selectedDate,
                                                          ParamType.DateTime,
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
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.5,
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 16.0, 16.0, 16.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondaryBackground,
                                                textStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                elevation: 0.0,
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryBackground,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
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
                                  .toList()
                                  .sortedList(
                                      keyOf: (e) => dateTimeFormat(
                                          "relative", e.eventDate!),
                                      desc: false)
                                  .toList();
                          if (calendarlist.isEmpty) {
                            return Center(
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                height: MediaQuery.sizeOf(context).height * 0.4,
                                child: const EmptyWidget(),
                              ),
                            );
                          }

                          return ListView.builder(
                            padding: const EdgeInsets.fromLTRB(
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
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 10.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    context.pushNamed(
                                      'event_details',
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
                                    elevation: 5.0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 10.0, 10.0, 0.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 5.0, 0.0, 5.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                10.0, 10.0),
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.3,
                                                      decoration: BoxDecoration(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      child: Text(
                                                        calendarlistItem
                                                            .eventTitle,
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    ),
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
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    10.0,
                                                                    0.0),
                                                        child: Container(
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.05,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: () {
                                                              if (calendarlistItem
                                                                      .eventName ==
                                                                  'Event') {
                                                                return const Color(
                                                                    0xFFFFFCF0);
                                                              } else if (calendarlistItem
                                                                      .eventName ==
                                                                  'Birthday') {
                                                                return const Color(
                                                                    0xFFF0F0FF);
                                                              } else {
                                                                return const Color(
                                                                    0xFFFBFCFF);
                                                              }
                                                            }(),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0),
                                                            border: Border.all(
                                                              color: () {
                                                                if (calendarlistItem
                                                                        .eventName ==
                                                                    'Event') {
                                                                  return const Color(
                                                                      0xFFFFE26A);
                                                                } else if (calendarlistItem
                                                                        .eventName ==
                                                                    'Birthday') {
                                                                  return const Color(
                                                                      0xFF635AAC);
                                                                } else {
                                                                  return const Color(
                                                                      0xFF7DD7FE);
                                                                }
                                                              }(),
                                                              width: 1.0,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
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
                                                                  const Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .bolt,
                                                                      color: Color(
                                                                          0xFFF8BA0B),
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                  ),
                                                                if (calendarlistItem
                                                                        .eventName ==
                                                                    'Holiday')
                                                                  const Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .celebration_sharp,
                                                                      color: Color(
                                                                          0xFF072F78),
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                  ),
                                                                if (calendarlistItem
                                                                        .eventName ==
                                                                    'Birthday')
                                                                  const Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                    child: Icon(
                                                                      Icons
                                                                          .cake,
                                                                      color: Color(
                                                                          0xFFB0A7FD),
                                                                      size:
                                                                          24.0,
                                                                    ),
                                                                  ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
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
                                                                          fontFamily:
                                                                              'Inter',
                                                                          color:
                                                                              () {
                                                                            if (calendarlistItem.eventName ==
                                                                                'Event') {
                                                                              return const Color(0xFFC29800);
                                                                            } else if (calendarlistItem.eventName ==
                                                                                'Holiday') {
                                                                              return const Color(0xFF072F78);
                                                                            } else {
                                                                              return const Color(0xFF4E0B6B);
                                                                            }
                                                                          }(),
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
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
                                                                        .eventImages.isEmpty) {
                                                                  await showAlignedDialog(
                                                                    context:
                                                                        context,
                                                                    isGlobal:
                                                                        false,
                                                                    avoidOverflow:
                                                                        false,
                                                                    targetAnchor: const AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    followerAnchor: const AlignmentDirectional(
                                                                            1.0,
                                                                            0.0)
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
                                                                              SizedBox(
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
                                                                    targetAnchor: const AlignmentDirectional(
                                                                            1.0,
                                                                            -1.0)
                                                                        .resolve(
                                                                            Directionality.of(context)),
                                                                    followerAnchor: const AlignmentDirectional(
                                                                            1.0,
                                                                            0.0)
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
                                                                              SizedBox(
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
                                                                                eventImages: calendarlistItem.eventImages,
                                                                              ),
                                                                              schoolref: _model.schoolref!,
                                                                              event: EventsNoticeStruct(
                                                                                eventId: calendarlistItem.eventId,
                                                                                eventName: calendarlistItem.eventName,
                                                                                eventTitle: calendarlistItem.eventTitle,
                                                                                eventDescription: calendarlistItem.eventDescription,
                                                                                eventDate: calendarlistItem.eventDate,
                                                                                eventImages: calendarlistItem.eventImages,
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
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 0.0, 10.0),
                                              child: Text(
                                                dateTimeFormat(
                                                    "dd MMM , y",
                                                    calendarlistItem
                                                        .eventDate!),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryText,
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
                                                calendarlistItem
                                                    .eventDescription,
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .tertiaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 0.0),
                                              child: Builder(
                                                builder: (context) {
                                                  final uploadedImages =
                                                      calendarlistItem
                                                          .eventImages
                                                          .toList();

                                                  return SingleChildScrollView(
                                                    scrollDirection:
                                                        Axis.horizontal,
                                                    child: Row(
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
                                                                      10.0,
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
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                await Navigator
                                                                    .push(
                                                                  context,
                                                                  PageTransition(
                                                                    type: PageTransitionType
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
                                                                child:
                                                                    ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                  child: Image
                                                                      .network(
                                                                    uploadedImagesItem,
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ].addToEnd(const SizedBox(height: 10.0)),
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
