import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'profilephotoupdatedsuccessfully_model.dart';
export 'profilephotoupdatedsuccessfully_model.dart';

class ProfilephotoupdatedsuccessfullyWidget extends StatefulWidget {
  const ProfilephotoupdatedsuccessfullyWidget({super.key});

  @override
  State<ProfilephotoupdatedsuccessfullyWidget> createState() =>
      _ProfilephotoupdatedsuccessfullyWidgetState();
}

class _ProfilephotoupdatedsuccessfullyWidgetState
    extends State<ProfilephotoupdatedsuccessfullyWidget> {
  late ProfilephotoupdatedsuccessfullyModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfilephotoupdatedsuccessfullyModel());

    // On component load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _model.soundPlayer ??= AudioPlayer();
      if (_model.soundPlayer!.playing) {
        await _model.soundPlayer!.stop();
      }
      _model.soundPlayer!.setVolume(1.0);
      _model.soundPlayer!
          .setAsset('assets/audios/success_bell-6776.wav')
          .then((_) => _model.soundPlayer!.play());

      HapticFeedback.lightImpact();
      await Future.delayed(const Duration(milliseconds: 2000));
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
        color: const Color(0xFFE4EBF8),
        boxShadow: const [
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
            'Profile photo updated successfully',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Nunito',
                  color: FlutterFlowTheme.of(context).text1,
                  fontSize: 16.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Container(
            width: 60.0,
            height: 60.0,
            decoration: const BoxDecoration(
              color: Color(0xFFD7F9CB),
              shape: BoxShape.circle,
            ),
            child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: FlutterFlowIconButton(
                borderRadius: 38.0,
                fillColor: const Color(0xFF4BA22E),
                icon: Icon(
                  Icons.close,
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
