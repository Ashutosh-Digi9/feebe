import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'teacher_edit_delete_model.dart';
export 'teacher_edit_delete_model.dart';

class TeacherEditDeleteWidget extends StatefulWidget {
  const TeacherEditDeleteWidget({super.key});

  @override
  State<TeacherEditDeleteWidget> createState() =>
      _TeacherEditDeleteWidgetState();
}

class _TeacherEditDeleteWidgetState extends State<TeacherEditDeleteWidget> {
  late TeacherEditDeleteModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TeacherEditDeleteModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.15,
      height: MediaQuery.sizeOf(context).height * 0.1,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).lightBg,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.delete_outline,
                color: FlutterFlowTheme.of(context).primaryText,
                size: 20.0,
              ),
              Text(
                'Delete',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      fontSize: 16.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ].divide(const SizedBox(width: 15.0)).around(const SizedBox(width: 15.0)),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
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
        ],
      ),
    );
  }
}
