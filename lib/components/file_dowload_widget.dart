import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file_dowload_model.dart';
export 'file_dowload_model.dart';

class FileDowloadWidget extends StatefulWidget {
  const FileDowloadWidget({super.key});

  @override
  State<FileDowloadWidget> createState() => _FileDowloadWidgetState();
}

class _FileDowloadWidgetState extends State<FileDowloadWidget> {
  late FileDowloadModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FileDowloadModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.25,
      height: MediaQuery.sizeOf(context).height * 0.1,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentDirectional(0.0, 0.0),
              child: Stack(
                alignment: AlignmentDirectional(0.0, 0.0),
                children: [
                  Container(
                    width: MediaQuery.sizeOf(context).width * 0.04,
                    height: MediaQuery.sizeOf(context).width * 0.04,
                    decoration: BoxDecoration(
                      color: Color(0xFF4BA22E),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: FlutterFlowTheme.of(context).secondary,
                      size: 20.0,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'File Downloaded Successfully',
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    font: GoogleFonts.nunito(
                      fontWeight: FontWeight.bold,
                      fontStyle:
                          FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                    ),
                    fontSize: 20.0,
                    letterSpacing: 0.0,
                    fontWeight: FontWeight.bold,
                    fontStyle:
                        FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
