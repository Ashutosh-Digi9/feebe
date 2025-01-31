import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/confirmationpages/thenotificationhasbeensuccessfullyremoved/thenotificationhasbeensuccessfullyremoved_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'deletenotification_model.dart';
export 'deletenotification_model.dart';

class DeletenotificationWidget extends StatefulWidget {
  const DeletenotificationWidget({
    super.key,
    this.notiref,
    this.schoolref,
    this.index,
  });

  final DocumentReference? notiref;
  final DocumentReference? schoolref;
  final int? index;

  @override
  State<DeletenotificationWidget> createState() =>
      _DeletenotificationWidgetState();
}

class _DeletenotificationWidgetState extends State<DeletenotificationWidget> {
  late DeletenotificationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DeletenotificationModel());
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
        color: FlutterFlowTheme.of(context).lightblue,
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
                var confirmDialogResponse = await showDialog<bool>(
                      context: context,
                      builder: (alertDialogContext) {
                        return AlertDialog(
                          title: const Text('Confirm Notification Removal'),
                          content: const Text(
                              'Are you sure you want to remove this notification? Once removed, it cannot be restored.'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, true),
                              child: const Text('Confirm'),
                            ),
                          ],
                        );
                      },
                    ) ??
                    false;
                if (confirmDialogResponse) {
                  if (valueOrDefault(currentUserDocument?.userRole, 0) == 2) {
                    await widget.notiref!.update({
                      ...mapToFirestore(
                        {
                          'schoolref':
                              FieldValue.arrayRemove([widget.schoolref]),
                        },
                      ),
                    });
                  } else if (valueOrDefault(currentUserDocument?.userRole, 0) ==
                      1) {
                    await currentUserReference!.update({
                      ...mapToFirestore(
                        {
                          'notifications': FieldValue.arrayRemove([
                            getNotificationFirestoreData(
                              updateNotificationStruct(
                                (currentUserDocument?.notifications.toList() ??
                                        [])
                                    .elementAtOrNull(widget.index!),
                                clearUnsetFields: false,
                              ),
                              true,
                            )
                          ]),
                        },
                      ),
                    });
                  } else {
                    await widget.notiref!.update({
                      ...mapToFirestore(
                        {
                          'userref':
                              FieldValue.arrayRemove([currentUserReference]),
                        },
                      ),
                    });
                  }

                  await showDialog(
                    context: context,
                    builder: (dialogContext) {
                      return Dialog(
                        elevation: 0,
                        insetPadding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        alignment: const AlignmentDirectional(0.0, -0.8)
                            .resolve(Directionality.of(context)),
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.08,
                          width: MediaQuery.sizeOf(context).width * 0.6,
                          child:
                              const ThenotificationhasbeensuccessfullyremovedWidget(),
                        ),
                      );
                    },
                  );

                  context.goNamed(
                    'Dashboard',
                    extra: <String, dynamic>{
                      kTransitionInfoKey: const TransitionInfo(
                        hasTransition: true,
                        transitionType: PageTransitionType.fade,
                      ),
                    },
                  );
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
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
            ),
          ),
        ],
      ),
    );
  }
}
