import '/components/deleteclasss_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'editclass_model.dart';
export 'editclass_model.dart';

class EditclassWidget extends StatefulWidget {
  const EditclassWidget({
    super.key,
    required this.schoolRef,
    required this.classref,
  });

  final DocumentReference? schoolRef;
  final DocumentReference? classref;

  @override
  State<EditclassWidget> createState() => _EditclassWidgetState();
}

class _EditclassWidgetState extends State<EditclassWidget> {
  late EditclassModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => EditclassModel());
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
        children: [
          Builder(
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
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        child: DeleteclasssWidget(
                          schoolref: widget.schoolRef!,
                          classref: widget.classref!,
                        ),
                      ),
                    );
                  },
                );

                Navigator.pop(context);
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
                    'Delete',
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
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ].divide(SizedBox(width: 15.0)).around(SizedBox(width: 15.0)),
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
                EditclassadminWidget.routeName,
                queryParameters: {
                  'schoolclassref': serializeParam(
                    widget.classref,
                    ParamType.DocumentReference,
                  ),
                  'schoolref': serializeParam(
                    widget.schoolRef,
                    ParamType.DocumentReference,
                  ),
                }.withoutNulls,
              );

              Navigator.pop(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.edit,
                  color: FlutterFlowTheme.of(context).tertiaryText,
                  size: 20.0,
                ),
                Text(
                  'Edit',
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
