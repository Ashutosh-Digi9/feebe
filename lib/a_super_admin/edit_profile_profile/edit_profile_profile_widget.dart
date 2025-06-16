import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/deleteaccount_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_profile_profile_model.dart';
export 'edit_profile_profile_model.dart';

class EditProfileProfileWidget extends StatefulWidget {
  const EditProfileProfileWidget({
    super.key,
    this.studentsref,
    this.prents,
    this.adddress,
    bool? gur,
  }) : this.gur = gur ?? false;

  final List<DocumentReference>? studentsref;
  final List<ParentsDetailsStruct>? prents;
  final String? adddress;
  final bool gur;

  @override
  State<EditProfileProfileWidget> createState() =>
      _EditProfileProfileWidgetState();
}

class _EditProfileProfileWidgetState extends State<EditProfileProfileWidget> {
  late EditProfileProfileModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditProfileProfileModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: Color(0xFFE9F0FD),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (valueOrDefault(currentUserDocument?.userRole, 0) == 6)
            Builder(
              builder: (context) => AuthUserStreamWidget(
                builder: (context) => InkWell(
                  splashColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  hoverColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: AlignmentDirectional(0.0, 0.0)
                              .resolve(Directionality.of(context)),
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.25,
                            width: MediaQuery.sizeOf(context).width * 0.55,
                            child: DeleteaccountWidget(),
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        FFIcons.ktrashEmpty,
                        color: FlutterFlowTheme.of(context).tertiaryText,
                        size: 20.0,
                      ),
                      Text(
                        'Delete ',
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              font: GoogleFonts.nunito(
                                fontWeight: FontWeight.normal,
                                fontStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .fontStyle,
                              ),
                              color: FlutterFlowTheme.of(context).primaryText,
                              fontSize: 16.0,
                              letterSpacing: 0.0,
                              fontWeight: FontWeight.normal,
                              fontStyle: FlutterFlowTheme.of(context)
                                  .bodyMedium
                                  .fontStyle,
                            ),
                      ),
                    ]
                        .divide(SizedBox(width: 15.0))
                        .around(SizedBox(width: 15.0)),
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
              Navigator.pop(context);
              if (valueOrDefault(currentUserDocument?.userRole, 0) == 4) {
                _model.student = await StudentsRecord.getDocumentOnce(
                    widget.studentsref!.firstOrNull!);
                if (widget.gur) {
                  context.pushNamed(
                    EditParentWidget.routeName,
                    queryParameters: {
                      'studentref': serializeParam(
                        widget.studentsref,
                        ParamType.DocumentReference,
                        isList: true,
                      ),
                      'parent': serializeParam(
                        _model.student?.parentsDetails
                            .where((e) => e.userRef == currentUserReference)
                            .toList()
                            .firstOrNull,
                        ParamType.DataStruct,
                      ),
                      'parentdetails': serializeParam(
                        widget.prents,
                        ParamType.DataStruct,
                        isList: true,
                      ),
                      'address': serializeParam(
                        widget.adddress,
                        ParamType.String,
                      ),
                    }.withoutNulls,
                  );
                } else {
                  if (Navigator.of(context).canPop()) {
                    context.pop();
                  }
                  context.pushNamed(
                    EditParentCopyWidget.routeName,
                    queryParameters: {
                      'studentref': serializeParam(
                        widget.studentsref,
                        ParamType.DocumentReference,
                        isList: true,
                      ),
                      'parent': serializeParam(
                        _model.student?.parentsDetails
                            .where((e) => e.userRef == currentUserReference)
                            .toList()
                            .firstOrNull,
                        ParamType.DataStruct,
                      ),
                      'parentdetails': serializeParam(
                        widget.prents,
                        ParamType.DataStruct,
                        isList: true,
                      ),
                      'address': serializeParam(
                        widget.adddress,
                        ParamType.String,
                      ),
                    }.withoutNulls,
                    extra: <String, dynamic>{
                      kTransitionInfoKey: TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                      ),
                    },
                  );
                }
              } else {
                context.pushNamed(
                  EditProfileSAWidget.routeName,
                  extra: <String, dynamic>{
                    kTransitionInfoKey: TransitionInfo(
                      hasTransition: true,
                      transitionType: PageTransitionType.fade,
                    ),
                  },
                );
              }

              safeSetState(() {});
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.edit_sharp,
                  color: FlutterFlowTheme.of(context).tertiaryText,
                  size: 20.0,
                ),
                Text(
                  'Edit ',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        font: GoogleFonts.nunito(
                          fontWeight: FontWeight.normal,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                        color: FlutterFlowTheme.of(context).primaryText,
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.normal,
                        fontStyle:
                            FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                      ),
                ),
              ].divide(SizedBox(width: 15.0)).around(SizedBox(width: 15.0)),
            ),
          ),
        ],
      ),
    );
  }
}
