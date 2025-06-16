// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/backend/schema/structs/index.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

// Imports other custom widgets

import 'index.dart'; // Imports other custom widgets

import '/custom_code/actions/index.dart';
import '/flutter_flow/custom_functions.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TimelinewidgetdatatypeClassCopy extends StatefulWidget {
  const TimelinewidgetdatatypeClassCopy({
    super.key,
    this.width,
    this.height,
    required this.timrlinewidget,
    required this.schoolclassref,
    required this.classname,
  });

  final double? width;
  final double? height;
  final List<EventsNoticeStruct> timrlinewidget;
  final DocumentReference schoolclassref;
  final String classname;

  @override
  State<TimelinewidgetdatatypeClassCopy> createState() =>
      _TimelinewidgetdatatypeClassCopyState();
}

class _TimelinewidgetdatatypeClassCopyState
    extends State<TimelinewidgetdatatypeClassCopy> {
  CalendarController _controller = CalendarController();
  late List<Meeting> _meetings;

  @override
  void initState() {
    super.initState();
    _controller.displayDate = DateTime.now();
    _meetings = _getDataSource();

    // Fix: Ensure UI updates safely after build
    _controller.addPropertyChangedListener((String property) {
      if (property == 'displayDate') {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            setState(() {}); // Safe update
          }
        });
      }
    });
  }

  @override
  void didUpdateWidget(covariant TimelinewidgetdatatypeClassCopy oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Check if the timrlinewidget or classname has changed
    if (widget.timrlinewidget != oldWidget.timrlinewidget) {
      setState(() {
        _meetings = _getDataSource(); // Update the meetings data
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenHeight < 900;

    return SizedBox(
      width: widget.width,
      height: isSmallScreen
          ? (screenHeight * 50)
          : widget.height ?? (screenHeight * 0.57),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  setState(() {
                    _controller.displayDate = DateTime(
                      _controller.displayDate!.year,
                      _controller.displayDate!.month - 1,
                      1,
                    );
                  });
                },
              ),
              Text(
                "${DateFormat.MMMM().format(_controller.displayDate!)} ${_controller.displayDate!.year}",
                style: TextStyle(
                  fontSize: isSmallScreen ? 18 : 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    _controller.displayDate = DateTime(
                      _controller.displayDate!.year,
                      _controller.displayDate!.month + 1,
                      1,
                    );
                  });
                },
              ),
            ],
          ),
          _buildWeekdayHeader(),
          const SizedBox(height: 4),
          Expanded(
            child: SfCalendar(
              controller: _controller,
              view: CalendarView.month,
              firstDayOfWeek: 1,
              dataSource: MeetingDataSource(_meetings),
              headerHeight: 0,
              viewHeaderHeight: 0,
              allowViewNavigation: false,
              allowedViews: [],
              monthViewSettings: MonthViewSettings(
                appointmentDisplayMode: MonthAppointmentDisplayMode.none,
                showAgenda: false,
                showTrailingAndLeadingDates: true,
                monthCellStyle: MonthCellStyle(
                  backgroundColor: const Color.fromARGB(160, 160, 160, 160),
                ),
              ),
              monthCellBuilder:
                  (BuildContext context, MonthCellDetails details) {
                final DateTime cellDate = details.date;

                final List<Meeting> dayMeetings = _meetings
                    .where((meeting) =>
                        meeting.eventDate.year == cellDate.year &&
                        meeting.eventDate.month == cellDate.month &&
                        meeting.eventDate.day == cellDate.day)
                    .toList();

                bool isToday = DateTime.now().year == cellDate.year &&
                    DateTime.now().month == cellDate.month &&
                    DateTime.now().day == cellDate.day;

                bool isCurrentMonth =
                    cellDate.month == _controller.displayDate!.month;

                bool isSunday = cellDate.weekday == DateTime.sunday;

                Color backgroundColor = isCurrentMonth
                    ? Colors.transparent
                    : const Color(0xFFf5f2f2);

                Color textColor =
                    isCurrentMonth ? Colors.black : const Color(0xFF666666);

                if ((!isCurrentMonth && isSunday) || isSunday) {
                  backgroundColor = const Color(0xFFFAD7B9);
                  textColor = Colors.black;
                }

                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      border: Border.all(
                        color: isToday
                            ? const Color.fromARGB(255, 29, 97, 231)
                            : const Color.fromARGB(160, 160, 160, 160),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (dayMeetings.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (dayMeetings.length > 0)
                                Image.network(
                                  _getEventIcon(dayMeetings[0].eventName),
                                  width: 16,
                                  height: 16,
                                ),
                              const SizedBox(width: 4),
                              if (dayMeetings.length > 1)
                                Image.network(
                                  _getEventIcon(dayMeetings[1].eventName),
                                  width: 16,
                                  height: 16,
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                        ],
                        if (dayMeetings.length > 2)
                          Image.network(
                            _getEventIcon(dayMeetings[2].eventName),
                            width: 16,
                            height: 16,
                          ),
                        const SizedBox(height: 4),
                        for (var meeting in dayMeetings.take(3)) ...[
                          Container(
                            width: double.infinity,
                            height: 14,
                            decoration: BoxDecoration(
                              color:
                                  _getEventBackgroundColor(meeting.eventName),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              meeting.eventTitle,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(height: 2),
                        ],
                        const Spacer(),
                        if (isToday)
                          Container(
                            width: 25,
                            height: 25,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                              color: Colors.blueAccent,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              cellDate.day.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          )
                        else
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              details.date.day.toString(),
                              style: TextStyle(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
              onTap: (CalendarTapDetails details) {
                if (details.targetElement == CalendarElement.calendarCell &&
                    details.date != null) {
                  context.pushNamed(
                    'add_calender_details',
                    queryParameters: {
                      'selectedDate': serializeParam(
                        details.date,
                        ParamType.DateTime,
                      ),
                      'schoolclassref': serializeParam(
                        widget.schoolclassref,
                        ParamType.DocumentReference,
                      ),
                      'tabindex': '2',
                      'classname': widget.classname,
                    }.withoutNulls,
                  );
                }
              },
              // onViewChanged: (ViewChangedDetails details) {
              //   // Schedule the state update after the current build phase
              //   WidgetsBinding.instance.addPostFrameCallback((_) {
              //     final DateTime newDisplayDate = details.visibleDates.first;

              //     // Update the controller's displayDate after the frame has been built
              //     setState(() {
              //       _controller.displayDate = newDisplayDate;
              //     });
              //   });
              // },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeekdayHeader() {
    List<String> weekdays = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

    int todayIndex = DateTime.now().weekday - 1;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(7, (index) {
        bool isToday = DateTime.now().weekday == (index + 1) % 7;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          child: Container(
            width: 47,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isToday ? Colors.blueAccent : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isToday ? Colors.transparent : Colors.black,
                width: 0.5,
              ),
            ),
            child: Text(
              weekdays[index],
              style: TextStyle(
                color: isToday ? Colors.white : Colors.black,
                // fontWeight: FontWeight.
                fontSize: 16,
              ),
            ),
          ),
        );
      }),
    );
  }

  Color _getEventBackgroundColor(String eventName) {
    switch (eventName) {
      case 'Birthday':
        return Color(0xFF30A0E1); // Birthday background color
      case 'Holiday':
        return Color(0xFFF37D47); // Holiday background color
      case 'Event':
        return Color(0xFF30A0E1); // Event background color
      default:
        return Colors.transparent; // Default background if no match
    }
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final List<Color> colors = [
      Color(0xFFFFF3CD),
      Color(0xFFCCE5FF),
      Color(0xFFD4EDDA),
      Color(0xFFF8D7DA),
      Color(0xFFE2E3E5),
    ];

    for (var item in widget.timrlinewidget) {
      final DateTime day = item.eventDate ?? DateTime.now(); // Ensure DateTime
      final String subject = item.eventName ?? "Title not specified";
      final String section = item.eventTitle ?? "Title not specified";
      final Color color =
          colors[meetings.length % colors.length]; // Color assignment
      // Ensure this is a List

      // Adding the Meeting instance to the meetings list
      meetings.add(Meeting(
        eventDate: day, // Corrected
        eventName: subject,
        eventTitle: section,
        background: color, // Corrected
        isAllDay: true, // Assuming this is an all-day event
        // List of images
      ));
    }

    return meetings;
  }

  String _getEventIcon(String eventName) {
    switch (eventName) {
      case 'Birthday':
        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/nq5mxu9l8wcq/9e42d7a1c542a64284cd980b22071d9e.png';
      case 'Holiday':
        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/m3qsf5ec7hmc/020ad4dfc4c23c2d77e4cf9c6908a893.png';
      case 'Event':
        return 'https://storage.googleapis.com/flutterflow-io-6f20.appspot.com/projects/fee-be-to8bwt/assets/qhtpl4v7m5lk/e3dc359e3aa56ca841825b06ebb2b9a9.png';
      default:
        return ''; // Default icon if no match
    }
  }

  String _geteventName(String subject) {
    if (subject.contains("Birthday")) return "Birthday";
    if (subject.contains("Holiday")) return "Holiday";
    return "Event";
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    final eventDate = _getMeetingData(index).eventDate;
    return DateTime(eventDate.year, eventDate.month, eventDate.day);
  }

  @override
  DateTime getEndTime(int index) {
    final eventDate = _getMeetingData(index).eventDate;
    return DateTime(eventDate.year, eventDate.month, eventDate.day, 23, 59);
  }

  @override
  String getSubject(int index) => _getMeetingData(index).eventName;

  @override
  Color getColor(int index) => _getMeetingData(index).background;

  @override
  bool isAllDay(int index) => _getMeetingData(index).isAllDay;

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    if (meeting is Meeting) {
      return meeting;
    }
    throw ArgumentError('Invalid argument for meeting at index $index');
  }
}

class Meeting {
  DateTime eventDate; // Corrected from String to DateTime
  String eventName;
  String eventTitle;
  Color background;
  bool isAllDay;
  // Assuming this is a List of URLs

  // Constructor expects parameters with types:
  Meeting({
    required this.eventDate,
    required this.eventName,
    required this.eventTitle,
    required this.background,
    required this.isAllDay,
  });
}
