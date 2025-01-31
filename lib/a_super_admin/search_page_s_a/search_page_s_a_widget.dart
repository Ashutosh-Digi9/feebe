import '/backend/backend.dart';
import '/components/nosearchresults_copy_widget.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_expanded_image_view.dart';
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
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 10.0),
                      child: SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.95,
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(
                              8.0, 0.0, 8.0, 10.0),
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
                                  labelColor:
                                      FlutterFlowTheme.of(context).text1,
                                  unselectedLabelColor:
                                      FlutterFlowTheme.of(context).text1,
                                  backgroundColor: FlutterFlowTheme.of(context)
                                      .secondaryBackground,
                                  unselectedBackgroundColor: const Color(0xFFF0F0F0),
                                  borderColor: const Color(0xFFF0F0F0),
                                  borderWidth: 2.0,
                                  borderRadius: 8.0,
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
                                              if (_model
                                                      .recentsearchboolschool ==
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
                                                        child: InkWell(
                                                          splashColor: Colors
                                                              .transparent,
                                                          focusColor: Colors
                                                              .transparent,
                                                          hoverColor: Colors
                                                              .transparent,
                                                          highlightColor: Colors
                                                              .transparent,
                                                          onTap: () async {},
                                                          child: Text(
                                                            'Recent Searches',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .alternate,
                                                                  letterSpacing:
                                                                      0.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
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
                                                                  EdgeInsets
                                                                      .zero,
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
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
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
                                                                        if (recentsearchItem.type ==
                                                                            0) {
                                                                          if (searchPageSASchoolRecordList.where((e) => e.schoolDetails.schoolName == recentsearchItem.searchterm).toList().firstOrNull?.schoolStatus ==
                                                                              0) {
                                                                            context.pushNamed(
                                                                              'NewSchoolDetails_SA',
                                                                              queryParameters: {
                                                                                'schoolref': serializeParam(
                                                                                  searchPageSASchoolRecordList.where((e) => e.schoolDetails.schoolName == recentsearchItem.searchterm).toList().firstOrNull?.reference,
                                                                                  ParamType.DocumentReference,
                                                                                ),
                                                                              }.withoutNulls,
                                                                            );
                                                                          } else {
                                                                            context.pushNamed(
                                                                              'ExistingSchoolDetails_SA',
                                                                              queryParameters: {
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
                                                                            context.pushNamed(
                                                                              'NewSchoolDetails_SA',
                                                                              queryParameters: {
                                                                                'schoolref': serializeParam(
                                                                                  searchPageSASchoolRecordList.where((e) => e.principalDetails.principalName == recentsearchItem.searchterm).toList().firstOrNull?.reference,
                                                                                  ParamType.DocumentReference,
                                                                                ),
                                                                              }.withoutNulls,
                                                                            );
                                                                          } else {
                                                                            context.pushNamed(
                                                                              'ExistingSchoolDetails_SA',
                                                                              queryParameters: {
                                                                                'schoolrefMain': serializeParam(
                                                                                  searchPageSASchoolRecordList.where((e) => e.principalDetails.principalName == recentsearchItem.searchterm).toList().firstOrNull?.reference,
                                                                                  ParamType.DocumentReference,
                                                                                ),
                                                                              }.withoutNulls,
                                                                            );
                                                                          }
                                                                        }
                                                                      },
                                                                      child:
                                                                          Text(
                                                                        recentsearchItem
                                                                            .searchterm,
                                                                        style: FlutterFlowTheme.of(context)
                                                                            .bodyMedium
                                                                            .override(
                                                                              fontFamily: 'Nunito',
                                                                              fontSize: 16.0,
                                                                              letterSpacing: 0.0,
                                                                              fontWeight: FontWeight.normal,
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
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    Expanded(
                                                      child: TextFormField(
                                                        controller: _model
                                                            .searchFiledSchoolTextController,
                                                        focusNode: _model
                                                            .searchFiledSchoolFocusNode,
                                                        onChanged: (_) =>
                                                            EasyDebounce
                                                                .debounce(
                                                          '_model.searchFiledSchoolTextController',
                                                          const Duration(
                                                              milliseconds:
                                                                  2000),
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
                                                                        'Nunito',
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
                                                                        'Nunito',
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
                                                                  .dIsable,
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
                                                          suffixIcon: _model
                                                                  .searchFiledSchoolTextController!
                                                                  .text
                                                                  .isNotEmpty
                                                              ? InkWell(
                                                                  onTap:
                                                                      () async {
                                                                    _model
                                                                        .searchFiledSchoolTextController
                                                                        ?.clear();
                                                                    _model.recentsearchboolschool =
                                                                        false;
                                                                    safeSetState(
                                                                        () {});
                                                                    safeSetState(
                                                                        () {
                                                                      _model
                                                                          .simpleSearchResults1 = TextSearch(searchPageSASchoolRecordList
                                                                              .map((e) => e
                                                                                  .schoolDetails.schoolName)
                                                                              .toList()
                                                                              .map((str) => TextSearchItem.fromTerms(str, [
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
                                                                    safeSetState(
                                                                        () {});
                                                                  },
                                                                  child: const Icon(
                                                                    Icons.clear,
                                                                    size: 22,
                                                                  ),
                                                                )
                                                              : null,
                                                        ),
                                                        style:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily:
                                                                      'Nunito',
                                                                  color: FlutterFlowTheme.of(
                                                                          context)
                                                                      .text1,
                                                                  letterSpacing:
                                                                      0.0,
                                                                ),
                                                        cursorColor:
                                                            FlutterFlowTheme.of(
                                                                    context)
                                                                .primaryText,
                                                        validator: _model
                                                            .searchFiledSchoolTextControllerValidator
                                                            .asValidator(
                                                                context),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (_model
                                                      .recentsearchboolschool ==
                                                  false)
                                                Padding(
                                                  padding: const EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 10.0, 0.0, 0.0),
                                                  child: Container(
                                                    decoration: const BoxDecoration(),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  0.0,
                                                                  10.0),
                                                      child: Builder(
                                                        builder: (context) {
                                                          final school = functions
                                                                  .filterSchoolsBySearchResults(
                                                                      _model
                                                                          .simpleSearchResults1
                                                                          .toList(),
                                                                      searchPageSASchoolRecordList
                                                                          .where((e) =>
                                                                              e.schoolStatus !=
                                                                              1)
                                                                          .toList())
                                                                  ?.toList() ??
                                                              [];
                                                          if (school.isEmpty) {
                                                            return const Center(
                                                              child:
                                                                  NosearchresultsCopyWidget(),
                                                            );
                                                          }

                                                          return ListView
                                                              .builder(
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
                                                                padding: const EdgeInsetsDirectional
                                                                    .fromSTEB(
                                                                        10.0,
                                                                        10.0,
                                                                        10.0,
                                                                        0.0),
                                                                child: InkWell(
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
                                                                            schoolItem.reference,
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
                                                                            schoolItem.isBranchPresent
                                                                                ? searchPageSASchoolRecordList.where((e) => (e.principalDetails.principalId == schoolItem.principalDetails.principalId) && (e.isBranchPresent == false)).toList().firstOrNull?.reference
                                                                                : schoolItem.reference,
                                                                            ParamType.DocumentReference,
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
                                                                  child:
                                                                      Material(
                                                                    color: Colors
                                                                        .transparent,
                                                                    elevation:
                                                                        5.0,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                    ),
                                                                    child:
                                                                        Container(
                                                                      height: MediaQuery.sizeOf(context)
                                                                              .height *
                                                                          0.12,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: FlutterFlowTheme.of(context)
                                                                            .secondary,
                                                                        boxShadow: const [
                                                                          BoxShadow(
                                                                            blurRadius:
                                                                                4.0,
                                                                            color:
                                                                                Color(0x33000000),
                                                                            offset:
                                                                                Offset(
                                                                              2.0,
                                                                              2.0,
                                                                            ),
                                                                            spreadRadius:
                                                                                1.0,
                                                                          )
                                                                        ],
                                                                        borderRadius:
                                                                            BorderRadius.circular(8.0),
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding: const EdgeInsetsDirectional.fromSTEB(
                                                                            20.0,
                                                                            0.0,
                                                                            10.0,
                                                                            0.0),
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.max,
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.start,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children:
                                                                              [
                                                                            Align(
                                                                              alignment: const AlignmentDirectional(0.0, 0.0),
                                                                              child: Container(
                                                                                width: 60.0,
                                                                                height: 60.0,
                                                                                decoration: const BoxDecoration(
                                                                                  shape: BoxShape.circle,
                                                                                ),
                                                                                child: InkWell(
                                                                                  splashColor: Colors.transparent,
                                                                                  focusColor: Colors.transparent,
                                                                                  hoverColor: Colors.transparent,
                                                                                  highlightColor: Colors.transparent,
                                                                                  onLongPress: () async {
                                                                                    await Navigator.push(
                                                                                      context,
                                                                                      PageTransition(
                                                                                        type: PageTransitionType.fade,
                                                                                        child: FlutterFlowExpandedImageView(
                                                                                          image: Image.network(
                                                                                            valueOrDefault<String>(
                                                                                              schoolItem.schoolDetails.schoolImage,
                                                                                              'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                                                                            ),
                                                                                            fit: BoxFit.contain,
                                                                                          ),
                                                                                          allowRotation: false,
                                                                                          tag: valueOrDefault<String>(
                                                                                            schoolItem.schoolDetails.schoolImage,
                                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png' '$schoolIndex',
                                                                                          ),
                                                                                          useHeroAnimation: true,
                                                                                        ),
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                  child: Hero(
                                                                                    tag: valueOrDefault<String>(
                                                                                      schoolItem.schoolDetails.schoolImage,
                                                                                      'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png' '$schoolIndex',
                                                                                    ),
                                                                                    transitionOnUserGestures: true,
                                                                                    child: ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(30.0),
                                                                                      child: Image.network(
                                                                                        valueOrDefault<String>(
                                                                                          schoolItem.schoolDetails.schoolImage,
                                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/08ulzcf8ggxf/Frame_731_(1).png',
                                                                                        ),
                                                                                        width: 200.0,
                                                                                        height: 200.0,
                                                                                        fit: BoxFit.cover,
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsetsDirectional.fromSTEB(10.0, 5.0, 0.0, 5.0),
                                                                              child: Column(
                                                                                mainAxisSize: MainAxisSize.max,
                                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                                children: [
                                                                                  Align(
                                                                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                    child: Text(
                                                                                      schoolItem.schoolDetails.schoolName.maybeHandleOverflow(
                                                                                        maxChars: 30,
                                                                                        replacement: '…',
                                                                                      ),
                                                                                      textAlign: TextAlign.start,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                    child: Text(
                                                                                      schoolItem.schoolDetails.city,
                                                                                      textAlign: TextAlign.start,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            color: FlutterFlowTheme.of(context).primaryBackground,
                                                                                            fontSize: 16.0,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.w600,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                  Align(
                                                                                    alignment: const AlignmentDirectional(-1.0, 0.0),
                                                                                    child: Text(
                                                                                      schoolItem.principalDetails.phoneNumber,
                                                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                                                            fontFamily: 'Nunito',
                                                                                            color: FlutterFlowTheme.of(context).tertiaryText,
                                                                                            letterSpacing: 0.0,
                                                                                            fontWeight: FontWeight.normal,
                                                                                          ),
                                                                                    ),
                                                                                  ),
                                                                                ].divide(const SizedBox(height: 4.0)),
                                                                              ),
                                                                            ),
                                                                          ].divide(const SizedBox(width: 10.0)),
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
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0.0, 10.0, 0.0, 10.0),
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
                                                      style: FlutterFlowTheme
                                                              .of(context)
                                                          .bodyMedium
                                                          .override(
                                                            fontFamily:
                                                                'Nunito',
                                                            letterSpacing: 0.0,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(0.0, 10.0,
                                                                0.0, 0.0),
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
                                                                child: InkWell(
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
                                                                    if (recentsearchItem
                                                                            .type ==
                                                                        0) {
                                                                      if (searchPageSASchoolRecordList
                                                                              .where((e) => e.schoolDetails.schoolName == recentsearchItem.searchterm)
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
                                                                              .where((e) => e.principalDetails.principalName == recentsearchItem.searchterm)
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
                                                                              'Nunito',
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
                                                              .simpleSearchResults2 = TextSearch(searchPageSASchoolRecordList
                                                                  .map((e) => e
                                                                      .principalDetails
                                                                      .principalName)
                                                                  .toList()
                                                                  .map((str) =>
                                                                      TextSearchItem.fromTerms(
                                                                          str, [
                                                                        str
                                                                      ]))
                                                                  .toList())
                                                              .search(_model
                                                                  .serachFiledPrinciTextController
                                                                  .text)
                                                              .map((r) =>
                                                                  r.object)
                                                              .toList();
                                                        });
                                                      },
                                                    ),
                                                    autofocus: false,
                                                    obscureText: false,
                                                    decoration: InputDecoration(
                                                      isDense: true,
                                                      labelStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .primaryText,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                      hintText:
                                                          ' Search Admin\'s Name..',
                                                      hintStyle:
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .labelMedium
                                                              .override(
                                                                fontFamily:
                                                                    'Nunito',
                                                                color: FlutterFlowTheme.of(
                                                                        context)
                                                                    .alternate,
                                                                letterSpacing:
                                                                    0.0,
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
                                                            BorderRadius
                                                                .circular(8.0),
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
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      errorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                      ),
                                                      focusedErrorBorder:
                                                          OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: FlutterFlowTheme
                                                                  .of(context)
                                                              .error,
                                                          width: 1.0,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
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
                                                      suffixIcon: _model
                                                              .serachFiledPrinciTextController!
                                                              .text
                                                              .isNotEmpty
                                                          ? InkWell(
                                                              onTap: () async {
                                                                _model
                                                                    .serachFiledPrinciTextController
                                                                    ?.clear();
                                                                _model.recentsearchadmin =
                                                                    false;
                                                                safeSetState(
                                                                    () {});
                                                                safeSetState(
                                                                    () {
                                                                  _model
                                                                      .simpleSearchResults2 = TextSearch(searchPageSASchoolRecordList
                                                                          .map((e) => e
                                                                              .principalDetails
                                                                              .principalName)
                                                                          .toList()
                                                                          .map((str) =>
                                                                              TextSearchItem.fromTerms(str, [
                                                                                str
                                                                              ]))
                                                                          .toList())
                                                                      .search(_model
                                                                          .serachFiledPrinciTextController
                                                                          .text)
                                                                      .map((r) =>
                                                                          r.object)
                                                                      .toList();
                                                                });
                                                                safeSetState(
                                                                    () {});
                                                              },
                                                              child: const Icon(
                                                                Icons.clear,
                                                                size: 22,
                                                              ),
                                                            )
                                                          : null,
                                                    ),
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyMedium
                                                        .override(
                                                          fontFamily: 'Nunito',
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
                                              padding: const EdgeInsetsDirectional
                                                  .fromSTEB(
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
                                                                    (e.schoolStatus !=
                                                                        1) &&
                                                                    !e.isBranchPresent)
                                                                .toList())
                                                        ?.toList() ??
                                                    [];
                                                if (princi.isEmpty) {
                                                  return SizedBox(
                                                    width: MediaQuery.sizeOf(
                                                                context)
                                                            .width *
                                                        1.0,
                                                    child:
                                                        const NosearchresultsCopyWidget(),
                                                  );
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
                                                  scrollDirection:
                                                      Axis.vertical,
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
                                                            Container(
                                                              width: 60.0,
                                                              height: 60.0,
                                                              decoration:
                                                                  const BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
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
                                                                onTap:
                                                                    () async {
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
                                                                  safeSetState(
                                                                      () {});
                                                                  if (princiItem
                                                                          .schoolStatus ==
                                                                      0) {
                                                                    context
                                                                        .pushNamed(
                                                                      'NewSchoolDetails_SA',
                                                                      queryParameters:
                                                                          {
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
                                                                    context
                                                                        .pushNamed(
                                                                      'ExistingSchoolDetails_SA',
                                                                      queryParameters:
                                                                          {
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
                                                                    safeSetState(
                                                                        () {});
                                                                  }
                                                                },
                                                                onLongPress:
                                                                    () async {
                                                                  await Navigator
                                                                      .push(
                                                                    context,
                                                                    PageTransition(
                                                                      type: PageTransitionType
                                                                          .fade,
                                                                      child:
                                                                          FlutterFlowExpandedImageView(
                                                                        image: Image
                                                                            .network(
                                                                          valueOrDefault<
                                                                              String>(
                                                                            princiItem.principalDetails.principalImage,
                                                                            'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                                          ),
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                        allowRotation:
                                                                            false,
                                                                        tag: valueOrDefault<
                                                                            String>(
                                                                          princiItem
                                                                              .principalDetails
                                                                              .principalImage,
                                                                          'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png' '$princiIndex',
                                                                        ),
                                                                        useHeroAnimation:
                                                                            true,
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                                child: Hero(
                                                                  tag: valueOrDefault<
                                                                      String>(
                                                                    princiItem
                                                                        .principalDetails
                                                                        .principalImage,
                                                                    'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png' '$princiIndex',
                                                                  ),
                                                                  transitionOnUserGestures:
                                                                      true,
                                                                  child:
                                                                      ClipRRect(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0),
                                                                    child: Image
                                                                        .network(
                                                                      valueOrDefault<
                                                                          String>(
                                                                        princiItem
                                                                            .principalDetails
                                                                            .principalImage,
                                                                        'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/3paoalf0j3o6/Add_profile_pic_(5).png',
                                                                      ),
                                                                      width:
                                                                          200.0,
                                                                      height:
                                                                          200.0,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    ),
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
                                                                style: FlutterFlowTheme.of(
                                                                        context)
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
