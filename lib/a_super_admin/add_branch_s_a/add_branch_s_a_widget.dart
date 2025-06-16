import '/admin_dashboard/editphoto/editphoto_widget.dart';
import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'add_branch_s_a_model.dart';
export 'add_branch_s_a_model.dart';

class AddBranchSAWidget extends StatefulWidget {
  const AddBranchSAWidget({
    super.key,
    required this.schoolref,
    required this.userref,
  });

  final DocumentReference? schoolref;
  final DocumentReference? userref;

  static String routeName = 'AddBranch_SA';
  static String routePath = '/addBranchSA';

  @override
  State<AddBranchSAWidget> createState() => _AddBranchSAWidgetState();
}

class _AddBranchSAWidgetState extends State<AddBranchSAWidget> {
  late AddBranchSAModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddBranchSAModel());

    _model.schoolnameTextController ??= TextEditingController();
    _model.schoolnameFocusNode ??= FocusNode();

    _model.nooffacultiesTextController ??= TextEditingController();
    _model.nooffacultiesFocusNode ??= FocusNode();

    _model.pincodeTextController ??= TextEditingController();
    _model.pincodeFocusNode ??= FocusNode();
    _model.pincodeFocusNode!.addListener(
      () async {
        _model.apiResultkpds = await GetcityandstateCall.call(
          postalcode: _model.pincodeTextController.text,
        );

        if ((_model.apiResultkpds?.succeeded ?? true)) {
          _model.city = GetcityandstateCall.city(
            (_model.apiResultkpds?.jsonBody ?? ''),
          );
          _model.state = GetcityandstateCall.state(
            (_model.apiResultkpds?.jsonBody ?? ''),
          );
          safeSetState(() {});
        }

        safeSetState(() {});
      },
    );
    _model.schoolAddressTextController ??= TextEditingController();
    _model.schoolAddressFocusNode ??= FocusNode();
    _model.schoolAddressFocusNode!.addListener(
      () async {
        _model.lastfield = true;
        safeSetState(() {});
      },
    );
    _model.cityTextController ??= TextEditingController();
    _model.cityFocusNode ??= FocusNode();

    _model.stateTextController ??= TextEditingController();
    _model.stateFocusNode ??= FocusNode();
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
      stream: SchoolRecord.getDocument(widget.schoolref!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).newBgcolor,
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

        final addBranchSASchoolRecord = snapshot.data!;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).newBgcolor,
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
                        context.goNamed(
                          ExistingSchoolDetailsSAWidget.routeName,
                          queryParameters: {
                            'schoolrefMain': serializeParam(
                              widget.schoolref,
                              ParamType.DocumentReference,
                            ),
                          }.withoutNulls,
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                            ),
                          },
                        );
                      },
                      child: Icon(
                        Icons.chevron_left,
                        color: FlutterFlowTheme.of(context).bgColor1,
                        size: 26.0,
                      ),
                    ),
                    title: Text(
                      'Add Branch',
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
                    actions: [],
                    centerTitle: false,
                    elevation: 0.0,
                  )
                : null,
            body: SafeArea(
              top: true,
              child: Form(
                key: _model.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    primary: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Material(
                          color: Colors.transparent,
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondary,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 15.4,
                                  color: Color(0x16000000),
                                  offset: Offset(
                                    0.0,
                                    4.0,
                                  ),
                                  spreadRadius: 0.0,
                                )
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          10.0, 10.0, 0.0, 0.0),
                                      child: Text(
                                        'Branch Details',
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
                                              fontSize: 18.0,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.bold,
                                              fontStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .fontStyle,
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
                                              child: Container(
                                                height: 201.0,
                                                child: EditphotoWidget(
                                                  person: false,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).then((value) => safeSetState(() {}));
                                    },
                                    onLongPress: () async {
                                      await Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: FlutterFlowExpandedImageView(
                                            image: Image.network(
                                              valueOrDefault<String>(
                                                FFAppState().schoolimage,
                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                              ),
                                              fit: BoxFit.contain,
                                            ),
                                            allowRotation: false,
                                            tag: valueOrDefault<String>(
                                              FFAppState().schoolimage,
                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                            ),
                                            useHeroAnimation: true,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Hero(
                                      tag: valueOrDefault<String>(
                                        FFAppState().schoolimage,
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                      ),
                                      transitionOnUserGestures: true,
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.3,
                                        height:
                                            MediaQuery.sizeOf(context).width *
                                                0.3,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          valueOrDefault<String>(
                                            FFAppState().schoolimage,
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    child: TextFormField(
                                      controller:
                                          _model.schoolnameTextController,
                                      focusNode: _model.schoolnameFocusNode,
                                      autofocus: false,
                                      textCapitalization:
                                          TextCapitalization.words,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Branch Name *',
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
                                              color: (_model.schoolnameFocusNode
                                                          ?.hasFocus ??
                                                      false)
                                                  ? FlutterFlowTheme.of(context)
                                                      .primaryBackground
                                                  : FlutterFlowTheme.of(context)
                                                      .textfieldText,
                                              fontSize: !(_model
                                                          .schoolnameFocusNode
                                                          ?.hasFocus ??
                                                      false)
                                                  ? 16.0
                                                  : 12.0,
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
                                        hintText: 'Branch Name',
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
                                                  FlutterFlowTheme.of(context)
                                                      .textfieldText,
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
                                        fillColor: (_model.schoolnameFocusNode
                                                    ?.hasFocus ??
                                                false)
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : FlutterFlowTheme.of(context)
                                                .tertiary,
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
                                                .text1,
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
                                      maxLines: 2,
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model
                                          .schoolnameTextControllerValidator
                                          .asValidator(context),
                                      inputFormatters: [
                                        if (!isAndroid && !isiOS)
                                          TextInputFormatter.withFunction(
                                              (oldValue, newValue) {
                                            return TextEditingValue(
                                              selection: newValue.selection,
                                              text: newValue.text
                                                  .toCapitalization(
                                                      TextCapitalization.words),
                                            );
                                          }),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    child: TextFormField(
                                      controller:
                                          _model.nooffacultiesTextController,
                                      focusNode: _model.nooffacultiesFocusNode,
                                      autofocus: false,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'No. of Employee *',
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
                                              color:
                                                  (_model.nooffacultiesFocusNode
                                                              ?.hasFocus ??
                                                          false)
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .textfieldText,
                                              fontSize: !(_model
                                                          .nooffacultiesFocusNode
                                                          ?.hasFocus ??
                                                      false)
                                                  ? 16.0
                                                  : 12.0,
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
                                        hintText: 'No. of Employee',
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
                                                  FlutterFlowTheme.of(context)
                                                      .textfieldText,
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
                                        fillColor: (_model
                                                    .nooffacultiesFocusNode
                                                    ?.hasFocus ??
                                                false)
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : FlutterFlowTheme.of(context)
                                                .tertiary,
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
                                                .text1,
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
                                      keyboardType: TextInputType.number,
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model
                                          .nooffacultiesTextControllerValidator
                                          .asValidator(context),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    child: TextFormField(
                                      controller: _model.pincodeTextController,
                                      focusNode: _model.pincodeFocusNode,
                                      autofocus: false,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'Pincode *',
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
                                              color: (_model.pincodeFocusNode
                                                          ?.hasFocus ??
                                                      false)
                                                  ? FlutterFlowTheme.of(context)
                                                      .primaryBackground
                                                  : FlutterFlowTheme.of(context)
                                                      .textfieldText,
                                              fontSize: !(_model
                                                          .pincodeFocusNode
                                                          ?.hasFocus ??
                                                      false)
                                                  ? 16.0
                                                  : 12.0,
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
                                        hintText: 'Pincode',
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
                                                  FlutterFlowTheme.of(context)
                                                      .textfieldText,
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
                                        fillColor: (_model.pincodeFocusNode
                                                    ?.hasFocus ??
                                                false)
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : FlutterFlowTheme.of(context)
                                                .tertiary,
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
                                                .text1,
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
                                      keyboardType: TextInputType.number,
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model
                                          .pincodeTextControllerValidator
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
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    child: TextFormField(
                                      controller:
                                          _model.schoolAddressTextController,
                                      focusNode: _model.schoolAddressFocusNode,
                                      autofocus: false,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelText: 'School Address *',
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
                                              color:
                                                  (_model.schoolAddressFocusNode
                                                              ?.hasFocus ??
                                                          false)
                                                      ? FlutterFlowTheme.of(
                                                              context)
                                                          .primaryBackground
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .textfieldText,
                                              fontSize: !(_model
                                                          .schoolAddressFocusNode
                                                          ?.hasFocus ??
                                                      false)
                                                  ? 16.0
                                                  : 12.0,
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
                                        hintText: 'School address',
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
                                                  FlutterFlowTheme.of(context)
                                                      .textfieldText,
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
                                        fillColor: (_model
                                                    .schoolAddressFocusNode
                                                    ?.hasFocus ??
                                                false)
                                            ? FlutterFlowTheme.of(context)
                                                .secondary
                                            : FlutterFlowTheme.of(context)
                                                .tertiary,
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
                                                .text1,
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
                                      maxLines: 5,
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model
                                          .schoolAddressTextControllerValidator
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
                                  Align(
                                    alignment: AlignmentDirectional(-0.9, 0.0),
                                    child: Text(
                                      'City',
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
                                            color: _model.city != null &&
                                                    _model.city != ''
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryBackground
                                                : FlutterFlowTheme.of(context)
                                                    .alternate,
                                            fontSize: 12.0,
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
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    child: TextFormField(
                                      controller: _model.cityTextController,
                                      focusNode: _model.cityFocusNode,
                                      autofocus: false,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      readOnly: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: _model.city,
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
                                                  FlutterFlowTheme.of(context)
                                                      .text1,
                                              fontSize: 14.0,
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
                                        fillColor:
                                            (_model.cityFocusNode?.hasFocus ??
                                                    false)
                                                ? FlutterFlowTheme.of(context)
                                                    .secondary
                                                : FlutterFlowTheme.of(context)
                                                    .tertiary,
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
                                                .text1,
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
                                          .cityTextControllerValidator
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
                                  Align(
                                    alignment: AlignmentDirectional(-0.9, 0.0),
                                    child: Text(
                                      'State',
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
                                            color: _model.state != null &&
                                                    _model.state != ''
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryBackground
                                                : FlutterFlowTheme.of(context)
                                                    .alternate,
                                            fontSize: 12.0,
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
                                    ),
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    child: TextFormField(
                                      controller: _model.stateTextController,
                                      focusNode: _model.stateFocusNode,
                                      autofocus: false,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      readOnly: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: _model.state,
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
                                                  FlutterFlowTheme.of(context)
                                                      .text1,
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
                                        fillColor:
                                            (_model.stateFocusNode?.hasFocus ??
                                                    false)
                                                ? FlutterFlowTheme.of(context)
                                                    .secondary
                                                : FlutterFlowTheme.of(context)
                                                    .tertiary,
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
                                                .text1,
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
                                          .stateTextControllerValidator
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
                                  Align(
                                    alignment: AlignmentDirectional(0.0, 0.0),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0.0, 20.0, 0.0, 10.0),
                                      child: FFButtonWidget(
                                        onPressed: ((_model.schoolnameTextController
                                                            .text ==
                                                        '') ||
                                                (_model.nooffacultiesTextController
                                                            .text ==
                                                        '') ||
                                                (_model.pincodeTextController
                                                            .text ==
                                                        '') ||
                                                !_model.lastfield)
                                            ? null
                                            : () async {
                                                await actions.hideKeyboard(
                                                  context,
                                                );
                                                if (_model.formKey
                                                            .currentState ==
                                                        null ||
                                                    !_model
                                                        .formKey.currentState!
                                                        .validate()) {
                                                  return;
                                                }
                                                if ((_model.city != null &&
                                                        _model.city != '') &&
                                                    (_model.city != ' ')) {
                                                  if (functions.serialnumber(
                                                          addBranchSASchoolRecord
                                                              .branchDetails
                                                              .length) ==
                                                      addBranchSASchoolRecord
                                                          .schoolDetails
                                                          .noOfBranches) {
                                                    await widget.schoolref!
                                                        .update(
                                                            createSchoolRecordData(
                                                      schoolDetails:
                                                          updateSchoolDetailsStruct(
                                                        SchoolDetailsStruct(
                                                          schoolId:
                                                              addBranchSASchoolRecord
                                                                  .schoolDetails
                                                                  .schoolId,
                                                          schoolName:
                                                              addBranchSASchoolRecord
                                                                  .schoolDetails
                                                                  .schoolName,
                                                          address:
                                                              addBranchSASchoolRecord
                                                                  .schoolDetails
                                                                  .address,
                                                          pincode:
                                                              addBranchSASchoolRecord
                                                                  .schoolDetails
                                                                  .pincode,
                                                          city:
                                                              addBranchSASchoolRecord
                                                                  .schoolDetails
                                                                  .city,
                                                          state:
                                                              addBranchSASchoolRecord
                                                                  .schoolDetails
                                                                  .state,
                                                          noOfStudents:
                                                              addBranchSASchoolRecord
                                                                  .schoolDetails
                                                                  .noOfStudents,
                                                          noOfFaculties:
                                                              addBranchSASchoolRecord
                                                                  .schoolDetails
                                                                  .noOfFaculties,
                                                          noOfBranches: functions
                                                              .serialnumber(
                                                                  addBranchSASchoolRecord
                                                                      .schoolDetails
                                                                      .noOfBranches),
                                                          schoolImage:
                                                              addBranchSASchoolRecord
                                                                  .schoolDetails
                                                                  .schoolImage,
                                                          listOfclasses:
                                                              addBranchSASchoolRecord
                                                                  .schoolDetails
                                                                  .listOfclasses,
                                                        ),
                                                        clearUnsetFields: false,
                                                      ),
                                                    ));
                                                  }
                                                  _model.addressdata =
                                                      AddressStruct(
                                                    locality: _model
                                                        .schoolAddressTextController
                                                        .text,
                                                    pincode: _model
                                                        .pincodeTextController
                                                        .text,
                                                    city: _model.city,
                                                    state: _model.state,
                                                  );
                                                  safeSetState(() {});
                                                  _model.address =
                                                      await actions.fetchlatlng(
                                                    '${_model.schoolAddressTextController.text}${_model.stateTextController.text}${_model.cityTextController.text}${_model.pincodeTextController.text}',
                                                  );

                                                  var schoolRecordReference =
                                                      SchoolRecord.collection
                                                          .doc();
                                                  await schoolRecordReference
                                                      .set({
                                                    ...createSchoolRecordData(
                                                      schoolDetails:
                                                          updateSchoolDetailsStruct(
                                                        SchoolDetailsStruct(
                                                          schoolName: _model
                                                              .schoolnameTextController
                                                              .text,
                                                          address: _model
                                                              .schoolAddressTextController
                                                              .text,
                                                          schoolId: functions
                                                              .generateUniqueId(),
                                                          noOfFaculties: int
                                                              .tryParse(_model
                                                                  .nooffacultiesTextController
                                                                  .text),
                                                          schoolImage:
                                                              FFAppState()
                                                                  .schoolimage,
                                                          pincode: _model
                                                              .pincodeTextController
                                                              .text,
                                                          city: _model.city,
                                                          state: _model.state,
                                                        ),
                                                        clearUnsetFields: false,
                                                        create: true,
                                                      ),
                                                      principalDetails:
                                                          updatePrincipalDetailsStruct(
                                                        PrincipalDetailsStruct(
                                                          principalId:
                                                              addBranchSASchoolRecord
                                                                  .principalDetails
                                                                  .principalId,
                                                          principalName:
                                                              addBranchSASchoolRecord
                                                                  .principalDetails
                                                                  .principalName,
                                                          phoneNumber:
                                                              addBranchSASchoolRecord
                                                                  .principalDetails
                                                                  .phoneNumber,
                                                          emailId:
                                                              addBranchSASchoolRecord
                                                                  .principalDetails
                                                                  .emailId,
                                                        ),
                                                        clearUnsetFields: false,
                                                        create: true,
                                                      ),
                                                      schoolStatus: 2,
                                                      isBranchPresent: true,
                                                      createdAt:
                                                          getCurrentTimestamp,
                                                      latlng: _model.address,
                                                      subscriptionStatus:
                                                          addBranchSASchoolRecord
                                                              .subscriptionStatus,
                                                      subscriptionDetails:
                                                          updateSubscribtionDetailsStruct(
                                                        addBranchSASchoolRecord
                                                            .subscriptionDetails,
                                                        clearUnsetFields: false,
                                                        create: true,
                                                      ),
                                                    ),
                                                    ...mapToFirestore(
                                                      {
                                                        'branch_details': [
                                                          getSchoolDetailsFirestoreData(
                                                            updateSchoolDetailsStruct(
                                                              SchoolDetailsStruct(
                                                                schoolName: _model
                                                                    .schoolnameTextController
                                                                    .text,
                                                                address: _model
                                                                    .schoolAddressTextController
                                                                    .text,
                                                                schoolId: functions
                                                                    .generateUniqueId(),
                                                                noOfStudents: int
                                                                    .tryParse(_model
                                                                        .pincodeTextController
                                                                        .text),
                                                                noOfFaculties: int
                                                                    .tryParse(_model
                                                                        .nooffacultiesTextController
                                                                        .text),
                                                                schoolImage:
                                                                    FFAppState()
                                                                        .schoolimage,
                                                              ),
                                                              clearUnsetFields:
                                                                  false,
                                                              create: true,
                                                            ),
                                                            true,
                                                          )
                                                        ],
                                                        'listOfAdmin':
                                                            addBranchSASchoolRecord
                                                                .listOfAdmin,
                                                      },
                                                    ),
                                                  });
                                                  _model.branchadded =
                                                      SchoolRecord
                                                          .getDocumentFromData({
                                                    ...createSchoolRecordData(
                                                      schoolDetails:
                                                          updateSchoolDetailsStruct(
                                                        SchoolDetailsStruct(
                                                          schoolName: _model
                                                              .schoolnameTextController
                                                              .text,
                                                          address: _model
                                                              .schoolAddressTextController
                                                              .text,
                                                          schoolId: functions
                                                              .generateUniqueId(),
                                                          noOfFaculties: int
                                                              .tryParse(_model
                                                                  .nooffacultiesTextController
                                                                  .text),
                                                          schoolImage:
                                                              FFAppState()
                                                                  .schoolimage,
                                                          pincode: _model
                                                              .pincodeTextController
                                                              .text,
                                                          city: _model.city,
                                                          state: _model.state,
                                                        ),
                                                        clearUnsetFields: false,
                                                        create: true,
                                                      ),
                                                      principalDetails:
                                                          updatePrincipalDetailsStruct(
                                                        PrincipalDetailsStruct(
                                                          principalId:
                                                              addBranchSASchoolRecord
                                                                  .principalDetails
                                                                  .principalId,
                                                          principalName:
                                                              addBranchSASchoolRecord
                                                                  .principalDetails
                                                                  .principalName,
                                                          phoneNumber:
                                                              addBranchSASchoolRecord
                                                                  .principalDetails
                                                                  .phoneNumber,
                                                          emailId:
                                                              addBranchSASchoolRecord
                                                                  .principalDetails
                                                                  .emailId,
                                                        ),
                                                        clearUnsetFields: false,
                                                        create: true,
                                                      ),
                                                      schoolStatus: 2,
                                                      isBranchPresent: true,
                                                      createdAt:
                                                          getCurrentTimestamp,
                                                      latlng: _model.address,
                                                      subscriptionStatus:
                                                          addBranchSASchoolRecord
                                                              .subscriptionStatus,
                                                      subscriptionDetails:
                                                          updateSubscribtionDetailsStruct(
                                                        addBranchSASchoolRecord
                                                            .subscriptionDetails,
                                                        clearUnsetFields: false,
                                                        create: true,
                                                      ),
                                                    ),
                                                    ...mapToFirestore(
                                                      {
                                                        'branch_details': [
                                                          getSchoolDetailsFirestoreData(
                                                            updateSchoolDetailsStruct(
                                                              SchoolDetailsStruct(
                                                                schoolName: _model
                                                                    .schoolnameTextController
                                                                    .text,
                                                                address: _model
                                                                    .schoolAddressTextController
                                                                    .text,
                                                                schoolId: functions
                                                                    .generateUniqueId(),
                                                                noOfStudents: int
                                                                    .tryParse(_model
                                                                        .pincodeTextController
                                                                        .text),
                                                                noOfFaculties: int
                                                                    .tryParse(_model
                                                                        .nooffacultiesTextController
                                                                        .text),
                                                                schoolImage:
                                                                    FFAppState()
                                                                        .schoolimage,
                                                              ),
                                                              clearUnsetFields:
                                                                  false,
                                                              create: true,
                                                            ),
                                                            true,
                                                          )
                                                        ],
                                                        'listOfAdmin':
                                                            addBranchSASchoolRecord
                                                                .listOfAdmin,
                                                      },
                                                    ),
                                                  }, schoolRecordReference);
                                                  await SmsschoolCall.call(
                                                    toPhoneNumber: functions
                                                        .newCustomFunction(
                                                            addBranchSASchoolRecord
                                                                .principalDetails
                                                                .phoneNumber),
                                                    userName:
                                                        addBranchSASchoolRecord
                                                            .principalDetails
                                                            .principalName,
                                                    userPassword:
                                                        addBranchSASchoolRecord
                                                            .principalDetails
                                                            .phoneNumber,
                                                  );

                                                  await widget.schoolref!
                                                      .update({
                                                    ...mapToFirestore(
                                                      {
                                                        'branch_details':
                                                            FieldValue
                                                                .arrayUnion([
                                                          getSchoolDetailsFirestoreData(
                                                            updateSchoolDetailsStruct(
                                                              SchoolDetailsStruct(
                                                                schoolName: _model
                                                                    .schoolnameTextController
                                                                    .text,
                                                                address: _model
                                                                    .schoolAddressTextController
                                                                    .text,
                                                                schoolId: functions
                                                                    .generateUniqueId(),
                                                                noOfStudents: int
                                                                    .tryParse(_model
                                                                        .pincodeTextController
                                                                        .text),
                                                                noOfFaculties: int
                                                                    .tryParse(_model
                                                                        .nooffacultiesTextController
                                                                        .text),
                                                                schoolImage:
                                                                    FFAppState()
                                                                        .schoolimage,
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
                                                  _model.schoolref =
                                                      await queryUsersRecordOnce(
                                                    queryBuilder:
                                                        (usersRecord) =>
                                                            usersRecord.where(
                                                      'ListofSchool',
                                                      arrayContains:
                                                          widget.schoolref,
                                                    ),
                                                  );
                                                  FFAppState().loopmin = 0;
                                                  safeSetState(() {});
                                                  while (FFAppState().loopmin <
                                                      _model
                                                          .schoolref!.length) {
                                                    await _model.schoolref!
                                                        .elementAtOrNull(
                                                            FFAppState()
                                                                .loopmin)!
                                                        .reference
                                                        .update({
                                                      ...mapToFirestore(
                                                        {
                                                          'ListofSchool':
                                                              FieldValue
                                                                  .arrayUnion([
                                                            _model.branchadded
                                                                ?.reference
                                                          ]),
                                                        },
                                                      ),
                                                    });
                                                    FFAppState().loopmin =
                                                        FFAppState().loopmin +
                                                            1;
                                                    safeSetState(() {});
                                                  }
                                                  FFAppState().imageurl = '';
                                                  FFAppState()
                                                          .profileimagechanged =
                                                      false;
                                                  FFAppState().schoolimage = '';
                                                  FFAppState()
                                                          .schoolimagechanged =
                                                      false;
                                                  FFAppState().loopmin = 0;
                                                  safeSetState(() {});
                                                  triggerPushNotification(
                                                    notificationTitle:
                                                        'Branch update',
                                                    notificationText:
                                                        'New branch added',
                                                    userRefs: [
                                                      addBranchSASchoolRecord
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
                                                      content:
                                                          'New Branch ${_model.schoolnameTextController.text} added',
                                                      createDate:
                                                          getCurrentTimestamp,
                                                      notification:
                                                          updateNotificationStruct(
                                                        NotificationStruct(
                                                          notificationTitle:
                                                              'Branch added',
                                                          descriptions:
                                                              'New Branch ${_model.schoolnameTextController.text} added',
                                                          timeStamp:
                                                              getCurrentTimestamp,
                                                          isRead: false,
                                                        ),
                                                        clearUnsetFields: false,
                                                        create: true,
                                                      ),
                                                      isread: false,
                                                    ),
                                                    ...mapToFirestore(
                                                      {
                                                        'userref': [
                                                          addBranchSASchoolRecord
                                                              .principalDetails
                                                              .principalId
                                                        ],
                                                      },
                                                    ),
                                                  });

                                                  context.pushNamed(
                                                    BranchAddedWidget.routeName,
                                                    queryParameters: {
                                                      'schoolref':
                                                          serializeParam(
                                                        widget.schoolref,
                                                        ParamType
                                                            .DocumentReference,
                                                      ),
                                                    }.withoutNulls,
                                                  );
                                                } else {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'Please enter a valid pin code',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );
                                                  safeSetState(() {
                                                    _model.pincodeTextController
                                                        ?.clear();
                                                  });
                                                }

                                                safeSetState(() {});
                                              },
                                        text: 'Add',
                                        options: FFButtonOptions(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.85,
                                          height: MediaQuery.sizeOf(context)
                                                  .height *
                                              0.06,
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  16.0, 0.0, 16.0, 0.0),
                                          iconPadding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0.0, 0.0, 0.0, 0.0),
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          textStyle:
                                              FlutterFlowTheme.of(context)
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
                                            shadows: [
                                              Shadow(
                                                color: Color(0xFF357DFB),
                                                offset: Offset(0.0, 0.0),
                                                blurRadius: 0.0,
                                              ),
                                              Shadow(
                                                color: Color(0x63253EA7),
                                                offset: Offset(0.0, 1.0),
                                                blurRadius: 2.0,
                                              )
                                            ],
                                          ),
                                          elevation: 3.0,
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          disabledColor:
                                              FlutterFlowTheme.of(context)
                                                  .dIsable,
                                          disabledTextColor:
                                              FlutterFlowTheme.of(context)
                                                  .disabletext,
                                        ),
                                      ),
                                    ),
                                  ),
                                ].divide(SizedBox(height: 15.0)),
                              ),
                            ),
                          ),
                        ),
                      ],
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
