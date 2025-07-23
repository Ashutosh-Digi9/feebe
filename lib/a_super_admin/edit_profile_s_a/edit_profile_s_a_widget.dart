import '/admin_dashboard/editphoto/editphoto_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/logout_widget.dart';
import '/confirmationpages/profilephotoupdatedsuccessfully/profilephotoupdatedsuccessfully_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'edit_profile_s_a_model.dart';
export 'edit_profile_s_a_model.dart';

class EditProfileSAWidget extends StatefulWidget {
  const EditProfileSAWidget({super.key});

  static String routeName = 'EditProfile_SA';
  static String routePath = '/editProfileSA';

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
      FFAppState().imageurl = '';
      FFAppState().schoolimage = '';
      safeSetState(() {});
    });

    _model.userNameTextController ??=
        TextEditingController(text: currentUserDisplayName);
    _model.userNameFocusNode ??= FocusNode();

    _model.phoneNumberTextController ??=
        TextEditingController(text: currentPhoneNumber);
    _model.phoneNumberFocusNode ??= FocusNode();

    _model.emailTextController ??= TextEditingController(
        text: valueOrDefault<bool>(currentUserDocument?.isemail, false)
            ? currentUserEmail
            : functions.getUsernameFromEmail(currentUserEmail));
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
        appBar: responsiveVisibility(
          context: context,
          tablet: false,
          tabletLandscape: false,
          desktop: false,
        )
            ? PreferredSize(
                preferredSize:
                    Size.fromHeight(MediaQuery.sizeOf(context).height * 0.06),
                child: AppBar(
                  backgroundColor: FlutterFlowTheme.of(context).info,
                  automaticallyImplyLeading: false,
                  leading: Align(
                    alignment: AlignmentDirectional(0.0, 0.0),
                    child: FlutterFlowIconButton(
                      borderColor: Colors.transparent,
                      borderRadius: 30.0,
                      borderWidth: 1.0,
                      buttonSize: 60.0,
                      icon: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).bgColor1,
                        size: 26.0,
                      ),
                      onPressed: () async {
                        FFAppState().profileimagechanged = false;
                        safeSetState(() {});
                        context.safePop();
                      },
                    ),
                  ),
                  title: Align(
                    alignment: AlignmentDirectional(-1.0, 0.0),
                    child: Text(
                      'Edit Profile',
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            font: GoogleFonts.nunito(
                              fontWeight: FontWeight.bold,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.bold,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                    ),
                  ),
                  actions: [],
                  centerTitle: true,
                  elevation: 0.0,
                ),
              )
            : null,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height * 0.7,
                decoration: BoxDecoration(),
                child: Form(
                  key: _model.formKey,
                  autovalidateMode: AutovalidateMode.disabled,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Contact Details',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      font: GoogleFonts.nunito(
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                      color: FlutterFlowTheme.of(context).text1,
                                      fontSize: 24.0,
                                      letterSpacing: 0.0,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
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
                                          alignment: AlignmentDirectional(
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
                                            child: Container(
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.2,
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.52,
                                              child: LogoutWidget(),
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
                                              font: GoogleFonts.nunito(
                                                fontWeight: FontWeight.bold,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              fontSize: 19.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                      ),
                                    ].divide(SizedBox(width: 10.0)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.3,
                          height: MediaQuery.sizeOf(context).width * 0.3,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: FlutterFlowTheme.of(context).secondary,
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
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                        ),
                                        fit: BoxFit.contain,
                                      ),
                                      allowRotation: false,
                                      tag: valueOrDefault<String>(
                                        FFAppState().profileimagechanged == true
                                            ? FFAppState().imageurl
                                            : currentUserPhoto,
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
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
                                  'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                ),
                                transitionOnUserGestures: true,
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.3,
                                  height:
                                      MediaQuery.sizeOf(context).width * 0.3,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: Image.network(
                                    valueOrDefault<String>(
                                      FFAppState().profileimagechanged == true
                                          ? FFAppState().imageurl
                                          : currentUserPhoto,
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/ro0v8oqh1xhd/Screenshot__317_-removebg-preview.png',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
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
                                      child: Container(
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
                                    font: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
                                  ),
                            ),
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            AuthUserStreamWidget(
                              builder: (context) => Container(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: TextFormField(
                                  controller: _model.userNameTextController,
                                  focusNode: _model.userNameFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Name *',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: GoogleFonts.nunito(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                          ),
                                          color: (_model.userNameFocusNode
                                                      ?.hasFocus ??
                                                  false)
                                              ? FlutterFlowTheme.of(context)
                                                  .primary
                                              : FlutterFlowTheme.of(context)
                                                  .textfieldText,
                                          fontSize: (_model.userNameFocusNode
                                                      ?.hasFocus ??
                                                  false)
                                              ? 12.0
                                              : 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontStyle,
                                        ),
                                    hintText: 'Name',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyLarge
                                        .override(
                                          font: GoogleFonts.nunito(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyLarge
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .textfieldText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyLarge
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
                                        font: GoogleFonts.nunito(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
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
                            AuthUserStreamWidget(
                              builder: (context) => Container(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: TextFormField(
                                  controller: _model.phoneNumberTextController,
                                  focusNode: _model.phoneNumberFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Phone Number *',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.nunito(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color: valueOrDefault<Color>(
                                            (_model.phoneNumberFocusNode
                                                        ?.hasFocus ??
                                                    false)
                                                ? FlutterFlowTheme.of(context)
                                                    .primary
                                                : FlutterFlowTheme.of(context)
                                                    .textfieldText,
                                            FlutterFlowTheme.of(context).text,
                                          ),
                                          fontSize: (_model.phoneNumberFocusNode
                                                      ?.hasFocus ??
                                                  false)
                                              ? 12.0
                                              : 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                    hintText: 'Phone Number',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.nunito(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .textfieldText,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
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
                                        font: GoogleFonts.nunito(
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryText,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                  maxLength: 10,
                                  buildCounter: (context,
                                          {required currentLength,
                                          required isFocused,
                                          maxLength}) =>
                                      null,
                                  keyboardType: TextInputType.phone,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
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
                            Align(
                              alignment: AlignmentDirectional(0.0, 0.0),
                              child: AuthUserStreamWidget(
                                builder: (context) => Container(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  child: TextFormField(
                                    controller: _model.emailTextController,
                                    focusNode: _model.emailFocusNode,
                                    autofocus: false,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    readOnly: true,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Email / Username*',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.nunito(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
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
                                            fontSize: (_model.emailFocusNode
                                                        ?.hasFocus ??
                                                    false)
                                                ? 12.0
                                                : 16.0,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      hintText: 'Email / Username',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            font: GoogleFonts.nunito(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .text,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .textfieldDisable,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .dIsable,
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
                                          font: GoogleFonts.nunito(
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                          color: FlutterFlowTheme.of(context)
                                              .tertiaryText,
                                          letterSpacing: 0.0,
                                          fontWeight:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontWeight,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .emailTextControllerValidator
                                        .asValidator(context),
                                    inputFormatters: [
                                      if (!isAndroid && !isiOS)
                                        TextInputFormatter.withFunction(
                                            (oldValue, newValue) {
                                          return TextEditingValue(
                                            selection: newValue.selection,
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
                            ),
                          ]
                              .divide(SizedBox(height: 15.0))
                              .around(SizedBox(height: 15.0)),
                        ),
                        if (valueOrDefault(currentUserDocument?.userRole, 0) ==
                            3)
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 0.0, 10.0, 0.0),
                            child: AuthUserStreamWidget(
                              builder: (context) => InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.teacher =
                                      await queryTeachersRecordOnce(
                                    queryBuilder: (teachersRecord) =>
                                        teachersRecord.where(
                                      'useref',
                                      isEqualTo: currentUserReference,
                                    ),
                                    singleRecord: true,
                                  ).then((s) => s.firstOrNull);

                                  context.pushNamed(
                                    AttendenceHistoryTeacherWidget.routeName,
                                    queryParameters: {
                                      'techerref': serializeParam(
                                        _model.teacher?.reference,
                                        ParamType.DocumentReference,
                                      ),
                                    }.withoutNulls,
                                  );

                                  safeSetState(() {});
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Attendance History',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            font: GoogleFonts.nunito(
                                              fontWeight: FontWeight.w500,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
                                            ),
                                            color: FlutterFlowTheme.of(context)
                                                .primary,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .bodyMedium
                                                    .fontStyle,
                                          ),
                                    ),
                                    Icon(
                                      Icons.arrow_right_alt_sharp,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ].divide(SizedBox(height: 15.0)),
                    ),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.sizeOf(context).width * 1.0,
                height: MediaQuery.sizeOf(context).height * 0.2,
                decoration: BoxDecoration(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: AlignmentDirectional(0.0, -1.0),
                      child: Builder(
                        builder: (context) => FFButtonWidget(
                          onPressed: ((_model.userNameTextController.text ==
                                          '') ||
                                  (_model.phoneNumberTextController.text ==
                                          ''))
                              ? null
                              : () async {
                                  if (_model.formKey.currentState == null ||
                                      !_model.formKey.currentState!
                                          .validate()) {
                                    return;
                                  }
                                  if (valueOrDefault(
                                          currentUserDocument?.userRole, 0) ==
                                      1) {
                                    await currentUserReference!
                                        .update(createUsersRecordData(
                                      email: _model.emailTextController.text,
                                      displayName:
                                          _model.userNameTextController.text,
                                      phoneNumber:
                                          _model.phoneNumberTextController.text,
                                      photoUrl:
                                          FFAppState().profileimagechanged ==
                                                  true
                                              ? FFAppState().imageurl
                                              : currentUserPhoto,
                                    ));
                                    FFAppState().profileimagechanged = false;
                                    FFAppState().schoolimagechanged = false;
                                    FFAppState().imageurl = '';
                                    FFAppState().schoolimage = '';
                                    safeSetState(() {});
                                  } else if (valueOrDefault(
                                          currentUserDocument?.userRole, 0) ==
                                      2) {
                                    await Future.wait([
                                      Future(() async {
                                        await currentUserReference!
                                            .update(createUsersRecordData(
                                          email:
                                              _model.emailTextController.text,
                                          displayName: _model
                                              .userNameTextController.text,
                                          phoneNumber: _model
                                              .phoneNumberTextController.text,
                                          photoUrl: FFAppState()
                                                      .profileimagechanged ==
                                                  true
                                              ? FFAppState().imageurl
                                              : currentUserPhoto,
                                        ));
                                      }),
                                      Future(() async {
                                        await (currentUserDocument?.listofSchool
                                                    .toList() ??
                                                [])
                                            .firstOrNull!
                                            .update(createSchoolRecordData(
                                              principalDetails:
                                                  updatePrincipalDetailsStruct(
                                                PrincipalDetailsStruct(
                                                  principalName:
                                                      currentUserDisplayName,
                                                  phoneNumber:
                                                      currentPhoneNumber,
                                                  principalImage: FFAppState()
                                                              .profileimagechanged ==
                                                          true
                                                      ? FFAppState().imageurl
                                                      : currentUserPhoto,
                                                ),
                                                clearUnsetFields: false,
                                              ),
                                            ));
                                      }),
                                    ]);
                                    FFAppState().profileimagechanged = false;
                                    FFAppState().schoolimagechanged = false;
                                    FFAppState().imageurl = '';
                                    FFAppState().schoolimage = '';
                                    safeSetState(() {});
                                  } else if (valueOrDefault(
                                          currentUserDocument?.userRole, 0) ==
                                      3) {
                                    await currentUserReference!
                                        .update(createUsersRecordData(
                                      email: _model.emailTextController.text,
                                      displayName:
                                          _model.userNameTextController.text,
                                      phoneNumber:
                                          _model.phoneNumberTextController.text,
                                      photoUrl:
                                          FFAppState().profileimagechanged ==
                                                  true
                                              ? FFAppState().imageurl
                                              : currentUserPhoto,
                                    ));
                                    await Future.wait([
                                      Future(() async {
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
                                          teacherName: _model
                                              .userNameTextController.text,
                                          phoneNumber: _model
                                              .phoneNumberTextController.text,
                                          emailId:
                                              _model.emailTextController.text,
                                          teacherImage: FFAppState()
                                                      .profileimagechanged ==
                                                  true
                                              ? FFAppState().imageurl
                                              : _model
                                                  .teacherProfile?.teacherImage,
                                        ));
                                        _model.schoolref =
                                            await querySchoolRecordOnce(
                                          queryBuilder: (schoolRecord) =>
                                              schoolRecord.where(
                                            'listOfteachersuser',
                                            arrayContains: currentUserReference,
                                          ),
                                          singleRecord: true,
                                        ).then((s) => s.firstOrNull);

                                        await _model.schoolref!.reference
                                            .update({
                                          ...mapToFirestore(
                                            {
                                              'teachers_data_list':
                                                  getTeacherListListFirestoreData(
                                                functions.updateTeacherDetails(
                                                    _model.schoolref!
                                                        .teachersDataList
                                                        .toList(),
                                                    currentUserReference!,
                                                    _model
                                                        .userNameTextController
                                                        .text,
                                                    _model
                                                        .phoneNumberTextController
                                                        .text,
                                                    FFAppState()
                                                            .profileimagechanged
                                                        ? FFAppState().imageurl
                                                        : currentUserPhoto),
                                              ),
                                            },
                                          ),
                                        });
                                        FFAppState().profileimagechanged =
                                            false;
                                        FFAppState().schoolimagechanged = false;
                                        FFAppState().imageurl = '';
                                        FFAppState().schoolimage = '';
                                        safeSetState(() {});
                                      }),
                                      Future(() async {
                                        FFAppState().loopmin = 0;
                                        safeSetState(() {});
                                        _model.classes =
                                            await querySchoolClassRecordOnce(
                                          queryBuilder: (schoolClassRecord) =>
                                              schoolClassRecord.where(
                                            'listOfteachersUser',
                                            arrayContains: currentUserReference,
                                          ),
                                        );
                                        while (FFAppState().loopmin <
                                            _model.classes!.length) {
                                          await _model.classes!
                                              .elementAtOrNull(
                                                  FFAppState().loopmin)!
                                              .reference
                                              .update({
                                            ...mapToFirestore(
                                              {
                                                'ListOfteachers':
                                                    getTeacherListListFirestoreData(
                                                  functions.updateTeacherDetails(
                                                      _model.classes!
                                                          .elementAtOrNull(
                                                              FFAppState()
                                                                  .loopmin)!
                                                          .listOfteachers
                                                          .toList(),
                                                      currentUserReference!,
                                                      _model
                                                          .userNameTextController
                                                          .text,
                                                      _model
                                                          .phoneNumberTextController
                                                          .text,
                                                      FFAppState()
                                                              .profileimagechanged
                                                          ? FFAppState()
                                                              .imageurl
                                                          : currentUserPhoto),
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
                                      }),
                                    ]);
                                  }

                                  await showDialog(
                                    context: context,
                                    builder: (dialogContext) {
                                      return Dialog(
                                        elevation: 0,
                                        insetPadding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        alignment:
                                            AlignmentDirectional(0.0, -0.8)
                                                .resolve(
                                                    Directionality.of(context)),
                                        child: GestureDetector(
                                          onTap: () {
                                            FocusScope.of(dialogContext)
                                                .unfocus();
                                            FocusManager.instance.primaryFocus
                                                ?.unfocus();
                                          },
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.08,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.85,
                                            child:
                                                ProfilephotoupdatedsuccessfullyWidget(),
                                          ),
                                        ),
                                      );
                                    },
                                  );

                                  context.goNamed(
                                    DashboardWidget.routeName,
                                    queryParameters: {
                                      'fromlogin': serializeParam(
                                        false,
                                        ParamType.bool,
                                      ),
                                    }.withoutNulls,
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: TransitionInfo(
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
                            padding: EdgeInsetsDirectional.fromSTEB(
                                16.0, 0.0, 16.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                              font: GoogleFonts.nunito(
                                fontWeight: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontWeight,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).secondaryText,
                              letterSpacing: 0.0,
                              fontWeight: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontWeight,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .fontStyle,
                              shadows: [
                                Shadow(
                                  color: Color(0xFF375DFB),
                                  offset: Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                ),
                                Shadow(
                                  color: Color(0x68253EA7),
                                  offset: Offset(0.0, 1.0),
                                  blurRadius: 2.0,
                                )
                              ],
                            ),
                            elevation: 3.0,
                            borderRadius: BorderRadius.circular(8.0),
                            disabledColor: FlutterFlowTheme.of(context).dIsable,
                            disabledTextColor:
                                FlutterFlowTheme.of(context).secondaryText,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () async {
                          context.pushNamed(ChangePasswordWidget.routeName);
                        },
                        child: Text(
                          'Change Password',
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    font: GoogleFonts.nunito(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w600,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .fontStyle,
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
