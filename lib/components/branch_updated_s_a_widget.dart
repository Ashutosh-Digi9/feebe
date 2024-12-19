import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'branch_updated_s_a_model.dart';
export 'branch_updated_s_a_model.dart';

class BranchUpdatedSAWidget extends StatefulWidget {
  const BranchUpdatedSAWidget({super.key});

  @override
  State<BranchUpdatedSAWidget> createState() => _BranchUpdatedSAWidgetState();
}

class _BranchUpdatedSAWidgetState extends State<BranchUpdatedSAWidget> {
  late BranchUpdatedSAModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BranchUpdatedSAModel());

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
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.24,
      height: MediaQuery.sizeOf(context).height * 0.1,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).snackbar,
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
                      color: Color(0xFFD7F9CB),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 45.0,
                    height: 45.0,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4BA22E),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      color: FlutterFlowTheme.of(context).secondaryText,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Branch Updated',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Nunito',
                    color: FlutterFlowTheme.of(context).secondaryBackground,
                    fontSize: 25.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
