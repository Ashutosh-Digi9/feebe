import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'edit_notice_model.dart';
export 'edit_notice_model.dart';

class EditNoticeWidget extends StatefulWidget {
  const EditNoticeWidget({
    super.key,
    required this.school,
    required this.eventid,
  });

  final DocumentReference? school;
  final int? eventid;

  @override
  State<EditNoticeWidget> createState() => _EditNoticeWidgetState();
}

class _EditNoticeWidgetState extends State<EditNoticeWidget> {
  late EditNoticeModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditNoticeModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.school = await SchoolRecord.getDocumentOnce(widget.school!);
      _model.eventName = _model.school!.listOfNotice
          .where((e) => e.eventId == widget.eventid)
          .toList()
          .firstOrNull!
          .eventName;
      safeSetState(() {});
    });

    _model.eventnameFocusNode ??= FocusNode();

    _model.descriptionFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: StreamBuilder<SchoolRecord>(
        stream: SchoolRecord.getDocument(widget.school!),
        builder: (context, snapshot) {
          // Customize what your widget looks like when it's loading.
          if (!snapshot.hasData) {
            return Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            );
          }

          final containerSchoolRecord = snapshot.data!;

          return Material(
            color: Colors.transparent,
            elevation: 2.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
              width: MediaQuery.sizeOf(context).width * 1.0,
              height: MediaQuery.sizeOf(context).height * 1.0,
              decoration: BoxDecoration(
                color: FlutterFlowTheme.of(context).secondaryBackground,
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Form(
                key: _model.formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: Padding(
                  padding:
                      const EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            10.0, 0.0, 10.0, 0.0),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                splashColor: Colors.transparent,
                                focusColor: Colors.transparent,
                                hoverColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () async {
                                  _model.eventName = 'Notice';
                                  safeSetState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: valueOrDefault<Color>(
                                        _model.eventName == 'Notice'
                                            ? const Color(0xFFC29800)
                                            : FlutterFlowTheme.of(context).text,
                                        FlutterFlowTheme.of(context).text,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.push_pin,
                                          color: FlutterFlowTheme.of(context)
                                              .warning,
                                          size: 20.0,
                                        ),
                                        Text(
                                          'Notice',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Nunito',
                                                color: valueOrDefault<Color>(
                                                  _model.eventName == 'Notice'
                                                      ? const Color(0xFFC29800)
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .text,
                                                  FlutterFlowTheme.of(context)
                                                      .text,
                                                ),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ]
                                          .divide(const SizedBox(width: 10.0))
                                          .around(const SizedBox(width: 10.0)),
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
                                  _model.eventName = 'Holiday';
                                  safeSetState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: valueOrDefault<Color>(
                                        _model.eventName == 'Holiday'
                                            ? const Color(0xFFC29800)
                                            : FlutterFlowTheme.of(context).text,
                                        FlutterFlowTheme.of(context).text,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.celebration_sharp,
                                          color: FlutterFlowTheme.of(context)
                                              .warning,
                                          size: 20.0,
                                        ),
                                        Text(
                                          'Holiday',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Nunito',
                                                color: valueOrDefault<Color>(
                                                  _model.eventName == 'Holiday'
                                                      ? const Color(0xFFC29800)
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .text,
                                                  FlutterFlowTheme.of(context)
                                                      .text,
                                                ),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ]
                                          .divide(const SizedBox(width: 10.0))
                                          .around(const SizedBox(width: 10.0)),
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
                                  _model.eventName = 'Home work ';
                                  safeSetState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: valueOrDefault<Color>(
                                        _model.eventName == 'Home work'
                                            ? const Color(0xFFC29800)
                                            : FlutterFlowTheme.of(context).text,
                                        FlutterFlowTheme.of(context).text,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.home_work_outlined,
                                          color: FlutterFlowTheme.of(context)
                                              .warning,
                                          size: 20.0,
                                        ),
                                        Text(
                                          'Home work',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Nunito',
                                                color: valueOrDefault<Color>(
                                                  _model.eventName ==
                                                          'Home work'
                                                      ? const Color(0xFFC29800)
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .text,
                                                  FlutterFlowTheme.of(context)
                                                      .text,
                                                ),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ]
                                          .divide(const SizedBox(width: 10.0))
                                          .around(const SizedBox(width: 10.0)),
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
                                  _model.eventName = 'Assignment';
                                  safeSetState(() {});
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    borderRadius: BorderRadius.circular(10.0),
                                    border: Border.all(
                                      color: valueOrDefault<Color>(
                                        _model.eventName == 'Assignment'
                                            ? const Color(0xFFC29800)
                                            : FlutterFlowTheme.of(context).text,
                                        FlutterFlowTheme.of(context).text,
                                      ),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 10.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Icon(
                                          Icons.assignment,
                                          color: FlutterFlowTheme.of(context)
                                              .warning,
                                          size: 20.0,
                                        ),
                                        Text(
                                          'Assignment',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Nunito',
                                                color: valueOrDefault<Color>(
                                                  _model.eventName ==
                                                          'Assignment'
                                                      ? const Color(0xFFC29800)
                                                      : FlutterFlowTheme.of(
                                                              context)
                                                          .text,
                                                  FlutterFlowTheme.of(context)
                                                      .text,
                                                ),
                                                fontSize: 12.0,
                                                letterSpacing: 0.0,
                                              ),
                                        ),
                                      ]
                                          .divide(const SizedBox(width: 10.0))
                                          .around(const SizedBox(width: 10.0)),
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
                            0.0, 10.0, 0.0, 10.0),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: TextFormField(
                            controller: _model.eventnameTextController ??=
                                TextEditingController(
                              text: containerSchoolRecord.listOfNotice
                                  .where((e) => widget.eventid == e.eventId)
                                  .toList()
                                  .firstOrNull
                                  ?.eventTitle,
                            ),
                            focusNode: _model.eventnameFocusNode,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'Title',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: valueOrDefault<Color>(
                                      (_model.eventnameFocusNode?.hasFocus ??
                                              false)
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context).text,
                                      FlutterFlowTheme.of(context).text,
                                    ),
                                    letterSpacing: 0.0,
                                  ),
                              hintText: 'Event name',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryText,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
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
                                  color: FlutterFlowTheme.of(context).primary,
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
                              fillColor: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                            ),
                            style: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .override(
                                  fontFamily: 'Nunito',
                                  letterSpacing: 0.0,
                                ),
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryText,
                            validator: _model.eventnameTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(
                            0.0, 10.0, 0.0, 10.0),
                        child: SizedBox(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          child: TextFormField(
                            controller: _model.descriptionTextController ??=
                                TextEditingController(
                              text: containerSchoolRecord.listOfNotice
                                  .where((e) => widget.eventid == e.eventId)
                                  .toList()
                                  .firstOrNull
                                  ?.eventDescription,
                            ),
                            focusNode: _model.descriptionFocusNode,
                            autofocus: false,
                            textCapitalization: TextCapitalization.sentences,
                            obscureText: false,
                            decoration: InputDecoration(
                              isDense: true,
                              labelText: 'Description',
                              labelStyle: FlutterFlowTheme.of(context)
                                  .labelMedium
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: valueOrDefault<Color>(
                                      (_model.descriptionFocusNode?.hasFocus ??
                                              false)
                                          ? FlutterFlowTheme.of(context).primary
                                          : FlutterFlowTheme.of(context).text,
                                      FlutterFlowTheme.of(context).text,
                                    ),
                                    letterSpacing: 0.0,
                                  ),
                              hintText: 'Description',
                              hintStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .tertiaryText,
                                    fontSize: 12.0,
                                    letterSpacing: 0.0,
                                    fontWeight: FontWeight.w500,
                                  ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).alternate,
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 0.2,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context).error,
                                  width: 0.2,
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
                                  letterSpacing: 0.0,
                                ),
                            maxLines: 4,
                            cursorColor:
                                FlutterFlowTheme.of(context).primaryText,
                            validator: _model.descriptionTextControllerValidator
                                .asValidator(context),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FFButtonWidget(
                              onPressed: () async {
                                final datePickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: (containerSchoolRecord
                                          .listOfNotice
                                          .where((e) =>
                                              e.eventId == widget.eventid)
                                          .toList()
                                          .firstOrNull
                                          ?.eventDate ??
                                      DateTime.now()),
                                  firstDate: (containerSchoolRecord.listOfNotice
                                          .where((e) =>
                                              e.eventId == widget.eventid)
                                          .toList()
                                          .firstOrNull
                                          ?.eventDate ??
                                      DateTime.now()),
                                  lastDate: DateTime(2050),
                                  builder: (context, child) {
                                    return wrapInMaterialDatePickerTheme(
                                      context,
                                      child!,
                                      headerBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      headerForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      headerTextStyle:
                                          FlutterFlowTheme.of(context)
                                              .headlineLarge
                                              .override(
                                                fontFamily: 'Nunito',
                                                fontSize: 32.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w600,
                                              ),
                                      pickerBackgroundColor:
                                          FlutterFlowTheme.of(context)
                                              .secondaryBackground,
                                      pickerForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      selectedDateTimeBackgroundColor:
                                          FlutterFlowTheme.of(context).primary,
                                      selectedDateTimeForegroundColor:
                                          FlutterFlowTheme.of(context).info,
                                      actionButtonForegroundColor:
                                          FlutterFlowTheme.of(context)
                                              .primaryText,
                                      iconSize: 24.0,
                                    );
                                  },
                                );

                                if (datePickedDate != null) {
                                  safeSetState(() {
                                    _model.datePicked = DateTime(
                                      datePickedDate.year,
                                      datePickedDate.month,
                                      datePickedDate.day,
                                    );
                                  });
                                }
                              },
                              text: 'Change Date',
                              options: FFButtonOptions(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.05,
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 16.0, 0.0),
                                iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 0.0),
                                color: FlutterFlowTheme.of(context).secondary,
                                textStyle: FlutterFlowTheme.of(context)
                                    .titleSmall
                                    .override(
                                      fontFamily: 'Nunito',
                                      color: FlutterFlowTheme.of(context)
                                          .primaryText,
                                      letterSpacing: 0.0,
                                    ),
                                elevation: 0.0,
                                borderSide: BorderSide(
                                  color: FlutterFlowTheme.of(context)
                                      .primaryBackground,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            Text(
                              _model.datePicked != null
                                  ? dateTimeFormat("yMMMd", _model.datePicked)
                                  : dateTimeFormat(
                                      "yMMMd",
                                      containerSchoolRecord.listOfNotice
                                          .where((e) =>
                                              e.eventId == widget.eventid)
                                          .toList()
                                          .firstOrNull!
                                          .eventDate!),
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    fontFamily: 'Inter',
                                    letterSpacing: 0.0,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      if (containerSchoolRecord.listOfNotice
                              .where((e) => widget.eventid == e.eventId)
                              .toList()
                              .firstOrNull
                              ?.eventImages.isNotEmpty)
                        Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 10.0),
                          child: Builder(
                            builder: (context) {
                              final images = containerSchoolRecord.listOfNotice
                                      .where(
                                          (e) => widget.eventid == e.eventId)
                                      .toList()
                                      .firstOrNull
                                      ?.eventImages
                                      .toList() ??
                                  [];

                              return Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children:
                                    List.generate(images.length, (imagesIndex) {
                                  final imagesItem = images[imagesIndex];
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      imagesItem,
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                              0.1,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                }),
                              );
                            },
                          ),
                        ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(0.0, 5.0, 0.0, 10.0),
                        child: Builder(
                          builder: (context) {
                            final images = _model.uploadedFileUrls.toList();

                            return Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children:
                                  List.generate(images.length, (imagesIndex) {
                                final imagesItem = images[imagesIndex];
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    imagesItem,
                                    height:
                                        MediaQuery.sizeOf(context).height * 0.1,
                                    fit: BoxFit.cover,
                                  ),
                                );
                              }),
                            );
                          },
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          FlutterFlowIconButton(
                            borderColor: FlutterFlowTheme.of(context).alternate,
                            borderRadius: 8.0,
                            borderWidth: 0.2,
                            buttonSize: 40.0,
                            icon: Icon(
                              Icons.attach_file,
                              color: FlutterFlowTheme.of(context).tertiaryText,
                              size: 24.0,
                            ),
                            showLoadingIndicator: true,
                            onPressed: () async {
                              final selectedMedia = await selectMedia(
                                mediaSource: MediaSource.photoGallery,
                                multiImage: true,
                              );
                              if (selectedMedia != null &&
                                  selectedMedia.every((m) => validateFileFormat(
                                      m.storagePath, context))) {
                                safeSetState(
                                    () => _model.isDataUploading = true);
                                var selectedUploadedFiles = <FFUploadedFile>[];

                                var downloadUrls = <String>[];
                                try {
                                  showUploadMessage(
                                    context,
                                    'Uploading file...',
                                    showLoading: true,
                                  );
                                  selectedUploadedFiles = selectedMedia
                                      .map((m) => FFUploadedFile(
                                            name: m.storagePath.split('/').last,
                                            bytes: m.bytes,
                                            height: m.dimensions?.height,
                                            width: m.dimensions?.width,
                                            blurHash: m.blurHash,
                                          ))
                                      .toList();

                                  downloadUrls = (await Future.wait(
                                    selectedMedia.map(
                                      (m) async => await uploadData(
                                          m.storagePath, m.bytes),
                                    ),
                                  ))
                                      .where((u) => u != null)
                                      .map((u) => u!)
                                      .toList();
                                } finally {
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();
                                  _model.isDataUploading = false;
                                }
                                if (selectedUploadedFiles.length ==
                                        selectedMedia.length &&
                                    downloadUrls.length ==
                                        selectedMedia.length) {
                                  safeSetState(() {
                                    _model.uploadedLocalFiles =
                                        selectedUploadedFiles;
                                    _model.uploadedFileUrls = downloadUrls;
                                  });
                                  showUploadMessage(context, 'Success!');
                                } else {
                                  safeSetState(() {});
                                  showUploadMessage(
                                      context, 'Failed to upload data');
                                  return;
                                }
                              }
                            },
                          ),
                          FFButtonWidget(
                            onPressed: () async {
                              if (_model.formKey.currentState == null ||
                                  !_model.formKey.currentState!.validate()) {
                                return;
                              }

                              await widget.school!.update({
                                ...mapToFirestore(
                                  {
                                    'List_of_notice':
                                        getEventsNoticeListFirestoreData(
                                      functions.updateEvent(
                                          containerSchoolRecord.listOfNotice
                                              .toList(),
                                          widget.eventid!,
                                          _model.eventnameTextController.text,
                                          _model.descriptionTextController.text,
                                          (_model.uploadedFileUrls.isEmpty
                                                  ? containerSchoolRecord
                                                      .listOfNotice
                                                      .where((e) =>
                                                          e.eventId ==
                                                          widget.eventid)
                                                      .toList()
                                                      .firstOrNull
                                                      ?.eventImages
                                                  : functions.combineImagePaths(
                                                      containerSchoolRecord
                                                          .listOfNotice
                                                          .where((e) =>
                                                              e.eventId ==
                                                              widget.eventid)
                                                          .toList()
                                                          .firstOrNull!
                                                          .eventImages
                                                          .toList(),
                                                      _model.uploadedFileUrls
                                                          .toList()))
                                              ?.toList(),
                                          _model.datePicked != null
                                              ? _model.datePicked!
                                              : containerSchoolRecord
                                                  .listOfNotice
                                                  .where((e) =>
                                                      e.eventId ==
                                                      widget.eventid)
                                                  .toList()
                                                  .firstOrNull!
                                                  .eventDate!,
                                          _model.eventName),
                                    ),
                                  },
                                ),
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Event Updated',
                                    style: TextStyle(
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                    ),
                                  ),
                                  duration: const Duration(milliseconds: 2100),
                                  backgroundColor:
                                      FlutterFlowTheme.of(context).primaryText,
                                ),
                              );
                              Navigator.pop(context);
                            },
                            text: 'Update notice',
                            options: FFButtonOptions(
                              height: MediaQuery.sizeOf(context).height * 0.05,
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  16.0, 0.0, 16.0, 0.0),
                              iconPadding: const EdgeInsetsDirectional.fromSTEB(
                                  0.0, 0.0, 0.0, 0.0),
                              color: FlutterFlowTheme.of(context).secondary,
                              textStyle: FlutterFlowTheme.of(context)
                                  .titleSmall
                                  .override(
                                    fontFamily: 'Nunito',
                                    color: FlutterFlowTheme.of(context)
                                        .primaryText,
                                    letterSpacing: 0.0,
                                  ),
                              elevation: 0.0,
                              borderSide: BorderSide(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ],
                      ),
                    ].addToEnd(const SizedBox(height: 10.0)),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
