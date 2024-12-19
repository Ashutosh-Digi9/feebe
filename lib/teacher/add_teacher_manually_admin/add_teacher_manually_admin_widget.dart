import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/editphoto_widget.dart';
import '/components/message_sent_s_a_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'add_teacher_manually_admin_model.dart';
export 'add_teacher_manually_admin_model.dart';

class AddTeacherManuallyAdminWidget extends StatefulWidget {
  const AddTeacherManuallyAdminWidget({
    super.key,
    required this.schoolRef,
  });

  final DocumentReference? schoolRef;

  @override
  State<AddTeacherManuallyAdminWidget> createState() =>
      _AddTeacherManuallyAdminWidgetState();
}

class _AddTeacherManuallyAdminWidgetState
    extends State<AddTeacherManuallyAdminWidget> {
  late AddTeacherManuallyAdminModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddTeacherManuallyAdminModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().imageurl =
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/kqg7tnob6oub/Add_profile_pic_(2).png';
      FFAppState().profileimagechanged = false;
      FFAppState().schoolimage =
          'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FFrame%20731.png?alt=media&token=4abe77e8-804d-485c-9b4a-d9532c4a190a';
      FFAppState().schoolimagechanged = false;
      safeSetState(() {});
      _model.currentPageLink = await generateCurrentPageLink(
        context,
        title: 'Add teacher',
        imageUrl: FFAppConstants.addImage,
        description: 'add teacher to the school',
        isShortLink: false,
      );
    });

    _model.contactNameTextController ??= TextEditingController();
    _model.contactNameFocusNode ??= FocusNode();

    _model.contactPhonenumberTextController ??= TextEditingController();
    _model.contactPhonenumberFocusNode ??= FocusNode();

    _model.contactemailTextController ??= TextEditingController();
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

    return StreamBuilder<SchoolRecord>(
      stream: SchoolRecord.getDocument(widget.schoolRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final addTeacherManuallyAdminSchoolRecord = snapshot.data!;

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
              leading: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onTap: () async {
                  context.pop();
                },
                child: Icon(
                  Icons.chevron_left,
                  color: FlutterFlowTheme.of(context).bgColor1,
                  size: 28.0,
                ),
              ),
              title: Text(
                'Add Teacher ',
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
              child: Form(
                key: _model.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.08,
                        decoration: const BoxDecoration(),
                        child: Align(
                          alignment: const AlignmentDirectional(0.0, 0.0),
                          child: Builder(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                await Share.share(
                                  _model.currentPageLink,
                                  sharePositionOrigin:
                                      getWidgetBoundingBox(context),
                                );
                              },
                              child: Text(
                                valueOrDefault<String>(
                                  addTeacherManuallyAdminSchoolRecord
                                      .schoolDetails.schoolName,
                                  'School name ',
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBackground,
                                      fontSize: 20.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
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
                                  FocusManager.instance.primaryFocus?.unfocus();
                                },
                                child: Padding(
                                  padding: MediaQuery.viewInsetsOf(context),
                                  child: SizedBox(
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.5,
                                    child: const EditphotoWidget(
                                      person: true,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).then((value) => safeSetState(() {}));
                        },
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 0.45,
                          height: MediaQuery.sizeOf(context).width * 0.45,
                          clipBehavior: Clip.antiAlias,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            FFAppState().profileimagechanged == true
                                ? FFAppState().imageurl
                                : FFAppConstants.addImage,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        child: TextFormField(
                          controller: _model.contactNameTextController,
                          focusNode: _model.contactNameFocusNode,
                          autofocus: false,
                          textCapitalization: TextCapitalization.words,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Teacher\'s Name ',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Nunito',
                                  color: valueOrDefault<Color>(
                                    (_model.contactNameFocusNode?.hasFocus ??
                                            false)
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .alternate,
                                    FlutterFlowTheme.of(context).alternate,
                                  ),
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Teacher’s name',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Nunito',
                                  color: FlutterFlowTheme.of(context).text,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).dIsable,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
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
                            fillColor:
                                (_model.contactNameFocusNode?.hasFocus ?? false)
                                    ? FlutterFlowTheme.of(context).tertiary
                                    : FlutterFlowTheme.of(context).secondary,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context).text1,
                                    letterSpacing: 0.0,
                                  ),
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.contactNameTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        child: TextFormField(
                          controller: _model.contactPhonenumberTextController,
                          focusNode: _model.contactPhonenumberFocusNode,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Teacher\'s Phone number ',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Nunito',
                                  color: valueOrDefault<Color>(
                                    (_model.contactPhonenumberFocusNode
                                                ?.hasFocus ??
                                            false)
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .alternate,
                                    FlutterFlowTheme.of(context).alternate,
                                  ),
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Teacher’s  phone number',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Nunito',
                                  color: FlutterFlowTheme.of(context).text,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).dIsable,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
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
                            fillColor:
                                (_model.contactPhonenumberFocusNode?.hasFocus ??
                                        false)
                                    ? FlutterFlowTheme.of(context).tertiary
                                    : FlutterFlowTheme.of(context).secondary,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context).text1,
                                    letterSpacing: 0.0,
                                  ),
                          maxLength: 10,
                          buildCounter: (context,
                                  {required currentLength,
                                  required isFocused,
                                  maxLength}) =>
                              null,
                          keyboardType: TextInputType.number,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model
                              .contactPhonenumberTextControllerValidator
                              .asValidator(context),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        child: TextFormField(
                          controller: _model.contactemailTextController,
                          focusNode: _model.contactemailFocusNode,
                          autofocus: false,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'Teacher\'s Email ID',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Nunito',
                                  color: valueOrDefault<Color>(
                                    (_model.contactemailFocusNode?.hasFocus ??
                                            false)
                                        ? FlutterFlowTheme.of(context).primary
                                        : FlutterFlowTheme.of(context)
                                            .alternate,
                                    FlutterFlowTheme.of(context).alternate,
                                  ),
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Teacher’s email ID',
                            hintStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Nunito',
                                  color: FlutterFlowTheme.of(context).text,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.w200,
                                ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context).dIsable,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
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
                            fillColor:
                                (_model.contactemailFocusNode?.hasFocus ??
                                        false)
                                    ? FlutterFlowTheme.of(context).tertiary
                                    : FlutterFlowTheme.of(context).secondary,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context).text1,
                                    letterSpacing: 0.0,
                                  ),
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.contactemailTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: Text(
                          'Your teacher will now receive an email with the login credentials . ',
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context)
                              .bodyMedium
                              .override(
                                fontFamily: 'Nunito',
                                color:
                                    FlutterFlowTheme.of(context).tertiaryText,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                              ),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(0.0, 0.0),
                        child: Builder(
                          builder: (context) => Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                            child: FFButtonWidget(
                              onPressed: () async {
                                var shouldSetState = false;
                                if (_model.formKey.currentState == null ||
                                    !_model.formKey.currentState!.validate()) {
                                  return;
                                }
                                if (FFAppState().profileimagechanged == true) {
                                  var confirmDialogResponse =
                                      await showDialog<bool>(
                                            context: context,
                                            builder: (alertDialogContext) {
                                              return AlertDialog(
                                                title: const Text('Add Teacher !!'),
                                                content: Text(
                                                    'Are you sure you want to add this teacher to ${addTeacherManuallyAdminSchoolRecord.schoolDetails.schoolName}? '),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            false),
                                                    child: const Text('Cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.pop(
                                                            alertDialogContext,
                                                            true),
                                                    child: const Text('Confirm'),
                                                  ),
                                                ],
                                              );
                                            },
                                          ) ??
                                          false;
                                  if (confirmDialogResponse) {
                                    _model.teacherApi =
                                        await CreateAccountCall.call(
                                      email: _model
                                          .contactemailTextController.text,
                                      displayName:
                                          _model.contactNameTextController.text,
                                      userRole: 3,
                                      phoneNumber: _model
                                          .contactPhonenumberTextController
                                          .text,
                                      password: _model
                                          .contactPhonenumberTextController
                                          .text,
                                    );

                                    shouldSetState = true;
                                    if ((_model.teacherApi?.succeeded ??
                                        true)) {
                                      _model.teacherref =
                                          await actions.stringToUser(
                                        CreateAccountCall.userref(
                                          (_model.teacherApi?.jsonBody ?? ''),
                                        )!,
                                      );
                                      shouldSetState = true;

                                      var teachersRecordReference =
                                          TeachersRecord.collection.doc();
                                      await teachersRecordReference
                                          .set(createTeachersRecordData(
                                        teacherName: _model
                                            .contactNameTextController.text,
                                        phoneNumber: _model
                                            .contactPhonenumberTextController
                                            .text,
                                        emailId: _model
                                            .contactemailTextController.text,
                                        teacherImage: FFAppState().imageurl,
                                        createdAt: getCurrentTimestamp,
                                        useref: _model.teacherref,
                                      ));
                                      _model.teacher =
                                          TeachersRecord.getDocumentFromData(
                                              createTeachersRecordData(
                                                teacherName: _model
                                                    .contactNameTextController
                                                    .text,
                                                phoneNumber: _model
                                                    .contactPhonenumberTextController
                                                    .text,
                                                emailId: _model
                                                    .contactemailTextController
                                                    .text,
                                                teacherImage:
                                                    FFAppState().imageurl,
                                                createdAt: getCurrentTimestamp,
                                                useref: _model.teacherref,
                                              ),
                                              teachersRecordReference);
                                      shouldSetState = true;

                                      await _model.teacherref!
                                          .update(createUsersRecordData(
                                        photoUrl: FFAppState().imageurl,
                                        subscriptionStatus:
                                            addTeacherManuallyAdminSchoolRecord
                                                .subscriptionStatus,
                                        subcriptiondetails:
                                            updateSubscribtionDetailsStruct(
                                          addTeacherManuallyAdminSchoolRecord
                                              .subscriptionDetails,
                                          clearUnsetFields: false,
                                        ),
                                      ));
                                      _model.teacheremail =
                                          await SendMailCall.call(
                                        toEmail: _model
                                            .contactemailTextController.text,
                                        userName: _model
                                            .contactemailTextController.text,
                                        password: _model
                                            .contactPhonenumberTextController
                                            .text,
                                      );

                                      shouldSetState = true;
                                      if ((_model.teacheremail?.succeeded ??
                                          true)) {
                                        await addTeacherManuallyAdminSchoolRecord
                                            .reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'List_of_teachers':
                                                  FieldValue.arrayUnion([
                                                _model.teacher?.reference
                                              ]),
                                              'teachers_data_list':
                                                  FieldValue.arrayUnion([
                                                getTeacherListFirestoreData(
                                                  updateTeacherListStruct(
                                                    TeacherListStruct(
                                                      teacherName: _model
                                                          .contactNameTextController
                                                          .text,
                                                      phoneNumber: _model
                                                          .contactPhonenumberTextController
                                                          .text,
                                                      emailId: _model
                                                          .contactemailTextController
                                                          .text,
                                                      teacherImage: _model
                                                          .teacher
                                                          ?.teacherImage,
                                                      teachersId: _model
                                                          .teacher?.reference,
                                                      userRef:
                                                          _model.teacherref,
                                                    ),
                                                    clearUnsetFields: false,
                                                  ),
                                                  true,
                                                )
                                              ]),
                                              'listOfteachersuser':
                                                  FieldValue.arrayUnion(
                                                      [_model.teacherref]),
                                            },
                                          ),
                                        });
                                        await showDialog(
                                          context: context,
                                          builder: (dialogContext) {
                                            return Dialog(
                                              elevation: 0,
                                              insetPadding: EdgeInsets.zero,
                                              backgroundColor:
                                                  Colors.transparent,
                                              alignment: const AlignmentDirectional(
                                                      0.0, -1.0)
                                                  .resolve(Directionality.of(
                                                      context)),
                                              child: GestureDetector(
                                                onTap: () {
                                                  FocusScope.of(dialogContext)
                                                      .unfocus();
                                                  FocusManager
                                                      .instance.primaryFocus
                                                      ?.unfocus();
                                                },
                                                child: const MessageSentSAWidget(),
                                              ),
                                            );
                                          },
                                        );

                                        if (valueOrDefault(
                                                currentUserDocument?.userRole,
                                                0) ==
                                            1) {
                                          context.goNamed('Dashboard');
                                        } else if (valueOrDefault(
                                                currentUserDocument?.userRole,
                                                0) ==
                                            2) {
                                          context.goNamed(
                                            'class_dashboard',
                                            queryParameters: {
                                              'schoolref': serializeParam(
                                                widget.schoolRef,
                                                ParamType.DocumentReference,
                                              ),
                                            }.withoutNulls,
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              getJsonField(
                                                (_model.teacheremail
                                                        ?.jsonBody ??
                                                    ''),
                                                r'''$.message''',
                                              ).toString(),
                                              style: TextStyle(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            ),
                                            duration:
                                                const Duration(milliseconds: 1250),
                                            backgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                          ),
                                        );
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            getJsonField(
                                              (_model.teacherApi?.jsonBody ??
                                                  ''),
                                              r'''$.message''',
                                            ).toString(),
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryText,
                                            ),
                                          ),
                                          duration:
                                              const Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .primaryText,
                                        ),
                                      );
                                    }
                                  } else {
                                    if (shouldSetState) safeSetState(() {});
                                    return;
                                  }

                                  FFAppState().imageurl =
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/kqg7tnob6oub/Add_profile_pic_(2).png';
                                  FFAppState().profileimagechanged = false;
                                  FFAppState().schoolimage =
                                      'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2FFrame%20731.png?alt=media&token=4abe77e8-804d-485c-9b4a-d9532c4a190a';
                                  FFAppState().schoolimagechanged = false;
                                  safeSetState(() {});
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please upload the teacher\'s image.',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                        ),
                                      ),
                                      duration: const Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondary,
                                    ),
                                  );
                                }

                                if (shouldSetState) safeSetState(() {});
                              },
                              text: 'Send',
                              options: FFButtonOptions(
                                width: MediaQuery.sizeOf(context).width * 0.85,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.06,
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
                                    ),
                                elevation: 0.0,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ].divide(const SizedBox(height: 15.0)),
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
