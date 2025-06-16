import '/backend/backend.dart';
import '/components/empty_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/shimmer_effects/notifications_shimmer/notifications_shimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notice_parent_model.dart';
export 'notice_parent_model.dart';

class NoticeParentWidget extends StatefulWidget {
  const NoticeParentWidget({
    super.key,
    required this.clasref,
    required this.studentref,
  });

  final DocumentReference? clasref;
  final DocumentReference? studentref;

  static String routeName = 'notice_parent';
  static String routePath = '/noticeParent';

  @override
  State<NoticeParentWidget> createState() => _NoticeParentWidgetState();
}

class _NoticeParentWidgetState extends State<NoticeParentWidget>
    with TickerProviderStateMixin {
  late NoticeParentModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoticeParentModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.dateClass = getCurrentTimestamp;
      _model.dateSchool = getCurrentTimestamp;
      safeSetState(() {});
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
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
                leading: FlutterFlowIconButton(
                  borderColor: Colors.transparent,
                  borderRadius: 8.0,
                  buttonSize: MediaQuery.sizeOf(context).width * 0.16,
                  icon: Icon(
                    Icons.chevron_left,
                    color: FlutterFlowTheme.of(context).bgColor1,
                    size: 28.0,
                  ),
                  onPressed: () async {
                    context.pushNamed(
                      DashboardWidget.routeName,
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                        ),
                      },
                    );
                  },
                ),
                title: Align(
                  alignment: AlignmentDirectional(-1.0, 0.0),
                  child: Text(
                    'Notice',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ),
                actions: [],
                centerTitle: true,
                elevation: 0.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Column(
            children: [
              Align(
                alignment: Alignment(0.0, 0),
                child: TabBar(
                  labelColor: FlutterFlowTheme.of(context).primaryText,
                  unselectedLabelColor: FlutterFlowTheme.of(context).text,
                  labelStyle: FlutterFlowTheme.of(context).titleMedium.override(
                        font: GoogleFonts.nunito(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                  unselectedLabelStyle: FlutterFlowTheme.of(context)
                      .titleMedium
                      .override(
                        font: GoogleFonts.nunito(
                          fontWeight: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontWeight,
                          fontStyle: FlutterFlowTheme.of(context)
                              .titleMedium
                              .fontStyle,
                        ),
                        letterSpacing: 0.0,
                        fontWeight:
                            FlutterFlowTheme.of(context).titleMedium.fontWeight,
                        fontStyle:
                            FlutterFlowTheme.of(context).titleMedium.fontStyle,
                      ),
                  indicatorColor: FlutterFlowTheme.of(context).primary,
                  tabs: [
                    Tab(
                      text: 'Class Notice',
                    ),
                    Tab(
                      text: 'School Notice',
                    ),
                  ],
                  controller: _model.tabBarController,
                  onTap: (i) async {
                    [() async {}, () async {}][i]();
                  },
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _model.tabBarController,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.7,
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.dateClass =
                                                functions.getAdjacentMonthDate(
                                                    false, _model.dateClass!);
                                            safeSetState(() {});
                                          },
                                          child: Icon(
                                            Icons.chevron_left,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 30.0,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 0.0),
                                          child: Text(
                                            dateTimeFormat(
                                                "MMM/yy", _model.dateClass),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.nunito(
                                                    fontWeight: FontWeight.w500,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(1.0, 1.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.dateClass = functions
                                                  .getAdjacentMonthDate(
                                                      true, _model.dateClass!);
                                              safeSetState(() {});
                                            },
                                            child: Icon(
                                              Icons.navigate_next_sharp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 30.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 1.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      final _datePicked1Date =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: getCurrentTimestamp,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2050),
                                        builder: (context, child) {
                                          return wrapInMaterialDatePickerTheme(
                                            context,
                                            child!,
                                            headerBackgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            headerForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            headerTextStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineLarge
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .fontStyle,
                                                      ),
                                                      fontSize: 32.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .fontStyle,
                                                    ),
                                            pickerBackgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            pickerForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            selectedDateTimeBackgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            selectedDateTimeForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            actionButtonForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            iconSize: 24.0,
                                          );
                                        },
                                      );

                                      if (_datePicked1Date != null) {
                                        safeSetState(() {
                                          _model.datePicked1 = DateTime(
                                            _datePicked1Date.year,
                                            _datePicked1Date.month,
                                            _datePicked1Date.day,
                                          );
                                        });
                                      } else if (_model.datePicked1 != null) {
                                        safeSetState(() {
                                          _model.datePicked1 =
                                              getCurrentTimestamp;
                                        });
                                      }
                                      if (_model.datePicked1 != null) {
                                        _model.dateClass = _model.datePicked1;
                                        safeSetState(() {});
                                      } else {
                                        _model.dateClass = getCurrentTimestamp;
                                        safeSetState(() {});
                                      }
                                    },
                                    child: Icon(
                                      Icons.calendar_today,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: StreamBuilder<SchoolClassRecord>(
                              stream: SchoolClassRecord.getDocument(
                                  widget.clasref!),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return NotificationsShimmerWidget();
                                }

                                final listViewSchoolClassRecord =
                                    snapshot.data!;

                                return Builder(
                                  builder: (context) {
                                    final notice = listViewSchoolClassRecord
                                        .notice
                                        .sortedList(
                                            keyOf: (e) => e.eventDate!,
                                            desc: true)
                                        .where((e) =>
                                            dateTimeFormat(
                                                "MMM/yy", e.eventDate) ==
                                            dateTimeFormat(
                                                "MMM/yy", _model.dateClass))
                                        .toList();
                                    if (notice.isEmpty) {
                                      return EmptyWidget();
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: notice.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 10.0),
                                      itemBuilder: (context, noticeIndex) {
                                        final noticeItem = notice[noticeIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 8.0, 8.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                NoticeDetailsWidget.routeName,
                                                queryParameters: {
                                                  'eventDetails':
                                                      serializeParam(
                                                    noticeItem,
                                                    ParamType.DataStruct,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 5.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    0.0,
                                                                    2.0),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Column(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .max,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Padding(
                                                                  padding: EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          0.0,
                                                                          5.0),
                                                                  child:
                                                                      Container(
                                                                    width: MediaQuery.sizeOf(context)
                                                                            .width *
                                                                        0.4,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .secondaryBackground,
                                                                    ),
                                                                    child: Text(
                                                                      noticeItem
                                                                          .eventTitle,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.nunito(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Opacity(
                                                                  opacity: 0.9,
                                                                  child: Text(
                                                                    dateTimeFormat(
                                                                        "dd MMM , y",
                                                                        noticeItem
                                                                            .eventDate!),
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.normal,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          color:
                                                                              FlutterFlowTheme.of(context).tertiaryText,
                                                                          fontSize:
                                                                              14.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.normal,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  () {
                                                                    if (noticeItem
                                                                            .eventName ==
                                                                        'Homework') {
                                                                      return FlutterFlowTheme.of(
                                                                              context)
                                                                          .homework;
                                                                    } else if (noticeItem
                                                                            .eventName ==
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
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .text,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3.59),
                                                                border:
                                                                    Border.all(
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    () {
                                                                      if (noticeItem
                                                                              .eventName ==
                                                                          'Homework') {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .homeworkborder;
                                                                      } else if (noticeItem
                                                                              .eventName ==
                                                                          'Reminder') {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .reminderborder;
                                                                      } else {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .generalBorder;
                                                                      }
                                                                    }(),
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .text,
                                                                  ),
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    if (noticeItem
                                                                            .eventName ==
                                                                        'General')
                                                                      Image
                                                                          .asset(
                                                                        'assets/images/9e73b2e5203026ba49a296de36e434f3.png',
                                                                        width:
                                                                            15.5,
                                                                        height:
                                                                            15.5,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    if (noticeItem
                                                                            .eventName ==
                                                                        'Reminder')
                                                                      Image
                                                                          .asset(
                                                                        'assets/images/3d-alarm.png',
                                                                        width:
                                                                            15.5,
                                                                        height:
                                                                            15.5,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    if (noticeItem
                                                                            .eventName ==
                                                                        'Homework')
                                                                      Image
                                                                          .asset(
                                                                        'assets/images/d291c399c6895698b0bb48476409d42e.png',
                                                                        width:
                                                                            15.5,
                                                                        height:
                                                                            15.5,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    Text(
                                                                      noticeItem
                                                                          .eventName,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.nunito(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ]
                                                                      .divide(SizedBox(
                                                                          width:
                                                                              5.0))
                                                                      .around(SizedBox(
                                                                          width:
                                                                              5.0)),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width *
                                                                0.8,
                                                        decoration:
                                                            BoxDecoration(),
                                                        child: Text(
                                                          noticeItem
                                                              .eventDescription,
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyMedium
                                                              .override(
                                                                font:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .normal,
                                                                  fontStyle: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .fontStyle,
                                                                ),
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                                fontStyle: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .fontStyle,
                                                              ),
                                                        ),
                                                      ),
                                                      if (noticeItem.eventfiles
                                                          .isNotEmpty)
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      10.0),
                                                          child: Container(
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.12,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  if (noticeItem
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              1)
                                                                          .toList()
                                                                          .length !=
                                                                      0)
                                                                    badges
                                                                        .Badge(
                                                                      badgeContent:
                                                                          Text(
                                                                        noticeItem
                                                                            .eventfiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                1)
                                                                            .toList()
                                                                            .length
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
                                                                          'assets/images/download.png',
                                                                          width:
                                                                              46.0,
                                                                          height:
                                                                              41.0,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (noticeItem
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              2)
                                                                          .toList()
                                                                          .length !=
                                                                      0)
                                                                    badges
                                                                        .Badge(
                                                                      badgeContent:
                                                                          Text(
                                                                        noticeItem
                                                                            .eventfiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                2)
                                                                            .toList()
                                                                            .length
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.nunito(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondary,
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
                                                                          0.0,
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
                                                                          'assets/images/download_(1).png',
                                                                          width:
                                                                              46.0,
                                                                          height:
                                                                              41.0,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (noticeItem
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              3)
                                                                          .toList()
                                                                          .length !=
                                                                      0)
                                                                    badges
                                                                        .Badge(
                                                                      badgeContent:
                                                                          Text(
                                                                        noticeItem
                                                                            .eventfiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                3)
                                                                            .toList()
                                                                            .length
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.nunito(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondary,
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
                                                                          0.0,
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
                                                                          'assets/images/download_(2).png',
                                                                          width:
                                                                              46.0,
                                                                          height:
                                                                              41.0,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (noticeItem
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              4)
                                                                          .toList()
                                                                          .length !=
                                                                      0)
                                                                    badges
                                                                        .Badge(
                                                                      badgeContent:
                                                                          Text(
                                                                        noticeItem
                                                                            .eventfiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                4)
                                                                            .toList()
                                                                            .length
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.nunito(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondary,
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
                                                                          0.0,
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
                                                                          'assets/images/clarity_image-gallery-line.png',
                                                                          width:
                                                                              46.0,
                                                                          height:
                                                                              41.0,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (noticeItem
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              5)
                                                                          .toList()
                                                                          .length !=
                                                                      0)
                                                                    badges
                                                                        .Badge(
                                                                      badgeContent:
                                                                          Text(
                                                                        noticeItem
                                                                            .eventfiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                5)
                                                                            .toList()
                                                                            .length
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.nunito(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondary,
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
                                                                          0.0,
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
                                                                          'assets/images/download-removebg-preview.png',
                                                                          width:
                                                                              46.0,
                                                                          height:
                                                                              41.0,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ]
                                                                    .divide(SizedBox(
                                                                        width:
                                                                            18.0))
                                                                    .around(SizedBox(
                                                                        width:
                                                                            18.0)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ]
                                                        .divide(SizedBox(
                                                            height: 5.0))
                                                        .addToEnd(SizedBox(
                                                            height: 20.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 20.0, 0.0, 10.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Container(
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.7,
                                    decoration: BoxDecoration(),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          splashColor: Colors.transparent,
                                          focusColor: Colors.transparent,
                                          hoverColor: Colors.transparent,
                                          highlightColor: Colors.transparent,
                                          onTap: () async {
                                            _model.dateSchool =
                                                functions.getAdjacentMonthDate(
                                                    false, _model.dateSchool!);
                                            safeSetState(() {});
                                          },
                                          child: Icon(
                                            Icons.chevron_left,
                                            color: FlutterFlowTheme.of(context)
                                                .primaryText,
                                            size: 30.0,
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  10.0, 0.0, 10.0, 0.0),
                                          child: Text(
                                            dateTimeFormat(
                                                "MMM/yy", _model.dateSchool),
                                            style: FlutterFlowTheme.of(context)
                                                .bodyMedium
                                                .override(
                                                  font: GoogleFonts.nunito(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle:
                                                        FlutterFlowTheme.of(
                                                                context)
                                                            .bodyMedium
                                                            .fontStyle,
                                                  ),
                                                  fontSize: 20.0,
                                                  letterSpacing: 0.0,
                                                  fontWeight: FontWeight.w600,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                          ),
                                        ),
                                        Align(
                                          alignment:
                                              AlignmentDirectional(1.0, 1.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              _model.dateSchool = functions
                                                  .getAdjacentMonthDate(
                                                      true, _model.dateSchool!);
                                              safeSetState(() {});
                                            },
                                            child: Icon(
                                              Icons.navigate_next_sharp,
                                              color:
                                                  FlutterFlowTheme.of(context)
                                                      .primaryText,
                                              size: 30.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(1.0, 1.0),
                                  child: InkWell(
                                    splashColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    hoverColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () async {
                                      final _datePicked2Date =
                                          await showDatePicker(
                                        context: context,
                                        initialDate: getCurrentTimestamp,
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2050),
                                        builder: (context, child) {
                                          return wrapInMaterialDatePickerTheme(
                                            context,
                                            child!,
                                            headerBackgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            headerForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            headerTextStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineLarge
                                                    .override(
                                                      font: GoogleFonts.nunito(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .headlineLarge
                                                                .fontStyle,
                                                      ),
                                                      fontSize: 32.0,
                                                      letterSpacing: 0.0,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .headlineLarge
                                                              .fontStyle,
                                                    ),
                                            pickerBackgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .secondaryBackground,
                                            pickerForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            selectedDateTimeBackgroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                            selectedDateTimeForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .info,
                                            actionButtonForegroundColor:
                                                FlutterFlowTheme.of(context)
                                                    .primaryText,
                                            iconSize: 24.0,
                                          );
                                        },
                                      );

                                      if (_datePicked2Date != null) {
                                        safeSetState(() {
                                          _model.datePicked2 = DateTime(
                                            _datePicked2Date.year,
                                            _datePicked2Date.month,
                                            _datePicked2Date.day,
                                          );
                                        });
                                      } else if (_model.datePicked2 != null) {
                                        safeSetState(() {
                                          _model.datePicked2 =
                                              getCurrentTimestamp;
                                        });
                                      }
                                      if (_model.datePicked2 != null) {
                                        _model.dateSchool = _model.datePicked2;
                                        safeSetState(() {});
                                      } else {
                                        _model.dateSchool = getCurrentTimestamp;
                                        safeSetState(() {});
                                      }
                                    },
                                    child: Icon(
                                      Icons.calendar_today,
                                      color:
                                          FlutterFlowTheme.of(context).primary,
                                      size: 24.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10.0),
                            child: StreamBuilder<List<SchoolRecord>>(
                              stream: querySchoolRecord(
                                queryBuilder: (schoolRecord) =>
                                    schoolRecord.where(
                                  'List_of_students',
                                  arrayContains: widget.studentref,
                                ),
                                singleRecord: true,
                              ),
                              builder: (context, snapshot) {
                                // Customize what your widget looks like when it's loading.
                                if (!snapshot.hasData) {
                                  return NotificationsShimmerWidget();
                                }
                                List<SchoolRecord> listViewSchoolRecordList =
                                    snapshot.data!;
                                if (listViewSchoolRecordList.isEmpty) {
                                  return EmptyWidget();
                                }
                                final listViewSchoolRecord =
                                    listViewSchoolRecordList.isNotEmpty
                                        ? listViewSchoolRecordList.first
                                        : null;

                                return Builder(
                                  builder: (context) {
                                    final notice = listViewSchoolRecord
                                            ?.listOfNotice
                                            .sortedList(
                                                keyOf: (e) => e.eventDate!,
                                                desc: true)
                                            .where((e) =>
                                                dateTimeFormat(
                                                    "MMM/yy", e.eventDate) ==
                                                dateTimeFormat("MMM/yy",
                                                    _model.dateSchool))
                                            .toList()
                                            .toList() ??
                                        [];
                                    if (notice.isEmpty) {
                                      return EmptyWidget();
                                    }

                                    return ListView.separated(
                                      padding: EdgeInsets.zero,
                                      primary: false,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemCount: notice.length,
                                      separatorBuilder: (_, __) =>
                                          SizedBox(height: 10.0),
                                      itemBuilder: (context, noticeIndex) {
                                        final noticeItem = notice[noticeIndex];
                                        return Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  8.0, 0.0, 8.0, 8.0),
                                          child: InkWell(
                                            splashColor: Colors.transparent,
                                            focusColor: Colors.transparent,
                                            hoverColor: Colors.transparent,
                                            highlightColor: Colors.transparent,
                                            onTap: () async {
                                              context.pushNamed(
                                                NoticeDetailsWidget.routeName,
                                                queryParameters: {
                                                  'eventDetails':
                                                      serializeParam(
                                                    noticeItem,
                                                    ParamType.DataStruct,
                                                  ),
                                                }.withoutNulls,
                                              );
                                            },
                                            child: Material(
                                              color: Colors.transparent,
                                              elevation: 5.0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                              ),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                          context)
                                                      .secondaryBackground,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                            0.0,
                                                                            0.0,
                                                                            0.0,
                                                                            5.0),
                                                                child:
                                                                    Container(
                                                                  width: MediaQuery.sizeOf(
                                                                              context)
                                                                          .width *
                                                                      0.4,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .secondaryBackground,
                                                                  ),
                                                                  child: Text(
                                                                    noticeItem
                                                                        .eventTitle,
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .override(
                                                                          font:
                                                                              GoogleFonts.nunito(
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                          fontSize:
                                                                              16.0,
                                                                          letterSpacing:
                                                                              0.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          fontStyle: FlutterFlowTheme.of(context)
                                                                              .bodyMedium
                                                                              .fontStyle,
                                                                        ),
                                                                  ),
                                                                ),
                                                              ),
                                                              Text(
                                                                dateTimeFormat(
                                                                    "dd MMM y",
                                                                    noticeItem
                                                                        .eventDate!),
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      font: GoogleFonts
                                                                          .nunito(
                                                                        fontWeight:
                                                                            FontWeight.normal,
                                                                        fontStyle: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .fontStyle,
                                                                      ),
                                                                      color: FlutterFlowTheme.of(
                                                                              context)
                                                                          .tertiaryText,
                                                                      fontSize:
                                                                          14.0,
                                                                      letterSpacing:
                                                                          0.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                              ),
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        0.0,
                                                                        0.0,
                                                                        10.0,
                                                                        0.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    valueOrDefault<
                                                                        Color>(
                                                                  () {
                                                                    if (noticeItem
                                                                            .eventName ==
                                                                        'Homework') {
                                                                      return FlutterFlowTheme.of(
                                                                              context)
                                                                          .homework;
                                                                    } else if (noticeItem
                                                                            .eventName ==
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
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .text,
                                                                ),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            3.59),
                                                                border:
                                                                    Border.all(
                                                                  color:
                                                                      valueOrDefault<
                                                                          Color>(
                                                                    () {
                                                                      if (noticeItem
                                                                              .eventName ==
                                                                          'Homework') {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .homeworkborder;
                                                                      } else if (noticeItem
                                                                              .eventName ==
                                                                          'Reminder') {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .reminderborder;
                                                                      } else {
                                                                        return FlutterFlowTheme.of(context)
                                                                            .generalBorder;
                                                                      }
                                                                    }(),
                                                                    FlutterFlowTheme.of(
                                                                            context)
                                                                        .text,
                                                                  ),
                                                                  width: 1.0,
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            5.0),
                                                                child: Row(
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .max,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    if (noticeItem
                                                                            .eventName ==
                                                                        'General')
                                                                      Image
                                                                          .asset(
                                                                        'assets/images/9e73b2e5203026ba49a296de36e434f3.png',
                                                                        width:
                                                                            15.5,
                                                                        height:
                                                                            15.5,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    if (noticeItem
                                                                            .eventName ==
                                                                        'Reminder')
                                                                      Image
                                                                          .asset(
                                                                        'assets/images/3d-alarm.png',
                                                                        width:
                                                                            15.5,
                                                                        height:
                                                                            15.5,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                    if (noticeItem
                                                                            .eventName ==
                                                                        'Homework')
                                                                      Image
                                                                          .asset(
                                                                        'assets/images/d291c399c6895698b0bb48476409d42e.png',
                                                                        width:
                                                                            15.5,
                                                                        height:
                                                                            15.5,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      ),
                                                                    Text(
                                                                      noticeItem
                                                                          .eventName,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            font:
                                                                                GoogleFonts.nunito(
                                                                              fontWeight: FontWeight.w500,
                                                                              fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                            ),
                                                                            color:
                                                                                FlutterFlowTheme.of(context).primaryText,
                                                                            fontSize:
                                                                                14.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            fontStyle:
                                                                                FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                                                                          ),
                                                                    ),
                                                                  ]
                                                                      .divide(SizedBox(
                                                                          width:
                                                                              5.0))
                                                                      .around(SizedBox(
                                                                          width:
                                                                              5.0)),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                -1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      10.0),
                                                          child: Container(
                                                            width: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .width *
                                                                0.8,
                                                            decoration:
                                                                BoxDecoration(),
                                                            child: Text(
                                                              noticeItem
                                                                  .eventDescription,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    font: GoogleFonts
                                                                        .nunito(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .normal,
                                                                      fontStyle: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .fontStyle,
                                                                    ),
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .tertiaryText,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal,
                                                                    fontStyle: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyMedium
                                                                        .fontStyle,
                                                                  ),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      if (noticeItem.eventfiles
                                                          .isNotEmpty)
                                                        Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      0.0,
                                                                      5.0),
                                                          child: Container(
                                                            height: MediaQuery
                                                                        .sizeOf(
                                                                            context)
                                                                    .height *
                                                                0.12,
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          10.0,
                                                                          0.0,
                                                                          0.0),
                                                              child: Row(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  if (noticeItem
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              1)
                                                                          .toList()
                                                                          .length !=
                                                                      0)
                                                                    badges
                                                                        .Badge(
                                                                      badgeContent:
                                                                          Text(
                                                                        noticeItem
                                                                            .eventfiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                1)
                                                                            .toList()
                                                                            .length
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
                                                                          'assets/images/download.png',
                                                                          width:
                                                                              46.0,
                                                                          height:
                                                                              41.0,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (noticeItem
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              2)
                                                                          .toList()
                                                                          .length !=
                                                                      0)
                                                                    badges
                                                                        .Badge(
                                                                      badgeContent:
                                                                          Text(
                                                                        noticeItem
                                                                            .eventfiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                2)
                                                                            .toList()
                                                                            .length
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.nunito(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondary,
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
                                                                          0.0,
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
                                                                          'assets/images/download_(1).png',
                                                                          width:
                                                                              46.0,
                                                                          height:
                                                                              41.0,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (noticeItem
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              3)
                                                                          .toList()
                                                                          .length !=
                                                                      0)
                                                                    badges
                                                                        .Badge(
                                                                      badgeContent:
                                                                          Text(
                                                                        noticeItem
                                                                            .eventfiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                3)
                                                                            .toList()
                                                                            .length
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.nunito(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondary,
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
                                                                          0.0,
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
                                                                          'assets/images/download_(2).png',
                                                                          width:
                                                                              46.0,
                                                                          height:
                                                                              41.0,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (noticeItem
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              4)
                                                                          .toList()
                                                                          .length !=
                                                                      0)
                                                                    badges
                                                                        .Badge(
                                                                      badgeContent:
                                                                          Text(
                                                                        noticeItem
                                                                            .eventfiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                4)
                                                                            .toList()
                                                                            .length
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.nunito(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondary,
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
                                                                          0.0,
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
                                                                          'assets/images/clarity_image-gallery-line.png',
                                                                          width:
                                                                              46.0,
                                                                          height:
                                                                              41.0,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  if (noticeItem
                                                                          .eventfiles
                                                                          .where((e) =>
                                                                              functions.getFileTypeFromUrl(e) ==
                                                                              5)
                                                                          .toList()
                                                                          .length !=
                                                                      0)
                                                                    badges
                                                                        .Badge(
                                                                      badgeContent:
                                                                          Text(
                                                                        noticeItem
                                                                            .eventfiles
                                                                            .where((e) =>
                                                                                functions.getFileTypeFromUrl(e) ==
                                                                                5)
                                                                            .toList()
                                                                            .length
                                                                            .toString(),
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .titleSmall
                                                                            .override(
                                                                              font: GoogleFonts.nunito(
                                                                                fontWeight: FontWeight.normal,
                                                                                fontStyle: FlutterFlowTheme.of(context).titleSmall.fontStyle,
                                                                              ),
                                                                              color: FlutterFlowTheme.of(context).secondary,
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
                                                                          0.0,
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
                                                                          'assets/images/download-removebg-preview.png',
                                                                          width:
                                                                              46.0,
                                                                          height:
                                                                              41.0,
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                ]
                                                                    .divide(SizedBox(
                                                                        width:
                                                                            18.0))
                                                                    .around(SizedBox(
                                                                        width:
                                                                            18.0)),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                    ]
                                                        .divide(SizedBox(
                                                            height: 5.0))
                                                        .addToEnd(SizedBox(
                                                            height: 20.0)),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ],
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
