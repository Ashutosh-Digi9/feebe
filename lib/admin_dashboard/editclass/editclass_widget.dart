import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
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
        color: const Color(0xFFE9F0FD),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            onTap: () async {
              context.pushNamed(
                'editclassadmin',
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
                  color: FlutterFlowTheme.of(context).primaryText,
                  size: 20.0,
                ),
                Text(
                  'Edit',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Nunito',
                        fontSize: 16.0,
                        letterSpacing: 0.0,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ].divide(const SizedBox(width: 15.0)).around(const SizedBox(width: 15.0)),
            ),
          ),
        ],
      ),
    );
  }
}
