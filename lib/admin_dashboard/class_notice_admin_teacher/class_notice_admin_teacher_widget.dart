import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/confirmationpages/noticecreated/noticecreated_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/shimmer_effects/addclasss_shimmer/addclasss_shimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'class_notice_admin_teacher_model.dart';
export 'class_notice_admin_teacher_model.dart';

class ClassNoticeAdminTeacherWidget extends StatefulWidget {
  const ClassNoticeAdminTeacherWidget({
    super.key,
    required this.classref,
    required this.schoolref,
    required this.date,
  });

  final DocumentReference? classref;
  final DocumentReference? schoolref;
  final DateTime? date;

  @override
  State<ClassNoticeAdminTeacherWidget> createState() =>
      _ClassNoticeAdminTeacherWidgetState();
}

class _ClassNoticeAdminTeacherWidgetState
    extends State<ClassNoticeAdminTeacherWidget> {
  late ClassNoticeAdminTeacherModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ClassNoticeAdminTeacherModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.date = widget.date;
      safeSetState(() {});
    });

    _model.eventnameTextController ??= TextEditingController();
    _model.eventnameFocusNode ??= FocusNode();

    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();
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
      stream: SchoolClassRecord.getDocument(widget.classref!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: const AddclasssShimmerWidget(),
          );
        }

        final classNoticeAdminTeacherSchoolClassRecord = snapshot.data!;

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
                  if (valueOrDefault(currentUserDocument?.userRole, 0) == 3) {
                    context.goNamed(
                      'Dashboard',
                      extra: <String, dynamic>{
                        kTransitionInfoKey: const TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                        ),
                      },
                    );
                  } else {
                    context.goNamed(
                      'class_dashboard',
                      queryParameters: {
                        'schoolref': serializeParam(
                          widget.schoolref,
                          ParamType.DocumentReference,
                        ),
                      }.withoutNulls,
                      extra: <String, dynamic>{
                        kTransitionInfoKey: const TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                        ),
                      },
                    );
                  }
                },
              ),
              title: Text(
                'Class Notice',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                    ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.8,
                    decoration: const BoxDecoration(),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 5.0, 0.0, 0.0),
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
                                    final datePickedDate =
                                        await showDatePicker(
                                      context: context,
                                      initialDate: getCurrentTimestamp,
                                      firstDate: getCurrentTimestamp,
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

                                    if (datePickedDate != null) {
                                      safeSetState(() {
                                        _model.datePicked = DateTime(
                                          datePickedDate.year,
                                          datePickedDate.month,
                                          datePickedDate.day,
                                        );
                                      });
                                    }
                                    _model.date = _model.datePicked;
                                    safeSetState(() {});
                                  },
                                  child: Icon(
                                    Icons.date_range_outlined,
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    size: 30.0,
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(0.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10.0, 0.0, 10.0, 0.0),
                                    child: Text(
                                      dateTimeFormat("dd MMM , y", _model.date),
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
                              ],
                            ),
                          ),
                          if (!functions.isDatePassed(_model.date!) &&
                              (valueOrDefault(
                                      currentUserDocument?.userRole, 0) !=
                                  1))
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Material(
                                  color: Colors.transparent,
                                  elevation: 2.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(-1.0, 0.0),
                                            child: Text(
                                              'New Notice',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        letterSpacing: 0.0,
                                                      ),
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    10.0, 0.0, 10.0, 0.0),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
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
                                                      _model.noticename =
                                                          'General';
                                                      safeSetState(() {});
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.26,
                                                      decoration: BoxDecoration(
                                                        color: valueOrDefault<
                                                            Color>(
                                                          _model.noticename ==
                                                                  'General'
                                                              ? const Color(
                                                                  0xFFFFFCF0)
                                                              : const Color(
                                                                  0xFFF5F2F2),
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .text,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        border: Border.all(
                                                          color: valueOrDefault<
                                                              Color>(
                                                            _model.noticename ==
                                                                    'General'
                                                                ? const Color(
                                                                    0xFFFF976A)
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .text,
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .text,
                                                          ),
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    10.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Icon(
                                                              Icons
                                                                  .mode_comment,
                                                              color:
                                                                  valueOrDefault<
                                                                      Color>(
                                                                _model.noticename ==
                                                                        'General'
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .warning
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .warning,
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .text,
                                                              ),
                                                              size: 20.0,
                                                            ),
                                                            Text(
                                                              'General',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: valueOrDefault<
                                                                        Color>(
                                                                      _model.noticename ==
                                                                              'General'
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primaryText
                                                                          : FlutterFlowTheme.of(context)
                                                                              .text,
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .text,
                                                                    ),
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ]
                                                              .divide(const SizedBox(
                                                                  width: 10.0))
                                                              .around(const SizedBox(
                                                                  width: 10.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
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
                                                      _model.noticename =
                                                          'Reminder';
                                                      safeSetState(() {});
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.26,
                                                      decoration: BoxDecoration(
                                                        color: valueOrDefault<
                                                            Color>(
                                                          _model.noticename ==
                                                                  'Reminder'
                                                              ? const Color(
                                                                  0xC3FBF0FF)
                                                              : const Color(
                                                                  0xFFF5F2F2),
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .text,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        border: Border.all(
                                                          color: valueOrDefault<
                                                              Color>(
                                                            _model.noticename ==
                                                                    'Reminder'
                                                                ? const Color(
                                                                    0xFFADA6EB)
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .text,
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .text,
                                                          ),
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    10.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Icon(
                                                              Icons.alarm,
                                                              color:
                                                                  valueOrDefault<
                                                                      Color>(
                                                                _model.noticename ==
                                                                        'Reminder'
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .error
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .warning,
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .text,
                                                              ),
                                                              size: 20.0,
                                                            ),
                                                            Text(
                                                              'Reminder',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: valueOrDefault<
                                                                        Color>(
                                                                      _model.noticename ==
                                                                              'Reminder'
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primaryText
                                                                          : FlutterFlowTheme.of(context)
                                                                              .text,
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .text,
                                                                    ),
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ]
                                                              .divide(const SizedBox(
                                                                  width: 10.0))
                                                              .around(const SizedBox(
                                                                  width: 10.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
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
                                                      _model.noticename =
                                                          'Notice';
                                                      safeSetState(() {});
                                                    },
                                                    child: Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.26,
                                                      decoration: BoxDecoration(
                                                        color: valueOrDefault<
                                                            Color>(
                                                          _model.noticename ==
                                                                  'Notice'
                                                              ? const Color(
                                                                  0xFFFFFCF0)
                                                              : const Color(
                                                                  0xFFF5F2F2),
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .text,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                        border: Border.all(
                                                          color: valueOrDefault<
                                                              Color>(
                                                            _model.noticename ==
                                                                    'Notice'
                                                                ? const Color(
                                                                    0xFFB0FF6A)
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .text,
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .text,
                                                          ),
                                                          width: 1.0,
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    10.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            Icon(
                                                              Icons.push_pin,
                                                              color:
                                                                  valueOrDefault<
                                                                      Color>(
                                                                _model.noticename ==
                                                                        'Notice'
                                                                    ? const Color(
                                                                        0xFF99D63C)
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .warning,
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .text,
                                                              ),
                                                              size: 20.0,
                                                            ),
                                                            Text(
                                                              'Notice',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: valueOrDefault<
                                                                        Color>(
                                                                      _model.noticename ==
                                                                              'Notice'
                                                                          ? FlutterFlowTheme.of(context)
                                                                              .primaryText
                                                                          : FlutterFlowTheme.of(context)
                                                                              .text,
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .text,
                                                                    ),
                                                                    fontSize:
                                                                        12.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ]
                                                              .divide(const SizedBox(
                                                                  width: 10.0))
                                                              .around(const SizedBox(
                                                                  width: 10.0)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ].divide(const SizedBox(width: 10.0)),
                                              ),
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
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 5.0, 10.0, 0.0),
                                                  child: SizedBox(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.9,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .eventnameTextController,
                                                      focusNode: _model
                                                          .eventnameFocusNode,
                                                      autofocus: false,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelText: 'Title',
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    (_model.eventnameFocusNode?.hasFocus ??
                                                                            false)
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primary
                                                                        : FlutterFlowTheme.of(context)
                                                                            .textfieldText,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .textfieldText,
                                                                  ),
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        hintText: 'Title',
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryText,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .dIsable,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            letterSpacing: 0.0,
                                                          ),
                                                      maxLength: 25,
                                                      buildCounter: (context,
                                                              {required currentLength,
                                                              required isFocused,
                                                              maxLength}) =>
                                                          null,
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .eventnameTextControllerValidator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(10.0, 10.0,
                                                          10.0, 0.0),
                                                  child: SizedBox(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.9,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .descriptionTextController,
                                                      focusNode: _model
                                                          .descriptionFocusNode,
                                                      autofocus: false,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelText:
                                                            'Description',
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    (_model.descriptionFocusNode?.hasFocus ??
                                                                            false)
                                                                        ? FlutterFlowTheme.of(context)
                                                                            .primary
                                                                        : FlutterFlowTheme.of(context)
                                                                            .textfieldText,
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .textfieldText,
                                                                  ),
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        hintText: 'Description',
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .tertiaryText,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .dIsable,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor: FlutterFlowTheme
                                                                .of(context)
                                                            .secondaryBackground,
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            letterSpacing: 0.0,
                                                          ),
                                                      maxLines: 4,
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
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
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: imagesview.length,
                                                  itemBuilder: (context,
                                                      imagesviewIndex) {
                                                    final imagesviewItem =
                                                        imagesview[
                                                            imagesviewIndex];
                                                    return ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                      child: Image.network(
                                                        imagesviewItem,
                                                        fit: BoxFit.contain,
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          ),
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              FlutterFlowIconButton(
                                                borderColor:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                borderRadius: 8.0,
                                                borderWidth: 0.2,
                                                buttonSize: 40.0,
                                                icon: Icon(
                                                  Icons.attach_file,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryText,
                                                  size: 24.0,
                                                ),
                                                onPressed: () async {
                                                  safeSetState(() {
                                                    _model.isDataUploading1 =
                                                        false;
                                                    _model.uploadedLocalFiles1 =
                                                        [];
                                                    _model.uploadedFileUrls1 =
                                                        [];
                                                  });

                                                  final selectedMedia =
                                                      await selectMedia(
                                                    imageQuality: 10,
                                                    mediaSource: MediaSource
                                                        .photoGallery,
                                                    multiImage: true,
                                                  );
                                                  if (selectedMedia != null &&
                                                      selectedMedia.every((m) =>
                                                          validateFileFormat(
                                                              m.storagePath,
                                                              context))) {
                                                    safeSetState(() => _model
                                                            .isDataUploading1 =
                                                        true);
                                                    var selectedUploadedFiles =
                                                        <FFUploadedFile>[];

                                                    var downloadUrls =
                                                        <String>[];
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
                                                                        .split(
                                                                            '/')
                                                                        .last,
                                                                    bytes:
                                                                        m.bytes,
                                                                    height: m
                                                                        .dimensions
                                                                        ?.height,
                                                                    width: m
                                                                        .dimensions
                                                                        ?.width,
                                                                    blurHash: m
                                                                        .blurHash,
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
                                                              .where((u) =>
                                                                  u != null)
                                                              .map((u) => u!)
                                                              .toList();
                                                    } finally {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .hideCurrentSnackBar();
                                                      _model.isDataUploading1 =
                                                          false;
                                                    }
                                                    if (selectedUploadedFiles
                                                                .length ==
                                                            selectedMedia
                                                                .length &&
                                                        downloadUrls.length ==
                                                            selectedMedia
                                                                .length) {
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

                                                  FFAppState()
                                                          .eventnoticeimage =
                                                      functions
                                                          .combineImagePaths(
                                                              _model
                                                                  .uploadedFileUrls1
                                                                  .toList(),
                                                              FFAppState()
                                                                  .eventnoticeimage
                                                                  .toList())
                                                          .toList()
                                                          .cast<String>();
                                                  safeSetState(() {});
                                                },
                                              ),
                                              FlutterFlowIconButton(
                                                borderColor:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                                borderRadius: 8.0,
                                                borderWidth: 0.2,
                                                buttonSize: 40.0,
                                                icon: Icon(
                                                  Icons.photo_camera_outlined,
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryText,
                                                  size: 24.0,
                                                ),
                                                onPressed: () async {
                                                  safeSetState(() {
                                                    _model.isDataUploading2 =
                                                        false;
                                                    _model.uploadedLocalFile2 =
                                                        FFUploadedFile(
                                                            bytes: Uint8List
                                                                .fromList([]));
                                                    _model.uploadedFileUrl2 =
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
                                                            .isDataUploading2 =
                                                        true);
                                                    var selectedUploadedFiles =
                                                        <FFUploadedFile>[];

                                                    var downloadUrls =
                                                        <String>[];
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
                                                                        .split(
                                                                            '/')
                                                                        .last,
                                                                    bytes:
                                                                        m.bytes,
                                                                    height: m
                                                                        .dimensions
                                                                        ?.height,
                                                                    width: m
                                                                        .dimensions
                                                                        ?.width,
                                                                    blurHash: m
                                                                        .blurHash,
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
                                                              .where((u) =>
                                                                  u != null)
                                                              .map((u) => u!)
                                                              .toList();
                                                    } finally {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .hideCurrentSnackBar();
                                                      _model.isDataUploading2 =
                                                          false;
                                                    }
                                                    if (selectedUploadedFiles
                                                                .length ==
                                                            selectedMedia
                                                                .length &&
                                                        downloadUrls.length ==
                                                            selectedMedia
                                                                .length) {
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
                                                          _model
                                                              .uploadedFileUrl2);
                                                  safeSetState(() {});
                                                },
                                              ),
                                              Builder(
                                                builder: (context) =>
                                                    FFButtonWidget(
                                                  onPressed: () async {
                                                    if (_model.formKey
                                                                .currentState ==
                                                            null ||
                                                        !_model.formKey
                                                            .currentState!
                                                            .validate()) {
                                                      return;
                                                    }
                                                    if (_model.noticename !=
                                                            null &&
                                                        _model.noticename !=
                                                            '') {
                                                      if (FFAppState()
                                                              .eventnoticeimage.isEmpty) {
                                                        await widget.classref!
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'notice': FieldValue
                                                                  .arrayUnion([
                                                                getEventsNoticeFirestoreData(
                                                                  updateEventsNoticeStruct(
                                                                    EventsNoticeStruct(
                                                                      eventId:
                                                                          functions
                                                                              .generateUniqueId(),
                                                                      eventTitle: _model
                                                                          .eventnameTextController
                                                                          .text,
                                                                      eventDescription: _model
                                                                          .descriptionTextController
                                                                          .text,
                                                                      eventDate:
                                                                          _model
                                                                              .date,
                                                                      eventName:
                                                                          _model
                                                                              .noticename,
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
                                                      } else {
                                                        await widget.classref!
                                                            .update({
                                                          ...mapToFirestore(
                                                            {
                                                              'notice': FieldValue
                                                                  .arrayUnion([
                                                                getEventsNoticeFirestoreData(
                                                                  updateEventsNoticeStruct(
                                                                    EventsNoticeStruct(
                                                                      eventId:
                                                                          functions
                                                                              .generateUniqueId(),
                                                                      eventTitle: _model
                                                                          .eventnameTextController
                                                                          .text,
                                                                      eventDescription: _model
                                                                          .descriptionTextController
                                                                          .text,
                                                                      eventImages:
                                                                          FFAppState()
                                                                              .eventnoticeimage,
                                                                      eventDate:
                                                                          _model
                                                                              .date,
                                                                      eventName:
                                                                          _model
                                                                              .noticename,
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
                                                      }

                                                      _model.students =
                                                          await queryStudentsRecordOnce();
                                                      triggerPushNotification(
                                                        notificationTitle: _model
                                                            .eventnameTextController
                                                            .text,
                                                        notificationText: _model
                                                            .eventnameTextController
                                                            .text,
                                                        userRefs: functions
                                                            .extractParentUserRefs(_model
                                                                .students!
                                                                .where((e) => classNoticeAdminTeacherSchoolClassRecord
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
                                                          content:
                                                              _model.noticename,
                                                          descri: _model
                                                              .descriptionTextController
                                                              .text,
                                                          datetimeofevent:
                                                              _model.date,
                                                          isread: false,
                                                          notification:
                                                              updateNotificationStruct(
                                                            NotificationStruct(
                                                              notificationTitle:
                                                                  _model
                                                                      .eventnameTextController
                                                                      .text,
                                                              descriptions: _model
                                                                  .descriptionTextController
                                                                  .text,
                                                              timeStamp:
                                                                  getCurrentTimestamp,
                                                              isRead: false,
                                                              eventDate:
                                                                  _model.date,
                                                              notificationImages:
                                                                  _model
                                                                      .uploadedFileUrls1,
                                                            ),
                                                            clearUnsetFields:
                                                                false,
                                                            create: true,
                                                          ),
                                                          createDate:
                                                              getCurrentTimestamp,
                                                          addedby:
                                                              currentUserReference,
                                                          tag:
                                                              _model.noticename,
                                                          heading:
                                                              'Added a notice',
                                                        ),
                                                        ...mapToFirestore(
                                                          {
                                                            'userref': functions
                                                                .extractParentUserRefs(_model
                                                                    .students!
                                                                    .where((e) => classNoticeAdminTeacherSchoolClassRecord
                                                                        .studentsList
                                                                        .contains(
                                                                            e.reference))
                                                                    .toList()),
                                                            'towhome': [
                                                              classNoticeAdminTeacherSchoolClassRecord
                                                                  .className
                                                            ],
                                                          },
                                                        ),
                                                      });
                                                      triggerPushNotification(
                                                        notificationTitle: _model
                                                            .eventnameTextController
                                                            .text,
                                                        notificationText: _model
                                                            .eventnameTextController
                                                            .text,
                                                        userRefs:
                                                            classNoticeAdminTeacherSchoolClassRecord
                                                                .listOfteachersUser
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
                                                          content:
                                                              _model.noticename,
                                                          descri: _model
                                                              .descriptionTextController
                                                              .text,
                                                          datetimeofevent:
                                                              _model.date,
                                                          isread: false,
                                                          notification:
                                                              updateNotificationStruct(
                                                            NotificationStruct(
                                                              notificationTitle:
                                                                  _model
                                                                      .eventnameTextController
                                                                      .text,
                                                              descriptions: _model
                                                                  .descriptionTextController
                                                                  .text,
                                                              timeStamp:
                                                                  getCurrentTimestamp,
                                                              isRead: false,
                                                              eventDate:
                                                                  _model.date,
                                                              notificationImages:
                                                                  _model
                                                                      .uploadedFileUrls1,
                                                            ),
                                                            clearUnsetFields:
                                                                false,
                                                            create: true,
                                                          ),
                                                          createDate:
                                                              getCurrentTimestamp,
                                                          tag:
                                                              _model.noticename,
                                                          addedby:
                                                              currentUserReference,
                                                          heading:
                                                              'Added a notice',
                                                        ),
                                                        ...mapToFirestore(
                                                          {
                                                            'userref':
                                                                classNoticeAdminTeacherSchoolClassRecord
                                                                    .listOfteachersUser,
                                                            'towhome': [
                                                              classNoticeAdminTeacherSchoolClassRecord
                                                                  .className
                                                            ],
                                                          },
                                                        ),
                                                      });
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Notice Added!',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                            ),
                                                          ),
                                                          duration: const Duration(
                                                              milliseconds:
                                                                  3100),
                                                          backgroundColor:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .primaryText,
                                                        ),
                                                      );
                                                      if (valueOrDefault(
                                                              currentUserDocument
                                                                  ?.userRole,
                                                              0) ==
                                                          2) {
                                                        safeSetState(() {
                                                          _model
                                                              .eventnameTextController
                                                              ?.clear();
                                                          _model
                                                              .descriptionTextController
                                                              ?.clear();
                                                        });
                                                        FFAppState()
                                                            .eventnoticeimage = [];
                                                        safeSetState(() {});
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (dialogContext) {
                                                            return Dialog(
                                                              elevation: 0,
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .zero,
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
                                                                child:
                                                                    SizedBox(
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.08,
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.6,
                                                                  child:
                                                                      const NoticecreatedWidget(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );

                                                        context.goNamed(
                                                          'Class_view',
                                                          queryParameters: {
                                                            'datePick':
                                                                serializeParam(
                                                              _model.datePicked,
                                                              ParamType
                                                                  .DateTime,
                                                            ),
                                                            'schoolclassref':
                                                                serializeParam(
                                                              classNoticeAdminTeacherSchoolClassRecord
                                                                  .reference,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                            'schoolref':
                                                                serializeParam(
                                                              widget.schoolref,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String,
                                                              dynamic>{
                                                            kTransitionInfoKey:
                                                                const TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .fade,
                                                            ),
                                                          },
                                                        );
                                                      } else {
                                                        _model.school =
                                                            await SchoolRecord
                                                                .getDocumentOnce(
                                                                    widget
                                                                        .schoolref!);
                                                        triggerPushNotification(
                                                          notificationTitle: _model
                                                              .eventnameTextController
                                                              .text,
                                                          notificationText: _model
                                                              .eventnameTextController
                                                              .text,
                                                          userRefs: [
                                                            _model
                                                                .school!
                                                                .principalDetails
                                                                .principalId!
                                                          ],
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
                                                                .noticename,
                                                            descri: _model
                                                                .descriptionTextController
                                                                .text,
                                                            datetimeofevent:
                                                                _model.date,
                                                            isread: false,
                                                            notification:
                                                                updateNotificationStruct(
                                                              NotificationStruct(
                                                                notificationTitle:
                                                                    _model
                                                                        .eventnameTextController
                                                                        .text,
                                                                descriptions: _model
                                                                    .descriptionTextController
                                                                    .text,
                                                                timeStamp:
                                                                    getCurrentTimestamp,
                                                                isRead: false,
                                                                eventDate:
                                                                    _model.date,
                                                                notificationImages:
                                                                    _model
                                                                        .uploadedFileUrls1,
                                                              ),
                                                              clearUnsetFields:
                                                                  false,
                                                              create: true,
                                                            ),
                                                            createDate:
                                                                getCurrentTimestamp,
                                                            tag: _model
                                                                .noticename,
                                                            addedby:
                                                                currentUserReference,
                                                            heading:
                                                                'Added a notice',
                                                          ),
                                                          ...mapToFirestore(
                                                            {
                                                              'schoolref': [
                                                                widget
                                                                    .schoolref
                                                              ],
                                                              'towhome': [
                                                                classNoticeAdminTeacherSchoolClassRecord
                                                                    .className
                                                              ],
                                                            },
                                                          ),
                                                        });
                                                        safeSetState(() {
                                                          _model
                                                              .eventnameTextController
                                                              ?.clear();
                                                          _model
                                                              .descriptionTextController
                                                              ?.clear();
                                                        });
                                                        FFAppState()
                                                            .eventnoticeimage = [];
                                                        safeSetState(() {});
                                                        await showDialog(
                                                          context: context,
                                                          builder:
                                                              (dialogContext) {
                                                            return Dialog(
                                                              elevation: 0,
                                                              insetPadding:
                                                                  EdgeInsets
                                                                      .zero,
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
                                                                child:
                                                                    SizedBox(
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.08,
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.6,
                                                                  child:
                                                                      const NoticecreatedWidget(),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );

                                                        context.goNamed(
                                                          'Class_view',
                                                          queryParameters: {
                                                            'datePick':
                                                                serializeParam(
                                                              _model.date,
                                                              ParamType
                                                                  .DateTime,
                                                            ),
                                                            'schoolclassref':
                                                                serializeParam(
                                                              classNoticeAdminTeacherSchoolClassRecord
                                                                  .reference,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                            'schoolref':
                                                                serializeParam(
                                                              widget.schoolref,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                          }.withoutNulls,
                                                          extra: <String,
                                                              dynamic>{
                                                            kTransitionInfoKey:
                                                                const TransitionInfo(
                                                              hasTransition:
                                                                  true,
                                                              transitionType:
                                                                  PageTransitionType
                                                                      .fade,
                                                            ),
                                                          },
                                                        );
                                                      }
                                                    } else {
                                                      ScaffoldMessenger.of(
                                                              context)
                                                          .showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            'Please select the notice name.',
                                                            style: TextStyle(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
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

                                                    safeSetState(() {});
                                                  },
                                                  text: 'Create notice',
                                                  options: FFButtonOptions(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.5,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.05,
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(16.0, 0.0,
                                                                16.0, 0.0),
                                                    iconPadding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 0.0,
                                                                0.0, 0.0),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondary,
                                                    textStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .titleSmall
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                    elevation: 0.0,
                                                    borderSide: BorderSide(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
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
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(0.0, 1.0),
                    child: FFButtonWidget(
                      onPressed: () async {
                        context.goNamed(
                          'Class_view',
                          queryParameters: {
                            'schoolclassref': serializeParam(
                              widget.classref,
                              ParamType.DocumentReference,
                            ),
                            'schoolref': serializeParam(
                              widget.schoolref,
                              ParamType.DocumentReference,
                            ),
                            'datePick': serializeParam(
                              getCurrentTimestamp,
                              ParamType.DateTime,
                            ),
                          }.withoutNulls,
                          extra: <String, dynamic>{
                            kTransitionInfoKey: const TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                            ),
                          },
                        );
                      },
                      text: 'View all notice',
                      options: FFButtonOptions(
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        height: MediaQuery.sizeOf(context).height * 0.05,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            16.0, 0.0, 16.0, 0.0),
                        iconPadding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                        color: FlutterFlowTheme.of(context).primary,
                        textStyle:
                            FlutterFlowTheme.of(context).titleSmall.override(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  letterSpacing: 0.0,
                                ),
                        elevation: 0.0,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
