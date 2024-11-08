import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'reject_school_s_a_model.dart';
export 'reject_school_s_a_model.dart';

class RejectSchoolSAWidget extends StatefulWidget {
  const RejectSchoolSAWidget({super.key});

  @override
  State<RejectSchoolSAWidget> createState() => _RejectSchoolSAWidgetState();
}

class _RejectSchoolSAWidgetState extends State<RejectSchoolSAWidget> {
  late RejectSchoolSAModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => RejectSchoolSAModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 1000));
      Navigator.pop(context);
    });
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const AlignmentDirectional(0.0, 1.0),
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.2,
        height: MediaQuery.sizeOf(context).height * 0.1,
        decoration: BoxDecoration(
          color: FlutterFlowTheme.of(context).secondaryBackground,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: const AlignmentDirectional(0.0, 0.0),
                child: Stack(
                  alignment: const AlignmentDirectional(0.0, 0.0),
                  children: [
                    Container(
                      width: 70.0,
                      height: 70.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF4CCCC),
                        shape: BoxShape.circle,
                      ),
                    ),
                    Container(
                      width: 45.0,
                      height: 45.0,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD93333),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close_sharp,
                        color: FlutterFlowTheme.of(context).secondaryText,
                        size: 24.0,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                'School rejected',
                style: FlutterFlowTheme.of(context).bodyMedium.override(
                      fontFamily: 'Nunito',
                      fontSize: 25.0,
                      letterSpacing: 0.0,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
