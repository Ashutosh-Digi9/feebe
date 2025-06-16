import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notice_details_model.dart';
export 'notice_details_model.dart';

class NoticeDetailsWidget extends StatefulWidget {
  const NoticeDetailsWidget({
    super.key,
    this.eventDetails,
    this.classRef,
  });

  final EventsNoticeStruct? eventDetails;
  final String? classRef;

  static String routeName = 'Notice_details';
  static String routePath = '/noticeDetails';

  @override
  State<NoticeDetailsWidget> createState() => _NoticeDetailsWidgetState();
}

class _NoticeDetailsWidgetState extends State<NoticeDetailsWidget> {
  late NoticeDetailsModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoticeDetailsModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 30.0,
                  borderWidth: 1.0,
                  buttonSize: 60.0,
                  icon: Icon(
                    Icons.chevron_left_rounded,
                    color: FlutterFlowTheme.of(context).alternate,
                    size: 26.0,
                  ),
                  onPressed: () async {
                    context.pop();
                  },
                ),
                title: Text(
                  widget.classRef != null && widget.classRef != ''
                      ? '${widget.classRef} - Notice'
                      : 'School Notice',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.nunito(
                          fontWeight: FontWeight.bold,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
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
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                10.0, 10.0, 10.0, 20.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment:
                                          AlignmentDirectional(-1.0, 0.0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.5,
                                        decoration: BoxDecoration(),
                                        child: Text(
                                          valueOrDefault<String>(
                                            widget.eventDetails?.eventTitle,
                                            'Title',
                                          ),
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.nunito(
                                                  fontWeight: FontWeight.bold,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .text1,
                                                fontSize: 24.0,
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
                                    Container(
                                      decoration: BoxDecoration(
                                        color: valueOrDefault<Color>(
                                          () {
                                            if (widget
                                                    .eventDetails?.eventName ==
                                                'Homework') {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .homework;
                                            } else if (widget
                                                    .eventDetails?.eventName ==
                                                'Reminder') {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .reminderfill;
                                            } else {
                                              return FlutterFlowTheme.of(
                                                      context)
                                                  .event;
                                            }
                                          }(),
                                          FlutterFlowTheme.of(context).text,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(3.59),
                                        border: Border.all(
                                          color: valueOrDefault<Color>(
                                            () {
                                              if (widget.eventDetails
                                                      ?.eventName ==
                                                  'Homework') {
                                                return FlutterFlowTheme.of(
                                                        context)
                                                    .homeworkborder;
                                              } else if (widget.eventDetails
                                                      ?.eventName ==
                                                  'Reminder') {
                                                return FlutterFlowTheme.of(
                                                        context)
                                                    .reminderborder;
                                              } else {
                                                return FlutterFlowTheme.of(
                                                        context)
                                                    .generalBorder;
                                              }
                                            }(),
                                            FlutterFlowTheme.of(context).text,
                                          ),
                                          width: 1.0,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(5.0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            if (widget
                                                    .eventDetails?.eventName ==
                                                'General')
                                              Image.asset(
                                                'assets/images/9e73b2e5203026ba49a296de36e434f3.png',
                                                width: 15.5,
                                                height: 15.5,
                                                fit: BoxFit.cover,
                                              ),
                                            if (widget
                                                    .eventDetails?.eventName ==
                                                'Reminder')
                                              Image.asset(
                                                'assets/images/3d-alarm.png',
                                                width: 15.5,
                                                height: 15.5,
                                                fit: BoxFit.contain,
                                              ),
                                            if (widget
                                                    .eventDetails?.eventName ==
                                                'Homework')
                                              Image.asset(
                                                'assets/images/d291c399c6895698b0bb48476409d42e.png',
                                                width: 15.5,
                                                height: 15.5,
                                                fit: BoxFit.cover,
                                              ),
                                            Text(
                                              valueOrDefault<String>(
                                                widget.eventDetails?.eventName,
                                                'Reminder',
                                              ),
                                              style: FlutterFlowTheme.of(
                                                      context)
                                                  .bodyMedium
                                                  .override(
                                                    font: GoogleFonts.nunito(
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .bodyMedium
                                                              .fontStyle,
                                                    ),
                                                    color: FlutterFlowTheme.of(
                                                            context)
                                                        .primaryText,
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.0,
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                            ),
                                          ]
                                              .divide(SizedBox(width: 5.0))
                                              .around(SizedBox(width: 5.0)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Text(
                                    'Date : ${dateTimeFormat("dd MMM y", widget.eventDetails?.eventDate)}',
                                    textAlign: TextAlign.center,
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
                                Align(
                                  alignment: AlignmentDirectional(-1.0, 0.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: FlutterFlowTheme.of(context)
                                          .secondary,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (widget.eventDetails
                                                    ?.eventDescription !=
                                                null &&
                                            widget.eventDetails
                                                    ?.eventDescription !=
                                                '')
                                          Align(
                                            alignment: AlignmentDirectional(
                                                -1.0, -1.0),
                                            child: Padding(
                                              padding: EdgeInsets.all(10.0),
                                              child: Container(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.85,
                                                decoration: BoxDecoration(),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          10.0, 0.0, 0.0, 0.0),
                                                  child: Text(
                                                    valueOrDefault<String>(
                                                      widget.eventDetails
                                                          ?.eventDescription,
                                                      'Des',
                                                    ),
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          font: GoogleFonts
                                                              .nunito(
                                                            fontWeight:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontWeight,
                                                            fontStyle:
                                                                FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                          ),
                                                          fontSize: 16.0,
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FlutterFlowTheme.of(
                                                                      context)
                                                                  .bodyMedium
                                                                  .fontWeight,
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
                                        if (widget.eventDetails?.eventfiles
                                                .length !=
                                            0)
                                          Align(
                                            alignment:
                                                AlignmentDirectional(-1.0, 0.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color:
                                                    FlutterFlowTheme.of(context)
                                                        .secondary,
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  if (widget.eventDetails
                                                          ?.eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              1)
                                                          .toList()
                                                          .length ==
                                                      1)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    12.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await launchURL(widget
                                                                .eventDetails!
                                                                .eventfiles
                                                                .where((e) =>
                                                                    functions
                                                                        .getFileTypeFromUrl(
                                                                            e) ==
                                                                    1)
                                                                .toList()
                                                                .firstOrNull!);
                                                          },
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.8,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.28,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/text_line_pdf.png',
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.8,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.28,
                                                                fit:
                                                                    BoxFit.none,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if (widget.eventDetails!
                                                          .eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              1)
                                                          .toList()
                                                          .length >
                                                      1)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    12.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.8,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.28,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        20.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                _model.viewpdf =
                                                                    true;
                                                                _model.viewdoc =
                                                                    false;
                                                                _model.viewmp3 =
                                                                    false;
                                                                _model.viewimg =
                                                                    false;
                                                                _model.viewppt =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Stack(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        1.0),
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/text_line_pdf.png',
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.8,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.28,
                                                                      fit: BoxFit
                                                                          .none,
                                                                    ),
                                                                  ),
                                                                  if (widget
                                                                          .eventDetails!
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              1)
                                                                          .toList()
                                                                          .length >
                                                                      1)
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          30.0,
                                                                          15.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          _model.viewpdf =
                                                                              true;
                                                                          _model.viewdoc =
                                                                              false;
                                                                          _model.viewmp3 =
                                                                              false;
                                                                          _model.viewimg =
                                                                              false;
                                                                          _model.viewppt =
                                                                              false;
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        child: badges
                                                                            .Badge(
                                                                          badgeContent:
                                                                              Text(
                                                                            widget.eventDetails!.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 1).toList().length.toString(),
                                                                            style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.nunito(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  fontSize: 20.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          showBadge:
                                                                              true,
                                                                          shape: badges
                                                                              .BadgeShape
                                                                              .circle,
                                                                          badgeColor:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          elevation:
                                                                              5.0,
                                                                          padding:
                                                                              EdgeInsets.all(5.0),
                                                                          position:
                                                                              badges.BadgePosition.topEnd(),
                                                                          animationType: badges
                                                                              .BadgeAnimationType
                                                                              .scale,
                                                                          toAnimate:
                                                                              true,
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
                                                  if (widget.eventDetails
                                                          ?.eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              2)
                                                          .toList()
                                                          .length ==
                                                      1)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    12.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await launchURL(widget
                                                                .eventDetails!
                                                                .eventfiles
                                                                .where((e) =>
                                                                    functions
                                                                        .getFileTypeFromUrl(
                                                                            e) ==
                                                                    2)
                                                                .toList()
                                                                .firstOrNull!);
                                                          },
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.8,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.28,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/text_line_doc.png',
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.8,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.28,
                                                                fit:
                                                                    BoxFit.none,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if (widget.eventDetails!
                                                          .eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              2)
                                                          .toList()
                                                          .length >
                                                      1)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    12.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.8,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.28,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        20.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                _model.viewpdf =
                                                                    false;
                                                                _model.viewdoc =
                                                                    true;
                                                                _model.viewmp3 =
                                                                    false;
                                                                _model.viewimg =
                                                                    false;
                                                                _model.viewppt =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Stack(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        1.0),
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/text_line_doc.png',
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.8,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.28,
                                                                      fit: BoxFit
                                                                          .none,
                                                                    ),
                                                                  ),
                                                                  if (widget
                                                                          .eventDetails!
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              2)
                                                                          .toList()
                                                                          .length >
                                                                      1)
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          30.0,
                                                                          15.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          _model.viewpdf =
                                                                              false;
                                                                          _model.viewdoc =
                                                                              true;
                                                                          _model.viewmp3 =
                                                                              false;
                                                                          _model.viewimg =
                                                                              false;
                                                                          _model.viewppt =
                                                                              false;
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        child: badges
                                                                            .Badge(
                                                                          badgeContent:
                                                                              Text(
                                                                            valueOrDefault<String>(
                                                                              widget.eventDetails?.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 2).toList().length.toString(),
                                                                              '2',
                                                                            ),
                                                                            style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.nunito(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondary,
                                                                                  fontSize: 20.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          showBadge:
                                                                              true,
                                                                          shape: badges
                                                                              .BadgeShape
                                                                              .circle,
                                                                          badgeColor:
                                                                              FlutterFlowTheme.of(context).primaryBackground,
                                                                          elevation:
                                                                              5.0,
                                                                          padding:
                                                                              EdgeInsets.all(5.0),
                                                                          position:
                                                                              badges.BadgePosition.topEnd(),
                                                                          animationType: badges
                                                                              .BadgeAnimationType
                                                                              .scale,
                                                                          toAnimate:
                                                                              true,
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
                                                  if (widget.eventDetails
                                                          ?.eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              3)
                                                          .toList()
                                                          .length ==
                                                      1)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    12.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await launchURL(widget
                                                                .eventDetails!
                                                                .eventfiles
                                                                .where((e) =>
                                                                    functions
                                                                        .getFileTypeFromUrl(
                                                                            e) ==
                                                                    3)
                                                                .toList()
                                                                .firstOrNull!);
                                                          },
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.8,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.28,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/text_line_mp3.png',
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.8,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.28,
                                                                fit:
                                                                    BoxFit.none,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if (widget.eventDetails!
                                                          .eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              3)
                                                          .toList()
                                                          .length >
                                                      1)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    12.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.8,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.28,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        20.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                _model.viewpdf =
                                                                    false;
                                                                _model.viewdoc =
                                                                    false;
                                                                _model.viewmp3 =
                                                                    true;
                                                                _model.viewimg =
                                                                    false;
                                                                _model.viewppt =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Stack(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        1.0),
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/text_line_mp3.png',
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.8,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.28,
                                                                      fit: BoxFit
                                                                          .none,
                                                                    ),
                                                                  ),
                                                                  if (widget
                                                                          .eventDetails!
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              3)
                                                                          .toList()
                                                                          .length >
                                                                      1)
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          30.0,
                                                                          15.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          _model.viewpdf =
                                                                              false;
                                                                          _model.viewdoc =
                                                                              false;
                                                                          _model.viewmp3 =
                                                                              true;
                                                                          _model.viewimg =
                                                                              false;
                                                                          _model.viewppt =
                                                                              false;
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        child: badges
                                                                            .Badge(
                                                                          badgeContent:
                                                                              Text(
                                                                            widget.eventDetails!.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 3).toList().length.toString(),
                                                                            style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.nunito(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  fontSize: 20.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          showBadge:
                                                                              true,
                                                                          shape: badges
                                                                              .BadgeShape
                                                                              .circle,
                                                                          badgeColor:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          elevation:
                                                                              5.0,
                                                                          padding:
                                                                              EdgeInsets.all(5.0),
                                                                          position:
                                                                              badges.BadgePosition.topEnd(),
                                                                          animationType: badges
                                                                              .BadgeAnimationType
                                                                              .scale,
                                                                          toAnimate:
                                                                              true,
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
                                                  if (widget.eventDetails
                                                          ?.eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              4)
                                                          .toList()
                                                          .length ==
                                                      1)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    12.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.8,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.28,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                          child: InkWell(
                                                            splashColor: Colors
                                                                .transparent,
                                                            focusColor: Colors
                                                                .transparent,
                                                            hoverColor: Colors
                                                                .transparent,
                                                            highlightColor:
                                                                Colors
                                                                    .transparent,
                                                            onTap: () async {
                                                              await Navigator
                                                                  .push(
                                                                context,
                                                                PageTransition(
                                                                  type:
                                                                      PageTransitionType
                                                                          .fade,
                                                                  child:
                                                                      FlutterFlowExpandedImageView(
                                                                    image: Image
                                                                        .network(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        functions.converttoimagepath(widget
                                                                            .eventDetails!
                                                                            .eventfiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                4)
                                                                            .toList()
                                                                            .firstOrNull!),
                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/nuu8fl3dozwm/clarity_image-gallery-line.png',
                                                                      ),
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                    allowRotation:
                                                                        false,
                                                                    tag: valueOrDefault<
                                                                        String>(
                                                                      functions.converttoimagepath(widget
                                                                          .eventDetails!
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              4)
                                                                          .toList()
                                                                          .firstOrNull!),
                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/nuu8fl3dozwm/clarity_image-gallery-line.png',
                                                                    ),
                                                                    useHeroAnimation:
                                                                        true,
                                                                  ),
                                                                ),
                                                              );
                                                            },
                                                            child: Hero(
                                                              tag:
                                                                  valueOrDefault<
                                                                      String>(
                                                                functions.converttoimagepath(widget
                                                                    .eventDetails!
                                                                    .eventfiles
                                                                    .where((e) =>
                                                                        functions
                                                                            .getFileTypeFromUrl(e) ==
                                                                        4)
                                                                    .toList()
                                                                    .firstOrNull!),
                                                                'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/nuu8fl3dozwm/clarity_image-gallery-line.png',
                                                              ),
                                                              transitionOnUserGestures:
                                                                  true,
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8.0),
                                                                child: Image
                                                                    .network(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    functions.converttoimagepath(widget
                                                                        .eventDetails!
                                                                        .eventfiles
                                                                        .where((e) =>
                                                                            functions.getFileTypeFromUrl(e) ==
                                                                            4)
                                                                        .toList()
                                                                        .firstOrNull!),
                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/nuu8fl3dozwm/clarity_image-gallery-line.png',
                                                                  ),
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.8,
                                                                  height: MediaQuery.sizeOf(
                                                                              context)
                                                                          .height *
                                                                      0.28,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if (widget.eventDetails!
                                                          .eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              4)
                                                          .toList()
                                                          .length >
                                                      1)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    12.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.8,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.28,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        20.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                _model.viewpdf =
                                                                    false;
                                                                _model.viewdoc =
                                                                    false;
                                                                _model.viewmp3 =
                                                                    false;
                                                                _model.viewimg =
                                                                    true;
                                                                _model.viewppt =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Stack(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        1.0),
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .network(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        functions.converttoimagepath(widget
                                                                            .eventDetails!
                                                                            .eventfiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                4)
                                                                            .toList()
                                                                            .firstOrNull!),
                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/nuu8fl3dozwm/clarity_image-gallery-line.png',
                                                                      ),
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.8,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.28,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                  if (widget
                                                                          .eventDetails!
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              4)
                                                                          .toList()
                                                                          .length >
                                                                      1)
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          30.0,
                                                                          15.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          _model.viewpdf =
                                                                              false;
                                                                          _model.viewdoc =
                                                                              false;
                                                                          _model.viewmp3 =
                                                                              false;
                                                                          _model.viewimg =
                                                                              true;
                                                                          _model.viewppt =
                                                                              false;
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        child: badges
                                                                            .Badge(
                                                                          badgeContent:
                                                                              Text(
                                                                            widget.eventDetails!.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 4).toList().length.toString(),
                                                                            style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.nunito(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  fontSize: 20.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          showBadge:
                                                                              true,
                                                                          shape: badges
                                                                              .BadgeShape
                                                                              .circle,
                                                                          badgeColor:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          elevation:
                                                                              5.0,
                                                                          padding:
                                                                              EdgeInsets.all(5.0),
                                                                          position:
                                                                              badges.BadgePosition.topEnd(),
                                                                          animationType: badges
                                                                              .BadgeAnimationType
                                                                              .scale,
                                                                          toAnimate:
                                                                              true,
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
                                                  if (widget.eventDetails
                                                          ?.eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              5)
                                                          .toList()
                                                          .length ==
                                                      1)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    12.0),
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {
                                                            await launchURL(widget
                                                                .eventDetails!
                                                                .eventfiles
                                                                .where((e) =>
                                                                    functions
                                                                        .getFileTypeFromUrl(
                                                                            e) ==
                                                                    5)
                                                                .toList()
                                                                .firstOrNull!);
                                                          },
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.8,
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.28,
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6.0),
                                                              border:
                                                                  Border.all(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primary,
                                                              ),
                                                            ),
                                                            child: ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          8.0),
                                                              child:
                                                                  Image.asset(
                                                                'assets/images/text_line_ppt.png',
                                                                width: MediaQuery.sizeOf(
                                                                            context)
                                                                        .width *
                                                                    0.8,
                                                                height: MediaQuery.sizeOf(
                                                                            context)
                                                                        .height *
                                                                    0.28,
                                                                fit:
                                                                    BoxFit.none,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if (widget.eventDetails!
                                                          .eventfiles
                                                          .where((e) =>
                                                              functions
                                                                  .getFileTypeFromUrl(
                                                                      e) ==
                                                              5)
                                                          .toList()
                                                          .length >
                                                      1)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    12.0),
                                                        child: Container(
                                                          width:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .width *
                                                                  0.8,
                                                          height:
                                                              MediaQuery.sizeOf(
                                                                          context)
                                                                      .height *
                                                                  0.28,
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6.0),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                      .of(context)
                                                                  .primary,
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        0.0,
                                                                        20.0),
                                                            child: InkWell(
                                                              splashColor: Colors
                                                                  .transparent,
                                                              focusColor: Colors
                                                                  .transparent,
                                                              hoverColor: Colors
                                                                  .transparent,
                                                              highlightColor:
                                                                  Colors
                                                                      .transparent,
                                                              onTap: () async {
                                                                _model.viewpdf =
                                                                    false;
                                                                _model.viewdoc =
                                                                    false;
                                                                _model.viewmp3 =
                                                                    false;
                                                                _model.viewimg =
                                                                    false;
                                                                _model.viewppt =
                                                                    true;
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: Stack(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        1.0,
                                                                        1.0),
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/text_line_ppt.png',
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width *
                                                                          0.8,
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.28,
                                                                      fit: BoxFit
                                                                          .none,
                                                                    ),
                                                                  ),
                                                                  if (widget
                                                                          .eventDetails!
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              5)
                                                                          .toList()
                                                                          .length >
                                                                      1)
                                                                    Padding(
                                                                      padding: EdgeInsetsDirectional.fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          30.0,
                                                                          15.0),
                                                                      child:
                                                                          InkWell(
                                                                        splashColor:
                                                                            Colors.transparent,
                                                                        focusColor:
                                                                            Colors.transparent,
                                                                        hoverColor:
                                                                            Colors.transparent,
                                                                        highlightColor:
                                                                            Colors.transparent,
                                                                        onTap:
                                                                            () async {
                                                                          _model.viewpdf =
                                                                              false;
                                                                          _model.viewdoc =
                                                                              false;
                                                                          _model.viewmp3 =
                                                                              false;
                                                                          _model.viewimg =
                                                                              false;
                                                                          _model.viewppt =
                                                                              true;
                                                                          safeSetState(
                                                                              () {});
                                                                        },
                                                                        child: badges
                                                                            .Badge(
                                                                          badgeContent:
                                                                              Text(
                                                                            widget.eventDetails!.eventfiles.where((e) => functions.getFileTypeFromUrl(e) == 5).toList().length.toString(),
                                                                            style: FlutterFlowTheme.of(context).titleSmall.override(
                                                                                  font: GoogleFonts.nunito(
                                                                                    fontWeight: FontWeight.normal,
                                                                                    fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                                  fontSize: 20.0,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.normal,
                                                                                  fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                                ),
                                                                          ),
                                                                          showBadge:
                                                                              true,
                                                                          shape: badges
                                                                              .BadgeShape
                                                                              .circle,
                                                                          badgeColor:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          elevation:
                                                                              5.0,
                                                                          padding:
                                                                              EdgeInsets.all(5.0),
                                                                          position:
                                                                              badges.BadgePosition.topEnd(),
                                                                          animationType: badges
                                                                              .BadgeAnimationType
                                                                              .scale,
                                                                          toAnimate:
                                                                              true,
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
                                                  if (_model.viewpdf)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              -1.0, 0.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final imagesview = widget
                                                                  .eventDetails
                                                                  ?.eventfiles
                                                                  .where((e) =>
                                                                      functions
                                                                          .getFileTypeFromUrl(
                                                                              e) ==
                                                                      1)
                                                                  .toList()
                                                                  .toList() ??
                                                              [];

                                                          return ListView
                                                              .separated(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10.0),
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                imagesview
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                SizedBox(
                                                                    height:
                                                                        10.0),
                                                            itemBuilder: (context,
                                                                imagesviewIndex) {
                                                              final imagesviewItem =
                                                                  imagesview[
                                                                      imagesviewIndex];
                                                              return Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Padding(
                                                                    padding: EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            10.0),
                                                                    child: badges
                                                                        .Badge(
                                                                      badgeContent:
                                                                          Text(
                                                                        functions
                                                                            .serialnumber(imagesviewIndex)
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.nunito(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondaryBackground,
                                                                              fontSize: 12.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
                                                                              fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                            ),
                                                                      ),
                                                                      showBadge:
                                                                          true,
                                                                      shape: badges
                                                                          .BadgeShape
                                                                          .circle,
                                                                      badgeColor:
                                                                          FlutterFlowTheme.of(context)
                                                                              .primary,
                                                                      elevation:
                                                                          5.0,
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              5.0),
                                                                      position:
                                                                          badges.BadgePosition
                                                                              .topEnd(),
                                                                      animationType: badges
                                                                          .BadgeAnimationType
                                                                          .scale,
                                                                      toAnimate:
                                                                          true,
                                                                      child:
                                                                          ClipRRect(
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/text_line_pdf.png',
                                                                          width:
                                                                              46.0,
                                                                          height:
                                                                              41.0,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  InkWell(
                                                                    splashColor:
                                                                        Colors
                                                                            .transparent,
                                                                    focusColor:
                                                                        Colors
                                                                            .transparent,
                                                                    hoverColor:
                                                                        Colors
                                                                            .transparent,
                                                                    highlightColor:
                                                                        Colors
                                                                            .transparent,
                                                                    onTap:
                                                                        () async {
                                                                      await launchURL(
                                                                          imagesviewItem);
                                                                    },
                                                                    child: Row(
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .max,
                                                                      children: [
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              5.0,
                                                                              0.0),
                                                                          child:
                                                                              Icon(
                                                                            Icons.remove_red_eye,
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primary,
                                                                            size:
                                                                                20.0,
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              0.0,
                                                                              10.0,
                                                                              0.0),
                                                                          child:
                                                                              Text(
                                                                            'View File',
                                                                            style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                  font: GoogleFonts.nunito(
                                                                                    fontWeight: FontWeight.w500,
                                                                                    fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                  ),
                                                                                  color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                  letterSpacing: 0.0,
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                            },
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  if (_model.viewdoc)
                                                    Builder(
                                                      builder: (context) {
                                                        final imagesview = widget
                                                                .eventDetails
                                                                ?.eventfiles
                                                                .where((e) =>
                                                                    functions
                                                                        .getFileTypeFromUrl(
                                                                            e) ==
                                                                    2)
                                                                .toList()
                                                                .toList() ??
                                                            [];

                                                        return ListView
                                                            .separated(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          primary: false,
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              imagesview.length,
                                                          separatorBuilder: (_,
                                                                  __) =>
                                                              SizedBox(
                                                                  height: 10.0),
                                                          itemBuilder: (context,
                                                              imagesviewIndex) {
                                                            final imagesviewItem =
                                                                imagesview[
                                                                    imagesviewIndex];
                                                            return Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                badges.Badge(
                                                                  badgeContent:
                                                                      Text(
                                                                    functions
                                                                        .serialnumber(
                                                                            imagesviewIndex)
                                                                        .toString(),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  showBadge:
                                                                      true,
                                                                  shape: badges
                                                                      .BadgeShape
                                                                      .circle,
                                                                  badgeColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                  elevation:
                                                                      0.0,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  position: badges
                                                                          .BadgePosition
                                                                      .topEnd(),
                                                                  animationType:
                                                                      badges
                                                                          .BadgeAnimationType
                                                                          .scale,
                                                                  toAnimate:
                                                                      true,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/text_line_doc.png',
                                                                      width:
                                                                          46.0,
                                                                      height:
                                                                          41.0,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    await launchURL(
                                                                        imagesviewItem);
                                                                  },
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .remove_red_eye,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          size:
                                                                              20.0,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          'View File',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.nunito(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  if (_model.viewmp3)
                                                    Builder(
                                                      builder: (context) {
                                                        final imagesview = widget
                                                                .eventDetails
                                                                ?.eventfiles
                                                                .where((e) =>
                                                                    functions
                                                                        .getFileTypeFromUrl(
                                                                            e) ==
                                                                    3)
                                                                .toList()
                                                                .toList() ??
                                                            [];

                                                        return ListView
                                                            .separated(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          primary: false,
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              imagesview.length,
                                                          separatorBuilder: (_,
                                                                  __) =>
                                                              SizedBox(
                                                                  height: 10.0),
                                                          itemBuilder: (context,
                                                              imagesviewIndex) {
                                                            final imagesviewItem =
                                                                imagesview[
                                                                    imagesviewIndex];
                                                            return Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                badges.Badge(
                                                                  badgeContent:
                                                                      Text(
                                                                    functions
                                                                        .serialnumber(
                                                                            imagesviewIndex)
                                                                        .toString(),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  showBadge:
                                                                      true,
                                                                  shape: badges
                                                                      .BadgeShape
                                                                      .circle,
                                                                  badgeColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                  elevation:
                                                                      0.0,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  position: badges
                                                                          .BadgePosition
                                                                      .topEnd(),
                                                                  animationType:
                                                                      badges
                                                                          .BadgeAnimationType
                                                                          .scale,
                                                                  toAnimate:
                                                                      true,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/text_line_mp3.png',
                                                                      width:
                                                                          46.0,
                                                                      height:
                                                                          41.0,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    await launchURL(
                                                                        imagesviewItem);
                                                                  },
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .remove_red_eye,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          size:
                                                                              20.0,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          'View File',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.nunito(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  if (_model.viewimg)
                                                    Align(
                                                      alignment:
                                                          AlignmentDirectional(
                                                              0.0, -1.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final imagesview = widget
                                                                  .eventDetails
                                                                  ?.eventfiles
                                                                  .where((e) =>
                                                                      functions
                                                                          .getFileTypeFromUrl(
                                                                              e) ==
                                                                      4)
                                                                  .toList()
                                                                  .toList() ??
                                                              [];

                                                          return ListView
                                                              .separated(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        10.0),
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                imagesview
                                                                    .length,
                                                            separatorBuilder: (_,
                                                                    __) =>
                                                                SizedBox(
                                                                    height:
                                                                        10.0),
                                                            itemBuilder: (context,
                                                                imagesviewIndex) {
                                                              final imagesviewItem =
                                                                  imagesview[
                                                                      imagesviewIndex];
                                                              return Align(
                                                                alignment:
                                                                    AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: badges
                                                                    .Badge(
                                                                  badgeContent:
                                                                      Text(
                                                                    functions
                                                                        .serialnumber(
                                                                            imagesviewIndex)
                                                                        .toString(),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  showBadge:
                                                                      true,
                                                                  shape: badges
                                                                      .BadgeShape
                                                                      .circle,
                                                                  badgeColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                  elevation:
                                                                      0.0,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  position: badges
                                                                          .BadgePosition
                                                                      .topStart(),
                                                                  animationType:
                                                                      badges
                                                                          .BadgeAnimationType
                                                                          .scale,
                                                                  toAnimate:
                                                                      true,
                                                                  child: Align(
                                                                    alignment:
                                                                        AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0),
                                                                    child:
                                                                        InkWell(
                                                                      splashColor:
                                                                          Colors
                                                                              .transparent,
                                                                      focusColor:
                                                                          Colors
                                                                              .transparent,
                                                                      hoverColor:
                                                                          Colors
                                                                              .transparent,
                                                                      highlightColor:
                                                                          Colors
                                                                              .transparent,
                                                                      onTap:
                                                                          () async {
                                                                        await Navigator
                                                                            .push(
                                                                          context,
                                                                          PageTransition(
                                                                            type:
                                                                                PageTransitionType.fade,
                                                                            child:
                                                                                FlutterFlowExpandedImageView(
                                                                              image: Image.network(
                                                                                functions.converttoimagepath(imagesviewItem),
                                                                                fit: BoxFit.contain,
                                                                              ),
                                                                              allowRotation: false,
                                                                              tag: functions.converttoimagepath(imagesviewItem),
                                                                              useHeroAnimation: true,
                                                                            ),
                                                                          ),
                                                                        );
                                                                      },
                                                                      child:
                                                                          Hero(
                                                                        tag: functions
                                                                            .converttoimagepath(imagesviewItem),
                                                                        transitionOnUserGestures:
                                                                            true,
                                                                        child:
                                                                            ClipRRect(
                                                                          borderRadius:
                                                                              BorderRadius.circular(8.0),
                                                                          child:
                                                                              Image.network(
                                                                            functions.converttoimagepath(imagesviewItem),
                                                                            width:
                                                                                MediaQuery.sizeOf(context).width * 0.8,
                                                                            height:
                                                                                MediaQuery.sizeOf(context).height * 0.28,
                                                                            fit:
                                                                                BoxFit.contain,
                                                                          ),
                                                                        ),
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
                                                  if (_model.viewppt)
                                                    Builder(
                                                      builder: (context) {
                                                        final imagesview = widget
                                                                .eventDetails
                                                                ?.eventfiles
                                                                .where((e) =>
                                                                    functions
                                                                        .getFileTypeFromUrl(
                                                                            e) ==
                                                                    5)
                                                                .toList()
                                                                .toList() ??
                                                            [];

                                                        return ListView
                                                            .separated(
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  vertical:
                                                                      10.0),
                                                          primary: false,
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemCount:
                                                              imagesview.length,
                                                          separatorBuilder: (_,
                                                                  __) =>
                                                              SizedBox(
                                                                  height: 10.0),
                                                          itemBuilder: (context,
                                                              imagesviewIndex) {
                                                            final imagesviewItem =
                                                                imagesview[
                                                                    imagesviewIndex];
                                                            return Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                badges.Badge(
                                                                  badgeContent:
                                                                      Text(
                                                                    functions
                                                                        .serialnumber(
                                                                            imagesviewIndex)
                                                                        .toString(),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).secondary,
                                                                          fontSize:
                                                                              12.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .titleSmall
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                  showBadge:
                                                                      true,
                                                                  shape: badges
                                                                      .BadgeShape
                                                                      .circle,
                                                                  badgeColor:
                                                                      FlutterFlowTheme.of(
                                                                              context)
                                                                          .primary,
                                                                  elevation:
                                                                      0.0,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              5.0),
                                                                  position: badges
                                                                          .BadgePosition
                                                                      .topEnd(),
                                                                  animationType:
                                                                      badges
                                                                          .BadgeAnimationType
                                                                          .scale,
                                                                  toAnimate:
                                                                      true,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            8.0),
                                                                    child: Image
                                                                        .asset(
                                                                      'assets/images/text_line_ppt.png',
                                                                      width:
                                                                          46.0,
                                                                      height:
                                                                          41.0,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                ),
                                                                InkWell(
                                                                  splashColor:
                                                                      Colors
                                                                          .transparent,
                                                                  focusColor: Colors
                                                                      .transparent,
                                                                  hoverColor: Colors
                                                                      .transparent,
                                                                  highlightColor:
                                                                      Colors
                                                                          .transparent,
                                                                  onTap:
                                                                      () async {
                                                                    await launchURL(
                                                                        imagesviewItem);
                                                                  },
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    children: [
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            5.0,
                                                                            0.0),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .remove_red_eye,
                                                                          color:
                                                                              FlutterFlowTheme.of(context).primary,
                                                                          size:
                                                                              20.0,
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                        child:
                                                                            Text(
                                                                          'View File',
                                                                          style: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .override(
                                                                                font: GoogleFonts.nunito(
                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                                ),
                                                                                color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                letterSpacing: 0.0,
                                                                                fontWeight: FontWeight.w500,
                                                                                fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                              ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            );
                                                          },
                                                        );
                                                      },
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ]
                                  .divide(SizedBox(height: 10.0))
                                  .around(SizedBox(height: 10.0)),
                            ),
                          ),
                        ),
                      ),
                    ].addToEnd(SizedBox(height: 30.0)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
