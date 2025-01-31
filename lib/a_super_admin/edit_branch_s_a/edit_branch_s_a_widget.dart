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
import 'edit_branch_s_a_model.dart';
export 'edit_branch_s_a_model.dart';

class EditBranchSAWidget extends StatefulWidget {
  const EditBranchSAWidget({
    super.key,
    required this.schoolref,
    required this.mainschoolref,
  });

  final DocumentReference? schoolref;
  final DocumentReference? mainschoolref;

  @override
  State<EditBranchSAWidget> createState() => _EditBranchSAWidgetState();
}

class _EditBranchSAWidgetState extends State<EditBranchSAWidget> {
  late EditBranchSAModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditBranchSAModel());

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

    _model.nooffacultiesFocusNode ??= FocusNode();

    _model.pincodeFocusNode ??= FocusNode();
    _model.pincodeFocusNode!.addListener(
      () async {
        _model.apiResultut5 = await GetcityandstateCall.call(
          postalcode: _model.pincodeTextController.text,
        );

        if ((_model.apiResultut5?.succeeded ?? true)) {
          _model.city = GetcityandstateCall.city(
            (_model.apiResultut5?.jsonBody ?? ''),
          );
          _model.state = GetcityandstateCall.state(
            (_model.apiResultut5?.jsonBody ?? ''),
          );
          _model.pincodechange = true;
          safeSetState(() {});
        }

        safeSetState(() {});
      },
    );

    _model.schoolAddressFocusNode ??= FocusNode();

    _model.cityFocusNode1 ??= FocusNode();

    _model.cityTextController2 ??= TextEditingController(text: _model.city);
    _model.cityFocusNode2 ??= FocusNode();

    _model.stateFocusNode1 ??= FocusNode();

    _model.stateTextController2 ??= TextEditingController(text: _model.state);
    _model.stateFocusNode2 ??= FocusNode();
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
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: const ClassshimmerWidget(),
          );
        }

        final editBranchSASchoolRecord = snapshot.data!;

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
                'Edit Branch',
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
                          child: Text(
                            editBranchSASchoolRecord.schoolDetails.schoolName,
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
                                  child: const SizedBox(
                                    height: 201.0,
                                    child: EditphotoWidget(
                                      person: false,
                                      child: false,
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
                                    FFAppState().schoolimagechanged == true
                                        ? FFAppState().schoolimage
                                        : editBranchSASchoolRecord
                                            .schoolDetails.schoolImage,
                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                  ),
                                  fit: BoxFit.contain,
                                ),
                                allowRotation: false,
                                tag: valueOrDefault<String>(
                                  FFAppState().schoolimagechanged == true
                                      ? FFAppState().schoolimage
                                      : editBranchSASchoolRecord
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
                                : editBranchSASchoolRecord
                                    .schoolDetails.schoolImage,
                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                          ),
                          transitionOnUserGestures: true,
                          child: Container(
                            width: MediaQuery.sizeOf(context).width * 0.45,
                            height: MediaQuery.sizeOf(context).width * 0.45,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Image.network(
                              valueOrDefault<String>(
                                FFAppState().schoolimagechanged == true
                                    ? FFAppState().schoolimage
                                    : editBranchSASchoolRecord
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
                          controller: _model.schoolnameTextController ??=
                              TextEditingController(
                            text: editBranchSASchoolRecord
                                .schoolDetails.schoolName,
                          ),
                          focusNode: _model.schoolnameFocusNode,
                          autofocus: false,
                          textCapitalization: TextCapitalization.words,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'School name ',
                            labelStyle: FlutterFlowTheme.of(context)
                                .labelMedium
                                .override(
                                  fontFamily: 'Nunito',
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  letterSpacing: 0.0,
                                ),
                            hintText: 'Branch Name',
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
                                (_model.schoolnameFocusNode?.hasFocus ?? false)
                                    ? FlutterFlowTheme.of(context).secondary
                                    : FlutterFlowTheme.of(context).tertiary,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context).text1,
                                    letterSpacing: 0.0,
                                  ),
                          maxLines: 2,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.schoolnameTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        child: TextFormField(
                          controller: _model.nooffacultiesTextController ??=
                              TextEditingController(
                            text: editBranchSASchoolRecord
                                .schoolDetails.noOfFaculties
                                .toString(),
                          ),
                          focusNode: _model.nooffacultiesFocusNode,
                          autofocus: false,
                          textCapitalization: TextCapitalization.sentences,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'No of employee',
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
                                (_model.nooffacultiesFocusNode?.hasFocus ??
                                        false)
                                    ? FlutterFlowTheme.of(context).secondary
                                    : FlutterFlowTheme.of(context).tertiary,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context).text1,
                                    letterSpacing: 0.0,
                                  ),
                          keyboardType: TextInputType.number,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.nooffacultiesTextControllerValidator
                              .asValidator(context),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        child: TextFormField(
                          controller: _model.pincodeTextController ??=
                              TextEditingController(
                            text:
                                editBranchSASchoolRecord.schoolDetails.pincode,
                          ),
                          focusNode: _model.pincodeFocusNode,
                          autofocus: false,
                          textCapitalization: TextCapitalization.sentences,
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
                            hintText: 'No. of faculties',
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
                                (_model.pincodeFocusNode?.hasFocus ?? false)
                                    ? FlutterFlowTheme.of(context).secondary
                                    : FlutterFlowTheme.of(context).tertiary,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context).text1,
                                    letterSpacing: 0.0,
                                  ),
                          keyboardType: TextInputType.number,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.pincodeTextControllerValidator
                              .asValidator(context),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.sizeOf(context).width * 0.9,
                        child: TextFormField(
                          controller: _model.schoolAddressTextController ??=
                              TextEditingController(
                            text:
                                editBranchSASchoolRecord.schoolDetails.address,
                          ),
                          focusNode: _model.schoolAddressFocusNode,
                          autofocus: false,
                          textCapitalization: TextCapitalization.sentences,
                          obscureText: false,
                          decoration: InputDecoration(
                            isDense: true,
                            labelText: 'School Address',
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
                                (_model.schoolAddressFocusNode?.hasFocus ??
                                        false)
                                    ? FlutterFlowTheme.of(context).secondary
                                    : FlutterFlowTheme.of(context).tertiary,
                          ),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context).text1,
                                    letterSpacing: 0.0,
                                  ),
                          maxLines: 5,
                          cursorColor: FlutterFlowTheme.of(context).primaryText,
                          validator: _model.schoolAddressTextControllerValidator
                              .asValidator(context),
                        ),
                      ),
                      Align(
                        alignment: const AlignmentDirectional(-0.88, 0.0),
                        child: Text(
                          'City',
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
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
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: TextFormField(
                            controller: _model.cityTextController1 ??=
                                TextEditingController(
                              text: editBranchSASchoolRecord.schoolDetails.city,
                            ),
                            focusNode: _model.cityFocusNode1,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            readOnly: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: _model.city,
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
                                  (_model.cityFocusNode1?.hasFocus ?? false)
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
                            validator: _model.cityTextController1Validator
                                .asValidator(context),
                          ),
                        ),
                      if (_model.city != null && _model.city != '')
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: TextFormField(
                            controller: _model.cityTextController2,
                            focusNode: _model.cityFocusNode2,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            readOnly: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: _model.city,
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context).text1,
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
                                  (_model.cityFocusNode2?.hasFocus ?? false)
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
                            validator: _model.cityTextController2Validator
                                .asValidator(context),
                          ),
                        ),
                      Align(
                        alignment: const AlignmentDirectional(-0.88, 0.0),
                        child: Text(
                          'State',
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
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
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: TextFormField(
                            controller: _model.stateTextController1 ??=
                                TextEditingController(
                              text:
                                  editBranchSASchoolRecord.schoolDetails.state,
                            ),
                            focusNode: _model.stateFocusNode1,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            readOnly: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: _model.state,
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
                                  (_model.stateFocusNode1?.hasFocus ?? false)
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
                            validator: _model.stateTextController1Validator
                                .asValidator(context),
                          ),
                        ),
                      if (_model.state != null && _model.state != '')
                        SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: TextFormField(
                            controller: _model.stateTextController2,
                            focusNode: _model.stateFocusNode2,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            readOnly: true,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryBackground,
                                    letterSpacing: 0.0,
                                  ),
                              hintText: _model.state,
                              hintStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context).text1,
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
                                  (_model.stateFocusNode2?.hasFocus ?? false)
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
                            validator: _model.stateTextController2Validator
                                .asValidator(context),
                          ),
                        ),
                      Container(
                        width: MediaQuery.sizeOf(context).width * 1.0,
                        height: MediaQuery.sizeOf(context).height * 0.1,
                        decoration: BoxDecoration(
                          color:
                              FlutterFlowTheme.of(context).secondaryBackground,
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 10.0,
                              color: Color(0x3FB7B7B7),
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
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 10.0),
                              child: FFButtonWidget(
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
                                          'Please enter a valid pincode',
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
                                        '${_model.schoolAddressTextController.text}${_model.stateTextController1.text}${_model.cityTextController1.text}${_model.pincodeTextController.text}',
                                      );

                                      await widget.schoolref!
                                          .update(createSchoolRecordData(
                                        schoolDetails:
                                            updateSchoolDetailsStruct(
                                          SchoolDetailsStruct(
                                            schoolName: _model
                                                .schoolnameTextController.text,
                                            address: _model
                                                .schoolAddressTextController
                                                .text,
                                            noOfFaculties: int.tryParse(_model
                                                .nooffacultiesTextController
                                                .text),
                                            schoolImage:
                                                FFAppState().schoolimagechanged
                                                    ? FFAppState().schoolimage
                                                    : editBranchSASchoolRecord
                                                        .schoolDetails
                                                        .schoolImage,
                                            pincode: _model
                                                .pincodeTextController.text,
                                            city: _model.city != null &&
                                                    _model.city != ''
                                                ? _model.city
                                                : _model
                                                    .cityTextController1.text,
                                            state: _model.state != null &&
                                                    _model.state != ''
                                                ? _model.state
                                                : _model
                                                    .stateTextController1.text,
                                          ),
                                          clearUnsetFields: false,
                                        ),
                                        isBranchPresent: true,
                                        latlng: _model.latlng,
                                      ));
                                      triggerPushNotification(
                                        notificationTitle: ' Edit Branch',
                                        notificationText:
                                            'Your Branch details has been edited',
                                        userRefs: [
                                          editBranchSASchoolRecord
                                              .principalDetails.principalId!
                                        ],
                                        initialPageName: 'Dashboard',
                                        parameterData: {},
                                      );
                                      FFAppState().imageurl =
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
                                      FFAppState().profileimagechanged = false;
                                      FFAppState().schoolimage =
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png';
                                      FFAppState().schoolimagechanged = false;
                                      safeSetState(() {});
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
                                      _model.latlng12 =
                                          await actions.fetchlatlng(
                                        '${_model.schoolAddressTextController.text}${_model.state}${_model.city}${_model.pincodeTextController.text}',
                                      );

                                      await widget.schoolref!
                                          .update(createSchoolRecordData(
                                        schoolDetails:
                                            updateSchoolDetailsStruct(
                                          SchoolDetailsStruct(
                                            schoolName: _model
                                                .schoolnameTextController.text,
                                            address: _model
                                                .schoolAddressTextController
                                                .text,
                                            noOfFaculties: int.tryParse(_model
                                                .nooffacultiesTextController
                                                .text),
                                            schoolImage:
                                                FFAppState().schoolimagechanged
                                                    ? FFAppState().schoolimage
                                                    : editBranchSASchoolRecord
                                                        .schoolDetails
                                                        .schoolImage,
                                            pincode: _model
                                                .pincodeTextController.text,
                                            city: _model.city != null &&
                                                    _model.city != ''
                                                ? _model.city
                                                : _model
                                                    .cityTextController1.text,
                                            state: _model.state != null &&
                                                    _model.state != ''
                                                ? _model.state
                                                : _model
                                                    .stateTextController1.text,
                                          ),
                                          clearUnsetFields: false,
                                        ),
                                        isBranchPresent: true,
                                        latlng: _model.latlng12,
                                      ));
                                      triggerPushNotification(
                                        notificationTitle: ' Edit Branch',
                                        notificationText:
                                            'Your Branch details has been edited',
                                        userRefs: [
                                          editBranchSASchoolRecord
                                              .principalDetails.principalId!
                                        ],
                                        initialPageName: 'Dashboard',
                                        parameterData: {},
                                      );
                                      FFAppState().imageurl =
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png';
                                      FFAppState().profileimagechanged = false;
                                      FFAppState().schoolimage =
                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png';
                                      FFAppState().schoolimagechanged = false;
                                      safeSetState(() {});
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
                                text: 'Update ',
                                options: FFButtonOptions(
                                  width:
                                      MediaQuery.sizeOf(context).width * 0.85,
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.05,
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      16.0, 0.0, 16.0, 0.0),
                                  iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 0.0, 0.0, 0.0),
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                  textStyle: FlutterFlowTheme.of(context)
                                      .titleSmall
                                      .override(
                                    fontFamily: 'Nunito',
                                    color: Colors.white,
                                    letterSpacing: 0.0,
                                    shadows: [
                                      const Shadow(
                                        color: Color(0xFF375DFB),
                                        offset: Offset(0.0, 0.0),
                                        blurRadius: 0.0,
                                      ),
                                      const Shadow(
                                        color: Color(0xFF253EA7),
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
