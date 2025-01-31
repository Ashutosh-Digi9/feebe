import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/components/editphoto_widget.dart';
import '/confirmationpages/schooladdedsuccessfully/schooladdedsuccessfully_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'add_school_manually_s_a_model.dart';
export 'add_school_manually_s_a_model.dart';

class AddSchoolManuallySAWidget extends StatefulWidget {
  const AddSchoolManuallySAWidget({super.key});

  @override
  State<AddSchoolManuallySAWidget> createState() =>
      _AddSchoolManuallySAWidgetState();
}

class _AddSchoolManuallySAWidgetState extends State<AddSchoolManuallySAWidget> {
  late AddSchoolManuallySAModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddSchoolManuallySAModel());

    _model.schoolnameTextController ??= TextEditingController();
    _model.schoolnameFocusNode ??= FocusNode();

    _model.schoolAddressTextController ??= TextEditingController();
    _model.schoolAddressFocusNode ??= FocusNode();

    _model.nooffacultiesTextController ??= TextEditingController();
    _model.nooffacultiesFocusNode ??= FocusNode();

    _model.noofbranchesTextController ??= TextEditingController();
    _model.noofbranchesFocusNode ??= FocusNode();

    _model.pincodeTextController ??= TextEditingController();
    _model.pincodeFocusNode ??= FocusNode();
    _model.pincodeFocusNode!.addListener(
      () async {
        _model.apiResultkps = await GetcityandstateCall.call(
          postalcode: _model.pincodeTextController.text,
        );

        if ((_model.apiResultkps?.succeeded ?? true)) {
          _model.city = GetcityandstateCall.city(
            (_model.apiResultkps?.jsonBody ?? ''),
          );
          _model.state = GetcityandstateCall.state(
            (_model.apiResultkps?.jsonBody ?? ''),
          );
          safeSetState(() {});
        }

        safeSetState(() {});
      },
    );
    _model.cityTextController ??= TextEditingController(text: _model.city);
    _model.cityFocusNode ??= FocusNode();

    _model.stateTextController ??= TextEditingController(text: _model.state);
    _model.stateFocusNode ??= FocusNode();

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

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).newBgcolor,
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
              size: 26.0,
            ),
          ),
          title: Text(
            'Add school',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w500,
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
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 1.0,
                              color: Color(0x98000000),
                              offset: Offset(
                                0.0,
                                2.0,
                              ),
                              spreadRadius: 0.0,
                            )
                          ],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      10.0, 10.0, 0.0, 0.0),
                                  child: SelectionArea(
                                      child: Text(
                                    'School Details.*',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          fontSize: 18.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  )),
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(0.0, 0.0),
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
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: const SizedBox(
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
                                      width: MediaQuery.sizeOf(context).width *
                                          0.3,
                                      height: MediaQuery.sizeOf(context).width *
                                          0.3,
                                      clipBehavior: Clip.antiAlias,
                                      decoration: const BoxDecoration(
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
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: TextFormField(
                                  controller: _model.schoolnameTextController,
                                  focusNode: _model.schoolnameFocusNode,
                                  autofocus: false,
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'School Name ',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: valueOrDefault<Color>(
                                            (_model.schoolnameFocusNode
                                                        ?.hasFocus ??
                                                    false)
                                                ? FlutterFlowTheme.of(context)
                                                    .primaryBackground
                                                : FlutterFlowTheme.of(context)
                                                    .textfieldText,
                                            FlutterFlowTheme.of(context)
                                                .primary,
                                          ),
                                          letterSpacing: 0.0,
                                        ),
                                    alignLabelWithHint: true,
                                    hintText: 'School Name',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .textfieldText,
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w200,
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
                                    fillColor: (_model.schoolnameFocusNode
                                                ?.hasFocus ??
                                            false)
                                        ? FlutterFlowTheme.of(context).secondary
                                        : FlutterFlowTheme.of(context).tertiary,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color:
                                            FlutterFlowTheme.of(context).text1,
                                        letterSpacing: 0.0,
                                      ),
                                  maxLines: 4,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model
                                      .schoolnameTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.9,
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
                                    labelText: 'School Address',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: (_model.schoolAddressFocusNode
                                                      ?.hasFocus ??
                                                  false)
                                              ? FlutterFlowTheme.of(context)
                                                  .primary
                                              : FlutterFlowTheme.of(context)
                                                  .textfieldText,
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'School Address',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .textfieldText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w200,
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
                                    fillColor: (_model.schoolAddressFocusNode
                                                ?.hasFocus ??
                                            false)
                                        ? FlutterFlowTheme.of(context).secondary
                                        : FlutterFlowTheme.of(context).tertiary,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color:
                                            FlutterFlowTheme.of(context).text1,
                                        letterSpacing: 0.0,
                                      ),
                                  maxLines: 4,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model
                                      .schoolAddressTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: TextFormField(
                                  controller:
                                      _model.nooffacultiesTextController,
                                  focusNode: _model.nooffacultiesFocusNode,
                                  autofocus: false,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'No. of Employee',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: valueOrDefault<Color>(
                                            (_model.nooffacultiesFocusNode
                                                        ?.hasFocus ??
                                                    false)
                                                ? FlutterFlowTheme.of(context)
                                                    .primary
                                                : FlutterFlowTheme.of(context)
                                                    .textfieldText,
                                            FlutterFlowTheme.of(context)
                                                .textfieldText,
                                          ),
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'No. of Employee',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .textfieldText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w200,
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
                                    fillColor: (_model.nooffacultiesFocusNode
                                                ?.hasFocus ??
                                            false)
                                        ? FlutterFlowTheme.of(context).secondary
                                        : FlutterFlowTheme.of(context).tertiary,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color:
                                            FlutterFlowTheme.of(context).text1,
                                        letterSpacing: 0.0,
                                      ),
                                  keyboardType: TextInputType.number,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model
                                      .nooffacultiesTextControllerValidator
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
                                  controller: _model.noofbranchesTextController,
                                  focusNode: _model.noofbranchesFocusNode,
                                  autofocus: false,
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'No. of Branch',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: (_model.noofbranchesFocusNode
                                                      ?.hasFocus ??
                                                  false)
                                              ? FlutterFlowTheme.of(context)
                                                  .primary
                                              : FlutterFlowTheme.of(context)
                                                  .textfieldText,
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'No. of Branch',
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .textfieldText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w200,
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
                                    fillColor: (_model.noofbranchesFocusNode
                                                ?.hasFocus ??
                                            false)
                                        ? FlutterFlowTheme.of(context).secondary
                                        : FlutterFlowTheme.of(context).tertiary,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color:
                                            FlutterFlowTheme.of(context).text1,
                                        letterSpacing: 0.0,
                                      ),
                                  keyboardType: TextInputType.number,
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model
                                      .noofbranchesTextControllerValidator
                                      .asValidator(context),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]'))
                                  ],
                                ),
                              ),
                              Align(
                                alignment: const AlignmentDirectional(-1.0, 0.0),
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.6,
                                  child: TextFormField(
                                    controller: _model.pincodeTextController,
                                    focusNode: _model.pincodeFocusNode,
                                    autofocus: false,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'Pincode',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: (_model.pincodeFocusNode
                                                        ?.hasFocus ??
                                                    false)
                                                ? FlutterFlowTheme.of(context)
                                                    .primary
                                                : FlutterFlowTheme.of(context)
                                                    .textfieldText,
                                            letterSpacing: 0.0,
                                          ),
                                      hintText: 'Pincode',
                                      hintStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .textfieldText,
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
                                      fillColor: (_model
                                                  .pincodeFocusNode?.hasFocus ??
                                              false)
                                          ? FlutterFlowTheme.of(context)
                                              .secondary
                                          : FlutterFlowTheme.of(context)
                                              .tertiary,
                                    ),
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .text1,
                                          letterSpacing: 0.0,
                                        ),
                                    keyboardType: TextInputType.number,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .pincodeTextControllerValidator
                                        .asValidator(context),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                          RegExp('[0-9]'))
                                    ],
                                  ),
                                ),
                              ),
                              Text(
                                'City',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: _model.city != null &&
                                              _model.city != ''
                                          ? FlutterFlowTheme.of(context)
                                              .primaryBackground
                                          : FlutterFlowTheme.of(context)
                                              .alternate,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.9,
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
                                    alignLabelWithHint: false,
                                    hintText: _model.city,
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .textfieldText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
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
                                    fillColor: (_model
                                                .cityFocusNode?.hasFocus ??
                                            false)
                                        ? FlutterFlowTheme.of(context).secondary
                                        : FlutterFlowTheme.of(context).tertiary,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color:
                                            FlutterFlowTheme.of(context).text1,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model.cityTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                              Text(
                                'State',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: _model.state != null &&
                                              _model.state != ''
                                          ? FlutterFlowTheme.of(context)
                                              .primaryBackground
                                          : FlutterFlowTheme.of(context)
                                              .alternate,
                                      fontSize: 12.0,
                                      letterSpacing: 0.0,
                                    ),
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.9,
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
                                    alignLabelWithHint: false,
                                    hintText: _model.state,
                                    hintStyle: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .textfieldText,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
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
                                    fillColor: (_model.nooffacultiesFocusNode
                                                ?.hasFocus ??
                                            false)
                                        ? FlutterFlowTheme.of(context).secondary
                                        : FlutterFlowTheme.of(context).tertiary,
                                  ),
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color:
                                            FlutterFlowTheme.of(context).text1,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                  cursorColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                  validator: _model.stateTextControllerValidator
                                      .asValidator(context),
                                ),
                              ),
                            ]
                                .divide(const SizedBox(height: 15.0))
                                .around(const SizedBox(height: 15.0)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.sizeOf(context).width * 1.0,
                      decoration: BoxDecoration(
                        color: FlutterFlowTheme.of(context).secondaryBackground,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 1.0,
                            color: Color(0x98000000),
                            offset: Offset(
                              0.0,
                              2.0,
                            ),
                            spreadRadius: 0.0,
                          )
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Align(
                              alignment: const AlignmentDirectional(-1.0, 0.0),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    10.0, 10.0, 0.0, 0.0),
                                child: Text(
                                  'Contact Details',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        fontSize: 18.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: const AlignmentDirectional(0.0, 0.0),
                              child: InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  await showModalBottomSheet(
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
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
                                onLongPress: () async {
                                  await Navigator.push(
                                    context,
                                    PageTransition(
                                      type: PageTransitionType.fade,
                                      child: FlutterFlowExpandedImageView(
                                        image: Image.network(
                                          valueOrDefault<String>(
                                            FFAppState().imageurl,
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                        allowRotation: false,
                                        tag: valueOrDefault<String>(
                                          FFAppState().imageurl,
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                        ),
                                        useHeroAnimation: true,
                                      ),
                                    ),
                                  );
                                },
                                child: Hero(
                                  tag: valueOrDefault<String>(
                                    FFAppState().imageurl,
                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                  ),
                                  transitionOnUserGestures: true,
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    height:
                                        MediaQuery.sizeOf(context).width * 0.3,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        FFAppState().imageurl,
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
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
                                  labelText: 'Admin\'s Name',
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
                                                  .textfieldText,
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Admin\'s Name',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .textfieldText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w200,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).dIsable,
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
                                  fillColor: (_model
                                              .contactNameFocusNode?.hasFocus ??
                                          false)
                                      ? FlutterFlowTheme.of(context).secondary
                                      : FlutterFlowTheme.of(context).tertiary,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: FlutterFlowTheme.of(context).text1,
                                      letterSpacing: 0.0,
                                    ),
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                validator: _model
                                    .contactNameTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              child: TextFormField(
                                controller:
                                    _model.contactPhonenumberTextController,
                                focusNode: _model.contactPhonenumberFocusNode,
                                autofocus: false,
                                textCapitalization:
                                    TextCapitalization.sentences,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Admin\'s Phone Number ',
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
                                                  .textfieldText,
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Admin\'s Phone Number ',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .textfieldText,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w200,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).dIsable,
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
                                  fillColor: (_model.contactPhonenumberFocusNode
                                              ?.hasFocus ??
                                          false)
                                      ? FlutterFlowTheme.of(context).secondary
                                      : FlutterFlowTheme.of(context).tertiary,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
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
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.9,
                              child: TextFormField(
                                controller: _model.contactemailTextController,
                                focusNode: _model.contactemailFocusNode,
                                autofocus: false,
                                textCapitalization: TextCapitalization.none,
                                obscureText: false,
                                decoration: InputDecoration(
                                  isDense: true,
                                  labelText: 'Admin\'s Email ID',
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
                                                  .textfieldText,
                                          FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                        ),
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                      ),
                                  hintText: 'Admin\'s Email ID',
                                  hintStyle: FlutterFlowTheme.of(context)
                                      .labelMedium
                                      .override(
                                        fontFamily: 'Nunito',
                                        color: FlutterFlowTheme.of(context)
                                            .textfieldText,
                                        fontSize: 14.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.w200,
                                      ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color:
                                          FlutterFlowTheme.of(context).dIsable,
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
                                  fillColor: (_model.contactemailFocusNode
                                              ?.hasFocus ??
                                          false)
                                      ? FlutterFlowTheme.of(context).secondary
                                      : FlutterFlowTheme.of(context).tertiary,
                                ),
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: FlutterFlowTheme.of(context).text1,
                                      letterSpacing: 0.0,
                                    ),
                                keyboardType: TextInputType.emailAddress,
                                cursorColor:
                                    FlutterFlowTheme.of(context).primaryText,
                                validator: _model
                                    .contactemailTextControllerValidator
                                    .asValidator(context),
                              ),
                            ),
                          ]
                              .divide(const SizedBox(height: 15.0))
                              .around(const SizedBox(height: 15.0)),
                        ),
                      ),
                    ),
                    Align(
                      alignment: const AlignmentDirectional(0.0, 0.0),
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 15.0, 0.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10.0,
                                color: Color(0x41B7B7B7),
                                offset: Offset(
                                  2.0,
                                  -5.0,
                                ),
                                spreadRadius: 0.0,
                              )
                            ],
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Builder(
                              builder: (context) => Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    if (_model.formKey.currentState == null ||
                                        !_model.formKey.currentState!
                                            .validate()) {
                                      return;
                                    }
                                    _model.address1 = await actions.fetchlatlng(
                                      '${_model.schoolAddressTextController.text}${_model.stateTextController.text}${_model.cityTextController.text}${_model.pincodeTextController.text}',
                                    );
                                    if ((_model.city != null &&
                                            _model.city != '') &&
                                        (_model.city != ' ')) {
                                      var confirmDialogResponse =
                                          await showDialog<bool>(
                                                context: context,
                                                builder: (alertDialogContext) {
                                                  return AlertDialog(
                                                    title: const Text(
                                                        'Add School Confirmation'),
                                                    content: const Text(
                                                        'Are you sure you want to add this school?'),
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
                                        _model.createaccount2 =
                                            await CreateAccountCall.call(
                                          email: _model
                                              .contactemailTextController.text,
                                          displayName: _model
                                              .contactNameTextController.text,
                                          phoneNumber: _model
                                              .contactPhonenumberTextController
                                              .text,
                                          userRole: 2,
                                          password: _model
                                              .contactPhonenumberTextController
                                              .text,
                                        );

                                        if ((_model.createaccount2?.succeeded ??
                                            true)) {
                                          _model.user =
                                              await queryUsersRecordOnce(
                                            queryBuilder: (usersRecord) =>
                                                usersRecord.where(
                                              'email',
                                              isEqualTo: _model
                                                  .contactemailTextController
                                                  .text,
                                            ),
                                            singleRecord: true,
                                          ).then((s) => s.firstOrNull);
                                          _model.addressdata = AddressStruct(
                                            locality: _model
                                                .schoolAddressTextController
                                                .text,
                                            pincode: _model
                                                .pincodeTextController.text,
                                            city: _model.city,
                                            state: _model.state,
                                          );
                                          safeSetState(() {});
                                          _model.address =
                                              await actions.fetchlatlng(
                                            '${_model.schoolAddressTextController.text}${_model.stateTextController.text}${_model.cityTextController.text}${_model.pincodeTextController.text}',
                                          );

                                          var schoolRecordReference =
                                              SchoolRecord.collection.doc();
                                          await schoolRecordReference
                                              .set(createSchoolRecordData(
                                            schoolDetails:
                                                updateSchoolDetailsStruct(
                                              SchoolDetailsStruct(
                                                schoolId: functions
                                                    .generateUniqueId(),
                                                schoolName: _model
                                                    .schoolnameTextController
                                                    .text,
                                                address: _model
                                                    .schoolAddressTextController
                                                    .text,
                                                noOfFaculties: int.tryParse(_model
                                                    .nooffacultiesTextController
                                                    .text),
                                                noOfBranches: int.tryParse(_model
                                                    .noofbranchesTextController
                                                    .text),
                                                schoolImage:
                                                    FFAppState().schoolimage,
                                                pincode: _model
                                                    .pincodeTextController.text,
                                                city: _model.city,
                                                state: _model.state,
                                              ),
                                              clearUnsetFields: false,
                                              create: true,
                                            ),
                                            principalDetails:
                                                updatePrincipalDetailsStruct(
                                              PrincipalDetailsStruct(
                                                principalName: _model
                                                    .contactNameTextController
                                                    .text,
                                                phoneNumber: _model
                                                    .contactPhonenumberTextController
                                                    .text,
                                                emailId: _model
                                                    .contactemailTextController
                                                    .text,
                                                principalImage:
                                                    FFAppState().imageurl,
                                                principalId:
                                                    _model.user?.reference,
                                              ),
                                              clearUnsetFields: false,
                                              create: true,
                                            ),
                                            schoolStatus: 0,
                                            subscriptionStatus: 0,
                                            isBranchPresent: false,
                                            createdAt: getCurrentTimestamp,
                                            latlng: _model.address,
                                          ));
                                          _model.schooldoc =
                                              SchoolRecord.getDocumentFromData(
                                                  createSchoolRecordData(
                                                    schoolDetails:
                                                        updateSchoolDetailsStruct(
                                                      SchoolDetailsStruct(
                                                        schoolId: functions
                                                            .generateUniqueId(),
                                                        schoolName: _model
                                                            .schoolnameTextController
                                                            .text,
                                                        address: _model
                                                            .schoolAddressTextController
                                                            .text,
                                                        noOfFaculties:
                                                            int.tryParse(_model
                                                                .nooffacultiesTextController
                                                                .text),
                                                        noOfBranches:
                                                            int.tryParse(_model
                                                                .noofbranchesTextController
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
                                                        principalName: _model
                                                            .contactNameTextController
                                                            .text,
                                                        phoneNumber: _model
                                                            .contactPhonenumberTextController
                                                            .text,
                                                        emailId: _model
                                                            .contactemailTextController
                                                            .text,
                                                        principalImage:
                                                            FFAppState()
                                                                .imageurl,
                                                        principalId: _model
                                                            .user?.reference,
                                                      ),
                                                      clearUnsetFields: false,
                                                      create: true,
                                                    ),
                                                    schoolStatus: 0,
                                                    subscriptionStatus: 0,
                                                    isBranchPresent: false,
                                                    createdAt:
                                                        getCurrentTimestamp,
                                                    latlng: _model.address,
                                                  ),
                                                  schoolRecordReference);

                                          await _model.user!.reference.update({
                                            ...createUsersRecordData(
                                              photoUrl: _model
                                                  .schooldoc
                                                  ?.principalDetails
                                                  .principalImage,
                                            ),
                                            ...mapToFirestore(
                                              {
                                                'ListofSchool':
                                                    FieldValue.arrayUnion([
                                                  _model.schooldoc?.reference
                                                ]),
                                              },
                                            ),
                                          });
                                          _model.seandmail =
                                              await SendMailCall.call(
                                            toEmail: _model
                                                .contactemailTextController
                                                .text,
                                            userName: _model
                                                .contactemailTextController
                                                .text,
                                            password: _model
                                                .contactPhonenumberTextController
                                                .text,
                                          );

                                          if ((_model.seandmail?.succeeded ??
                                              true)) {
                                            await showDialog(
                                              context: context,
                                              builder: (dialogContext) {
                                                return Dialog(
                                                  elevation: 0,
                                                  insetPadding: EdgeInsets.zero,
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      const AlignmentDirectional(
                                                              0.0, -0.8)
                                                          .resolve(
                                                              Directionality.of(
                                                                  context)),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      FocusScope.of(
                                                              dialogContext)
                                                          .unfocus();
                                                      FocusManager
                                                          .instance.primaryFocus
                                                          ?.unfocus();
                                                    },
                                                    child: SizedBox(
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.08,
                                                      width: MediaQuery.sizeOf(
                                                                  context)
                                                              .width *
                                                          0.6,
                                                      child:
                                                          const SchooladdedsuccessfullyWidget(),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );

                                            context.pushNamed('Dashboard');
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  getJsonField(
                                                    (_model.seandmail
                                                            ?.jsonBody ??
                                                        ''),
                                                    r'''$.message''',
                                                  ).toString(),
                                                  style: TextStyle(
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                  ),
                                                ),
                                                duration: const Duration(
                                                    milliseconds: 4000),
                                                backgroundColor:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                              ),
                                            );
                                          }
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                getJsonField(
                                                  (_model.createaccount2
                                                          ?.jsonBody ??
                                                      ''),
                                                  r'''$.message''',
                                                ).toString(),
                                                style: TextStyle(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primaryText,
                                                ),
                                              ),
                                              duration:
                                                  const Duration(milliseconds: 4000),
                                              backgroundColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondary,
                                            ),
                                          );
                                        }
                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            'Please enter a valid pincode',
                                            style: TextStyle(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                            ),
                                          ),
                                          duration:
                                              const Duration(milliseconds: 4000),
                                          backgroundColor:
                                              FlutterFlowTheme.of(context)
                                                  .secondary,
                                        ),
                                      );
                                      safeSetState(() {
                                        _model.pincodeTextController?.clear();
                                      });
                                    }

                                    FFAppState().imageurl =
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
                                    FFAppState().profileimagechanged = false;
                                    FFAppState().schoolimage =
                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png';
                                    FFAppState().schoolimagechanged = false;
                                    safeSetState(() {});

                                    safeSetState(() {});
                                  },
                                  text: 'Send',
                                  options: FFButtonOptions(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.8,
                                    height: MediaQuery.sizeOf(context).height *
                                        0.06,
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
                                        Shadow(
                                          color: FlutterFlowTheme.of(context)
                                              .buttonShadow,
                                          offset: const Offset(0.0, 1.0),
                                          blurRadius: 2.0,
                                        ),
                                        Shadow(
                                          color: FlutterFlowTheme.of(context)
                                              .buttonShadow2,
                                          offset: const Offset(0.0, 0.0),
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
                      ),
                    ),
                  ]
                      .divide(const SizedBox(height: 5.0))
                      .addToEnd(const SizedBox(height: 10.0)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
