import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/custom_code/widgets/index.dart' as custom_widgets;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calender_class_model.dart';
export 'calender_class_model.dart';

class CalenderClassWidget extends StatefulWidget {
  const CalenderClassWidget({
    super.key,
    required this.schoolclassref,
    this.schoolref,
    bool? mainpage,
    bool? studentpage,
  })  : this.mainpage = mainpage ?? false,
        this.studentpage = studentpage ?? false;

  final DocumentReference? schoolclassref;
  final DocumentReference? schoolref;
  final bool mainpage;
  final bool studentpage;

  static String routeName = 'calender_class';
  static String routePath = '/calenderClass';

  @override
  State<CalenderClassWidget> createState() => _CalenderClassWidgetState();
}

class _CalenderClassWidgetState extends State<CalenderClassWidget> {
  late CalenderClassModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CalenderClassModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SchoolClassRecord>(
      stream: SchoolClassRecord.getDocument(widget.schoolclassref!)
        ..listen((calenderClassSchoolClassRecord) async {
          if (_model.calenderClassPreviousSnapshot != null &&
              !SchoolClassRecordDocumentEquality().equals(
                  calenderClassSchoolClassRecord,
                  _model.calenderClassPreviousSnapshot)) {}
          _model.calenderClassPreviousSnapshot = calenderClassSchoolClassRecord;
        }),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).tertiary,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }

        final calenderClassSchoolClassRecord = snapshot.data!;

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
                        color: FlutterFlowTheme.of(context).bgColor1,
                        size: 28.0,
                      ),
                      onPressed: () async {
                        if (widget.mainpage == true) {
                          if (valueOrDefault(
                                  currentUserDocument?.userRole, 0) ==
                              3) {
                            context.pushNamed(DashboardWidget.routeName);
                          } else {
                            context.pushNamed(
                              ClassDashboardWidget.routeName,
                              queryParameters: {
                                'schoolref': serializeParam(
                                  widget.schoolref,
                                  ParamType.DocumentReference,
                                ),
                              }.withoutNulls,
                            );
                          }
                        } else {
                          if (widget.studentpage == true) {
                            context.safePop();
                          } else {
                            context.pushNamed(
                              ClassViewWidget.routeName,
                              queryParameters: {
                                'schoolclassref': serializeParam(
                                  calenderClassSchoolClassRecord.reference,
                                  ParamType.DocumentReference,
                                ),
                                'schoolref': serializeParam(
                                  widget.schoolref,
                                  ParamType.DocumentReference,
                                ),
                                'datePick': serializeParam(
                                  getCurrentTimestamp,
                                  ParamType.DateTime,
                                ),
                              }.withoutNulls,
                            );
                          }
                        }
                      },
                    ),
                    title: Text(
                      calenderClassSchoolClassRecord.className,
                      style:
                          FlutterFlowTheme.of(context).headlineMedium.override(
                                font: GoogleFonts.nunito(
                                  fontWeight: FontWeight.w600,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .headlineMedium
                                      .fontStyle,
                                ),
                                color: FlutterFlowTheme.of(context).primaryText,
                                fontSize: 16.0,
                                letterSpacing: 0.0,
                                fontWeight: FontWeight.w600,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .headlineMedium
                                    .fontStyle,
                              ),
                    ),
                    actions: [],
                    centerTitle: false,
                    elevation: 0.0,
                  )
                : null,
            body: SafeArea(
              top: true,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5.0, 0.0, 5.0, 0.0),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(0.0, 10.0, 0.0, 0.0),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width * 1.0,
                          height: MediaQuery.sizeOf(context).height * 1.0,
                          child: custom_widgets.TimelinewidgetdatatypeClass(
                            width: MediaQuery.sizeOf(context).width * 1.0,
                            height: MediaQuery.sizeOf(context).height * 1.0,
                            timrlinewidget:
                                calenderClassSchoolClassRecord.calendar,
                            schoolclassref: widget.schoolclassref!,
                            classname: calenderClassSchoolClassRecord.className,
                          ),
                        ),
                      ),
                    ],
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
