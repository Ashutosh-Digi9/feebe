import '/backend/backend.dart';
import '/components/editphoto_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/classshimmer/classshimmer_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'edit_teacher_admin_model.dart';
export 'edit_teacher_admin_model.dart';

class EditTeacherAdminWidget extends StatefulWidget {
  const EditTeacherAdminWidget({
    super.key,
    required this.schoolRef,
    required this.teacherref,
  });

  final DocumentReference? schoolRef;
  final DocumentReference? teacherref;

  @override
  State<EditTeacherAdminWidget> createState() => _EditTeacherAdminWidgetState();
}

class _EditTeacherAdminWidgetState extends State<EditTeacherAdminWidget> {
  late EditTeacherAdminModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditTeacherAdminModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().imageurl =
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
      FFAppState().profileimagechanged = false;
      FFAppState().schoolimage =
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png';
      FFAppState().schoolimagechanged = false;
      safeSetState(() {});
      _model.schol = await SchoolRecord.getDocumentOnce(widget.schoolRef!);
      _model.teacherdata = TeacherListStruct(
        teacherName: _model.schol?.teachersDataList
            .where((e) => e.teachersId == widget.teacherref)
            .toList()
            .firstOrNull
            ?.teacherName,
        phoneNumber: _model.schol?.teachersDataList
            .where((e) => e.teachersId == widget.teacherref)
            .toList()
            .firstOrNull
            ?.phoneNumber,
        emailId: _model.schol?.teachersDataList
            .where((e) => e.teachersId == widget.teacherref)
            .toList()
            .firstOrNull
            ?.emailId,
        teacherImage: _model.schol?.teachersDataList
            .where((e) => e.teachersId == widget.teacherref)
            .toList()
            .firstOrNull
            ?.teacherImage,
        teachersId: _model.schol?.teachersDataList
            .where((e) => e.teachersId == widget.teacherref)
            .toList()
            .firstOrNull
            ?.teachersId,
        userRef: _model.schol?.teachersDataList
            .where((e) => e.teachersId == widget.teacherref)
            .toList()
            .firstOrNull
            ?.userRef,
      );
      safeSetState(() {});
    });

    _model.contactNameFocusNode ??= FocusNode();

    _model.contactPhonenumberFocusNode ??= FocusNode();

    _model.contactemailFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<TeachersRecord>(
      stream: TeachersRecord.getDocument(widget.teacherref!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
            body: const ClassshimmerWidget(),
          );
        }

        final editTeacherAdminTeachersRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).secondaryBackground,
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
                'Edit Teacher',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
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
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.75,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).newBgcolor,
                    ),
                    child: Form(
                      key: _model.formKey,
                      autovalidateMode: AutovalidateMode.disabled,
                      child: Align(
                        alignment: const AlignmentDirectional(0.0, -1.0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: FlutterFlowExpandedImageView(
                                          image: Image.network(
                                            valueOrDefault<String>(
                                              FFAppState().profileimagechanged ==
                                                      true
                                                  ? FFAppState().imageurl
                                                  : editTeacherAdminTeachersRecord
                                                      .teacherImage,
                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                          allowRotation: false,
                                          tag: valueOrDefault<String>(
                                            FFAppState().profileimagechanged ==
                                                    true
                                                ? FFAppState().imageurl
                                                : editTeacherAdminTeachersRecord
                                                    .teacherImage,
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                          ),
                                          useHeroAnimation: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: valueOrDefault<String>(
                                      FFAppState().profileimagechanged == true
                                          ? FFAppState().imageurl
                                          : editTeacherAdminTeachersRecord
                                              .teacherImage,
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                    ),
                                    transitionOnUserGestures: true,
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.45,
                                      height: MediaQuery.sizeOf(context).width *
                                          0.45,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        valueOrDefault<String>(
                                          FFAppState().profileimagechanged ==
                                                  true
                                              ? FFAppState().imageurl
                                              : editTeacherAdminTeachersRecord
                                                  .teacherImage,
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                        ),
                                        fit: BoxFit.cover,
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
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          onTap: () {
                                            FocusScope.of(context).unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: SizedBox(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.2,
                                              child: const EditphotoWidget(
                                                person: true,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  child: Text(
                                    'Change Picture',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  child: TextFormField(
                                    controller:
                                        _model.contactNameTextController ??=
                                            TextEditingController(
                                      text: editTeacherAdminTeachersRecord
                                          .teacherName,
                                    ),
                                    focusNode: _model.contactNameFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Teacher\'s name ',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: valueOrDefault<Color>(
                                              (_model.contactNameFocusNode
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
                                      hintText: 'Teacher’s name',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w200,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .dIsable,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .newBgcolor,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          letterSpacing: 0.0,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .contactNameTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  child: TextFormField(
                                    controller: _model
                                            .contactPhonenumberTextController ??=
                                        TextEditingController(
                                      text: editTeacherAdminTeachersRecord
                                          .phoneNumber,
                                    ),
                                    focusNode:
                                        _model.contactPhonenumberFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Teacher\'s phone number',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: valueOrDefault<Color>(
                                              (_model.contactPhonenumberFocusNode
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
                                      hintText: 'Teacher’s  phone number',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w200,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .dIsable,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .newBgcolor,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          letterSpacing: 0.0,
                                        ),
                                    maxLength: 10,
                                    buildCounter: (context,
                                            {required currentLength,
                                            required isFocused,
                                            maxLength}) =>
                                        null,
                                    keyboardType: TextInputType.number,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .contactPhonenumberTextControllerValidator
                                        .asValidator(context),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]'))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  child: TextFormField(
                                    controller:
                                        _model.contactemailTextController ??=
                                            TextEditingController(
                                      text: editTeacherAdminTeachersRecord
                                          .emailId,
                                    ),
                                    focusNode: _model.contactemailFocusNode,
                                    autofocus: false,
                                    readOnly: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Teacher\'s email ID',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: valueOrDefault<Color>(
                                              (_model.contactemailFocusNode?.hasFocus ??
                                                      false)
                                                  ? FlutterFlowTheme.of(context)
                                                      .primary
                                                  : FlutterFlowTheme.of(context)
                                                      .text,
                                              FlutterFlowTheme.of(context).text,
                                            ),
                                            letterSpacing: 0.0,
                                          ),
                                      hintText: 'Teacher’s email ID',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w200,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .dIsable,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      filled: true,
                                      fillColor: FlutterFlowTheme.of(context)
                                          .newBgcolor,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          letterSpacing: 0.0,
                                        ),
                                    keyboardType: TextInputType.emailAddress,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .contactemailTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                              ].divide(const SizedBox(height: 15.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsetsDirectional.fromSTEB(0.0, 20.0, 0.0, 0.0),
                    child: Material(
                      color: Colors.transparent,
                      elevation: 2.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 18.9,
                              color: Color(0x1B555555),
                              offset: Offset(
                                0.0,
                                -10.0,
                              ),
                              spreadRadius: 0.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: const Color(0xFFF4F4F4),
                          ),
                        ),
                        child: Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: FFButtonWidget(
                            onPressed: () async {
                              if (_model.formKey.currentState == null ||
                                  !_model.formKey.currentState!.validate()) {
                                return;
                              }

                              await widget.teacherref!
                                  .update(createTeachersRecordData(
                                teacherName:
                                    _model.contactNameTextController.text,
                                phoneNumber: _model
                                    .contactPhonenumberTextController.text,
                                teacherImage: FFAppState().profileimagechanged
                                    ? FFAppState().imageurl
                                    : editTeacherAdminTeachersRecord
                                        .teacherImage,
                              ));

                              await editTeacherAdminTeachersRecord.useref!
                                  .update(createUsersRecordData(
                                photoUrl: FFAppState().profileimagechanged
                                    ? FFAppState().imageurl
                                    : editTeacherAdminTeachersRecord
                                        .teacherImage,
                                displayName:
                                    _model.contactNameTextController.text,
                                phoneNumber: _model
                                    .contactPhonenumberTextController.text,
                              ));

                              await widget.schoolRef!.update({
                                ...mapToFirestore(
                                  {
                                    'teachers_data_list':
                                        FieldValue.arrayRemove([
                                      getTeacherListFirestoreData(
                                        updateTeacherListStruct(
                                          _model.teacherdata,
                                          clearUnsetFields: false,
                                        ),
                                        true,
                                      )
                                    ]),
                                  },
                                ),
                              });

                              await widget.schoolRef!.update({
                                ...mapToFirestore(
                                  {
                                    'teachers_data_list':
                                        FieldValue.arrayUnion([
                                      getTeacherListFirestoreData(
                                        updateTeacherListStruct(
                                          TeacherListStruct(
                                            teacherName: _model
                                                .contactNameTextController.text,
                                            phoneNumber: _model
                                                .contactPhonenumberTextController
                                                .text,
                                            emailId: _model
                                                .contactemailTextController
                                                .text,
                                            teacherImage: FFAppState()
                                                    .profileimagechanged
                                                ? FFAppState().imageurl
                                                : editTeacherAdminTeachersRecord
                                                    .teacherImage,
                                            teachersId: widget.teacherref,
                                            userRef:
                                                editTeacherAdminTeachersRecord
                                                    .useref,
                                          ),
                                          clearUnsetFields: false,
                                        ),
                                        true,
                                      )
                                    ]),
                                  },
                                ),
                              });
                              FFAppState().imageurl =
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
                              FFAppState().profileimagechanged = false;
                              FFAppState().schoolimage =
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png';
                              FFAppState().schoolimagechanged = false;
                              safeSetState(() {});

                              context.goNamed(
                                'Teacherdetailsedited',
                                queryParameters: {
                                  'schoolref': serializeParam(
                                    widget.schoolRef,
                                    ParamType.DocumentReference,
                                  ),
                                  'teacheref': serializeParam(
                                    widget.teacherref,
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
                            },
                            text: 'Save',
                            options: FFButtonOptions(
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              height: MediaQuery.sizeOf(context).height * 0.06,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).primary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                fontFamily: 'Nunito',
                                color: Colors.white,
                                letterSpacing: 0.0,
                                shadows: [
                                  const Shadow(
                                    color: Color(0x7B253EA7),
                                    offset: Offset(0.0, 1.0),
                                    blurRadius: 2.0,
                                  ),
                                  const Shadow(
                                    color: Color(0xFF375DFB),
                                    offset: Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                  )
                                ],
                              ),
                              elevation: 0.0,
                              borderRadius: BorderRadius.circular(8.0),
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
        );
      },
    );
  }
}
