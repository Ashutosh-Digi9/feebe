import '/backend/api_requests/api_calls.dart';
import '/backend/backend.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/editphoto_widget.dart';
import '/confirmationpages/editsavedsuccessfully/editsavedsuccessfully_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/shimmer_effects/classshimmer/classshimmer_widget.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'edit_school_s_a_model.dart';
export 'edit_school_s_a_model.dart';

class EditSchoolSAWidget extends StatefulWidget {
  const EditSchoolSAWidget({
    super.key,
    required this.schoolRef,
    required this.mainschoolref,
  });

  final DocumentReference? schoolRef;
  final DocumentReference? mainschoolref;

  @override
  State<EditSchoolSAWidget> createState() => _EditSchoolSAWidgetState();
}

class _EditSchoolSAWidgetState extends State<EditSchoolSAWidget> {
  late EditSchoolSAModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditSchoolSAModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      FFAppState().profileimagechanged = false;
      FFAppState().schoolimagechanged = false;
      FFAppState().imageurl =
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
      FFAppState().schoolimage =
          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png';
      safeSetState(() {});
    });

    _model.schoolnameFocusNode ??= FocusNode();

    _model.noofbranchesFocusNode ??= FocusNode();

    _model.nooffacultiesFocusNode ??= FocusNode();

    _model.schoolAddressFocusNode ??= FocusNode();

    _model.pincodeFocusNode ??= FocusNode();
    _model.pincodeFocusNode!.addListener(
      () async {
        _model.apiResultjlv = await GetcityandstateCall.call(
          postalcode: _model.pincodeTextController.text,
        );

        if ((_model.apiResultjlv?.succeeded ?? true)) {
          _model.city = GetcityandstateCall.city(
            (_model.apiResultjlv?.jsonBody ?? ''),
          );
          _model.state = GetcityandstateCall.state(
            (_model.apiResultjlv?.jsonBody ?? ''),
          );
          _model.pincodechange = true;
          safeSetState(() {});
        }

        safeSetState(() {});
      },
    );

    _model.cityoldFocusNode ??= FocusNode();

    _model.cityTextController ??= TextEditingController(text: _model.city);
    _model.cityFocusNode ??= FocusNode();

    _model.stateoldFocusNode ??= FocusNode();

    _model.stateTextController ??= TextEditingController(text: _model.state);
    _model.stateFocusNode ??= FocusNode();

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

    return StreamBuilder<SchoolRecord>(
      stream: SchoolRecord.getDocument(widget.schoolRef!),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: const ClassshimmerWidget(),
          );
        }

        final editSchoolSASchoolRecord = snapshot.data!;

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
                'Edit School',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      color: FlutterFlowTheme.of(context).primaryText,
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
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
                  padding: const EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 0.08,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).tertiary,
                          ),
                          child: Align(
                            alignment: const AlignmentDirectional(0.0, 0.0),
                            child: Text(
                              editSchoolSASchoolRecord.schoolDetails.schoolName,
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
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context).secondaryText,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 1.0,
                                  color: Color(0x98000000),
                                  offset: Offset(
                                    0.0,
                                    0.0,
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Align(
                                  alignment: const AlignmentDirectional(-1.0, 0.0),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        10.0, 10.0, 0.0, 0.0),
                                    child: Text(
                                      'School Details',
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            fontSize: 18.0,
                                            letterSpacing: 0.0,
                                            fontWeight: FontWeight.w500,
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
                                              FFAppState().schoolimagechanged ==
                                                      true
                                                  ? FFAppState().schoolimage
                                                  : editSchoolSASchoolRecord
                                                      .schoolDetails
                                                      .schoolImage,
                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                            ),
                                            fit: BoxFit.contain,
                                          ),
                                          allowRotation: false,
                                          tag: valueOrDefault<String>(
                                            FFAppState().schoolimagechanged ==
                                                    true
                                                ? FFAppState().schoolimage
                                                : editSchoolSASchoolRecord
                                                    .schoolDetails.schoolImage,
                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                          ),
                                          useHeroAnimation: true,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Hero(
                                    tag: valueOrDefault<String>(
                                      FFAppState().schoolimagechanged == true
                                          ? FFAppState().schoolimage
                                          : editSchoolSASchoolRecord
                                              .schoolDetails.schoolImage,
                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
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
                                          FFAppState().schoolimagechanged ==
                                                  true
                                              ? FFAppState().schoolimage
                                              : editSchoolSASchoolRecord
                                                  .schoolDetails.schoolImage,
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  child: TextFormField(
                                    controller:
                                        _model.schoolnameTextController ??=
                                            TextEditingController(
                                      text: editSchoolSASchoolRecord
                                          .schoolDetails.schoolName,
                                    ),
                                    focusNode: _model.schoolnameFocusNode,
                                    autofocus: false,
                                    textCapitalization:
                                        TextCapitalization.words,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'School Name',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            letterSpacing: 0.0,
                                          ),
                                      hintText: 'School Name',
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
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .text1,
                                          letterSpacing: 0.0,
                                        ),
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .schoolnameTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  child: TextFormField(
                                    controller:
                                        _model.noofbranchesTextController ??=
                                            TextEditingController(
                                      text: editSchoolSASchoolRecord
                                          .schoolDetails.noOfBranches
                                          .toString(),
                                    ),
                                    focusNode: _model.noofbranchesFocusNode,
                                    autofocus: false,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'No of branches',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            letterSpacing: 0.0,
                                          ),
                                      hintText: 'No. of branches',
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
                                      fillColor: (_model.noofbranchesFocusNode
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
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .text1,
                                          letterSpacing: 0.0,
                                        ),
                                    keyboardType: TextInputType.number,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .noofbranchesTextControllerValidator
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
                                        _model.nooffacultiesTextController ??=
                                            TextEditingController(
                                      text: editSchoolSASchoolRecord
                                          .schoolDetails.noOfFaculties
                                          .toString(),
                                    ),
                                    focusNode: _model.nooffacultiesFocusNode,
                                    autofocus: false,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'No. of employee',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            letterSpacing: 0.0,
                                          ),
                                      hintText: 'No. of employee',
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
                                      fillColor: (_model.nooffacultiesFocusNode
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
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .text1,
                                          letterSpacing: 0.0,
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
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  child: TextFormField(
                                    controller:
                                        _model.schoolAddressTextController ??=
                                            TextEditingController(
                                      text: editSchoolSASchoolRecord
                                          .schoolDetails.address,
                                    ),
                                    focusNode: _model.schoolAddressFocusNode,
                                    autofocus: false,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      labelText: 'School address',
                                      labelStyle: FlutterFlowTheme.of(context)
                                          .labelMedium
                                          .override(
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
                                            letterSpacing: 0.0,
                                          ),
                                      hintText: 'School address',
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
                                            BorderRadius.circular(20.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: FlutterFlowTheme.of(context)
                                              .error,
                                          width: 1.0,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      filled: true,
                                      fillColor: (_model.schoolAddressFocusNode
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
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .text1,
                                          letterSpacing: 0.0,
                                        ),
                                    maxLines: 5,
                                    cursorColor: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    validator: _model
                                        .schoolAddressTextControllerValidator
                                        .asValidator(context),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.sizeOf(context).width * 0.9,
                                  child: TextFormField(
                                    controller: _model.pincodeTextController ??=
                                        TextEditingController(
                                      text: editSchoolSASchoolRecord
                                          .schoolDetails.pincode,
                                    ),
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
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBackground,
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
                                Align(
                                  alignment: const AlignmentDirectional(-0.88, 0.0),
                                  child: Text(
                                    'City',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                if (_model.city == null || _model.city == '')
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    child: TextFormField(
                                      controller:
                                          _model.cityoldTextController ??=
                                              TextEditingController(
                                        text: editSchoolSASchoolRecord
                                            .schoolDetails.city,
                                      ),
                                      focusNode: _model.cityoldFocusNode,
                                      autofocus: false,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      readOnly: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              letterSpacing: 0.0,
                                            ),
                                        hintText: _model.city,
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .text1,
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
                                        fillColor: (_model.cityoldFocusNode
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
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .text1,
                                            letterSpacing: 0.0,
                                          ),
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model
                                          .cityoldTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                if (_model.city != null && _model.city != '')
                                  SizedBox(
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
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              letterSpacing: 0.0,
                                            ),
                                        hintText: _model.city,
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .text1,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
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
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .text1,
                                            letterSpacing: 0.0,
                                          ),
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model
                                          .cityTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                Align(
                                  alignment: const AlignmentDirectional(-0.88, 0.0),
                                  child: Text(
                                    'State',
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          fontSize: 12.0,
                                          letterSpacing: 0.0,
                                        ),
                                  ),
                                ),
                                if (_model.state == null || _model.state == '')
                                  SizedBox(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.9,
                                    child: TextFormField(
                                      controller:
                                          _model.stateoldTextController ??=
                                              TextEditingController(
                                        text: editSchoolSASchoolRecord
                                            .schoolDetails.state,
                                      ),
                                      focusNode: _model.stateoldFocusNode,
                                      autofocus: false,
                                      textCapitalization:
                                          TextCapitalization.sentences,
                                      readOnly: true,
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        isDense: true,
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              letterSpacing: 0.0,
                                            ),
                                        hintText: _model.state,
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .text1,
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
                                        fillColor: (_model.stateoldFocusNode
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
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .text1,
                                            letterSpacing: 0.0,
                                          ),
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model
                                          .stateoldTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                                if (_model.state != null && _model.state != '')
                                  SizedBox(
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
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                              letterSpacing: 0.0,
                                            ),
                                        hintText: _model.state,
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Nunito',
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .text1,
                                              letterSpacing: 0.0,
                                              fontWeight: FontWeight.normal,
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
                                            fontFamily: 'Nunito',
                                            color: FlutterFlowTheme.of(context)
                                                .text1,
                                            letterSpacing: 0.0,
                                          ),
                                      cursorColor: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      validator: _model
                                          .stateTextControllerValidator
                                          .asValidator(context),
                                    ),
                                  ),
                              ]
                                  .divide(const SizedBox(height: 15.0))
                                  .around(const SizedBox(height: 15.0)),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).secondaryText,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 1.0,
                                color: Color(0x98000000),
                                offset: Offset(
                                  0.0,
                                  0.0,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(12.0),
                          ),
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
                                          fontWeight: FontWeight.w500,
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
                                            height: 100.0,
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
                                            FFAppState().profileimagechanged ==
                                                    true
                                                ? FFAppState().imageurl
                                                : editSchoolSASchoolRecord
                                                    .principalDetails
                                                    .principalImage,
                                            'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fhappy-children-back-school-background_23-2147852164.jpg?alt=media&token=e1069716-5656-42e7-a945-ff9fe1565ec6',
                                          ),
                                          fit: BoxFit.contain,
                                        ),
                                        allowRotation: false,
                                        tag: valueOrDefault<String>(
                                          FFAppState().profileimagechanged ==
                                                  true
                                              ? FFAppState().imageurl
                                              : editSchoolSASchoolRecord
                                                  .principalDetails
                                                  .principalImage,
                                          'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fhappy-children-back-school-background_23-2147852164.jpg?alt=media&token=e1069716-5656-42e7-a945-ff9fe1565ec6',
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
                                        : editSchoolSASchoolRecord
                                            .principalDetails.principalImage,
                                    'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fhappy-children-back-school-background_23-2147852164.jpg?alt=media&token=e1069716-5656-42e7-a945-ff9fe1565ec6',
                                  ),
                                  transitionOnUserGestures: true,
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.45,
                                    height:
                                        MediaQuery.sizeOf(context).width * 0.45,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      valueOrDefault<String>(
                                        FFAppState().profileimagechanged == true
                                            ? FFAppState().imageurl
                                            : editSchoolSASchoolRecord
                                                .principalDetails
                                                .principalImage,
                                        'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fhappy-children-back-school-background_23-2147852164.jpg?alt=media&token=e1069716-5656-42e7-a945-ff9fe1565ec6',
                                      ),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: TextFormField(
                                  controller:
                                      _model.contactNameTextController ??=
                                          TextEditingController(
                                    text: editSchoolSASchoolRecord
                                        .principalDetails.principalName,
                                  ),
                                  focusNode: _model.contactNameFocusNode,
                                  autofocus: false,
                                  textCapitalization: TextCapitalization.words,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Admin\'s name',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'Admin\'s name',
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
                                    fillColor: (_model.contactNameFocusNode
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
                                  controller: _model
                                          .contactPhonenumberTextController ??=
                                      TextEditingController(
                                    text: editSchoolSASchoolRecord
                                        .principalDetails.phoneNumber,
                                  ),
                                  focusNode: _model.contactPhonenumberFocusNode,
                                  autofocus: false,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Admin\'s phone number',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'Admin\'s phone number',
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
                                    fillColor: (_model
                                                .contactPhonenumberFocusNode
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
                                  controller:
                                      _model.contactemailTextController ??=
                                          TextEditingController(
                                    text: editSchoolSASchoolRecord
                                        .principalDetails.emailId,
                                  ),
                                  focusNode: _model.contactemailFocusNode,
                                  autofocus: false,
                                  readOnly: true,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    labelText: 'Admin\'s email',
                                    labelStyle: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBackground,
                                          letterSpacing: 0.0,
                                        ),
                                    hintText: 'Admin\'s email',
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
                                        color:
                                            FlutterFlowTheme.of(context).text1,
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
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.1,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 10.0,
                                color: Color(0x48B7B7B7),
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
                              builder: (context) => FFButtonWidget(
                                onPressed: () async {
                                  if (_model.formKey.currentState == null ||
                                      !_model.formKey.currentState!
                                          .validate()) {
                                    return;
                                  }
                                  if ((_model.pincodechange == true) &&
                                      (_model.city == null ||
                                          _model.city == '')) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          'Please enter valid pincode',
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
                                    safeSetState(() {
                                      _model.pincodeTextController?.clear();
                                    });
                                  } else {
                                    if (_model.city == null ||
                                        _model.city == '') {
                                      _model.latlng = await actions.fetchlatlng(
                                        '${_model.schoolAddressTextController.text}${_model.stateoldTextController.text}${_model.cityTextController.text}${_model.pincodeTextController.text}',
                                      );

                                      await widget.schoolRef!
                                          .update(createSchoolRecordData(
                                        schoolDetails:
                                            updateSchoolDetailsStruct(
                                          SchoolDetailsStruct(
                                            schoolId: editSchoolSASchoolRecord
                                                .schoolDetails.schoolId,
                                            schoolName: _model
                                                .schoolnameTextController.text,
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
                                                FFAppState().schoolimagechanged
                                                    ? FFAppState().schoolimage
                                                    : editSchoolSASchoolRecord
                                                        .schoolDetails
                                                        .schoolImage,
                                            pincode: _model
                                                .pincodeTextController.text,
                                            city: _model.city != null &&
                                                    _model.city != ''
                                                ? _model.city
                                                : _model
                                                    .cityoldTextController.text,
                                            state: _model.state != null &&
                                                    _model.state != ''
                                                ? _model.state
                                                : _model.stateoldTextController
                                                    .text,
                                          ),
                                          clearUnsetFields: false,
                                        ),
                                        principalDetails:
                                            updatePrincipalDetailsStruct(
                                          PrincipalDetailsStruct(
                                            principalName: _model
                                                .contactNameTextController.text,
                                            phoneNumber: _model
                                                .contactPhonenumberTextController
                                                .text,
                                            principalImage:
                                                FFAppState().profileimagechanged
                                                    ? FFAppState().imageurl
                                                    : editSchoolSASchoolRecord
                                                        .principalDetails
                                                        .principalImage,
                                            emailId: _model
                                                .contactemailTextController
                                                .text,
                                            principalId:
                                                editSchoolSASchoolRecord
                                                    .principalDetails
                                                    .principalId,
                                          ),
                                          clearUnsetFields: false,
                                        ),
                                        latlng: _model.latlng,
                                      ));

                                      await editSchoolSASchoolRecord
                                          .principalDetails.principalId!
                                          .update(createUsersRecordData(
                                        email: _model
                                            .contactemailTextController.text,
                                        displayName: _model
                                            .contactNameTextController.text,
                                        photoUrl:
                                            FFAppState().profileimagechanged
                                                ? FFAppState().imageurl
                                                : editSchoolSASchoolRecord
                                                    .principalDetails
                                                    .principalImage,
                                        phoneNumber: _model
                                            .contactPhonenumberTextController
                                            .text,
                                      ));
                                      triggerPushNotification(
                                        notificationTitle: ' Edit school',
                                        notificationText:
                                            'Your school details has been edited',
                                        userRefs: [
                                          editSchoolSASchoolRecord
                                              .principalDetails.principalId!
                                        ],
                                        initialPageName: 'Dashboard',
                                        parameterData: {},
                                      );
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: const AlignmentDirectional(
                                                    0.0, -0.8)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(dialogContext)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: SizedBox(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.08,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.6,
                                                child:
                                                    const EditsavedsuccessfullyWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      );

                                      context.goNamed(
                                        'ExistingSchoolDetails_SA',
                                        queryParameters: {
                                          'schoolrefMain': serializeParam(
                                            widget.mainschoolref,
                                            ParamType.DocumentReference,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: const TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                          ),
                                        },
                                      );
                                    } else {
                                      _model.latlng1 =
                                          await actions.fetchlatlng(
                                        '${_model.schoolAddressTextController.text}${_model.state}${_model.city}${_model.pincodeTextController.text}',
                                      );

                                      await widget.schoolRef!
                                          .update(createSchoolRecordData(
                                        schoolDetails:
                                            updateSchoolDetailsStruct(
                                          SchoolDetailsStruct(
                                            schoolId: editSchoolSASchoolRecord
                                                .schoolDetails.schoolId,
                                            schoolName: _model
                                                .schoolnameTextController.text,
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
                                                FFAppState().schoolimagechanged
                                                    ? FFAppState().schoolimage
                                                    : editSchoolSASchoolRecord
                                                        .schoolDetails
                                                        .schoolImage,
                                            pincode: _model
                                                .pincodeTextController.text,
                                            city: _model.city != null &&
                                                    _model.city != ''
                                                ? _model.city
                                                : _model
                                                    .cityoldTextController.text,
                                            state: _model.state != null &&
                                                    _model.state != ''
                                                ? _model.state
                                                : _model.stateoldTextController
                                                    .text,
                                          ),
                                          clearUnsetFields: false,
                                        ),
                                        principalDetails:
                                            updatePrincipalDetailsStruct(
                                          PrincipalDetailsStruct(
                                            principalName: _model
                                                .contactNameTextController.text,
                                            phoneNumber: _model
                                                .contactPhonenumberTextController
                                                .text,
                                            principalImage:
                                                FFAppState().profileimagechanged
                                                    ? FFAppState().imageurl
                                                    : editSchoolSASchoolRecord
                                                        .principalDetails
                                                        .principalImage,
                                            emailId: _model
                                                .contactemailTextController
                                                .text,
                                            principalId:
                                                editSchoolSASchoolRecord
                                                    .principalDetails
                                                    .principalId,
                                          ),
                                          clearUnsetFields: false,
                                        ),
                                        latlng: _model.latlng1,
                                      ));

                                      await editSchoolSASchoolRecord
                                          .principalDetails.principalId!
                                          .update(createUsersRecordData(
                                        email: _model
                                            .contactemailTextController.text,
                                        displayName: _model
                                            .contactNameTextController.text,
                                        photoUrl:
                                            FFAppState().profileimagechanged
                                                ? FFAppState().imageurl
                                                : editSchoolSASchoolRecord
                                                    .principalDetails
                                                    .principalImage,
                                        phoneNumber: _model
                                            .contactPhonenumberTextController
                                            .text,
                                      ));
                                      triggerPushNotification(
                                        notificationTitle: ' Edit school',
                                        notificationText:
                                            'Your school details has been edited',
                                        userRefs: [
                                          editSchoolSASchoolRecord
                                              .principalDetails.principalId!
                                        ],
                                        initialPageName: 'Dashboard',
                                        parameterData: {},
                                      );
                                      await showDialog(
                                        context: context,
                                        builder: (dialogContext) {
                                          return Dialog(
                                            elevation: 0,
                                            insetPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            alignment: const AlignmentDirectional(
                                                    0.0, -0.8)
                                                .resolve(
                                                    Directionality.of(context)),
                                            child: GestureDetector(
                                              onTap: () {
                                                FocusScope.of(dialogContext)
                                                    .unfocus();
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                              },
                                              child: SizedBox(
                                                height:
                                                    MediaQuery.sizeOf(context)
                                                            .height *
                                                        0.08,
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.6,
                                                child:
                                                    const EditsavedsuccessfullyWidget(),
                                              ),
                                            ),
                                          );
                                        },
                                      );

                                      context.goNamed(
                                        'ExistingSchoolDetails_SA',
                                        queryParameters: {
                                          'schoolrefMain': serializeParam(
                                            widget.mainschoolref,
                                            ParamType.DocumentReference,
                                          ),
                                        }.withoutNulls,
                                        extra: <String, dynamic>{
                                          kTransitionInfoKey: const TransitionInfo(
                                            hasTransition: true,
                                            transitionType:
                                                PageTransitionType.fade,
                                          ),
                                        },
                                      );
                                    }
                                  }

                                  safeSetState(() {});
                                },
                                text: 'Update',
                                options: FFButtonOptions(
                                  width: MediaQuery.sizeOf(context).width * 0.8,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.06,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 16.0, 16.0, 16.0),
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
                                        color: Color(0x79253EA7),
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
                                  elevation: 3.0,
                                  borderRadius: BorderRadius.circular(8.0),
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
          ),
        );
      },
    );
  }
}
