import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/backend/push_notifications/push_notifications_util.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/shimmer_effects/classshimmer/classshimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:collection/collection.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'addnotice_all_schools_model.dart';
export 'addnotice_all_schools_model.dart';

class AddnoticeAllSchoolsWidget extends StatefulWidget {
  const AddnoticeAllSchoolsWidget({super.key});

  @override
  State<AddnoticeAllSchoolsWidget> createState() =>
      _AddnoticeAllSchoolsWidgetState();
}

class _AddnoticeAllSchoolsWidgetState extends State<AddnoticeAllSchoolsWidget> {
  late AddnoticeAllSchoolsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddnoticeAllSchoolsModel());

    _model.eventnameTextController ??= TextEditingController();
    _model.eventnameFocusNode ??= FocusNode();

    _model.descriptionTextController ??= TextEditingController();
    _model.descriptionFocusNode ??= FocusNode();

    _model.searchTextController ??= TextEditingController();
    _model.searchFocusNode ??= FocusNode();
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
            'Notice',
            style: FlutterFlowTheme.of(context).headlineMedium.override(
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
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 10.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Form(
                                  key: _model.formKey,
                                  autovalidateMode: AutovalidateMode.disabled,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            10.0, 10.0, 10.0, 0.0),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.noticename = 'General';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.25,
                                                  decoration: BoxDecoration(
                                                    color: _model.noticename ==
                                                            'General'
                                                        ? const Color(0xFFFFFCF0)
                                                        : const Color(0xFFF5F2F2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    border: Border.all(
                                                      color:
                                                          valueOrDefault<Color>(
                                                        _model.noticename ==
                                                                'General'
                                                            ? const Color(0xFFFF976A)
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .text,
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .text,
                                                      ),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                0.0, 5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(
                                                          Icons.mode_comment,
                                                          color: valueOrDefault<
                                                              Color>(
                                                            _model.noticename ==
                                                                    'General'
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .warning
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .warning,
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .warning,
                                                          ),
                                                          size: 20.0,
                                                        ),
                                                        Text(
                                                          'General',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  _model.noticename ==
                                                                          'General'
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .text,
                                                                ),
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ]
                                                          .divide(const SizedBox(
                                                              width: 10.0))
                                                          .around(const SizedBox(
                                                              width: 10.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.noticename = '';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.25,
                                                  decoration: BoxDecoration(
                                                    color: _model.noticename ==
                                                            'Reminder'
                                                        ? const Color(0xC3FBF0FF)
                                                        : const Color(0xFFF5F2F2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    border: Border.all(
                                                      color:
                                                          valueOrDefault<Color>(
                                                        _model.noticename ==
                                                                'Reminder'
                                                            ? const Color(0xFFADA6EB)
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .text,
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .text,
                                                      ),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                0.0, 5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(
                                                          Icons.alarm_sharp,
                                                          color: valueOrDefault<
                                                              Color>(
                                                            _model.noticename ==
                                                                    'Reminder'
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .error
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .warning,
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .warning,
                                                          ),
                                                          size: 20.0,
                                                        ),
                                                        Text(
                                                          'Reminder',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  _model.noticename ==
                                                                          'Reminder'
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .text,
                                                                ),
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ]
                                                          .divide(const SizedBox(
                                                              width: 10.0))
                                                          .around(const SizedBox(
                                                              width: 10.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              InkWell(
                                                splashColor: Colors.transparent,
                                                focusColor: Colors.transparent,
                                                hoverColor: Colors.transparent,
                                                highlightColor:
                                                    Colors.transparent,
                                                onTap: () async {
                                                  _model.noticename = 'Notice';
                                                  safeSetState(() {});
                                                },
                                                child: Container(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.25,
                                                  decoration: BoxDecoration(
                                                    color: _model.noticename ==
                                                            'Notice'
                                                        ? const Color(0xFFFFFCF0)
                                                        : const Color(0xFFF5F2F2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    border: Border.all(
                                                      color:
                                                          valueOrDefault<Color>(
                                                        _model.noticename ==
                                                                'Notice'
                                                            ? const Color(0xFFB0FF6A)
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .text,
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .text,
                                                      ),
                                                      width: 1.0,
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 5.0,
                                                                0.0, 5.0),
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Icon(
                                                          Icons.push_pin,
                                                          color: valueOrDefault<
                                                              Color>(
                                                            _model.noticename ==
                                                                    'Notice'
                                                                ? FlutterFlowTheme.of(
                                                                        context)
                                                                    .checkBg
                                                                : FlutterFlowTheme.of(
                                                                        context)
                                                                    .warning,
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .warning,
                                                          ),
                                                          size: 20.0,
                                                        ),
                                                        Text(
                                                          'Notice',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  _model.noticename ==
                                                                          'Notice'
                                                                      ? FlutterFlowTheme.of(
                                                                              context)
                                                                          .primaryText
                                                                      : FlutterFlowTheme.of(
                                                                              context)
                                                                          .alternate,
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .text,
                                                                ),
                                                                fontSize: 12.0,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                        ),
                                                      ]
                                                          .divide(const SizedBox(
                                                              width: 10.0))
                                                          .around(const SizedBox(
                                                              width: 10.0)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ].divide(const SizedBox(width: 10.0)),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 5.0, 0.0, 10.0),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.9,
                                          child: TextFormField(
                                            controller:
                                                _model.eventnameTextController,
                                            focusNode:
                                                _model.eventnameFocusNode,
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelText: 'Title',
                                              labelStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Nunito',
                                                    color:
                                                        valueOrDefault<Color>(
                                                      (_model.eventnameFocusNode
                                                                  ?.hasFocus ??
                                                              false)
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primary
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                    ),
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                              hintText: 'Title',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryText,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .dIsable,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Nunito',
                                                  letterSpacing: 0.0,
                                                ),
                                            maxLength: 25,
                                            buildCounter: (context,
                                                    {required currentLength,
                                                    required isFocused,
                                                    maxLength}) =>
                                                null,
                                            cursorColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            validator: _model
                                                .eventnameTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  0.9,
                                          child: TextFormField(
                                            controller: _model
                                                .descriptionTextController,
                                            focusNode:
                                                _model.descriptionFocusNode,
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: true,
                                              labelText: 'Description',
                                              labelStyle: FlutterFlowTheme.of(
                                                      context)
                                                  .labelMedium
                                                  .override(
                                                    fontFamily: 'Nunito',
                                                    color:
                                                        valueOrDefault<Color>(
                                                      (_model.descriptionFocusNode
                                                                  ?.hasFocus ??
                                                              false)
                                                          ? FlutterFlowTheme.of(
                                                                  context)
                                                              .primary
                                                          : FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .alternate,
                                                    ),
                                                    fontSize: 12.0,
                                                    letterSpacing: 0.0,
                                                  ),
                                              hintText: 'Description',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiaryText,
                                                        fontSize: 12.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .dIsable,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              focusedErrorBorder:
                                                  OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .error,
                                                  width: 1.0,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .secondaryBackground,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Nunito',
                                                  letterSpacing: 0.0,
                                                ),
                                            maxLines: 4,
                                            cursorColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            validator: _model
                                                .descriptionTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            0.0, 10.0, 0.0, 0.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            FlutterFlowIconButton(
                                              borderColor:
                                                  FlutterFlowTheme.of(context)
                                                      .alternate,
                                              borderRadius: 8.0,
                                              borderWidth: 0.2,
                                              buttonSize: 40.0,
                                              icon: Icon(
                                                Icons.attach_file,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .tertiaryText,
                                                size: 24.0,
                                              ),
                                              showLoadingIndicator: true,
                                              onPressed: () async {
                                                final selectedMedia =
                                                    await selectMedia(
                                                  imageQuality: 10,
                                                  mediaSource:
                                                      MediaSource.photoGallery,
                                                  multiImage: true,
                                                );
                                                if (selectedMedia != null &&
                                                    selectedMedia.every((m) =>
                                                        validateFileFormat(
                                                            m.storagePath,
                                                            context))) {
                                                  safeSetState(() => _model
                                                      .isDataUploading = true);
                                                  var selectedUploadedFiles =
                                                      <FFUploadedFile>[];

                                                  var downloadUrls = <String>[];
                                                  try {
                                                    showUploadMessage(
                                                      context,
                                                      'Uploading file...',
                                                      showLoading: true,
                                                    );
                                                    selectedUploadedFiles =
                                                        selectedMedia
                                                            .map((m) =>
                                                                FFUploadedFile(
                                                                  name: m
                                                                      .storagePath
                                                                      .split(
                                                                          '/')
                                                                      .last,
                                                                  bytes:
                                                                      m.bytes,
                                                                  height: m
                                                                      .dimensions
                                                                      ?.height,
                                                                  width: m
                                                                      .dimensions
                                                                      ?.width,
                                                                  blurHash: m
                                                                      .blurHash,
                                                                ))
                                                            .toList();

                                                    downloadUrls = (await Future
                                                            .wait(
                                                      selectedMedia.map(
                                                        (m) async =>
                                                            await uploadData(
                                                                m.storagePath,
                                                                m.bytes),
                                                      ),
                                                    ))
                                                        .where((u) => u != null)
                                                        .map((u) => u!)
                                                        .toList();
                                                  } finally {
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .hideCurrentSnackBar();
                                                    _model.isDataUploading =
                                                        false;
                                                  }
                                                  if (selectedUploadedFiles
                                                              .length ==
                                                          selectedMedia
                                                              .length &&
                                                      downloadUrls.length ==
                                                          selectedMedia
                                                              .length) {
                                                    safeSetState(() {
                                                      _model.uploadedLocalFiles =
                                                          selectedUploadedFiles;
                                                      _model.uploadedFileUrls =
                                                          downloadUrls;
                                                    });
                                                    showUploadMessage(
                                                        context, 'Success!');
                                                  } else {
                                                    safeSetState(() {});
                                                    showUploadMessage(context,
                                                        'Failed to upload data');
                                                    return;
                                                  }
                                                }

                                                if (_model.uploadedFileUrls.isNotEmpty) {
                                                  FFAppState()
                                                          .eventnoticeimage =
                                                      functions
                                                          .combineImagePaths(
                                                              FFAppState()
                                                                  .eventnoticeimage
                                                                  .toList(),
                                                              _model
                                                                  .uploadedFileUrls
                                                                  .toList())
                                                          .toList()
                                                          .cast<String>();
                                                  safeSetState(() {});
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        'File uploaded',
                                                        style: TextStyle(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                        ),
                                                      ),
                                                      duration: const Duration(
                                                          milliseconds: 4000),
                                                      backgroundColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .secondary,
                                                    ),
                                                  );
                                                }
                                              },
                                            ),
                                            Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      10.0, 0.0, 0.0, 0.0),
                                              child: FFButtonWidget(
                                                onPressed: () async {
                                                  await showModalBottomSheet<
                                                          bool>(
                                                      context: context,
                                                      builder: (context) {
                                                        final datePickedCupertinoTheme =
                                                            CupertinoTheme.of(
                                                                context);
                                                        return Container(
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height /
                                                              3,
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .secondaryBackground,
                                                          child: CupertinoTheme(
                                                            data:
                                                                datePickedCupertinoTheme
                                                                    .copyWith(
                                                              textTheme:
                                                                  datePickedCupertinoTheme
                                                                      .textTheme
                                                                      .copyWith(
                                                                dateTimePickerTextStyle:
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .headlineMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primaryText,
                                                                          fontSize:
                                                                              20.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                        ),
                                                              ),
                                                            ),
                                                            child:
                                                                CupertinoDatePicker(
                                                              mode:
                                                                  CupertinoDatePickerMode
                                                                      .date,
                                                              minimumDate:
                                                                  getCurrentTimestamp,
                                                              initialDateTime:
                                                                  getCurrentTimestamp,
                                                              maximumDate:
                                                                  DateTime(
                                                                      2050),
                                                              backgroundColor:
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                              use24hFormat:
                                                                  false,
                                                              onDateTimeChanged:
                                                                  (newDateTime) =>
                                                                      safeSetState(
                                                                          () {
                                                                _model.datePicked =
                                                                    newDateTime;
                                                              }),
                                                            ),
                                                          ),
                                                        );
                                                      });
                                                },
                                                text: 'Pick Date',
                                                options: FFButtonOptions(
                                                  width:
                                                      MediaQuery.sizeOf(context)
                                                              .width *
                                                          0.25,
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(16.0, 16.0,
                                                          16.0, 16.0),
                                                  iconPadding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0.0, 0.0,
                                                              0.0, 0.0),
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .primary,
                                                  textStyle: FlutterFlowTheme
                                                          .of(context)
                                                      .titleSmall
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color: Colors.white,
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.0,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                      ),
                                                  elevation: 0.0,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                            ),
                                            if (_model.datePicked != null)
                                              Text(
                                                dateTimeFormat("dd MMM , y",
                                                    _model.datePicked),
                                                style:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          letterSpacing: 0.0,
                                                        ),
                                              ),
                                          ].divide(const SizedBox(width: 10.0)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Align(
                                  alignment: const AlignmentDirectional(-1.0, 0.0),
                                  child: Builder(
                                    builder: (context) {
                                      final uplodedImage = FFAppState()
                                          .eventnoticeimage
                                          .toList();

                                      return SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children:
                                              List.generate(uplodedImage.length,
                                                  (uplodedImageIndex) {
                                            final uplodedImageItem =
                                                uplodedImage[uplodedImageIndex];
                                            return Padding(
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
                                                      0.0, 0.0, 10.0, 0.0),
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
                                                          uplodedImageItem,
                                                          fit: BoxFit.contain,
                                                        ),
                                                        allowRotation: false,
                                                        tag: uplodedImageItem,
                                                        useHeroAnimation: true,
                                                      ),
                                                    ),
                                                  );
                                                },
                                                child: Hero(
                                                  tag: uplodedImageItem,
                                                  transitionOnUserGestures:
                                                      true,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.network(
                                                      uplodedImageItem,
                                                      width: 60.0,
                                                      height: 50.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          }),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    if (valueOrDefault(
                                            currentUserDocument?.userRole, 0) ==
                                        11)
                                      AuthUserStreamWidget(
                                        builder: (context) => FFButtonWidget(
                                          onPressed: () async {},
                                          text: 'Create Notice',
                                          options: FFButtonOptions(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.07,
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    16.0, 0.0, 16.0, 0.0),
                                            iconPadding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 0.0, 0.0, 0.0),
                                            color: FlutterFlowTheme.of(context)
                                                .secondary,
                                            textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                      fontFamily: 'Nunito',
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      letterSpacing: 0.0,
                                                    ),
                                            elevation: 0.0,
                                            borderSide: BorderSide(
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryBackground,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(8.0),
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ].divide(const SizedBox(height: 10.0)),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                      child: StreamBuilder<List<SchoolRecord>>(
                        stream: querySchoolRecord(
                          queryBuilder: (schoolRecord) => schoolRecord.where(
                            'principal_details.principal_id',
                            isEqualTo: currentUserReference,
                          ),
                        ),
                        builder: (context, snapshot) {
                          // Customize what your widget looks like when it's loading.
                          if (!snapshot.hasData) {
                            return SizedBox(
                              height: MediaQuery.sizeOf(context).height * 0.4,
                              child: const ClassshimmerWidget(),
                            );
                          }
                          List<SchoolRecord> containerSchoolRecordList =
                              snapshot.data!;

                          return Container(
                            height: MediaQuery.sizeOf(context).height * 1.0,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment:
                                          const AlignmentDirectional(-1.0, 0.0),
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                            20.0, 10.0, 0.0, 0.0),
                                        child: Text(
                                          'Send to',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Nunito',
                                                fontSize: 20.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 0.0, 10.0, 0.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 5.0, 0.0, 0.0),
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
                                                    if (_model.selectall ==
                                                        false) {
                                                      _model.selectschoolref =
                                                          (currentUserDocument
                                                                      ?.listofSchool
                                                                      .toList() ??
                                                                  [])
                                                              .toList()
                                                              .cast<
                                                                  DocumentReference>();
                                                      _model.selectall = true;
                                                      safeSetState(() {});
                                                    } else {
                                                      _model.selectschoolref =
                                                          [];
                                                      _model.selectall = false;
                                                      safeSetState(() {});
                                                    }
                                                  },
                                                  child: Container(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        0.05,
                                                    height: MediaQuery.sizeOf(
                                                                context)
                                                            .height *
                                                        0.024,
                                                    decoration: BoxDecoration(
                                                      color: FlutterFlowTheme
                                                              .of(context)
                                                          .secondaryBackground,
                                                      border: Border.all(
                                                        color: _model.selectall
                                                            ? FlutterFlowTheme
                                                                    .of(context)
                                                                .secondaryBackground
                                                            : FlutterFlowTheme
                                                                    .of(context)
                                                                .text,
                                                      ),
                                                    ),
                                                    child: Visibility(
                                                      visible: _model.selectall,
                                                      child: Align(
                                                        alignment:
                                                            const AlignmentDirectional(
                                                                0.0, 0.0),
                                                        child: Icon(
                                                          Icons.check_box,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryBackground,
                                                          size: 24.0,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Text(
                                            'Select all',
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Nunito',
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .tertiaryText,
                                                  fontSize: 10.0,
                                                  letterSpacing: 0.0,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                      0.0, 4.0, 0.0, 0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16.0),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          10.0, 0.0, 10.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                1.0,
                                        decoration: BoxDecoration(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                        child: SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width *
                                                  1.0,
                                          child: TextFormField(
                                            controller:
                                                _model.searchTextController,
                                            focusNode: _model.searchFocusNode,
                                            onChanged: (_) =>
                                                EasyDebounce.debounce(
                                              '_model.searchTextController',
                                              const Duration(milliseconds: 2000),
                                              () async {
                                                _model.searchbool = true;
                                                safeSetState(() {});
                                                safeSetState(() {
                                                  _model.simpleSearchResults =
                                                      TextSearch(containerSchoolRecordList
                                                              .map((e) => e
                                                                  .schoolDetails
                                                                  .schoolName)
                                                              .toList()
                                                              .map((str) =>
                                                                  TextSearchItem
                                                                      .fromTerms(str,
                                                                          [str]))
                                                              .toList())
                                                          .search(_model
                                                              .searchTextController
                                                              .text)
                                                          .map((r) => r.object)
                                                          .toList();
                                                });
                                              },
                                            ),
                                            autofocus: false,
                                            obscureText: false,
                                            decoration: InputDecoration(
                                              isDense: false,
                                              labelStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        letterSpacing: 0.0,
                                                      ),
                                              hintText: 'Search School',
                                              hintStyle:
                                                  FlutterFlowTheme.of(context)
                                                      .labelMedium
                                                      .override(
                                                        fontFamily: 'Nunito',
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .alternate,
                                                        letterSpacing: 0.0,
                                                      ),
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              focusedErrorBorder:
                                                  InputBorder.none,
                                              filled: true,
                                              fillColor:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
                                              hoverColor:
                                                  FlutterFlowTheme.of(context)
                                                      .tertiary,
                                              prefixIcon: Icon(
                                                Icons.search_sharp,
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .alternate,
                                              ),
                                              suffixIcon: _model
                                                      .searchTextController!
                                                      .text
                                                      .isNotEmpty
                                                  ? InkWell(
                                                      onTap: () async {
                                                        _model
                                                            .searchTextController
                                                            ?.clear();
                                                        _model.searchbool =
                                                            true;
                                                        safeSetState(() {});
                                                        safeSetState(() {
                                                          _model
                                                              .simpleSearchResults = TextSearch(containerSchoolRecordList
                                                                  .map((e) => e
                                                                      .schoolDetails
                                                                      .schoolName)
                                                                  .toList()
                                                                  .map((str) =>
                                                                      TextSearchItem.fromTerms(
                                                                          str, [
                                                                        str
                                                                      ]))
                                                                  .toList())
                                                              .search(_model
                                                                  .searchTextController
                                                                  .text)
                                                              .map((r) =>
                                                                  r.object)
                                                              .toList();
                                                        });
                                                        safeSetState(() {});
                                                      },
                                                      child: Icon(
                                                        Icons.clear,
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primary,
                                                        size: 20.0,
                                                      ),
                                                    )
                                                  : null,
                                            ),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  fontFamily: 'Nunito',
                                                  letterSpacing: 0.0,
                                                ),
                                            cursorColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            validator: _model
                                                .searchTextControllerValidator
                                                .asValidator(context),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                if (_model.searchbool == false)
                                  Container(
                                    decoration: const BoxDecoration(),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 5.0),
                                      child: AuthUserStreamWidget(
                                        builder: (context) => Builder(
                                          builder: (context) {
                                            final schools = (currentUserDocument
                                                        ?.listofSchool
                                                        .toList() ??
                                                    [])
                                                .toList();
                                            if (schools.isEmpty) {
                                              return const EmptyWidget();
                                            }

                                            return ListView.builder(
                                              padding: EdgeInsets.zero,
                                              primary: false,
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: schools.length,
                                              itemBuilder:
                                                  (context, schoolsIndex) {
                                                final schoolsItem =
                                                    schools[schoolsIndex];
                                                return Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          5.0, 0.0, 5.0, 10.0),
                                                  child: StreamBuilder<
                                                      SchoolRecord>(
                                                    stream: SchoolRecord
                                                        .getDocument(
                                                            schoolsItem),
                                                    builder:
                                                        (context, snapshot) {
                                                      // Customize what your widget looks like when it's loading.
                                                      if (!snapshot.hasData) {
                                                        return SizedBox(
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.4,
                                                          child:
                                                              const ClassshimmerWidget(),
                                                        );
                                                      }

                                                      final containerSchoolRecord =
                                                          snapshot.data!;

                                                      return InkWell(
                                                        splashColor:
                                                            Colors.transparent,
                                                        focusColor:
                                                            Colors.transparent,
                                                        hoverColor:
                                                            Colors.transparent,
                                                        highlightColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          if (!_model
                                                              .selectschoolref
                                                              .contains(
                                                                  schoolsItem)) {
                                                            _model
                                                                .addToSelectschoolref(
                                                                    schoolsItem);
                                                            _model.addToSchoolnames(
                                                                containerSchoolRecord
                                                                    .schoolDetails
                                                                    .schoolName);
                                                            safeSetState(() {});
                                                            if (_model
                                                                    .selectschoolref
                                                                    .length ==
                                                                (currentUserDocument
                                                                            ?.listofSchool
                                                                            .toList() ??
                                                                        [])
                                                                    .length) {
                                                              _model.selectall =
                                                                  true;
                                                              safeSetState(
                                                                  () {});
                                                            } else {
                                                              _model.selectall =
                                                                  false;
                                                              safeSetState(
                                                                  () {});
                                                            }
                                                          } else {
                                                            _model
                                                                .removeFromSelectschoolref(
                                                                    schoolsItem);
                                                            _model.schoolnames = functions
                                                                .removeaname(
                                                                    _model
                                                                        .schoolnames
                                                                        .toList(),
                                                                    containerSchoolRecord
                                                                        .schoolDetails
                                                                        .schoolName)
                                                                .toList()
                                                                .cast<String>();
                                                            safeSetState(() {});
                                                            if (_model
                                                                    .selectschoolref
                                                                    .length !=
                                                                (currentUserDocument
                                                                            ?.listofSchool
                                                                            .toList() ??
                                                                        [])
                                                                    .length) {
                                                              _model.selectall =
                                                                  false;
                                                              safeSetState(
                                                                  () {});
                                                            } else {
                                                              _model.selectall =
                                                                  true;
                                                              safeSetState(
                                                                  () {});
                                                            }
                                                          }
                                                        },
                                                        child: Material(
                                                          color: Colors
                                                              .transparent,
                                                          elevation: 5.0,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16.0),
                                                          ),
                                                          child: Container(
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.15,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondary,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          16.0),
                                                              border:
                                                                  Border.all(
                                                                color: _model
                                                                        .selectschoolref
                                                                        .contains(
                                                                            schoolsItem)
                                                                    ? FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground
                                                                    : FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceAround,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: 60.0,
                                                                  height: 60.0,
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                  ),
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0),
                                                                    child: Image
                                                                        .network(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        containerSchoolRecord
                                                                            .schoolDetails
                                                                            .schoolImage,
                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                                                      ),
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          5.0,
                                                                          0.0,
                                                                          5.0),
                                                                  child: Column(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .center,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              5.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.54,
                                                                            decoration:
                                                                                const BoxDecoration(),
                                                                            child:
                                                                                Align(
                                                                              alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                              child: Text(
                                                                                containerSchoolRecord.schoolDetails.schoolName,
                                                                                textAlign: TextAlign.start,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Nunito',
                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              0.0,
                                                                              5.0),
                                                                          child:
                                                                              Container(
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.54,
                                                                            decoration:
                                                                                const BoxDecoration(),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          containerSchoolRecord
                                                                              .principalDetails
                                                                              .phoneNumber,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Nunito',
                                                                                color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.normal,
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
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                if (_model.searchbool == true)
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        5.0, 0.0, 5.0, 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(0.0),
                                      ),
                                      child: Builder(
                                        builder: (context) {
                                          final schools = functions
                                                  .filterSchoolsBySearchResults(
                                                      _model.simpleSearchResults
                                                          .toList(),
                                                      containerSchoolRecordList
                                                          .toList())
                                                  ?.toList() ??
                                              [];
                                          if (schools.isEmpty) {
                                            return const EmptyWidget();
                                          }

                                          return ListView.builder(
                                            padding: EdgeInsets.zero,
                                            primary: false,
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            itemCount: schools.length,
                                            itemBuilder:
                                                (context, schoolsIndex) {
                                              final schoolsItem =
                                                  schools[schoolsIndex];
                                              return Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 16.0, 0.0, 0.0),
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
                                                    if (!_model.selectschoolref
                                                        .contains(schoolsItem
                                                            .reference)) {
                                                      _model
                                                          .addToSelectschoolref(
                                                              schoolsItem
                                                                  .reference);
                                                      _model.addToSchoolnames(
                                                          schoolsItem
                                                              .schoolDetails
                                                              .schoolName);
                                                      safeSetState(() {});
                                                    } else {
                                                      _model
                                                          .removeFromSelectschoolref(
                                                              schoolsItem
                                                                  .reference);
                                                      _model.schoolnames = functions
                                                          .removeaname(
                                                              _model.schoolnames
                                                                  .toList(),
                                                              schoolsItem
                                                                  .schoolDetails
                                                                  .schoolName)
                                                          .toList()
                                                          .cast<String>();
                                                      safeSetState(() {});
                                                    }

                                                    if (_model.selectschoolref
                                                            .length ==
                                                        (currentUserDocument
                                                                    ?.listofSchool
                                                                    .toList() ??
                                                                [])
                                                            .length) {
                                                      _model.selectall = true;
                                                      safeSetState(() {});
                                                    } else {
                                                      _model.selectall = false;
                                                      safeSetState(() {});
                                                    }
                                                  },
                                                  child: Material(
                                                    color: Colors.transparent,
                                                    elevation: 5.0,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16.0),
                                                    ),
                                                    child: Container(
                                                      height: MediaQuery.sizeOf(
                                                                  context)
                                                              .height *
                                                          0.18,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .secondary,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(16.0),
                                                        border: Border.all(
                                                          color: _model
                                                                  .selectschoolref
                                                                  .contains(
                                                                      schoolsItem
                                                                          .reference)
                                                              ? FlutterFlowTheme
                                                                      .of(
                                                                          context)
                                                                  .primaryBackground
                                                              : FlutterFlowTheme
                                                                      .of(context)
                                                                  .secondaryBackground,
                                                        ),
                                                      ),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          15.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Container(
                                                                width: 60.0,
                                                                height: 60.0,
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Image
                                                                    .network(
                                                                  schoolsItem
                                                                      .schoolDetails
                                                                      .schoolImage,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        5.0,
                                                                        0.0,
                                                                        5.0),
                                                            child: Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.54,
                                                                      decoration:
                                                                          const BoxDecoration(),
                                                                      child:
                                                                          Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            -1.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          schoolsItem
                                                                              .schoolDetails
                                                                              .schoolName,
                                                                          textAlign:
                                                                              TextAlign.start,
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                fontFamily: 'Nunito',
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                fontSize: 16.0,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                    child:
                                                                        Container(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.54,
                                                                      decoration:
                                                                          const BoxDecoration(),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Align(
                                                                  alignment:
                                                                      const AlignmentDirectional(
                                                                          -1.0,
                                                                          0.0),
                                                                  child: Text(
                                                                    schoolsItem
                                                                        .principalDetails
                                                                        .phoneNumber,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          fontFamily:
                                                                              'Nunito',
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiaryText,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
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
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(0.0, 1.0),
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
                        color: FlutterFlowTheme.of(context).tertiary,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            context.goNamed(
                              'Dashboard',
                              extra: <String, dynamic>{
                                kTransitionInfoKey: const TransitionInfo(
                                  hasTransition: true,
                                  transitionType: PageTransitionType.fade,
                                ),
                              },
                            );
                          },
                          text: 'Cancel',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.28,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 16.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color: FlutterFlowTheme.of(context).secondary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Nunito',
                                  color:
                                      FlutterFlowTheme.of(context).tertiaryText,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).alternate,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            if (_model.formKey.currentState == null ||
                                !_model.formKey.currentState!.validate()) {
                              return;
                            }
                            if (_model.selectschoolref.isNotEmpty) {
                              if (_model.noticename != null &&
                                  _model.noticename != '') {
                                if (_model.datePicked != null) {
                                  while (FFAppState().loopmin <
                                      _model.selectschoolref.length) {
                                    await _model.selectschoolref
                                        .elementAtOrNull(FFAppState().loopmin)!
                                        .update({
                                      ...mapToFirestore(
                                        {
                                          'List_of_notice':
                                              FieldValue.arrayUnion([
                                            getEventsNoticeFirestoreData(
                                              updateEventsNoticeStruct(
                                                EventsNoticeStruct(
                                                  eventId: functions
                                                      .generateUniqueId(),
                                                  eventName: _model.noticename,
                                                  eventTitle: _model
                                                      .eventnameTextController
                                                      .text,
                                                  eventDescription: _model
                                                      .descriptionTextController
                                                      .text,
                                                  eventImages:
                                                      _model.uploadedFileUrls,
                                                  eventDate: _model.datePicked,
                                                ),
                                                clearUnsetFields: false,
                                              ),
                                              true,
                                            )
                                          ]),
                                        },
                                      ),
                                    });
                                    FFAppState().loopmin =
                                        FFAppState().loopmin + 1;
                                    safeSetState(() {});
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Notice  Successfully Added!',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                      ),
                                      duration: const Duration(milliseconds: 2600),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                    ),
                                  );
                                  FFAppState().loopmin = 0;
                                  safeSetState(() {});
                                  while (FFAppState().loopmin <
                                      FFAppState().selectedschoolref.length) {
                                    _model.school =
                                        await SchoolRecord.getDocumentOnce(
                                            _model
                                                .selectschoolref.firstOrNull!);
                                    triggerPushNotification(
                                      notificationTitle: 'Event added',
                                      notificationText:
                                          _model.eventnameTextController.text,
                                      userRefs: _model
                                          .school!.listOfteachersuser
                                          .toList(),
                                      initialPageName: 'Notification_Teacher',
                                      parameterData: {
                                        'schoolref': _model.school?.reference,
                                      },
                                    );

                                    await NotificationsRecord.collection
                                        .doc()
                                        .set({
                                      ...createNotificationsRecordData(
                                        content: 'Notice',
                                        descri: _model
                                            .descriptionTextController.text,
                                        datetimeofevent: _model.datePicked,
                                        isread: false,
                                        notification: updateNotificationStruct(
                                          NotificationStruct(
                                            notificationTitle: _model
                                                .eventnameTextController.text,
                                            descriptions: _model
                                                .descriptionTextController.text,
                                            timeStamp: getCurrentTimestamp,
                                            isRead: false,
                                            eventDate: _model.datePicked,
                                            notificationImages:
                                                _model.uploadedFileUrls,
                                          ),
                                          clearUnsetFields: false,
                                          create: true,
                                        ),
                                        addedby: currentUserReference,
                                        heading: 'Added a notice',
                                        createDate: getCurrentTimestamp,
                                        tag: _model.noticename,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'userref':
                                              _model.school?.listOfteachersuser,
                                          'towhome': _model.schoolnames,
                                        },
                                      ),
                                    });
                                    _model.students =
                                        await queryStudentsRecordOnce();
                                    triggerPushNotification(
                                      notificationTitle: 'Event added',
                                      notificationText:
                                          _model.eventnameTextController.text,
                                      userRefs: functions
                                          .extractParentUserRefs(_model
                                              .students!
                                              .where((e) => _model
                                                  .school!.listOfStudents
                                                  .contains(e.reference))
                                              .toList())
                                          .toList(),
                                      initialPageName: 'Dashboard',
                                      parameterData: {},
                                    );

                                    await NotificationsRecord.collection
                                        .doc()
                                        .set({
                                      ...createNotificationsRecordData(
                                        content: 'Notice',
                                        descri: _model
                                            .descriptionTextController.text,
                                        datetimeofevent: _model.datePicked,
                                        isread: false,
                                        notification: updateNotificationStruct(
                                          NotificationStruct(
                                            notificationTitle: _model
                                                .eventnameTextController.text,
                                            descriptions: _model
                                                .descriptionTextController.text,
                                            timeStamp: getCurrentTimestamp,
                                            isRead: false,
                                            eventDate: _model.datePicked,
                                            notificationImages:
                                                _model.uploadedFileUrls,
                                          ),
                                          clearUnsetFields: false,
                                          create: true,
                                        ),
                                        createDate: getCurrentTimestamp,
                                        addedby: currentUserReference,
                                        heading: 'Added a notice',
                                        tag: _model.noticename,
                                      ),
                                      ...mapToFirestore(
                                        {
                                          'userref': functions
                                              .extractParentUserRefs(_model
                                                  .students!
                                                  .where((e) => _model
                                                      .school!.listOfStudents
                                                      .contains(e.reference))
                                                  .toList()),
                                          'towhome': _model.schoolnames,
                                        },
                                      ),
                                    });
                                    FFAppState().loopmin =
                                        FFAppState().loopmin + 1;
                                    safeSetState(() {});
                                  }

                                  await NotificationsRecord.collection
                                      .doc()
                                      .set({
                                    ...createNotificationsRecordData(
                                      content: 'Notice',
                                      descri:
                                          _model.descriptionTextController.text,
                                      datetimeofevent: _model.datePicked,
                                      isread: false,
                                      notification: updateNotificationStruct(
                                        NotificationStruct(
                                          notificationTitle: _model
                                              .eventnameTextController.text,
                                          descriptions: _model
                                              .descriptionTextController.text,
                                          timeStamp: getCurrentTimestamp,
                                          isRead: false,
                                          eventDate: _model.datePicked,
                                          notificationImages:
                                              _model.uploadedFileUrls,
                                        ),
                                        clearUnsetFields: false,
                                        create: true,
                                      ),
                                      createDate: getCurrentTimestamp,
                                      addedby: currentUserReference,
                                      heading: 'Added a notice',
                                      tag: _model.noticename,
                                    ),
                                    ...mapToFirestore(
                                      {
                                        'schoolref':
                                            FFAppState().selectedschoolref,
                                        'towhome': _model.schoolnames,
                                      },
                                    ),
                                  });
                                  FFAppState().loopmin = 0;
                                  FFAppState().eventnoticeimage = [];
                                  safeSetState(() {});
                                  _model.noticename = null;
                                  safeSetState(() {});

                                  context.goNamed(
                                    'Dashboard',
                                    extra: <String, dynamic>{
                                      kTransitionInfoKey: const TransitionInfo(
                                        hasTransition: true,
                                        transitionType: PageTransitionType.fade,
                                      ),
                                    },
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Please  pick the date',
                                        style: TextStyle(
                                          color: FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                        ),
                                      ),
                                      duration: const Duration(milliseconds: 4000),
                                      backgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                    ),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please pick the notice name',
                                      style: TextStyle(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                      ),
                                    ),
                                    duration: const Duration(milliseconds: 4000),
                                    backgroundColor:
                                        FlutterFlowTheme.of(context)
                                            .primaryText,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'please select atleast one school ',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .secondaryBackground,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 4000),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              );
                            }

                            safeSetState(() {});
                          },
                          text: 'Send',
                          options: FFButtonOptions(
                            width: MediaQuery.sizeOf(context).width * 0.28,
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                16.0, 16.0, 16.0, 16.0),
                            iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Nunito',
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  fontSize: 14.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FontWeight.normal,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).dIsable,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
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
    );
  }
}
