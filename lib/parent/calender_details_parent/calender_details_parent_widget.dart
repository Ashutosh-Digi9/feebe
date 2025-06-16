import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calender_details_parent_model.dart';
export 'calender_details_parent_model.dart';

class CalenderDetailsParentWidget extends StatefulWidget {
  const CalenderDetailsParentWidget({
    super.key,
    this.eventDetails,
  });

  final EventsNoticeStruct? eventDetails;

  static String routeName = 'calender_details_parent';
  static String routePath = '/calenderDetailsParent';

  @override
  State<CalenderDetailsParentWidget> createState() =>
      _CalenderDetailsParentWidgetState();
}

class _CalenderDetailsParentWidgetState
    extends State<CalenderDetailsParentWidget> {
  late CalenderDetailsParentModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalenderDetailsParentModel());
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
                    Icons.chevron_left,
                    color: FlutterFlowTheme.of(context).alternate,
                    size: 26.0,
                  ),
                  onPressed: () async {
                    context.pop();
                  },
                ),
                title: Text(
                  'Event',
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                alignment: AlignmentDirectional(-1.0, 0.0),
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
                                              FlutterFlowTheme.of(context)
                                                  .bodyMedium
                                                  .fontStyle,
                                        ),
                                        color:
                                            FlutterFlowTheme.of(context).text1,
                                        fontSize: 20.0,
                                        letterSpacing: 0.0,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .fontStyle,
                                      ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  color: () {
                                    if (widget.eventDetails?.eventName ==
                                        'Event') {
                                      return FlutterFlowTheme.of(context).event;
                                    } else if (widget
                                            .eventDetails?.eventName ==
                                        'Birthday') {
                                      return FlutterFlowTheme.of(context)
                                          .birthdayfill;
                                    } else {
                                      return FlutterFlowTheme.of(context)
                                          .holiday;
                                    }
                                  }(),
                                  borderRadius: BorderRadius.circular(3.59),
                                  border: Border.all(
                                    color: () {
                                      if (widget.eventDetails?.eventName ==
                                          'Event') {
                                        return FlutterFlowTheme.of(context)
                                            .eventborder;
                                      } else if (widget
                                              .eventDetails?.eventName ==
                                          'Birthday') {
                                        return FlutterFlowTheme.of(context)
                                            .birthdayborder;
                                      } else {
                                        return FlutterFlowTheme.of(context)
                                            .holidayborder;
                                      }
                                    }(),
                                    width: 1.0,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      if (widget.eventDetails?.eventName ==
                                          'Event')
                                        Image.asset(
                                          'assets/images/typcn--flash-removebg-preview.png',
                                          width: 15.5,
                                          height: 15.5,
                                          fit: BoxFit.contain,
                                        ),
                                      if (widget.eventDetails?.eventName ==
                                          'Holiday')
                                        Image.asset(
                                          'assets/images/fxemoji--confetti-removebg-preview.png',
                                          width: 15.5,
                                          height: 15.5,
                                          fit: BoxFit.cover,
                                        ),
                                      if (widget.eventDetails?.eventName ==
                                          'Birthday')
                                        Image.asset(
                                          'assets/images/noto--birthday-cake-removebg-preview.png',
                                          width: 15.5,
                                          height: 15.5,
                                          fit: BoxFit.cover,
                                        ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0.0, 0.0, 10.0, 0.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            widget.eventDetails?.eventName,
                                            'name',
                                          ),
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                color: () {
                                                  if (widget.eventDetails
                                                          ?.eventName ==
                                                      'Event') {
                                                    return FlutterFlowTheme.of(
                                                            context)
                                                        .eventtext;
                                                  } else if (widget
                                                          .eventDetails
                                                          ?.eventName ==
                                                      'Holiday') {
                                                    return FlutterFlowTheme.of(
                                                            context)
                                                        .holidaytext;
                                                  } else {
                                                    return FlutterFlowTheme.of(
                                                            context)
                                                        .birthdaytext;
                                                  }
                                                }(),
                                                fontSize: 14.0,
                                                letterSpacing: 0.0,
                                                fontWeight: FontWeight.w500,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
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
                              dateTimeFormat(
                                  "dd MMM y", widget.eventDetails!.eventDate!),
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .override(
                                    font: GoogleFonts.nunito(
                                      fontWeight: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontWeight,
                                      fontStyle: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .fontStyle,
                                    ),
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
                          Align(
                            alignment: AlignmentDirectional(-1.0, 0.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).secondary,
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, -1.0),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Text(
                                        valueOrDefault<String>(
                                          widget
                                              .eventDetails?.eventDescription,
                                          'Des',
                                        ),
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
                                              fontSize: 16.0,
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
                                  ),
                                  Align(
                                    alignment: AlignmentDirectional(-1.0, 0.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondary,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                if (widget.eventDetails
                                                        ?.eventfiles
                                                        .where((e) =>
                                                            functions
                                                                .getFileTypeFromUrl(
                                                                    e) ==
                                                            1)
                                                        .toList()
                                                        .length !=
                                                    0)
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      _model.viewpdf = true;
                                                      _model.viewdoc = false;
                                                      _model.viewmp3 = false;
                                                      _model.viewimg = false;
                                                      _model.viewppt = false;
                                                      safeSetState(() {});
                                                    },
                                                    child: badges.Badge(
                                                      badgeContent: Text(
                                                        widget.eventDetails!
                                                            .eventfiles
                                                            .where((e) =>
                                                                functions
                                                                    .getFileTypeFromUrl(
                                                                        e) ==
                                                                1)
                                                            .toList()
                                                            .length
                                                            .toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondaryBackground,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      showBadge: true,
                                                      shape: badges
                                                          .BadgeShape.circle,
                                                      badgeColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      elevation: 5.0,
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      position:
                                                          badges.BadgePosition
                                                              .topEnd(),
                                                      animationType: badges
                                                          .BadgeAnimationType
                                                          .scale,
                                                      toAnimate: true,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/download.png',
                                                          width: 46.0,
                                                          height: 41.0,
                                                          fit: BoxFit.contain,
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
                                                        .length !=
                                                    0)
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      _model.viewpdf = false;
                                                      _model.viewdoc = true;
                                                      _model.viewmp3 = false;
                                                      _model.viewimg = false;
                                                      _model.viewppt = false;
                                                      safeSetState(() {});
                                                    },
                                                    child: badges.Badge(
                                                      badgeContent: Text(
                                                        widget.eventDetails!
                                                            .eventfiles
                                                            .where((e) =>
                                                                functions
                                                                    .getFileTypeFromUrl(
                                                                        e) ==
                                                                2)
                                                            .toList()
                                                            .length
                                                            .toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      showBadge: true,
                                                      shape: badges
                                                          .BadgeShape.circle,
                                                      badgeColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      elevation: 0.0,
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      position:
                                                          badges.BadgePosition
                                                              .topEnd(),
                                                      animationType: badges
                                                          .BadgeAnimationType
                                                          .scale,
                                                      toAnimate: true,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/download_(1).png',
                                                          width: 46.0,
                                                          height: 41.0,
                                                          fit: BoxFit.contain,
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
                                                        .length !=
                                                    0)
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      _model.viewpdf = false;
                                                      _model.viewdoc = false;
                                                      _model.viewmp3 = true;
                                                      _model.viewimg = false;
                                                      _model.viewppt = false;
                                                      safeSetState(() {});
                                                    },
                                                    child: badges.Badge(
                                                      badgeContent: Text(
                                                        widget.eventDetails!
                                                            .eventfiles
                                                            .where((e) =>
                                                                functions
                                                                    .getFileTypeFromUrl(
                                                                        e) ==
                                                                3)
                                                            .toList()
                                                            .length
                                                            .toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      showBadge: true,
                                                      shape: badges
                                                          .BadgeShape.circle,
                                                      badgeColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      elevation: 0.0,
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      position:
                                                          badges.BadgePosition
                                                              .topEnd(),
                                                      animationType: badges
                                                          .BadgeAnimationType
                                                          .scale,
                                                      toAnimate: true,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/download_(2).png',
                                                          width: 46.0,
                                                          height: 41.0,
                                                          fit: BoxFit.contain,
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
                                                        .length !=
                                                    0)
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      _model.viewpdf = false;
                                                      _model.viewdoc = false;
                                                      _model.viewmp3 = false;
                                                      _model.viewimg = true;
                                                      _model.viewppt = false;
                                                      safeSetState(() {});
                                                    },
                                                    child: badges.Badge(
                                                      badgeContent: Text(
                                                        widget.eventDetails!
                                                            .eventfiles
                                                            .where((e) =>
                                                                functions
                                                                    .getFileTypeFromUrl(
                                                                        e) ==
                                                                4)
                                                            .toList()
                                                            .length
                                                            .toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      showBadge: true,
                                                      shape: badges
                                                          .BadgeShape.circle,
                                                      badgeColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      elevation: 0.0,
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      position:
                                                          badges.BadgePosition
                                                              .topEnd(),
                                                      animationType: badges
                                                          .BadgeAnimationType
                                                          .scale,
                                                      toAnimate: true,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/clarity_image-gallery-line.png',
                                                          width: 46.0,
                                                          height: 41.0,
                                                          fit: BoxFit.contain,
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
                                                        .length !=
                                                    0)
                                                  InkWell(
                                                    splashColor:
                                                        Colors.transparent,
                                                    focusColor:
                                                        Colors.transparent,
                                                    hoverColor:
                                                        Colors.transparent,
                                                    highlightColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      _model.viewpdf = false;
                                                      _model.viewdoc = false;
                                                      _model.viewmp3 = false;
                                                      _model.viewimg = false;
                                                      _model.viewppt = true;
                                                      safeSetState(() {});
                                                    },
                                                    child: badges.Badge(
                                                      badgeContent: Text(
                                                        widget.eventDetails!
                                                            .eventfiles
                                                            .where((e) =>
                                                                functions
                                                                    .getFileTypeFromUrl(
                                                                        e) ==
                                                                5)
                                                            .toList()
                                                            .length
                                                            .toString(),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .titleSmall
                                                                .override(
                                                                  font: GoogleFonts
                                                                      .nunito(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .titleSmall
                                                                        .fontStyle,
                                                                  ),
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .secondary,
                                                                  fontSize:
                                                                      12.0,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .titleSmall
                                                                      .fontStyle,
                                                                ),
                                                      ),
                                                      showBadge: true,
                                                      shape: badges
                                                          .BadgeShape.circle,
                                                      badgeColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primary,
                                                      elevation: 0.0,
                                                      padding:
                                                          EdgeInsets.all(5.0),
                                                      position:
                                                          badges.BadgePosition
                                                              .topEnd(),
                                                      animationType: badges
                                                          .BadgeAnimationType
                                                          .scale,
                                                      toAnimate: true,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        child: Image.asset(
                                                          'assets/images/download-removebg-preview.png',
                                                          width: 46.0,
                                                          height: 41.0,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                              ]
                                                  .divide(SizedBox(width: 5.0))
                                                  .around(SizedBox(width: 5.0)),
                                            ),
                                          ),
                                          if (_model.viewpdf)
                                            Align(
                                              alignment: AlignmentDirectional(
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

                                                  return ListView.separated(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10.0),
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    itemCount:
                                                        imagesview.length,
                                                    separatorBuilder: (_, __) =>
                                                        SizedBox(height: 10.0),
                                                    itemBuilder: (context,
                                                        imagesviewIndex) {
                                                      final imagesviewItem =
                                                          imagesview[
                                                              imagesviewIndex];
                                                      return Visibility(
                                                        visible: functions
                                                                .getFileTypeFromUrl(
                                                                    imagesviewItem) ==
                                                            1,
                                                        child: Align(
                                                          alignment:
                                                              AlignmentDirectional(
                                                                  -1.0, 0.0),
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
                                                              await launchURL(
                                                                  imagesviewItem);
                                                            },
                                                            child: Icon(
                                                              Icons
                                                                  .picture_as_pdf,
                                                              color: Color(
                                                                  0xFFE9060A),
                                                              size: 24.0,
                                                            ),
                                                          ),
                                                        ),
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

                                                return ListView.separated(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: imagesview.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(height: 10.0),
                                                  itemBuilder: (context,
                                                      imagesviewIndex) {
                                                    final imagesviewItem =
                                                        imagesview[
                                                            imagesviewIndex];
                                                    return Visibility(
                                                      visible: functions
                                                              .getFileTypeFromUrl(
                                                                  imagesviewItem) ==
                                                          2,
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
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
                                                            await launchURL(
                                                                imagesviewItem);
                                                          },
                                                          child: Icon(
                                                            Icons
                                                                .document_scanner,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primary,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      ),
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

                                                return ListView.separated(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: imagesview.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(height: 10.0),
                                                  itemBuilder: (context,
                                                      imagesviewIndex) {
                                                    final imagesviewItem =
                                                        imagesview[
                                                            imagesviewIndex];
                                                    return Visibility(
                                                      visible: functions
                                                              .getFileTypeFromUrl(
                                                                  imagesviewItem) ==
                                                          3,
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
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
                                                            await launchURL(
                                                                imagesviewItem);
                                                          },
                                                          child: Icon(
                                                            Icons.audio_file,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryText,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            ),
                                          if (_model.viewimg)
                                            Builder(
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

                                                return ListView.separated(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: imagesview.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(height: 10.0),
                                                  itemBuilder: (context,
                                                      imagesviewIndex) {
                                                    final imagesviewItem =
                                                        imagesview[
                                                            imagesviewIndex];
                                                    return Visibility(
                                                      visible: functions
                                                              .getFileTypeFromUrl(
                                                                  imagesviewItem) ==
                                                          4,
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
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
                                                            await launchURL(
                                                                imagesviewItem);
                                                          },
                                                          child: Icon(
                                                            Icons.image,
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .checkBg,
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
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

                                                return ListView.separated(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 10.0),
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  scrollDirection:
                                                      Axis.vertical,
                                                  itemCount: imagesview.length,
                                                  separatorBuilder: (_, __) =>
                                                      SizedBox(height: 10.0),
                                                  itemBuilder: (context,
                                                      imagesviewIndex) {
                                                    final imagesviewItem =
                                                        imagesview[
                                                            imagesviewIndex];
                                                    return Visibility(
                                                      visible: functions
                                                              .getFileTypeFromUrl(
                                                                  imagesviewItem) ==
                                                          5,
                                                      child: Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
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
                                                            await launchURL(
                                                                imagesviewItem);
                                                          },
                                                          child: FaIcon(
                                                            FontAwesomeIcons
                                                                .solidFilePowerpoint,
                                                            color: Color(
                                                                0xFFEE400C),
                                                            size: 24.0,
                                                          ),
                                                        ),
                                                      ),
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
        ),
      ),
    );
  }
}
