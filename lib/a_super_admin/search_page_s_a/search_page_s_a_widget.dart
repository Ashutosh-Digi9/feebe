import '/backend/backend.dart';
import '/components/nosearchresults_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/shimmer_effects/main_dashboard_shimmer/main_dashboard_shimmer_widget.dart';
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:text_search/text_search.dart';
import 'search_page_s_a_model.dart';
export 'search_page_s_a_model.dart';

class SearchPageSAWidget extends StatefulWidget {
  const SearchPageSAWidget({super.key});

  @override
  State<SearchPageSAWidget> createState() => _SearchPageSAWidgetState();
}

class _SearchPageSAWidgetState extends State<SearchPageSAWidget>
    with TickerProviderStateMixin {
  late SearchPageSAModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SearchPageSAModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.recentsearchboolschool = true;
      _model.recentsearchadmin = true;
      safeSetState(() {});
    });

    _model.tabBarController = TabController(
      vsync: this,
      length: 2,
      initialIndex: 0,
    )..addListener(() => safeSetState(() {}));
    _model.searchFiledSchoolTextController ??= TextEditingController();
    _model.searchFiledSchoolFocusNode ??= FocusNode();

    _model.serachFiledPrinciTextController ??= TextEditingController();
    _model.serachFiledPrinciFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<SchoolRecord>>(
      stream: querySchoolRecord(),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).newBgcolor,
            body: const MainDashboardShimmerWidget(),
          );
        }
        List<SchoolRecord> searchPageSASchoolRecordList = snapshot.data!;

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
                child: Icon(
                  Icons.chevron_left,
                  color: FlutterFlowTheme.of(context).bgColor1,
                  size: 28.0,
                ),
              ),
              actions: const [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: SingleChildScrollView(
                primary: false,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.95,
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 0.0),
                        child: Column(
                          children: [
                            Align(
                              alignment: const Alignment(0.0, 0),
                              child: FlutterFlowButtonTabBar(
                                useToggleButtonStyle: true,
                                labelStyle: FlutterFlowTheme.of(context)
                                    .titleMedium
                                    .override(
                                      fontFamily: 'Nunito',
                                      fontSize: 14.0,
                                      letterSpacing: 0.0,
                                    ),
                                unselectedLabelStyle:
                                    FlutterFlowTheme.of(context)
                                        .titleMedium
                                        .override(
                                          fontFamily: 'Nunito',
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                        ),
                                labelColor: FlutterFlowTheme.of(context).text1,
                                unselectedLabelColor:
                                    FlutterFlowTheme.of(context).text1,
                                backgroundColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                unselectedBackgroundColor: const Color(0xFFF0F0F0),
                                borderColor: const Color(0xBEF9DDFE),
                                borderWidth: 2.0,
                                borderRadius: 6.0,
                                elevation: 0.0,
                                buttonMargin: const EdgeInsetsDirectional.fromSTEB(
                                    8.0, 0.0, 8.0, 0.0),
                                tabs: const [
                                  Tab(
                                    text: 'Schools',
                                  ),
                                  Tab(
                                    text: 'Admin',
                                  ),
                                ],
                                controller: _model.tabBarController,
                                onTap: (i) async {
                                  [
                                    () async {
                                      _model.pagevariable = 0;
                                      safeSetState(() {});
                                    },
                                    () async {
                                      _model.pagevariable = 1;
                                      safeSetState(() {});
                                    }
                                  ][i]();
                                },
                              ),
                            ),
                            Expanded(
                              child: TabBarView(
                                controller: _model.tabBarController,
                                children: [
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Container(
                                      decoration: const BoxDecoration(),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            if (_model.recentsearchboolschool ==
                                                true)
                                              Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          const AlignmentDirectional(
                                                              -1.0, 0.0),
                                                      child: Text(
                                                        'Recent Searches',
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  10.0,
                                                                  0.0,
                                                                  0.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final recentsearch = FFAppState()
                                                              .recentsearchitem
                                                              .where((e) =>
                                                                  e.type == 0)
                                                              .toList()
                                                              .take(5)
                                                              .toList()
                                                              .sortedList(
                                                                  keyOf: (e) =>
                                                                      e.createddate!,
                                                                  desc: true)
                                                              .toList();

                                                          return ListView
                                                              .builder(
                                                            padding:
                                                                EdgeInsets.zero,
                                                            primary: false,
                                                            shrinkWrap: true,
                                                            scrollDirection:
                                                                Axis.vertical,
                                                            itemCount:
                                                                recentsearch
                                                                    .length,
                                                            itemBuilder: (context,
                                                                recentsearchIndex) {
                                                              final recentsearchItem =
                                                                  recentsearch[
                                                                      recentsearchIndex];
                                                              return Align(
                                                                alignment:
                                                                    const AlignmentDirectional(
                                                                        -1.0,
                                                                        0.0),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                              5.0),
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
                                                                      if (recentsearchItem
                                                                              .type ==
                                                                          0) {
                                                                        if (searchPageSASchoolRecordList.where((e) => e.schoolDetails.schoolName == recentsearchItem.searchterm).toList().firstOrNull?.schoolStatus ==
                                                                            0) {
                                                                          context
                                                                              .pushNamed(
                                                                            'NewSchoolDetails_SA',
                                                                            queryParameters:
                                                                                {
                                                                              'schoolref': serializeParam(
                                                                                searchPageSASchoolRecordList.where((e) => e.schoolDetails.schoolName == recentsearchItem.searchterm).toList().firstOrNull?.reference,
                                                                                ParamType.DocumentReference,
                                                                              ),
                                                                            }.withoutNulls,
                                                                          );
                                                                        } else {
                                                                          context
                                                                              .pushNamed(
                                                                            'ExistingSchoolDetails_SA',
                                                                            queryParameters:
                                                                                {
                                                                              'schoolrefMain': serializeParam(
                                                                                searchPageSASchoolRecordList.where((e) => e.schoolDetails.schoolName == recentsearchItem.searchterm).toList().firstOrNull?.reference,
                                                                                ParamType.DocumentReference,
                                                                              ),
                                                                            }.withoutNulls,
                                                                          );
                                                                        }
                                                                      } else {
                                                                        if (searchPageSASchoolRecordList.where((e) => e.principalDetails.principalName == recentsearchItem.searchterm).toList().firstOrNull?.schoolStatus ==
                                                                            0) {
                                                                          context
                                                                              .pushNamed(
                                                                            'NewSchoolDetails_SA',
                                                                            queryParameters:
                                                                                {
                                                                              'schoolref': serializeParam(
                                                                                searchPageSASchoolRecordList.where((e) => e.principalDetails.principalName == recentsearchItem.searchterm).toList().firstOrNull?.reference,
                                                                                ParamType.DocumentReference,
                                                                              ),
                                                                            }.withoutNulls,
                                                                          );
                                                                        } else {
                                                                          context
                                                                              .pushNamed(
                                                                            'ExistingSchoolDetails_SA',
                                                                            queryParameters:
                                                                                {
                                                                              'schoolrefMain': serializeParam(
                                                                                searchPageSASchoolRecordList.where((e) => e.principalDetails.principalName == recentsearchItem.searchterm).toList().firstOrNull?.reference,
                                                                                ParamType.DocumentReference,
                                                                              ),
                                                                            }.withoutNulls,
                                                                          );
                                                                        }
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      recentsearchItem
                                                                          .searchterm,
                                                                      style: FlutterFlowTheme.of(
                                                                              context)
                                                                          .bodyMedium
                                                                          .override(
                                                                            fontFamily:
                                                                                'Inter',
                                                                            fontSize:
                                                                                16.0,
                                                                            letterSpacing:
                                                                                0.0,
                                                                            fontWeight:
                                                                                FontWeight.normal,
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
                                                  ],
                                                ),
                                              ),
                                            Container(
                                              decoration: const BoxDecoration(),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: TextFormField(
                                                      controller: _model
                                                          .searchFiledSchoolTextController,
                                                      focusNode: _model
                                                          .searchFiledSchoolFocusNode,
                                                      onChanged: (_) =>
                                                          EasyDebounce.debounce(
                                                        '_model.searchFiledSchoolTextController',
                                                        const Duration(
                                                            milliseconds: 2000),
                                                        () async {
                                                          _model.recentsearchboolschool =
                                                              false;
                                                          safeSetState(() {});
                                                          safeSetState(() {
                                                            _model
                                                                .simpleSearchResults1 = TextSearch(searchPageSASchoolRecordList
                                                                    .map((e) => e
                                                                        .schoolDetails
                                                                        .schoolName)
                                                                    .toList()
                                                                    .map((str) =>
                                                                        TextSearchItem.fromTerms(
                                                                            str,
                                                                            [
                                                                              str
                                                                            ]))
                                                                    .toList())
                                                                .search(_model
                                                                    .searchFiledSchoolTextController
                                                                    .text)
                                                                .map((r) =>
                                                                    r.object)
                                                                .toList();
                                                          });
                                                        },
                                                      ),
                                                      autofocus: false,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        labelStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .text1,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        hintText:
                                                            'Search School name...',
                                                        hintStyle:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .labelMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Inter',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .primaryBackground,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .error,
                                                            width: 1.0,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      8.0),
                                                        ),
                                                        filled: true,
                                                        fillColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .tertiary,
                                                        prefixIcon: Icon(
                                                          Icons.search,
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                        ),
                                                      ),
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily: 'Inter',
                                                            color: FlutterFlowTheme
                                                                    .of(context)
                                                                .text1,
                                                            letterSpacing: 0.0,
                                                          ),
                                                      cursorColor:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .primaryText,
                                                      validator: _model
                                                          .searchFiledSchoolTextControllerValidator
                                                          .asValidator(context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (_model.recentsearchboolschool ==
                                                false)
                                              Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 10.0, 0.0, 0.0),
                                                child: Container(
                                                  decoration: const BoxDecoration(),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final school = functions
                                                              .filterSchoolsBySearchResults(
                                                                  _model
                                                                      .simpleSearchResults1
                                                                      .toList(),
                                                                  searchPageSASchoolRecordList
                                                                      .where((e) =>
                                                                          (e.schoolStatus !=
                                                                              1) &&
                                                                          !e.isBranchPresent)
                                                                      .toList())
                                                              ?.toList() ??
                                                          [];
                                                      if (school.isEmpty) {
                                                        return const NosearchresultsWidget();
                                                      }

                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            school.length,
                                                        itemBuilder: (context,
                                                            schoolIndex) {
                                                          final schoolItem =
                                                              school[
                                                                  schoolIndex];
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        10.0,
                                                                        10.0,
                                                                        0.0),
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
                                                                FFAppState()
                                                                    .addToRecentsearchitem(
                                                                        SearchitemsStruct(
                                                                  searchterm: schoolItem
                                                                      .schoolDetails
                                                                      .schoolName,
                                                                  createddate:
                                                                      getCurrentTimestamp,
                                                                  type: 0,
                                                                ));
                                                                safeSetState(
                                                                    () {});
                                                                if (schoolItem
                                                                        .schoolStatus ==
                                                                    0) {
                                                                  context
                                                                      .pushNamed(
                                                                    'NewSchoolDetails_SA',
                                                                    queryParameters:
                                                                        {
                                                                      'schoolref':
                                                                          serializeParam(
                                                                        schoolItem
                                                                            .reference,
                                                                        ParamType
                                                                            .DocumentReference,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );
                                                                } else {
                                                                  context
                                                                      .pushNamed(
                                                                    'ExistingSchoolDetails_SA',
                                                                    queryParameters:
                                                                        {
                                                                      'schoolrefMain':
                                                                          serializeParam(
                                                                        schoolItem
                                                                            .reference,
                                                                        ParamType
                                                                            .DocumentReference,
                                                                      ),
                                                                    }.withoutNulls,
                                                                  );
                                                                }

                                                                if (FFAppState()
                                                                        .recentsearchitem
                                                                        .length >
                                                                    5) {
                                                                  FFAppState()
                                                                      .removeAtIndexFromRecentsearchitem(
                                                                          0);
                                                                  safeSetState(
                                                                      () {});
                                                                }
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              16.0),
                                                                  border: Border
                                                                      .all(
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                              10.0),
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Align(
                                                                        alignment: const AlignmentDirectional(
                                                                            0.0,
                                                                            -1.0),
                                                                        child:
                                                                            Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              0.0,
                                                                              15.0,
                                                                              0.0,
                                                                              0.0),
                                                                          child:
                                                                              ClipRRect(
                                                                            borderRadius:
                                                                                BorderRadius.circular(8.0),
                                                                            child:
                                                                                Image.network(
                                                                              valueOrDefault<String>(
                                                                                schoolItem.schoolDetails.schoolImage,
                                                                                'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fhappy-children-back-school-background_23-2147852164.jpg?alt=media&token=e1069716-5656-42e7-a945-ff9fe1565ec6',
                                                                              ),
                                                                              width: MediaQuery.sizeOf(context).width * 0.15,
                                                                              height: MediaQuery.sizeOf(context).height * 0.06,
                                                                              fit: BoxFit.contain,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            0.0,
                                                                            5.0,
                                                                            0.0,
                                                                            5.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Container(
                                                                              width: MediaQuery.sizeOf(context).width * 0.7,
                                                                              decoration: const BoxDecoration(),
                                                                              child: Text(
                                                                                schoolItem.schoolDetails.schoolName,
                                                                                style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                      fontFamily: 'Nunito',
                                                                                      color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                      fontSize: 16.0,
                                                                                      letterSpacing: 0.0,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                              ),
                                                                            ),
                                                                            Text(
                                                                              schoolItem.principalDetails.phoneNumber,
                                                                              style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                    fontFamily: 'Nunito',
                                                                                    color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                    letterSpacing: 0.0,
                                                                                    fontWeight: FontWeight.w500,
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
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(
                                        0.0, 10.0, 0.0, 0.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        if (_model.recentsearchadmin == true)
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.max,
                                              children: [
                                                Align(
                                                  alignment:
                                                      const AlignmentDirectional(
                                                          -1.0, 0.0),
                                                  child: Text(
                                                    'Recent Searches',
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
                                                          letterSpacing: 0.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                  child: Builder(
                                                    builder: (context) {
                                                      final recentsearch =
                                                          FFAppState()
                                                              .recentsearchitem
                                                              .where((e) =>
                                                                  e.type == 1)
                                                              .toList()
                                                              .take(5)
                                                              .toList()
                                                              .sortedList(
                                                                  keyOf: (e) =>
                                                                      e.createddate!,
                                                                  desc: true)
                                                              .toList();

                                                      return ListView.builder(
                                                        padding:
                                                            EdgeInsets.zero,
                                                        primary: false,
                                                        shrinkWrap: true,
                                                        scrollDirection:
                                                            Axis.vertical,
                                                        itemCount:
                                                            recentsearch.length,
                                                        itemBuilder: (context,
                                                            recentsearchIndex) {
                                                          final recentsearchItem =
                                                              recentsearch[
                                                                  recentsearchIndex];
                                                          return Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    -1.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(5.0),
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
                                                                onTap:
                                                                    () async {
                                                                  if (recentsearchItem
                                                                          .type ==
                                                                      0) {
                                                                    if (searchPageSASchoolRecordList
                                                                            .where((e) =>
                                                                                e.schoolDetails.schoolName ==
                                                                                recentsearchItem.searchterm)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.schoolStatus ==
                                                                        0) {
                                                                      context
                                                                          .pushNamed(
                                                                        'NewSchoolDetails_SA',
                                                                        queryParameters:
                                                                            {
                                                                          'schoolref':
                                                                              serializeParam(
                                                                            searchPageSASchoolRecordList.where((e) => e.schoolDetails.schoolName == recentsearchItem.searchterm).toList().firstOrNull?.reference,
                                                                            ParamType.DocumentReference,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    } else {
                                                                      context
                                                                          .pushNamed(
                                                                        'ExistingSchoolDetails_SA',
                                                                        queryParameters:
                                                                            {
                                                                          'schoolrefMain':
                                                                              serializeParam(
                                                                            searchPageSASchoolRecordList.where((e) => e.schoolDetails.schoolName == recentsearchItem.searchterm).toList().firstOrNull?.reference,
                                                                            ParamType.DocumentReference,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    }
                                                                  } else {
                                                                    if (searchPageSASchoolRecordList
                                                                            .where((e) =>
                                                                                e.principalDetails.principalName ==
                                                                                recentsearchItem.searchterm)
                                                                            .toList()
                                                                            .firstOrNull
                                                                            ?.schoolStatus ==
                                                                        0) {
                                                                      context
                                                                          .pushNamed(
                                                                        'NewSchoolDetails_SA',
                                                                        queryParameters:
                                                                            {
                                                                          'schoolref':
                                                                              serializeParam(
                                                                            searchPageSASchoolRecordList.where((e) => e.principalDetails.principalName == recentsearchItem.searchterm).toList().firstOrNull?.reference,
                                                                            ParamType.DocumentReference,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    } else {
                                                                      context
                                                                          .pushNamed(
                                                                        'ExistingSchoolDetails_SA',
                                                                        queryParameters:
                                                                            {
                                                                          'schoolrefMain':
                                                                              serializeParam(
                                                                            searchPageSASchoolRecordList.where((e) => e.principalDetails.principalName == recentsearchItem.searchterm).toList().firstOrNull?.reference,
                                                                            ParamType.DocumentReference,
                                                                          ),
                                                                        }.withoutNulls,
                                                                      );
                                                                    }
                                                                  }
                                                                },
                                                                child: Text(
                                                                  recentsearchItem
                                                                      .searchterm,
                                                                  style: FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyMedium
                                                                      .override(
                                                                        fontFamily:
                                                                            'Inter',
                                                                        fontSize:
                                                                            16.0,
                                                                        letterSpacing:
                                                                            0.0,
                                                                        fontWeight:
                                                                            FontWeight.w500,
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
                                              ],
                                            ),
                                          ),
                                        Container(
                                          decoration: const BoxDecoration(),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Expanded(
                                                child: TextFormField(
                                                  controller: _model
                                                      .serachFiledPrinciTextController,
                                                  focusNode: _model
                                                      .serachFiledPrinciFocusNode,
                                                  onChanged: (_) =>
                                                      EasyDebounce.debounce(
                                                    '_model.serachFiledPrinciTextController',
                                                    const Duration(
                                                        milliseconds: 2000),
                                                    () async {
                                                      _model.recentsearchadmin =
                                                          false;
                                                      safeSetState(() {});
                                                      safeSetState(() {
                                                        _model
                                                            .simpleSearchResults2 = TextSearch(
                                                                searchPageSASchoolRecordList
                                                                    .map((e) => e
                                                                        .principalDetails
                                                                        .principalName)
                                                                    .toList()
                                                                    .map((str) =>
                                                                        TextSearchItem.fromTerms(
                                                                            str,
                                                                            [
                                                                              str
                                                                            ]))
                                                                    .toList())
                                                            .search(_model
                                                                .serachFiledPrinciTextController
                                                                .text)
                                                            .map(
                                                                (r) => r.object)
                                                            .toList();
                                                      });
                                                    },
                                                  ),
                                                  autofocus: false,
                                                  obscureText: false,
                                                  decoration: InputDecoration(
                                                    isDense: true,
                                                    labelStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .primaryText,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    hintText:
                                                        ' Search Admin\'s  name..',
                                                    hintStyle: FlutterFlowTheme
                                                            .of(context)
                                                        .labelMedium
                                                        .override(
                                                          fontFamily: 'Inter',
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .alternate,
                                                          letterSpacing: 0.0,
                                                        ),
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color: FlutterFlowTheme
                                                                .of(context)
                                                            .primaryBackground,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                        color:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .error,
                                                        width: 1.0,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    filled: true,
                                                    fillColor: FlutterFlowTheme
                                                            .of(context)
                                                        .secondaryBackground,
                                                    prefixIcon: Icon(
                                                      Icons.search,
                                                      color:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .alternate,
                                                    ),
                                                  ),
                                                  style: FlutterFlowTheme.of(
                                                          context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Inter',
                                                        letterSpacing: 0.0,
                                                      ),
                                                  cursorColor:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .primaryText,
                                                  validator: _model
                                                      .serachFiledPrinciTextControllerValidator
                                                      .asValidator(context),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        if (_model.recentsearchadmin == false)
                                          Padding(
                                            padding:
                                                const EdgeInsetsDirectional.fromSTEB(
                                                    0.0, 10.0, 0.0, 0.0),
                                            child: Container(
                                              decoration: const BoxDecoration(),
                                            ),
                                          ),
                                        Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Builder(
                                            builder: (context) {
                                              final princi = functions
                                                      .filterprinciserachresults(
                                                          _model
                                                              .simpleSearchResults2
                                                              .toList(),
                                                          searchPageSASchoolRecordList
                                                              .where((e) =>
                                                                  e.schoolStatus !=
                                                                  1)
                                                              .toList())
                                                      ?.toList() ??
                                                  [];
                                              if (princi.isEmpty) {
                                                return const NosearchresultsWidget();
                                              }

                                              return GridView.builder(
                                                padding: EdgeInsets.zero,
                                                gridDelegate:
                                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  crossAxisSpacing: 10.0,
                                                  mainAxisSpacing: 10.0,
                                                  childAspectRatio: 1.0,
                                                ),
                                                shrinkWrap: true,
                                                scrollDirection: Axis.vertical,
                                                itemCount: princi.length,
                                                itemBuilder:
                                                    (context, princiIndex) {
                                                  final princiItem =
                                                      princi[princiIndex];
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
                                                      FFAppState()
                                                          .addToRecentsearchitem(
                                                              SearchitemsStruct(
                                                        searchterm: princiItem
                                                            .principalDetails
                                                            .principalName,
                                                        createddate:
                                                            getCurrentTimestamp,
                                                        type: 1,
                                                      ));
                                                      safeSetState(() {});
                                                      if (princiItem
                                                              .schoolStatus ==
                                                          0) {
                                                        context.pushNamed(
                                                          'NewSchoolDetails_SA',
                                                          queryParameters: {
                                                            'schoolref':
                                                                serializeParam(
                                                              princiItem
                                                                  .reference,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                          }.withoutNulls,
                                                        );
                                                      } else {
                                                        context.pushNamed(
                                                          'ExistingSchoolDetails_SA',
                                                          queryParameters: {
                                                            'schoolrefMain':
                                                                serializeParam(
                                                              princiItem
                                                                  .reference,
                                                              ParamType
                                                                  .DocumentReference,
                                                            ),
                                                          }.withoutNulls,
                                                        );
                                                      }

                                                      if (FFAppState()
                                                              .recentsearchitem
                                                              .length >
                                                          5) {
                                                        FFAppState()
                                                            .removeAtIndexFromRecentsearchitem(
                                                                0);
                                                        safeSetState(() {});
                                                      }
                                                    },
                                                    child: Container(
                                                      decoration:
                                                          const BoxDecoration(),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Container(
                                                              width: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.16,
                                                              height: MediaQuery
                                                                          .sizeOf(
                                                                              context)
                                                                      .width *
                                                                  0.16,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .tertiaryText,
                                                                shape: BoxShape
                                                                    .circle,
                                                              ),
                                                              child: Container(
                                                                clipBehavior: Clip
                                                                    .antiAlias,
                                                                decoration:
                                                                    const BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                ),
                                                                child: Image
                                                                    .network(
                                                                  valueOrDefault<
                                                                      String>(
                                                                    princiItem
                                                                        .principalDetails
                                                                        .principalImage,
                                                                    'https://firebasestorage.googleapis.com/v0/b/feebee-8578d.firebasestorage.app/o/defaultImages%2Fflat-style-woman-avatar_90220-2876.jpg?alt=media&token=2c9154f7-595d-40d6-87fd-c0be9eb08d5a',
                                                                  ),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                const AlignmentDirectional(
                                                                    0.0, 0.0),
                                                            child: Text(
                                                              princiItem
                                                                  .principalDetails
                                                                  .principalName,
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily:
                                                                        'Nunito',
                                                                    color: FlutterFlowTheme.of(
                                                                            context)
                                                                        .primaryBackground,
                                                                    fontSize:
                                                                        14.0,
                                                                    letterSpacing:
                                                                        0.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
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
