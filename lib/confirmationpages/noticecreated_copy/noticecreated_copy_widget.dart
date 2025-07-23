import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:google_fonts/google_fonts.dart';
import 'noticecreated_copy_model.dart';
export 'noticecreated_copy_model.dart';

class NoticecreatedCopyWidget extends StatefulWidget {
  const NoticecreatedCopyWidget({super.key});

  @override
  State<NoticecreatedCopyWidget> createState() =>
      _NoticecreatedCopyWidgetState();
}

class _NoticecreatedCopyWidgetState extends State<NoticecreatedCopyWidget> {
  late NoticecreatedCopyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NoticecreatedCopyModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(
        Duration(
          milliseconds: 2000,
        ),
      );
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
      width: MediaQuery.sizeOf(context).width * 1.0,
      height: MediaQuery.sizeOf(context).height * 1.0,
      decoration: BoxDecoration(
        color: Color(0xFFE4EBF8),
        boxShadow: [
          BoxShadow(
            blurRadius: 12.0,
            color: Color(0x33000000),
            offset: Offset(
              1.0,
              1.0,
            ),
            spreadRadius: 2.0,
          )
        ],
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Notice created successfully ',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  font: GoogleFonts.nunito(
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
                  color: FlutterFlowTheme.of(context).text1,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                ),
          ),
          Container(
            width: 60.0,
            height: 60.0,
            decoration: BoxDecoration(
              color: Color(0xFFD7F9CB),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: EdgeInsets.all(9.0),
              child: FlutterFlowIconButton(
                borderRadius: 38.0,
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
          ),
        ],
      ),
    );
  }
}
