import '/admin_dashboard/editphoto/editphoto_widget.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/confirmationpages/messagesenttotheteacher/messagesenttotheteacher_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
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

  static String routeName = 'add_Teacher_manually_Admin';
  static String routePath = '/addTeacherManuallyAdmin';

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
      FFAppState().imageurl = '';
      FFAppState().profileimagechanged = false;
      FFAppState().schoolimage = '';
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
    _model.contactemailFocusNode!.addListener(
      () async {
        _model.lastfield = true;
        safeSetState(() {});
      },
    );
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
            appBar: responsiveVisibility(
              context: context,
              tablet: false,
              tabletLandscape: false,
              desktop: false,
            )
                ? AppBar(
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
                            font: GoogleFonts.nunito(
                              fontWeight: FontWeight.w600,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                            color: FlutterFlowTheme.of(context).primaryText,
                            fontSize: 16.0,
                            letterSpacing: 0.0,
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.sizeOf(context).height * 0.8,
                      decoration: BoxDecoration(),
                      child: Form(
                        key: _model.formKey,
                        autovalidateMode: AutovalidateMode.disabled,
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).width * 1.0,
                                decoration: BoxDecoration(
                                  color: Color(0x151D61E7),
                                ),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 5.0, 0.0, 5.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Container(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.8,
                                          decoration: BoxDecoration(),
                                          child: Builder(
                                            builder: (context) => InkWell(
                                              splashColor: Colors.transparent,
                                              focusColor: Colors.transparent,
                                              hoverColor: Colors.transparent,
                                              highlightColor:
                                                  Colors.transparent,
                                              onTap: () async {
                                                await Share.share(
                                                  _model.currentPageLink,
                                                  sharePositionOrigin:
                                                      getWidgetBoundingBox(
                                                          context),
                                                );
                                              },
                                              child: Text(
                                                valueOrDefault<String>(
                                                  addTeacherManuallyAdminSchoolRecord
                                                      .schoolDetails.schoolName,
                                                  'School name ',
                                                ),
                                                textAlign: TextAlign.center,
                                                style: FlutterFlowTheme.of(
                                                        context)
                                                    .bodyMedium
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .fontStyle,
                                                      ),
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .primaryBackground,
                                                      fontSize: 20.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
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
                                                    getWidgetBoundingBox(
                                                        context),
                                              );
                                            },
                                            child: Text(
                                              valueOrDefault<String>(
                                                addTeacherManuallyAdminSchoolRecord
                                                    .schoolDetails.city,
                                                'School name ',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryBackground,
                                                    fontSize: 16.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.bold,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]
                                        .divide(SizedBox(height: 10.0))
                                        .around(SizedBox(height: 10.0)),
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
                                          padding:
                                              MediaQuery.viewInsetsOf(context),
                                          child: Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.2,
                                            child: EditphotoWidget(
                                              person: true,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ).then((value) => safeSetState(() {}));
                                },
                                child: Container(
                                  width: MediaQuery.sizeOf(context).width * 0.3,
                                  height:
                                      MediaQuery.sizeOf(context).width * 0.3,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
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
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: TextFormField(
                                  controller: _model.contactNameTextController,
                                  focusNode: _model.contactNameFocusNode,
                                  autofocus: false,
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Teacher\'s Name *',
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
                                            (_model.contactNameFocusNode
                                                        ?.hasFocus ??
                                                    false)
                                                ? FlutterFlowTheme.of(context)
                                                    .primary
                                                : FlutterFlowTheme.of(context)
                                                    .text,
                                            FlutterFlowTheme.of(context)
                                                .textfieldText,
                                          ),
                                          fontSize: (_model.contactNameFocusNode
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
                                    hintText: 'Teacher’s name',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.nunito(
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color:
                                              FlutterFlowTheme.of(context).text,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
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
                                    fillColor: (_model.contactNameFocusNode
                                                ?.hasFocus ??
                                            false)
                                        ? FlutterFlowTheme.of(context).tertiary
                                        : FlutterFlowTheme.of(context)
                                            .secondary,
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
                                      .contactNameTextControllerValidator
                                      .asValidator(context),
                                  inputFormatters: [
                                    if (!isAndroid && !isiOS)
                                      TextInputFormatter.withFunction(
                                          (oldValue, newValue) {
                                        return TextEditingValue(
                                          selection: newValue.selection,
                                          text: newValue.text.toCapitalization(
                                              TextCapitalization.words),
                                        );
                                      }),
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: TextFormField(
                                  controller:
                                      _model.contactPhonenumberTextController,
                                  focusNode: _model.contactPhonenumberFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Teacher\'s Phone number *',
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
                                            (_model.contactPhonenumberFocusNode
                                                        ?.hasFocus ??
                                                    false)
                                                ? FlutterFlowTheme.of(context)
                                                    .primary
                                                : FlutterFlowTheme.of(context)
                                                    .text,
                                            FlutterFlowTheme.of(context)
                                                .textfieldText,
                                          ),
                                          fontSize:
                                              (_model.contactPhonenumberFocusNode
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
                                    hintText: 'Teacher’s  phone number',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.nunito(
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color:
                                              FlutterFlowTheme.of(context).text,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
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
                                    fillColor: (_model
                                                .contactPhonenumberFocusNode
                                                ?.hasFocus ??
                                            false)
                                        ? FlutterFlowTheme.of(context).tertiary
                                        : FlutterFlowTheme.of(context)
                                            .secondary,
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
                                  keyboardType: TextInputType.number,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model
                                      .contactPhonenumberTextControllerValidator
                                      .asValidator(context),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]'))
                                  ],
                                ),
                              ),
                              Container(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: TextFormField(
                                  controller: _model.contactemailTextController,
                                  focusNode: _model.contactemailFocusNode,
                                  autofocus: false,
                                  textCapitalization: TextCapitalization.none,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Teacher\'s user name / Email *',
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
                                            (_model.contactemailFocusNode?.hasFocus ??
                                                    false)
                                                ? FlutterFlowTheme.of(context)
                                                    .primary
                                                : FlutterFlowTheme.of(context)
                                                    .text,
                                            FlutterFlowTheme.of(context)
                                                .textfieldText,
                                          ),
                                          fontSize: (_model
                                                      .contactemailFocusNode
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
                                    hintText: 'Teacher\'s user name / Email',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.nunito(
                                            fontWeight: FontWeight.normal,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color:
                                              FlutterFlowTheme.of(context).text,
                                          fontSize: 16.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.normal,
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
                                    fillColor: (_model.contactemailFocusNode
                                                ?.hasFocus ??
                                            false)
                                        ? FlutterFlowTheme.of(context).tertiary
                                        : FlutterFlowTheme.of(context)
                                            .secondary,
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
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model
                                      .contactemailTextControllerValidator
                                      .asValidator(context),
                                  inputFormatters: [
                                    if (!isAndroid && !isiOS)
                                      TextInputFormatter.withFunction(
                                          (oldValue, newValue) {
                                        return TextEditingValue(
                                          selection: newValue.selection,
                                          text: newValue.text.toCapitalization(
                                              TextCapitalization.none),
                                        );
                                      }),
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[a-z0-9@.]'))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    10.0, 0.0, 10.0, 0.0),
                                child: Text(
                                  'Your teacher will now receive an email with the link to her profile. ',
                                  textAlign: TextAlign.start,
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
                                        fontSize: 16.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontWeight,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                            ].divide(SizedBox(height: 15.0)),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional(0.0, 0.0),
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
                            color: FlutterFlowTheme.of(context).secondary,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                              color: Color(0xFFF4F4F4),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Builder(
                                builder: (context) => Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 10.0),
                                  child: FFButtonWidget(
                                    onPressed: ((_model.contactNameTextController
                                                        .text ==
                                                    '') ||
                                            (_model.contactPhonenumberTextController
                                                        .text ==
                                                    '') ||
                                            !_model.lastfield)
                                        ? null
                                        : () async {
                                            var _shouldSetState = false;
                                            if (_model.formKey.currentState ==
                                                    null ||
                                                !_model.formKey.currentState!
                                                    .validate()) {
                                              return;
                                            }
                                            if (addTeacherManuallyAdminSchoolRecord
                                                    .schoolDetails
                                                    .noOfFaculties ==
                                                addTeacherManuallyAdminSchoolRecord
                                                    .listOfTeachers.length) {
                                              await addTeacherManuallyAdminSchoolRecord
                                                  .reference
                                                  .update(
                                                      createSchoolRecordData(
                                                schoolDetails:
                                                    updateSchoolDetailsStruct(
                                                  SchoolDetailsStruct(
                                                    schoolId:
                                                        addTeacherManuallyAdminSchoolRecord
                                                            .schoolDetails
                                                            .schoolId,
                                                    schoolName:
                                                        addTeacherManuallyAdminSchoolRecord
                                                            .schoolDetails
                                                            .schoolName,
                                                    address:
                                                        addTeacherManuallyAdminSchoolRecord
                                                            .schoolDetails
                                                            .address,
                                                    pincode:
                                                        addTeacherManuallyAdminSchoolRecord
                                                            .schoolDetails
                                                            .pincode,
                                                    city:
                                                        addTeacherManuallyAdminSchoolRecord
                                                            .schoolDetails.city,
                                                    state:
                                                        addTeacherManuallyAdminSchoolRecord
                                                            .schoolDetails
                                                            .state,
                                                    noOfStudents:
                                                        addTeacherManuallyAdminSchoolRecord
                                                            .schoolDetails
                                                            .noOfStudents,
                                                    noOfFaculties:
                                                        functions.serialnumber(
                                                            addTeacherManuallyAdminSchoolRecord
                                                                .schoolDetails
                                                                .noOfFaculties),
                                                    noOfBranches:
                                                        addTeacherManuallyAdminSchoolRecord
                                                            .schoolDetails
                                                            .noOfBranches,
                                                    schoolImage:
                                                        addTeacherManuallyAdminSchoolRecord
                                                            .schoolDetails
                                                            .schoolImage,
                                                    listOfclasses:
                                                        addTeacherManuallyAdminSchoolRecord
                                                            .schoolDetails
                                                            .listOfclasses,
                                                  ),
                                                  clearUnsetFields: false,
                                                ),
                                              ));
                                            }
                                            if (FFAppState()
                                                    .profileimagechanged ==
                                                true) {
                                              var confirmDialogResponse =
                                                  await showDialog<bool>(
                                                        context: context,
                                                        builder:
                                                            (alertDialogContext) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Add Teacher !!'),
                                                            content: Text(
                                                                'Are you sure you want to add this teacher to ${addTeacherManuallyAdminSchoolRecord.schoolDetails.schoolName}? '),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext,
                                                                        false),
                                                                child: Text(
                                                                    'Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () =>
                                                                    Navigator.pop(
                                                                        alertDialogContext,
                                                                        true),
                                                                child: Text(
                                                                    'Confirm'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ) ??
                                                      false;
                                              if (confirmDialogResponse) {
                                                await SendsmsteacherCall.call(
                                                  toPhoneNumber: int.tryParse(_model
                                                      .contactPhonenumberTextController
                                                      .text),
                                                  userName: _model
                                                      .contactemailTextController
                                                      .text,
                                                  userPassword: _model
                                                      .contactPhonenumberTextController
                                                      .text,
                                                );

                                                _model.teacherApi =
                                                    await CreateAccountCall
                                                        .call(
                                                  email: functions.isValidEmail(
                                                          _model
                                                              .contactemailTextController
                                                              .text)
                                                      ? _model
                                                          .contactemailTextController
                                                          .text
                                                      : '${_model.contactemailTextController.text}@feebe.in',
                                                  displayName: _model
                                                      .contactNameTextController
                                                      .text,
                                                  userRole: 3,
                                                  phoneNumber: _model
                                                      .contactPhonenumberTextController
                                                      .text,
                                                  password: _model
                                                      .contactPhonenumberTextController
                                                      .text,
                                                );

                                                _shouldSetState = true;
                                                if ((_model.teacherApi
                                                        ?.succeeded ??
                                                    true)) {
                                                  _model.teacherref =
                                                      await actions
                                                          .stringToUser(
                                                    CreateAccountCall.userref(
                                                      (_model.teacherApi
                                                              ?.jsonBody ??
                                                          ''),
                                                    )!,
                                                  );
                                                  _shouldSetState = true;

                                                  var teachersRecordReference =
                                                      TeachersRecord.collection
                                                          .doc();
                                                  await teachersRecordReference
                                                      .set(
                                                          createTeachersRecordData(
                                                    teacherName: _model
                                                        .contactNameTextController
                                                        .text,
                                                    phoneNumber: _model
                                                        .contactPhonenumberTextController
                                                        .text,
                                                    emailId: functions
                                                            .isValidEmail(_model
                                                                .contactemailTextController
                                                                .text)
                                                        ? _model
                                                            .contactemailTextController
                                                            .text
                                                        : '${_model.contactemailTextController.text}@feebe.in',
                                                    teacherImage:
                                                        FFAppState().imageurl,
                                                    createdAt:
                                                        getCurrentTimestamp,
                                                    useref: _model.teacherref,
                                                    isemail: functions
                                                            .isValidEmail(_model
                                                                .contactemailTextController
                                                                .text)
                                                        ? true
                                                        : false,
                                                  ));
                                                  _model.teacher = TeachersRecord
                                                      .getDocumentFromData(
                                                          createTeachersRecordData(
                                                            teacherName: _model
                                                                .contactNameTextController
                                                                .text,
                                                            phoneNumber: _model
                                                                .contactPhonenumberTextController
                                                                .text,
                                                            emailId: functions
                                                                    .isValidEmail(_model
                                                                        .contactemailTextController
                                                                        .text)
                                                                ? _model
                                                                    .contactemailTextController
                                                                    .text
                                                                : '${_model.contactemailTextController.text}@feebe.in',
                                                            teacherImage:
                                                                FFAppState()
                                                                    .imageurl,
                                                            createdAt:
                                                                getCurrentTimestamp,
                                                            useref: _model
                                                                .teacherref,
                                                            isemail: functions
                                                                    .isValidEmail(_model
                                                                        .contactemailTextController
                                                                        .text)
                                                                ? true
                                                                : false,
                                                          ),
                                                          teachersRecordReference);
                                                  _shouldSetState = true;

                                                  await _model.teacherref!
                                                      .update(
                                                          createUsersRecordData(
                                                    photoUrl:
                                                        FFAppState().imageurl,
                                                    subscriptionStatus:
                                                        addTeacherManuallyAdminSchoolRecord
                                                            .subscriptionStatus,
                                                    subcriptiondetails:
                                                        updateSubscribtionDetailsStruct(
                                                      addTeacherManuallyAdminSchoolRecord
                                                          .subscriptionDetails,
                                                      clearUnsetFields: false,
                                                    ),
                                                    isemail: functions
                                                            .isValidEmail(_model
                                                                .contactemailTextController
                                                                .text)
                                                        ? true
                                                        : false,
                                                  ));
                                                  _model.teacheremail =
                                                      await SendMailCall.call(
                                                    toEmail: functions
                                                            .isValidEmail(_model
                                                                .contactemailTextController
                                                                .text)
                                                        ? _model
                                                            .contactemailTextController
                                                            .text
                                                        : '${_model.contactemailTextController.text}@feebe.in',
                                                    userName: _model
                                                        .contactNameTextController
                                                        .text,
                                                    password: _model
                                                        .contactPhonenumberTextController
                                                        .text,
                                                    message:
                                                        'Welcome to Feebe! You have successfully been onboarded by ${addTeacherManuallyAdminSchoolRecord.schoolDetails.schoolName} Our platform is designed to make your daily tasks smoother, so you can focus on what truly matters—your students!',
                                                  );

                                                  _shouldSetState = true;
                                                  if ((_model.teacheremail
                                                          ?.succeeded ??
                                                      true)) {
                                                    await addTeacherManuallyAdminSchoolRecord
                                                        .reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'List_of_teachers':
                                                              FieldValue
                                                                  .arrayUnion([
                                                            _model.teacher
                                                                ?.reference
                                                          ]),
                                                          'teachers_data_list':
                                                              FieldValue
                                                                  .arrayUnion([
                                                            getTeacherListFirestoreData(
                                                              updateTeacherListStruct(
                                                                TeacherListStruct(
                                                                  teacherName:
                                                                      _model
                                                                          .contactNameTextController
                                                                          .text,
                                                                  phoneNumber:
                                                                      _model
                                                                          .contactPhonenumberTextController
                                                                          .text,
                                                                  emailId: functions.isValidEmail(_model
                                                                          .contactemailTextController
                                                                          .text)
                                                                      ? _model
                                                                          .contactemailTextController
                                                                          .text
                                                                      : '${_model.contactemailTextController.text}@feebe.in',
                                                                  teacherImage: _model
                                                                      .teacher
                                                                      ?.teacherImage,
                                                                  teachersId: _model
                                                                      .teacher
                                                                      ?.reference,
                                                                  userRef: _model
                                                                      .teacherref,
                                                                  isemail: functions.isValidEmail(_model
                                                                          .contactemailTextController
                                                                          .text)
                                                                      ? true
                                                                      : false,
                                                                ),
                                                                clearUnsetFields:
                                                                    false,
                                                              ),
                                                              true,
                                                            )
                                                          ]),
                                                          'listOfteachersuser':
                                                              FieldValue
                                                                  .arrayUnion([
                                                            _model.teacherref
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                    if (valueOrDefault(
                                                            currentUserDocument
                                                                ?.userRole,
                                                            0) ==
                                                        1) {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (dialogContext) {
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
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.08,
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.8,
                                                                child:
                                                                    MessagesenttotheteacherWidget(),
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
                                                        ExistingSchoolDetailsSAWidget
                                                            .routeName,
                                                        queryParameters: {
                                                          'schoolrefMain':
                                                              serializeParam(
                                                            widget.schoolRef,
                                                            ParamType
                                                                .DocumentReference,
                                                          ),
                                                        }.withoutNulls,
                                                      );
                                                    } else if (valueOrDefault(
                                                            currentUserDocument
                                                                ?.userRole,
                                                            0) ==
                                                        2) {
                                                      await showDialog(
                                                        context: context,
                                                        builder:
                                                            (dialogContext) {
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
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.08,
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.8,
                                                                child:
                                                                    MessagesenttotheteacherWidget(),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );

                                                      context.safePop();
                                                    }

                                                    FFAppState().imageurl = '';
                                                    FFAppState()
                                                            .profileimagechanged =
                                                        false;
                                                    FFAppState().schoolimage =
                                                        '';
                                                    FFAppState()
                                                            .schoolimagechanged =
                                                        false;
                                                    safeSetState(() {});
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                            context)
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
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .secondary,
                                                          ),
                                                        ),
                                                        duration: Duration(
                                                            milliseconds: 1250),
                                                        backgroundColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
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
                                                          (_model.teacherApi
                                                                  ?.jsonBody ??
                                                              ''),
                                                          r'''$.message''',
                                                        ).toString(),
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryText,
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
                                              } else {
                                                if (_shouldSetState)
                                                  safeSetState(() {});
                                                return;
                                              }
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Please upload teacher\'s profile image',
                                                    style: TextStyle(
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 2500),
                                                  backgroundColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                ),
                                              );
                                            }

                                            if (_shouldSetState)
                                              safeSetState(() {});
                                          },
                                    text: 'Send',
                                    options: FFButtonOptions(
                                      width: MediaQuery.sizeOf(context).width *
                                          0.85,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.06,
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16.0, 0.0, 16.0, 0.0),
                                      iconPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              0.0, 0.0, 0.0, 0.0),
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      textStyle: FlutterFlowTheme.of(context)
                                          .titleSmall
                                          .override(
                                            font: GoogleFonts.nunito(
                                              fontWeight:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontWeight,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .fontStyle,
                                            ),
                                            color: Colors.white,
                                            letterSpacing: 0.0,
                                            fontWeight:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontWeight,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .fontStyle,
                                          ),
                                      elevation: 3.0,
                                      borderRadius: BorderRadius.circular(8.0),
                                      disabledColor:
                                          FlutterFlowTheme.of(context).dIsable,
                                      disabledTextColor:
                                          FlutterFlowTheme.of(context)
                                              .disabletext,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
