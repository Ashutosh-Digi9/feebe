import '/admin_dashboard/edit_indi_student/edit_indi_student_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_video_player.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/classshimmer/classshimmer_widget.dart';
import '/shimmer_effects/main_dashboard_shimmer/main_dashboard_shimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:aligned_dialog/aligned_dialog.dart';
import 'package:flutter/material.dart';
import 'indistudentmainpages_model.dart';
export 'indistudentmainpages_model.dart';

class IndistudentmainpagesWidget extends StatefulWidget {
  const IndistudentmainpagesWidget({
    super.key,
    required this.studentsref,
    required this.classref,
    required this.schoolref,
  });

  final DocumentReference? studentsref;
  final List<DocumentReference>? classref;
  final DocumentReference? schoolref;

  @override
  State<IndistudentmainpagesWidget> createState() =>
      _IndistudentmainpagesWidgetState();
}

class _IndistudentmainpagesWidgetState
    extends State<IndistudentmainpagesWidget> {
  late IndistudentmainpagesModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => IndistudentmainpagesModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<StudentsRecord>(
      stream: StudentsRecord.getDocument(widget.studentsref!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: const MainDashboardShimmerWidget(),
          );
        }

        final indistudentmainpagesStudentsRecord = snapshot.data!;

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
                      queryParameters: {
                        'tabindex': serializeParam(
                          3,
                          ParamType.int,
                        ),
                      }.withoutNulls,
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
                        'tabindex': serializeParam(
                          3,
                          ParamType.int,
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
                'Student Profile ',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              actions: [
                Visibility(
                  visible:
                      valueOrDefault(currentUserDocument?.userRole, 0) != 1,
                  child: Builder(
                    builder: (context) => Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 15.0, 0.0),
                      child: AuthUserStreamWidget(
                        builder: (context) => InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            await showAlignedDialog(
                              context: context,
                              isGlobal: false,
                              avoidOverflow: false,
                              targetAnchor: const AlignmentDirectional(1.0, 1.0)
                                  .resolve(Directionality.of(context)),
                              followerAnchor: const AlignmentDirectional(1.0, 0.0)
                                  .resolve(Directionality.of(context)),
                              builder: (dialogContext) {
                                return Material(
                                  color: Colors.transparent,
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(dialogContext).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.12,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.45,
                                      child: EditIndiStudentWidget(
                                        clssref: widget.classref!,
                                        studentref:
                                            indistudentmainpagesStudentsRecord
                                                .reference,
                                        schoolref: widget.schoolref!,
                                        stduentdatatype: StudentListStruct(
                                          studentName:
                                              indistudentmainpagesStudentsRecord
                                                  .studentName,
                                          studentId:
                                              indistudentmainpagesStudentsRecord
                                                  .reference,
                                          studentImage:
                                              indistudentmainpagesStudentsRecord
                                                  .studentImage,
                                          parentList:
                                              indistudentmainpagesStudentsRecord
                                                  .parentsList,
                                          isAddedinClass: true,
                                          classref:
                                              indistudentmainpagesStudentsRecord
                                                  .classref,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Icon(
                            Icons.more_vert,
                            color: FlutterFlowTheme.of(context).primaryText,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                child: Container(
                  decoration: const BoxDecoration(),
                  child: Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 0.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondary,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 0.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Align(
                                            alignment:
                                                const AlignmentDirectional(0.0, -1.0),
                                            child: Container(
                                              width: 60.0,
                                              height: 60.0,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                              ),
                                              child: InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  await Navigator.push(
                                                    context,
                                                    PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child:
                                                          FlutterFlowExpandedImageView(
                                                        image: Image.network(
                                                          valueOrDefault<
                                                              String>(
                                                            indistudentmainpagesStudentsRecord
                                                                .studentImage,
                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                          ),
                                                          fit: BoxFit.contain,
                                                        ),
                                                        allowRotation: false,
                                                        tag: valueOrDefault<
                                                            String>(
                                                          indistudentmainpagesStudentsRecord
                                                              .studentImage,
                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                        ),
                                                        useHeroAnimation: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Hero(
                                                  tag: valueOrDefault<String>(
                                                    indistudentmainpagesStudentsRecord
                                                        .studentImage,
                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                  ),
                                                  transitionOnUserGestures:
                                                      true,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                    child: Image.network(
                                                      valueOrDefault<String>(
                                                        indistudentmainpagesStudentsRecord
                                                            .studentImage,
                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                      ),
                                                      width: 200.0,
                                                      height: 200.0,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 5.0),
                                                child: Text(
                                                  indistudentmainpagesStudentsRecord
                                                      .studentName,
                                                  maxLines: 2,
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        fontSize: 16.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 5.0),
                                                child: Text(
                                                  'Age - ${functions.calculateAgeInYears(indistudentmainpagesStudentsRecord.dateOfBirth!)}',
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .text1,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                ),
                                              ),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.4,
                                                decoration: const BoxDecoration(),
                                                child: Builder(
                                                  builder: (context) {
                                                    final classess =
                                                        indistudentmainpagesStudentsRecord
                                                            .classref
                                                            .toList();

                                                    return Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: List.generate(
                                                          classess.length,
                                                          (classessIndex) {
                                                        final classessItem =
                                                            classess[
                                                                classessIndex];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      5.0),
                                                          child: StreamBuilder<
                                                              SchoolClassRecord>(
                                                            stream: SchoolClassRecord
                                                                .getDocument(
                                                                    classessItem),
                                                            builder: (context,
                                                                snapshot) {
                                                              // Customize what your widget looks like when it's loading.
                                                              if (!snapshot
                                                                  .hasData) {
                                                                return Center(
                                                                  child:
                                                                      SizedBox(
                                                                    width: 50.0,
                                                                    height:
                                                                        50.0,
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      valueColor:
                                                                          AlwaysStoppedAnimation<
                                                                              Color>(
                                                                        FlutterFlowTheme.of(context)
                                                                            .primary,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                );
                                                              }

                                                              final textSchoolClassRecord =
                                                                  snapshot
                                                                      .data!;

                                                              return Text(
                                                                '${textSchoolClassRecord.className} , ',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .text1,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                    ),
                                                              );
                                                            },
                                                          ),
                                                        );
                                                      }),
                                                    );
                                                  },
                                                ),
                                              ),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.4,
                                                decoration: const BoxDecoration(),
                                              ),
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.4,
                                                decoration: const BoxDecoration(),
                                                child: Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 10.0),
                                                  child: Text(
                                                    'Allergies : ${indistudentmainpagesStudentsRecord.allergiesOthers}',
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .text1,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              if (indistudentmainpagesStudentsRecord
                                                          .document !=
                                                      '')
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 0.0, 10.0),
                                                  child: FFButtonWidget(
                                                    onPressed: () async {
                                                      await launchURL(
                                                          indistudentmainpagesStudentsRecord
                                                              .document);
                                                    },
                                                    text: 'View Document',
                                                    icon: const Icon(
                                                      Icons.visibility_sharp,
                                                      size: 15.0,
                                                    ),
                                                    options: FFButtonOptions(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.4,
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.04,
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  16.0,
                                                                  0.0,
                                                                  16.0,
                                                                  0.0),
                                                      iconPadding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  0.0),
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      textStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .titleSmall
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryBackground,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      elevation: 0.0,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                  ),
                                                ),
                                            ]
                                                .divide(const SizedBox(height: 1.0))
                                                .around(const SizedBox(height: 1.0)),
                                          ),
                                        ]
                                            .divide(const SizedBox(width: 10.0))
                                            .around(const SizedBox(width: 10.0)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 0.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondary,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Align(
                                        alignment:
                                            const AlignmentDirectional(-1.0, 0.0),
                                        child: Padding(
                                          padding:
                                              const EdgeInsetsDirectional.fromSTEB(
                                                  5.0, 10.0, 0.0, 0.0),
                                          child: Text(
                                            'Parent Contact Details',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Nunito',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .text1,
                                                  fontSize: 16.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: const BoxDecoration(),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.4,
                                                    decoration: const BoxDecoration(),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      5.0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              indistudentmainpagesStudentsRecord
                                                                  .parentsDetails
                                                                  .firstOrNull
                                                                  ?.parentsName,
                                                              'name',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .text1,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      10.0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              indistudentmainpagesStudentsRecord
                                                                  .parentsDetails
                                                                  .firstOrNull
                                                                  ?.parentsPhone,
                                                              'name',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .text1,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      5.0),
                                                          child: Text(
                                                            valueOrDefault<
                                                                String>(
                                                              indistudentmainpagesStudentsRecord
                                                                  .parentsDetails
                                                                  .firstOrNull
                                                                  ?.parentsEmail,
                                                              'name',
                                                            ),
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .text1,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                          ),
                                                        ),
                                                        if (indistudentmainpagesStudentsRecord
                                                                    .parentsDetails
                                                                    .firstOrNull
                                                                    ?.document !=
                                                                null &&
                                                            indistudentmainpagesStudentsRecord
                                                                    .parentsDetails
                                                                    .firstOrNull
                                                                    ?.document !=
                                                                '')
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        10.0,
                                                                        0.0,
                                                                        0.0),
                                                            child:
                                                                FFButtonWidget(
                                                              onPressed:
                                                                  () async {
                                                                await launchURL(
                                                                    indistudentmainpagesStudentsRecord
                                                                        .parentsDetails
                                                                        .firstOrNull!
                                                                        .document);
                                                              },
                                                              text:
                                                                  'View Document',
                                                              icon: const Icon(
                                                                Icons
                                                                    .visibility_sharp,
                                                                size: 15.0,
                                                              ),
                                                              options:
                                                                  FFButtonOptions(
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.3,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.04,
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                                iconPadding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            0.0),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .secondaryBackground,
                                                                textStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                elevation: 0.0,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                              ),
                                                            ),
                                                          ),
                                                      ].divide(const SizedBox(
                                                          height: 5.0)),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 150.0,
                                                    child: VerticalDivider(
                                                      thickness: 2.0,
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                    ),
                                                  ),
                                                  if ((indistudentmainpagesStudentsRecord
                                                              .parentsList
                                                              .length ==
                                                          2) ||
                                                      (indistudentmainpagesStudentsRecord
                                                              .parentsList
                                                              .length ==
                                                          3))
                                                    Container(
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.4,
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                indistudentmainpagesStudentsRecord
                                                                    .parentsDetails
                                                                    .elementAtOrNull(
                                                                        1)
                                                                    ?.parentsName,
                                                                'name',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .text1,
                                                                    letterSpacing:
                                                                        0.0,
                                                                  ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        10.0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                indistudentmainpagesStudentsRecord
                                                                    .parentsDetails
                                                                    .elementAtOrNull(
                                                                        1)
                                                                    ?.parentsPhone,
                                                                'name',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .text1,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: Text(
                                                              valueOrDefault<
                                                                  String>(
                                                                indistudentmainpagesStudentsRecord
                                                                    .parentsDetails
                                                                    .elementAtOrNull(
                                                                        1)
                                                                    ?.parentsEmail,
                                                                'name',
                                                              ),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .text1,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                  ),
                                                            ),
                                                          ),
                                                          if (indistudentmainpagesStudentsRecord
                                                                      .parentsDetails
                                                                      .elementAtOrNull(
                                                                          1)
                                                                      ?.document !=
                                                                  null &&
                                                              indistudentmainpagesStudentsRecord
                                                                      .parentsDetails
                                                                      .elementAtOrNull(
                                                                          1)
                                                                      ?.document !=
                                                                  '')
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                              child:
                                                                  FFButtonWidget(
                                                                onPressed:
                                                                    () async {
                                                                  await launchURL(indistudentmainpagesStudentsRecord
                                                                      .parentsDetails
                                                                      .elementAtOrNull(
                                                                          1)!
                                                                      .document);
                                                                },
                                                                text:
                                                                    'View Document',
                                                                icon: const Icon(
                                                                  Icons
                                                                      .visibility_sharp,
                                                                  size: 15.0,
                                                                ),
                                                                options:
                                                                    FFButtonOptions(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.3,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.04,
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          16.0,
                                                                          0.0,
                                                                          16.0,
                                                                          0.0),
                                                                  iconPadding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          0.0),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  textStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .override(
                                                                        fontFamily:
                                                                            'Nunito',
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .primaryBackground,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                  elevation:
                                                                      0.0,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8.0),
                                                                ),
                                                              ),
                                                            ),
                                                        ].divide(const SizedBox(
                                                            height: 5.0)),
                                                      ),
                                                    ),
                                                ].divide(const SizedBox(width: 5.0)),
                                              ),
                                            ),
                                            if (indistudentmainpagesStudentsRecord
                                                    .parentsList.length ==
                                                3)
                                              Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.4,
                                                decoration: const BoxDecoration(),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  5.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          indistudentmainpagesStudentsRecord
                                                              .parentsDetails
                                                              .elementAtOrNull(
                                                                  2)
                                                              ?.parentsName,
                                                          'name',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .text1,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  10.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          indistudentmainpagesStudentsRecord
                                                              .parentsDetails
                                                              .elementAtOrNull(
                                                                  2)
                                                              ?.parentsPhone,
                                                          'name',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .text1,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  5.0),
                                                      child: Text(
                                                        valueOrDefault<String>(
                                                          indistudentmainpagesStudentsRecord
                                                              .parentsDetails
                                                              .elementAtOrNull(
                                                                  2)
                                                              ?.parentsEmail,
                                                          'name',
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .text1,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                ),
                                                      ),
                                                    ),
                                                    if (indistudentmainpagesStudentsRecord
                                                                .parentsDetails
                                                                .elementAtOrNull(
                                                                    2)
                                                                ?.document !=
                                                            null &&
                                                        indistudentmainpagesStudentsRecord
                                                                .parentsDetails
                                                                .elementAtOrNull(
                                                                    2)
                                                                ?.document !=
                                                            '')
                                                      Padding(
                                                        padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    10.0,
                                                                    0.0,
                                                                    0.0),
                                                        child: FFButtonWidget(
                                                          onPressed: () async {
                                                            await launchURL(
                                                                indistudentmainpagesStudentsRecord
                                                                    .parentsDetails
                                                                    .elementAtOrNull(
                                                                        2)!
                                                                    .document);
                                                          },
                                                          text: 'View Document',
                                                          icon: const Icon(
                                                            Icons
                                                                .visibility_sharp,
                                                            size: 15.0,
                                                          ),
                                                          options:
                                                              FFButtonOptions(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.3,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.04,
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        16.0,
                                                                        0.0,
                                                                        16.0,
                                                                        0.0),
                                                            iconPadding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        0.0),
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground,
                                                            textStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .titleSmall
                                                                    .override(
                                                                      fontFamily:
                                                                          'Nunito',
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryBackground,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                            elevation: 0.0,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8.0),
                                                          ),
                                                        ),
                                                      ),
                                                  ].divide(
                                                      const SizedBox(height: 5.0)),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ].addToEnd(const SizedBox(height: 10.0)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: Material(
                              color: Colors.transparent,
                              elevation: 5.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                decoration: BoxDecoration(
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Align(
                                      alignment: const AlignmentDirectional(0.0, 0.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 12.0, 0.0, 0.0),
                                        child: Text(
                                          'Today \'s Timeline',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Nunito',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                fontSize: 18.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 15.0),
                                        child: Builder(
                                          builder: (context) {
                                            final timeslines =
                                                indistudentmainpagesStudentsRecord
                                                    .timeline
                                                    .where((e) =>
                                                        dateTimeFormat(
                                                            "yMd", e.date) ==
                                                        dateTimeFormat("yMd",
                                                            getCurrentTimestamp))
                                                    .toList()
                                                    .unique((e) => e.activityId)
                                                    .toList()
                                                    .take(4)
                                                    .toList();
                                            if (timeslines.isEmpty) {
                                              return const Center(
                                                child: EmptyWidget(),
                                              );
                                            }

                                            return Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: List.generate(
                                                  timeslines.length,
                                                  (timeslinesIndex) {
                                                final timeslinesItem =
                                                    timeslines[timeslinesIndex];
                                                return Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 10.0, 0.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        height:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.12,
                                                        clipBehavior:
                                                            Clip.antiAlias,
                                                        decoration:
                                                            const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                        ),
                                                        child: Image.network(
                                                          () {
                                                            if (timeslinesItem
                                                                    .activityId ==
                                                                0) {
                                                              return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Ffork_and_knife_with_plate.png?alt=media&token=d3c0ab7c-f43b-4a3b-b615-02135d701b23';
                                                            } else if (timeslinesItem
                                                                    .activityId ==
                                                                1) {
                                                              return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FBitmap.png?alt=media&token=932b22f6-a33b-4cb2-a8f8-a3d176899f44';
                                                            } else if (timeslinesItem
                                                                    .activityId ==
                                                                2) {
                                                              return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fcamera.png?alt=media&token=4349afe9-7085-47ec-9527-857f6ce94378';
                                                            } else if (timeslinesItem
                                                                    .activityId ==
                                                                3) {
                                                              return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FAppreciation.png?alt=media&token=d7cd93a2-eaed-4068-8271-5c3c69805c34';
                                                            } else if (timeslinesItem
                                                                    .activityId ==
                                                                4) {
                                                              return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fpotty_(2).png?alt=media&token=ebf034f3-760d-405e-b9db-1a8407d2ec02';
                                                            } else if (timeslinesItem
                                                                    .activityId ==
                                                                0) {
                                                              return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Ffork_and_knife_with_plate.png?alt=media&token=d3c0ab7c-f43b-4a3b-b615-02135d701b23';
                                                            } else if (timeslinesItem
                                                                    .activityId ==
                                                                1) {
                                                              return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FBitmap.png?alt=media&token=932b22f6-a33b-4cb2-a8f8-a3d176899f44';
                                                            } else if (timeslinesItem
                                                                    .activityId ==
                                                                2) {
                                                              return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fcamera.png?alt=media&token=4349afe9-7085-47ec-9527-857f6ce94378';
                                                            } else if (timeslinesItem
                                                                    .activityId ==
                                                                3) {
                                                              return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FAppreciation.png?alt=media&token=d7cd93a2-eaed-4068-8271-5c3c69805c34';
                                                            } else if (timeslinesItem
                                                                    .activityId ==
                                                                4) {
                                                              return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fpotty_(2).png?alt=media&token=ebf034f3-760d-405e-b9db-1a8407d2ec02';
                                                            } else {
                                                              return 'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FIncident.png?alt=media&token=f2401cf9-a754-4a0c-8f2f-ad0423ebe926';
                                                            }
                                                          }(),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      Text(
                                                        dateTimeFormat(
                                                            "jm",
                                                            timeslinesItem
                                                                .date!),
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
                                                    ],
                                                  ),
                                                );
                                              }),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Builder(
                            builder: (context) {
                              final classes = indistudentmainpagesStudentsRecord
                                  .classref
                                  .toList();
                              if (classes.isEmpty) {
                                return Center(
                                  child: SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 1.0,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.3,
                                    child: const EmptyWidget(),
                                  ),
                                );
                              }

                              return ListView.builder(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: classes.length,
                                itemBuilder: (context, classesIndex) {
                                  final classesItem = classes[classesIndex];
                                  return Align(
                                    alignment: const AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child:
                                              StreamBuilder<SchoolClassRecord>(
                                            stream:
                                                SchoolClassRecord.getDocument(
                                                    classesItem),
                                            builder: (context, snapshot) {
                                              // Customize what your widget looks like when it's loading.
                                              if (!snapshot.hasData) {
                                                return SizedBox(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          1.0,
                                                  child: const ClassshimmerWidget(),
                                                );
                                              }

                                              final containerSchoolClassRecord =
                                                  snapshot.data!;

                                              return Material(
                                                color: Colors.transparent,
                                                elevation: 2.0,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .secondaryBackground,
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                10.0,
                                                                10.0,
                                                                0.0,
                                                                10.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Align(
                                                          alignment:
                                                              const AlignmentDirectional(
                                                                  -1.0, 0.0),
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        15.0,
                                                                        0.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: Text(
                                                              'Class : ${containerSchoolClassRecord.className}',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primary,
                                                                    fontSize:
                                                                        18.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      10.0,
                                                                      10.0,
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
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    context
                                                                        .pushNamed(
                                                                      'class_attendence',
                                                                      queryParameters:
                                                                          {
                                                                        'classRef':
                                                                            serializeParam(
                                                                          classesItem,
                                                                          ParamType
                                                                              .DocumentReference,
                                                                        ),
                                                                        'schoolref':
                                                                            serializeParam(
                                                                          widget
                                                                              .schoolref,
                                                                          ParamType
                                                                              .DocumentReference,
                                                                        ),
                                                                        'classattendence':
                                                                            serializeParam(
                                                                          false,
                                                                          ParamType
                                                                              .bool,
                                                                        ),
                                                                        'classes':
                                                                            serializeParam(
                                                                          true,
                                                                          ParamType
                                                                              .bool,
                                                                        ),
                                                                      }.withoutNulls,
                                                                    );
                                                                  },
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        2.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.25,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.08,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                4.0,
                                                                            color:
                                                                                Color(0x491D61E7),
                                                                            offset:
                                                                                Offset(
                                                                              0.0,
                                                                              2.0,
                                                                            ),
                                                                          )
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(5.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            StreamBuilder<SchoolClassRecord>(
                                                                              stream: SchoolClassRecord.getDocument(classesItem),
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

                                                                                final textSchoolClassRecord = snapshot.data!;

                                                                                return Text(
                                                                                  '${functions.calculateAttendancePercentage(textSchoolClassRecord.attendance.toList(), indistudentmainpagesStudentsRecord.reference).toString()} %',
                                                                                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                        fontFamily: 'Nunito',
                                                                                        color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                        fontSize: 24.0,
                                                                                        letterSpacing: 0.0,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                );
                                                                              },
                                                                            ),
                                                                            Text(
                                                                              'Attendance',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Nunito',
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                child: InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    context
                                                                        .pushNamed(
                                                                      'calender_class',
                                                                      queryParameters:
                                                                          {
                                                                        'schoolclassref':
                                                                            serializeParam(
                                                                          containerSchoolClassRecord
                                                                              .reference,
                                                                          ParamType
                                                                              .DocumentReference,
                                                                        ),
                                                                        'schoolref':
                                                                            serializeParam(
                                                                          widget
                                                                              .schoolref,
                                                                          ParamType
                                                                              .DocumentReference,
                                                                        ),
                                                                        'mainpage':
                                                                            serializeParam(
                                                                          false,
                                                                          ParamType
                                                                              .bool,
                                                                        ),
                                                                      }.withoutNulls,
                                                                    );
                                                                  },
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        2.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.25,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.08,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                4.0,
                                                                            color:
                                                                                Color(0x491D61E7),
                                                                            offset:
                                                                                Offset(
                                                                              0.0,
                                                                              2.0,
                                                                            ),
                                                                          )
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(5.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            ClipRRect(
                                                                              borderRadius: BorderRadius.circular(8.0),
                                                                              child: Image.asset(
                                                                                'assets/images/Saly-42.png',
                                                                                width: MediaQuery.sizeOf(context).width * 0.12,
                                                                                height: MediaQuery.sizeOf(context).height * 0.04,
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              'Calender',
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Nunito',
                                                                                    letterSpacing: 0.0,
                                                                                  ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
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
                                                                onTap:
                                                                    () async {
                                                                  if (valueOrDefault(
                                                                          currentUserDocument
                                                                              ?.userRole,
                                                                          0) ==
                                                                      1) {
                                                                    context
                                                                        .pushNamed(
                                                                      'calender_class',
                                                                      queryParameters:
                                                                          {
                                                                        'schoolclassref':
                                                                            serializeParam(
                                                                          classesItem,
                                                                          ParamType
                                                                              .DocumentReference,
                                                                        ),
                                                                        'schoolref':
                                                                            serializeParam(
                                                                          widget
                                                                              .schoolref,
                                                                          ParamType
                                                                              .DocumentReference,
                                                                        ),
                                                                        'mainpage':
                                                                            serializeParam(
                                                                          false,
                                                                          ParamType
                                                                              .bool,
                                                                        ),
                                                                      }.withoutNulls,
                                                                    );
                                                                  } else {
                                                                    context
                                                                        .pushNamed(
                                                                      'calender_class',
                                                                      queryParameters:
                                                                          {
                                                                        'schoolclassref':
                                                                            serializeParam(
                                                                          classesItem,
                                                                          ParamType
                                                                              .DocumentReference,
                                                                        ),
                                                                        'schoolref':
                                                                            serializeParam(
                                                                          widget
                                                                              .schoolref,
                                                                          ParamType
                                                                              .DocumentReference,
                                                                        ),
                                                                        'mainpage':
                                                                            serializeParam(
                                                                          false,
                                                                          ParamType
                                                                              .bool,
                                                                        ),
                                                                      }.withoutNulls,
                                                                    );
                                                                  }
                                                                },
                                                                child: Material(
                                                                  color: Colors
                                                                      .transparent,
                                                                  elevation:
                                                                      2.0,
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                  ),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.25,
                                                                    height: MediaQuery.sizeOf(context)
                                                                            .height *
                                                                        0.08,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondary,
                                                                      boxShadow: const [
                                                                        BoxShadow(
                                                                          blurRadius:
                                                                              4.0,
                                                                          color:
                                                                              Color(0x491D61E7),
                                                                          offset:
                                                                              Offset(
                                                                            0.0,
                                                                            2.0,
                                                                          ),
                                                                        )
                                                                      ],
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              5.0),
                                                                      child:
                                                                          Column(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          Icon(
                                                                            Icons.notifications_rounded,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).warning,
                                                                            size:
                                                                                34.0,
                                                                          ),
                                                                          Text(
                                                                            'Notice',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  fontFamily: 'Nunito',
                                                                                  letterSpacing: 0.0,
                                                                                ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
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
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              width: MediaQuery.sizeOf(context).width * 1.0,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text(
                                        'Pictures ${indistudentmainpagesStudentsRecord.studentName}  tagged in',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              letterSpacing: 0.0,
                                            ),
                                      ),
                                      FFButtonWidget(
                                        onPressed: () async {
                                          context.pushNamed(
                                            'Student_gallery',
                                            queryParameters: {
                                              'student': serializeParam(
                                                widget.studentsref,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );
                                        },
                                        text: 'View all',
                                        options: FFButtonOptions(
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
                                          textStyle: FlutterFlowTheme.of(
                                                  context)
                                              .titleSmall
                                              .override(
                                                fontFamily: 'Nunito',
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .primaryBackground,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          hoverTextColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                        ),
                                        showLoadingIndicator: false,
                                      ),
                                    ],
                                  ),
                                  if (indistudentmainpagesStudentsRecord
                                          .imageslist.isNotEmpty)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Builder(
                                          builder: (context) {
                                            final images =
                                                indistudentmainpagesStudentsRecord
                                                    .imageslist
                                                    .toList()
                                                    .take(4)
                                                    .toList();
                                            if (images.isEmpty) {
                                              return Center(
                                                child: SizedBox(
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.3,
                                                  child: const EmptyWidget(),
                                                ),
                                              );
                                            }

                                            return GridView.builder(
                                              padding: EdgeInsets.zero,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 3,
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 10.0,
                                                childAspectRatio: 1.0,
                                              ),
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: images.length,
                                              itemBuilder:
                                                  (context, imagesIndex) {
                                                final imagesItem =
                                                    images[imagesIndex];
                                                return Padding(
                                                  padding: const EdgeInsets.all(10.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.transparent,
                                                      focusColor:
                                                          Colors.transparent,
                                                      hoverColor:
                                                          Colors.transparent,
                                                      highlightColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        context.pushNamed(
                                                          'indivi_image_view',
                                                          queryParameters: {
                                                            'student':
                                                                serializeParam(
                                                              widget
                                                                  .studentsref,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                            'index':
                                                                serializeParam(
                                                              imagesIndex,
                                                              ParamType.int,
                                                            ),
                                                          }.withoutNulls,
                                                        );
                                                      },
                                                      onLongPress: () async {
                                                        await Navigator.push(
                                                          context,
                                                          PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .fade,
                                                            child:
                                                                FlutterFlowExpandedImageView(
                                                              image:
                                                                  Image.network(
                                                                imagesItem,
                                                                fit: BoxFit
                                                                    .contain,
                                                              ),
                                                              allowRotation:
                                                                  false,
                                                              tag: imagesItem,
                                                              useHeroAnimation:
                                                                  true,
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Hero(
                                                        tag: imagesItem,
                                                        transitionOnUserGestures:
                                                            true,
                                                        child: ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                          child: Image.network(
                                                            imagesItem,
                                                            fit: BoxFit.cover,
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
                                    ),
                                  if (indistudentmainpagesStudentsRecord
                                          .timelineVideo.isNotEmpty)
                                    Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 0.0),
                                        child: Builder(
                                          builder: (context) {
                                            final images =
                                                indistudentmainpagesStudentsRecord
                                                    .timelineVideo
                                                    .toList()
                                                    .take(4)
                                                    .toList();
                                            if (images.isEmpty) {
                                              return Center(
                                                child: SizedBox(
                                                  height:
                                                      MediaQuery.sizeOf(context)
                                                              .height *
                                                          0.3,
                                                  child: const EmptyWidget(),
                                                ),
                                              );
                                            }

                                            return GridView.builder(
                                              padding: EdgeInsets.zero,
                                              gridDelegate:
                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 10.0,
                                                mainAxisSpacing: 10.0,
                                                childAspectRatio: 0.9,
                                              ),
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: images.length,
                                              itemBuilder:
                                                  (context, imagesIndex) {
                                                final imagesItem =
                                                    images[imagesIndex];
                                                return FlutterFlowVideoPlayer(
                                                  path: imagesItem,
                                                  videoType: VideoType.network,
                                                  width: 100.0,
                                                  height: 100.0,
                                                  aspectRatio: 9.0,
                                                  autoPlay: false,
                                                  looping: true,
                                                  showControls: false,
                                                  allowFullScreen: true,
                                                  allowPlaybackSpeedMenu: false,
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                ]
                                    .divide(const SizedBox(height: 5.0))
                                    .around(const SizedBox(height: 5.0)),
                              ),
                            ),
                          ),
                        ]
                            .divide(const SizedBox(height: 15.0))
                            .addToEnd(const SizedBox(height: 10.0)),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
