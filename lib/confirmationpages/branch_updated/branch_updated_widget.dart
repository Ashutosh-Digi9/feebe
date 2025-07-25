import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'branch_updated_model.dart';
export 'branch_updated_model.dart';

class BranchUpdatedWidget extends StatefulWidget {
  const BranchUpdatedWidget({
    super.key,
    required this.schoolref,
    required this.mainschoolref,
  });

  final DocumentReference? schoolref;
  final DocumentReference? mainschoolref;

  static String routeName = 'BranchUpdated';
  static String routePath = '/branchUpdated';

  @override
  State<BranchUpdatedWidget> createState() => _BranchUpdatedWidgetState();
}

class _BranchUpdatedWidgetState extends State<BranchUpdatedWidget> {
  late BranchUpdatedModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BranchUpdatedModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
        Duration(
          milliseconds: 2000,
        ),
      );

      context.goNamed(
        ExistingSchoolDetailsSAWidget.routeName,
        queryParameters: {
          'schoolrefMain': serializeParam(
            widget.mainschoolref,
            ParamType.DocumentReference,
          ),
        }.withoutNulls,
        extra: <String, dynamic>{
          kTransitionInfoKey: TransitionInfo(
            hasTransition: true,
            transitionType: PageTransitionType.fade,
          ),
        },
      );
    });
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
        backgroundColor: FlutterFlowTheme.of(context).secondary,
        appBar: responsiveVisibility(
          context: context,
          tablet: false,
          tabletLandscape: false,
          desktop: false,
        )
            ? AppBar(
                backgroundColor: FlutterFlowTheme.of(context).info,
                automaticallyImplyLeading: false,
                actions: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                    child: InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () async {
                        context.goNamed(
                          ExistingSchoolDetailsSAWidget.routeName,
                          queryParameters: {
                            'schoolrefMain': serializeParam(
                              widget.mainschoolref,
                              ParamType.DocumentReference,
                            ),
                          }.withoutNulls,
                          extra: <String, dynamic>{
                            kTransitionInfoKey: TransitionInfo(
                              hasTransition: true,
                              transitionType: PageTransitionType.fade,
                            ),
                          },
                        );
                      },
                      child: Icon(
                        Icons.close,
                        color: FlutterFlowTheme.of(context).primaryText,
                        size: 30.0,
                      ),
                    ),
                  ),
                ],
                centerTitle: true,
                elevation: 0.0,
              )
            : null,
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: AlignmentDirectional(0.0, -1.0),
                child: Container(
                  width: MediaQuery.sizeOf(context).width * 0.2,
                  height: MediaQuery.sizeOf(context).width * 0.2,
                  decoration: BoxDecoration(
                    color: Color(0xFFD7F9CB),
                    shape: BoxShape.circle,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(9.0),
                        child: FlutterFlowIconButton(
                          borderRadius: 38.0,
                          buttonSize: MediaQuery.sizeOf(context).width * 0.12,
                          fillColor: Color(0xFF4BA22E),
                          icon: Icon(
                            Icons.done,
                            color: FlutterFlowTheme.of(context).info,
                            size: 25.0,
                          ),
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                'Branch Updated',
                textAlign: TextAlign.center,
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      font: GoogleFonts.nunito(
                        fontWeight: FontWeight.bold,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                      fontSize: 30.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
