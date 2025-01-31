import '/admin_dashboard/edit_delete_school/edit_delete_school_widget.dart';
import '/admin_dashboard/select_class_calender/select_class_calender_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
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
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            body: const MainDashboardShimmerWidget(),
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
                'Add Event ',
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
                              Icons.calendar_today_outlined,
                              color: FlutterFlowTheme.of(context).primary,
                              size: 25.0,
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
                    if (!functions.isDatePassed(_model.calendarDate!) &&
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
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 0.0, 0.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.center,
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
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10.0, 10.0, 10.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 5.0, 0.0),
                                            child: FFButtonWidget(
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
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.26,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.04,
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
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
                                                              .tertiaryText,
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 2.0, 0.0),
                                            child: FFButtonWidget(
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
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.26,
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.04,
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        16.0, 0.0, 16.0, 0.0),
                                                iconPadding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                            0.0, 0.0, 0.0, 0.0),
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
                                                              .tertiaryText,
                                                      fontSize: 12.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                elevation: 0.0,
                                                borderSide: BorderSide(
                                                  color: valueOrDefault<Color>(
                                                    _model.eventName ==
                                                            'Holiday'
                                                        ? const Color(0xFF7DD7FE)
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
                                                            .tertiaryText,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                              elevation: 0.0,
                                              borderSide: BorderSide(
                                                color: valueOrDefault<Color>(
                                                  _model.eventName == 'Birthday'
                                                      ? const Color(0xFFADA6EB)
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
                                                    10.0, 0.0, 10.0, 10.0),
                                            child: SizedBox(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.9,
                                              child: TextFormField(
                                                controller: _model
                                                    .titleNoticeTextController,
                                                focusNode:
                                                    _model.titleNoticeFocusNode,
                                                autofocus: false,
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
                                                obscureText: false,
                                                decoration: InputDecoration(
                                                  isDense: true,
                                                  labelText: 'Event\'s name',
                                                  labelStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .titleSmall
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            color: (_model
                                                                        .titleNoticeFocusNode
                                                                        ?.hasFocus ??
                                                                    false)
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                            fontSize: 14.0,
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
                                                    .titleNoticeTextControllerValidator
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
                                                textCapitalization:
                                                    TextCapitalization
                                                        .sentences,
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
                                                            fontSize: 14.0,
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
                                                maxLines: 4,
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
                                    Container(
                                      decoration: const BoxDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 0.0, 10.0, 0.0),
                                        child: Builder(
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
                                                      BorderRadius.circular(
                                                          8.0),
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
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        FlutterFlowIconButton(
                                          borderColor: const Color(0xFFEDF1F3),
                                          borderRadius: 8.0,
                                          buttonSize: 40.0,
                                          icon: Icon(
                                            Icons.attach_file,
                                            color: FlutterFlowTheme.of(context)
                                                .tertiaryText,
                                            size: 20.0,
                                          ),
                                          onPressed: () async {
                                            safeSetState(() {
                                              _model.isDataUploading1 = false;
                                              _model.uploadedLocalFiles1 = [];
                                              _model.uploadedFileUrls1 = [];
                                            });

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
                                                        .where((u) => u != null)
                                                        .map((u) => u!)
                                                        .toList();
                                              } finally {
                                                ScaffoldMessenger.of(context)
                                                    .hideCurrentSnackBar();
                                                _model.isDataUploading1 = false;
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
                                                        _model.uploadedFileUrls1
                                                            .toList())
                                                    .toList()
                                                    .cast<String>();
                                            safeSetState(() {});
                                          },
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 30.0, 0.0),
                                          child: FlutterFlowIconButton(
                                            borderColor: const Color(0xFFEDF1F3),
                                            borderRadius: 8.0,
                                            buttonSize: 40.0,
                                            icon: Icon(
                                              Icons.photo_camera_outlined,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiaryText,
                                              size: 20.0,
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
                                        FFButtonWidget(
                                          onPressed:
                                              (addEventsDetailsSchoolRecord
                                                          .listOfStudents.isEmpty)
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
                                                            eventDescription: _model
                                                                .descriptionNoticeTextController
                                                                .text,
                                                            eventDate: _model
                                                                .calendarDate,
                                                            eventName: _model
                                                                .eventName,
                                                            eventImages: _model
                                                                .uploadedFileUrls1,
                                                          );
                                                          safeSetState(() {});
                                                          if (FFAppState()
                                                                  .eventnoticeimage.isEmpty) {
                                                            await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              enableDrag: false,
                                                              context: context,
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
                                                                        SizedBox(
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.75,
                                                                      child:
                                                                          SelectClassCalenderWidget(
                                                                        schoolref:
                                                                            widget.schoolRef!,
                                                                        eventtitle: _model
                                                                            .titleNoticeTextController
                                                                            .text,
                                                                        eventname:
                                                                            _model.eventName,
                                                                        description: _model
                                                                            .descriptionNoticeTextController
                                                                            .text,
                                                                        datetime:
                                                                            _model.calendarDate!,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ).then((value) =>
                                                                safeSetState(
                                                                    () {}));
                                                          } else {
                                                            await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              enableDrag: false,
                                                              context: context,
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
                                                                        SizedBox(
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.75,
                                                                      child:
                                                                          SelectClassCalenderWidget(
                                                                        schoolref:
                                                                            widget.schoolRef!,
                                                                        eventtitle: _model
                                                                            .titleNoticeTextController
                                                                            .text,
                                                                        eventname:
                                                                            _model.eventName,
                                                                        description: _model
                                                                            .descriptionNoticeTextController
                                                                            .text,
                                                                        datetime:
                                                                            _model.calendarDate!,
                                                                        images:
                                                                            FFAppState().eventnoticeimage,
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
                                                          ScaffoldMessenger.of(
                                                                  context)
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
                                                              duration: const Duration(
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
                                                          ScaffoldMessenger.of(
                                                                  context)
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
                                                              duration: const Duration(
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
                                                              eventImages: _model
                                                                  .uploadedFileUrls1,
                                                            );
                                                            safeSetState(() {});
                                                            if (FFAppState()
                                                                    .eventnoticeimage.isEmpty) {
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
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
                                                                          SizedBox(
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.75,
                                                                        child:
                                                                            SelectClassCalenderWidget(
                                                                          schoolref:
                                                                              widget.schoolRef!,
                                                                          eventtitle: _model
                                                                              .titleNoticeTextController
                                                                              .text,
                                                                          eventname:
                                                                              _model.eventName,
                                                                          description: _model
                                                                              .descriptionNoticeTextController
                                                                              .text,
                                                                          datetime:
                                                                              _model.calendarDate!,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              ).then((value) =>
                                                                  safeSetState(
                                                                      () {}));
                                                            } else {
                                                              await showModalBottomSheet(
                                                                isScrollControlled:
                                                                    true,
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
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
                                                                          SizedBox(
                                                                        height: MediaQuery.sizeOf(context).height *
                                                                            0.75,
                                                                        child:
                                                                            SelectClassCalenderWidget(
                                                                          schoolref:
                                                                              widget.schoolRef!,
                                                                          eventtitle: _model
                                                                              .titleNoticeTextController
                                                                              .text,
                                                                          eventname:
                                                                              _model.eventName,
                                                                          description: _model
                                                                              .descriptionNoticeTextController
                                                                              .text,
                                                                          datetime:
                                                                              _model.calendarDate!,
                                                                          images:
                                                                              FFAppState().eventnoticeimage,
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
                                                                duration: const Duration(
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
                                                0.5,
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.05,
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
                                            disabledColor:
                                                FlutterFlowTheme.of(context)
                                                    .dIsable,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ]
                                      .divide(const SizedBox(height: 15.0))
                                      .addToEnd(const SizedBox(height: 5.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 10.0),
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
                                            10.0, 10.0, 10.0, 10.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 10.0, 0.0, 10.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.4,
                                                    decoration: BoxDecoration(
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
                                                            fontFamily:
                                                                'Nunito',
                                                            fontSize: 16.0,
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
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
                                                                    0xFFFBF0FF);
                                                              } else {
                                                                return const Color(
                                                                    0xFFF0FCFF);
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
                                                                      0xFFADA6EB);
                                                                } else {
                                                                  return const Color(
                                                                      0xFF7DD7FE);
                                                                }
                                                              }(),
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
                                                                      .center,
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
                                                                          20.0,
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
                                                                          20.0,
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
                                                                          20.0,
                                                                    ),
                                                                  ),
                                                                Text(
                                                                  calendarlistItem
                                                                      .eventName,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Nunito',
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
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if (!functions.isDatePassed(
                                                              calendarlistItem
                                                                  .eventDate!) &&
                                                          (dateTimeFormat(
                                                                  "yMd",
                                                                  calendarlistItem
                                                                      .eventDate) !=
                                                              dateTimeFormat(
                                                                  "yMd",
                                                                  getCurrentTimestamp)) &&
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
                                                                size: 24.0,
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
                                                                                EditDeleteSchoolWidget(
                                                                              eventid: calendarlistItem.eventId,
                                                                              event: EventsNoticeStruct(
                                                                                eventId: calendarlistItem.eventId,
                                                                                eventTitle: calendarlistItem.eventTitle,
                                                                                eventDescription: calendarlistItem.eventDescription,
                                                                                eventDate: calendarlistItem.eventDate,
                                                                                eventName: calendarlistItem.eventName,
                                                                              ),
                                                                              noticebool: false,
                                                                              schoolref: addEventsDetailsSchoolRecord.reference,
                                                                              schoolcal: true,
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
                                                                                EditDeleteSchoolWidget(
                                                                              eventid: calendarlistItem.eventId,
                                                                              noticebool: false,
                                                                              schoolref: addEventsDetailsSchoolRecord.reference,
                                                                              schoolcal: true,
                                                                              eventImages: EventsNoticeStruct(
                                                                                eventId: calendarlistItem.eventId,
                                                                                eventTitle: calendarlistItem.eventTitle,
                                                                                eventDescription: calendarlistItem.eventDescription,
                                                                                eventDate: calendarlistItem.eventDate,
                                                                                eventName: calendarlistItem.eventName,
                                                                                eventImages: calendarlistItem.eventImages,
                                                                              ),
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

                                                                Navigator.pop(
                                                                    context);

                                                                context
                                                                    .pushNamed(
                                                                  'add_events_details',
                                                                  queryParameters:
                                                                      {
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
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.9,
                                              decoration: const BoxDecoration(),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 10.0),
                                                child: Text(
                                                  calendarlistItem
                                                      .eventDescription,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(0.0, 8.0, 0.0, 0.0),
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
