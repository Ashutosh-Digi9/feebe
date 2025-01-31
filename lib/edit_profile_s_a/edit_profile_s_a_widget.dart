import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/custom_cloud_functions/custom_cloud_function_response_manager.dart';
import '/components/editphoto_widget.dart';
import '/components/logout_widget.dart';
import '/confirmationpages/profilephotoupdatedsuccessfully/profilephotoupdatedsuccessfully_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'edit_profile_s_a_model.dart';
export 'edit_profile_s_a_model.dart';

class EditProfileSAWidget extends StatefulWidget {
  const EditProfileSAWidget({super.key});

  @override
  State<EditProfileSAWidget> createState() => _EditProfileSAWidgetState();
}

class _EditProfileSAWidgetState extends State<EditProfileSAWidget> {
  late EditProfileSAModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProfileSAModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().profileimagechanged = false;
      FFAppState().schoolimagechanged = false;
      FFAppState().imageurl =
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
      FFAppState().schoolimage =
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png';
      safeSetState(() {});
      try {
        final result = await FirebaseFunctions.instance
            .httpsCallable('cleanupOldNotifications')
            .call({});
        _model.cloudFunction0w5 =
            CleanupOldNotificationsCloudFunctionCallResponse(
          succeeded: true,
        );
      } on FirebaseFunctionsException catch (error) {
        _model.cloudFunction0w5 =
            CleanupOldNotificationsCloudFunctionCallResponse(
          errorCode: error.code,
          succeeded: false,
        );
      }
    });

    _model.userNameTextController ??=
        TextEditingController(text: currentUserDisplayName);
    _model.userNameFocusNode ??= FocusNode();

    _model.phoneNumberTextController ??=
        TextEditingController(text: currentPhoneNumber);
    _model.phoneNumberFocusNode ??= FocusNode();

    _model.emailTextController ??=
        TextEditingController(text: currentUserEmail);
    _model.emailFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).tertiary,
        appBar: PreferredSize(
          preferredSize:
              Size.fromHeight(MediaQuery.sizeOf(context).height * 0.06),
          child: AppBar(
            backgroundColor: FlutterFlowTheme.of(context).info,
            automaticallyImplyLeading: false,
            leading: Align(
              alignment: const AlignmentDirectional(0.0, 0.0),
              child: FlutterFlowIconButton(
                borderColor: Colors.transparent,
                borderRadius: 30.0,
                borderWidth: 1.0,
                buttonSize: 60.0,
                icon: const Icon(
                  Icons.chevron_left,
                  color: Color(0x58001B36),
                ),
                onPressed: () async {
                  context.safePop();
                },
              ),
            ),
            title: Align(
              alignment: const AlignmentDirectional(-1.0, 0.0),
              child: Text(
                'Edit Profile',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            actions: const [],
            centerTitle: true,
            elevation: 0.0,
          ),
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.7,
                decoration: const BoxDecoration(),
                child: Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Contact Details',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: FlutterFlowTheme.of(context).text1,
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Builder(
                                builder: (context) => InkWell(
                                  splashColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                  hoverColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (dialogContext) {
                                        return Dialog(
                                          elevation: 0,
                                          insetPadding: EdgeInsets.zero,
                                          backgroundColor: Colors.transparent,
                                          alignment: const AlignmentDirectional(
                                                  0.0, 0.0)
                                              .resolve(
                                                  Directionality.of(context)),
                                          child: GestureDetector(
                                            onTap: () {
                                              FocusScope.of(dialogContext)
                                                  .unfocus();
                                              FocusManager.instance.primaryFocus
                                                  ?.unfocus();
                                            },
                                            child: SizedBox(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.2,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.52,
                                              child: const LogoutWidget(),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      FaIcon(
                                        FontAwesomeIcons.powerOff,
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBackground,
                                        size: 20.0,
                                      ),
                                      Text(
                                        'Log Out',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              fontSize: 19.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ].divide(const SizedBox(width: 10.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.4,
                          height: MediaQuery.sizeOf(context).width * 0.4,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).lightBg,
                              width: 1.0,
                            ),
                          ),
                          child: AuthUserStreamWidget(
                            builder: (context) => InkWell(
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
                                              : currentUserPhoto,
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: valueOrDefault<String>(
                                        FFAppState().profileimagechanged == true
                                            ? FFAppState().imageurl
                                            : currentUserPhoto,
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
                                      : currentUserPhoto,
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                ),
                                transitionOnUserGestures: true,
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.4,
                                  height:
                                      MediaQuery.sizeOf(context).width * 0.4,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    valueOrDefault<String>(
                                      FFAppState().profileimagechanged == true
                                          ? FFAppState().imageurl
                                          : currentUserPhoto,
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 10.0, 0.0, 0.0),
                          child: InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              await showModalBottomSheet(
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                isDismissible: false,
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
                                      padding: MediaQuery.viewInsetsOf(context),
                                      child: const SizedBox(
                                        height: 201.0,
                                        child: EditphotoWidget(
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
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AuthUserStreamWidget(
                              builder: (context) => SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: TextFormField(
                                  controller: _model.userNameTextController,
                                  focusNode: _model.userNameFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Name',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: valueOrDefault<Color>(
                                            (_model.userNameFocusNode
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
                                    hintText: 'Name',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color:
                                              FlutterFlowTheme.of(context).text,
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .dIsable,
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
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
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
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                  keyboardType: TextInputType.name,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model
                                      .userNameTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  child: TextFormField(
                                    controller:
                                        _model.phoneNumberTextController,
                                    focusNode: _model.phoneNumberFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Phone Number',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: valueOrDefault<Color>(
                                              (_model.phoneNumberFocusNode
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
                                      hintText: 'Phone Number',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .text,
                                            letterSpacing: 0.0,
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
                                          .secondaryBackground,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryText,
                                          letterSpacing: 0.0,
                                        ),
                                    maxLength: 10,
                                    buildCounter: (context,
                                            {required currentLength,
                                            required isFocused,
                                            maxLength}) =>
                                        null,
                                    keyboardType: TextInputType.phone,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .phoneNumberTextControllerValidator
                                        .asValidator(context),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]'))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: TextFormField(
                                  controller: _model.emailTextController,
                                  focusNode: _model.emailFocusNode,
                                  autofocus: false,
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Email',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: valueOrDefault<Color>(
                                            (_model.emailFocusNode
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
                                    hintText: 'Email',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color:
                                              FlutterFlowTheme.of(context).text,
                                          letterSpacing: 0.0,
                                        ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.of(context)
                                            .dIsable,
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
                                        color:
                                            FlutterFlowTheme.of(context).error,
                                        width: 1.0,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color:
                                            FlutterFlowTheme.of(context).error,
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
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                      ),
                                  keyboardType: TextInputType.emailAddress,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model.emailTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ),
                          ]
                              .divide(const SizedBox(height: 15.0))
                              .around(const SizedBox(height: 15.0)),
                        ),
                        if (valueOrDefault(currentUserDocument?.userRole, 0) ==
                            3)
                          AuthUserStreamWidget(
                            builder: (context) => InkWell(
                              splashColor: Colors.transparent,
                              focusColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () async {
                                _model.teacher = await queryTeachersRecordOnce(
                                  queryBuilder: (teachersRecord) =>
                                      teachersRecord.where(
                                    'useref',
                                    isEqualTo: currentUserReference,
                                  ),
                                  singleRecord: true,
                                ).then((s) => s.firstOrNull);

                                context.pushNamed(
                                  'attendence_history_teacher',
                                  queryParameters: {
                                    'techerref': serializeParam(
                                      _model.teacher?.reference,
                                      ParamType.DocumentReference,
                                    ),
                                  }.withoutNulls,
                                );

                                safeSetState(() {});
                              },
                              child: Text(
                                'Attendence History',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                      ].divide(const SizedBox(height: 15.0)),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 0.2,
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: const AlignmentDirectional(0.0, -1.0),
                      child: Builder(
                        builder: (context) => FFButtonWidget(
                          onPressed: () async {
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              return;
                            }
                            if (valueOrDefault(
                                    currentUserDocument?.userRole, 0) ==
                                1) {
                              await currentUserReference!
                                  .update(createUsersRecordData(
                                email: _model.emailTextController.text,
                                displayName: _model.userNameTextController.text,
                                phoneNumber:
                                    _model.phoneNumberTextController.text,
                                photoUrl:
                                    FFAppState().profileimagechanged == true
                                        ? FFAppState().imageurl
                                        : currentUserPhoto,
                              ));
                              FFAppState().profileimagechanged = false;
                              FFAppState().schoolimagechanged = false;
                              FFAppState().imageurl =
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
                              FFAppState().schoolimage =
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png';
                              safeSetState(() {});
                            } else if (valueOrDefault(
                                    currentUserDocument?.userRole, 0) ==
                                2) {
                              await currentUserReference!
                                  .update(createUsersRecordData(
                                email: _model.emailTextController.text,
                                displayName: _model.userNameTextController.text,
                                phoneNumber:
                                    _model.phoneNumberTextController.text,
                                photoUrl:
                                    FFAppState().profileimagechanged == true
                                        ? FFAppState().imageurl
                                        : currentUserPhoto,
                              ));

                              await (currentUserDocument?.listofSchool
                                          .toList() ??
                                      [])
                                  .firstOrNull!
                                  .update(createSchoolRecordData(
                                    principalDetails:
                                        updatePrincipalDetailsStruct(
                                      PrincipalDetailsStruct(
                                        principalName: currentUserDisplayName,
                                        phoneNumber: currentPhoneNumber,
                                        principalImage:
                                            FFAppState().profileimagechanged ==
                                                    true
                                                ? FFAppState().imageurl
                                                : currentUserPhoto,
                                      ),
                                      clearUnsetFields: false,
                                    ),
                                  ));
                              FFAppState().profileimagechanged = false;
                              FFAppState().schoolimagechanged = false;
                              FFAppState().imageurl =
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
                              FFAppState().schoolimage =
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png';
                              safeSetState(() {});
                            } else if (valueOrDefault(
                                    currentUserDocument?.userRole, 0) ==
                                3) {
                              await currentUserReference!
                                  .update(createUsersRecordData(
                                email: _model.emailTextController.text,
                                displayName: _model.userNameTextController.text,
                                phoneNumber:
                                    _model.phoneNumberTextController.text,
                                photoUrl:
                                    FFAppState().profileimagechanged == true
                                        ? FFAppState().imageurl
                                        : currentUserPhoto,
                              ));
                              _model.teacherProfile =
                                  await queryTeachersRecordOnce(
                                queryBuilder: (teachersRecord) =>
                                    teachersRecord.where(
                                  'useref',
                                  isEqualTo: currentUserReference,
                                ),
                                singleRecord: true,
                              ).then((s) => s.firstOrNull);

                              await _model.teacherProfile!.reference
                                  .update(createTeachersRecordData(
                                teacherName: _model.userNameTextController.text,
                                phoneNumber:
                                    _model.phoneNumberTextController.text,
                                emailId: _model.emailTextController.text,
                                teacherImage:
                                    FFAppState().profileimagechanged == true
                                        ? FFAppState().imageurl
                                        : _model.teacherProfile?.teacherImage,
                              ));
                              FFAppState().profileimagechanged = false;
                              FFAppState().schoolimagechanged = false;
                              FFAppState().imageurl =
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
                              FFAppState().schoolimage =
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png';
                              safeSetState(() {});
                            }

                            await showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return Dialog(
                                  elevation: 0,
                                  insetPadding: EdgeInsets.zero,
                                  backgroundColor: Colors.transparent,
                                  alignment: const AlignmentDirectional(0.0, -0.8)
                                      .resolve(Directionality.of(context)),
                                  child: GestureDetector(
                                    onTap: () {
                                      FocusScope.of(dialogContext).unfocus();
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    child: SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.08,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.75,
                                      child:
                                          const ProfilephotoupdatedsuccessfullyWidget(),
                                    ),
                                  ),
                                );
                              },
                            );

                            context.goNamed(
                              'Dashboard',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                ),
                              },
                            );

                            safeSetState(() {});
                          },
                          text: 'Save Changes',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.85,
                            height: MediaQuery.sizeOf(context).height * 0.055,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                              fontFamily: 'Nunito',
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              shadows: [
                                const Shadow(
                                  color: Color(0xFF375DFB),
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                ),
                                const Shadow(
                                  color: Color(0x68253EA7),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 2.0,
                                )
                              ],
                            ),
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed('ChangePassword');
                        },
                        child: Text(
                          'Change Password',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
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
  }
}
