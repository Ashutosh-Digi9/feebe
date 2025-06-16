import '/auth/firebase_auth/auth_util.dart';
import '/components/deleteaccount_copy_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'edit_admin_delete_model.dart';
export 'edit_admin_delete_model.dart';

class EditAdminDeleteWidget extends StatefulWidget {
  const EditAdminDeleteWidget({
    super.key,
    required this.schoolref,
    required this.mainschool,
    required this.admin,
  });

  final List<DocumentReference>? schoolref;
  final DocumentReference? mainschool;
  final DocumentReference? admin;

  @override
  State<EditAdminDeleteWidget> createState() => _EditAdminDeleteWidgetState();
}

class _EditAdminDeleteWidgetState extends State<EditAdminDeleteWidget> {
  late EditAdminDeleteModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditAdminDeleteModel());
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
          if (valueOrDefault(currentUserDocument?.userRole, 0) == 1)
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
                            child: DeleteaccountCopyWidget(
                              adminref: widget.admin!,
                              schools: widget.schoolref!,
                              mainsc: widget.mainschool!,
                            ),
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
              context.pushNamed(
                EditAdminCopyWidget.routeName,
                queryParameters: {
                  'mainschoolref': serializeParam(
                    widget.mainschool,
                    ParamType.DocumentReference,
                  ),
                  'adminref': serializeParam(
                    widget.admin,
                    ParamType.DocumentReference,
                  ),
                }.withoutNulls,
              );
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
