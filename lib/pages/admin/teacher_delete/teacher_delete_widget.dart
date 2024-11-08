import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'teacher_delete_model.dart';
export 'teacher_delete_model.dart';

class TeacherDeleteWidget extends StatefulWidget {
  const TeacherDeleteWidget({super.key});

  @override
  State<TeacherDeleteWidget> createState() => _TeacherDeleteWidgetState();
}

class _TeacherDeleteWidgetState extends State<TeacherDeleteWidget> {
  late TeacherDeleteModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TeacherDeleteModel());
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
      height: MediaQuery.sizeOf(context).height * 0.6,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Lottie.asset(
            'assets/jsons/Animation_-_1730978259634.json',
            width: MediaQuery.sizeOf(context).width * 0.3,
            height: MediaQuery.sizeOf(context).height * 0.35,
            fit: BoxFit.contain,
            animate: true,
          ),
          Text(
            'Teacher Account deleted Succesfully',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Nunito',
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    );
  }
}
