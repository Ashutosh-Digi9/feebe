import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/confirmationpages/thenotificationhasbeensuccessfullyremoved/thenotificationhasbeensuccessfullyremoved_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
                          title: Text('Confirm Notification Removal'),
                          content: Text(
                              'Are you sure you want to remove this notification? Once removed, it cannot be restored.'),
                          actions: [
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, false),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pop(alertDialogContext, true),
                              child: Text('Confirm'),
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
                          'userref':
                              FieldValue.arrayRemove([currentUserReference]),
                        },
                      ),
                    });
                    Navigator.pop(context);
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: AlignmentDirectional(0.0, -0.8)
                              .resolve(Directionality.of(context)),
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child:
                                ThenotificationhasbeensuccessfullyremovedWidget(
                              schoolref: widget.schoolref,
                            ),
                          ),
                        );
                      },
                    );
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
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: AlignmentDirectional(0.0, -0.8)
                              .resolve(Directionality.of(context)),
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child:
                                ThenotificationhasbeensuccessfullyremovedWidget(),
                          ),
                        );
                      },
                    );

                    context.goNamed(
                      NotificationsSAWidget.routeName,
                      extra: <String, dynamic>{
                        kTransitionInfoKey: TransitionInfo(
                          hasTransition: true,
                          transitionType: PageTransitionType.fade,
                        ),
                      },
                    );
                  } else {
                    await widget.notiref!.update({
                      ...mapToFirestore(
                        {
                          'userref':
                              FieldValue.arrayRemove([currentUserReference]),
                        },
                      ),
                    });
                    await showDialog(
                      context: context,
                      builder: (dialogContext) {
                        return Dialog(
                          elevation: 0,
                          insetPadding: EdgeInsets.zero,
                          backgroundColor: Colors.transparent,
                          alignment: AlignmentDirectional(0.0, -0.8)
                              .resolve(Directionality.of(context)),
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.08,
                            width: MediaQuery.sizeOf(context).width * 0.6,
                            child:
                                ThenotificationhasbeensuccessfullyremovedWidget(),
                          ),
                        );
                      },
                    );

                    context.safePop();
                  }
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.delete_outline,
                    color: FlutterFlowTheme.of(context).tertiaryText,
                    size: 20.0,
                  ),
                  Text(
                    'Delete',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          font: GoogleFonts.nunito(
                            fontWeight: FontWeight.w500,
                            fontStyle: FlutterFlowTheme.of(context)
                                .bodyMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).tertiaryText,
                          fontSize: 16.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w500,
                          fontStyle:
                              FlutterFlowTheme.of(context).bodyMedium.fontStyle,
                        ),
                  ),
                ].divide(SizedBox(width: 15.0)).around(SizedBox(width: 15.0)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
