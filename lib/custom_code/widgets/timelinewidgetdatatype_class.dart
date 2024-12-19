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

import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class TimelinewidgetdatatypeClass extends StatefulWidget {
  const TimelinewidgetdatatypeClass({
    super.key,
    this.width,
    this.height,
    required this.timrlinewidget,
    required this.schoolclassref,
  });

  final double? width;
  final double? height;
  final List<EventsNoticeStruct> timrlinewidget;
  final DocumentReference schoolclassref;

  @override
  State<TimelinewidgetdatatypeClass> createState() =>
      _TimelinewidgetdatatypeClassState();
}

class _TimelinewidgetdatatypeClassState
    extends State<TimelinewidgetdatatypeClass> {
  CalendarController _controller = CalendarController();
  late List<Meeting> _meetings;

  @override
  void initState() {
    super.initState();
    _controller.displayDate = DateTime.now();
    _meetings = _getDataSource();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Column(
        children: [
          // Centered calendar title with navigation
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
                        _controller.displayDate!.day);
                  });
                },
              ),
              Text(
                "${DateFormat.MMMM().format(_controller.displayDate!)} ${_controller.displayDate!.year}",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  setState(() {
                    _controller.displayDate = DateTime(
                        _controller.displayDate!.year,
                        _controller.displayDate!.month + 1,
                        _controller.displayDate!.day);
                  });
                },
              ),
            ],
          ),
          Expanded(
            child: SfCalendar(
                controller: _controller,
                view: CalendarView.month,
                dataSource: MeetingDataSource(_meetings),
                headerHeight: 0, // Removes default header
                allowViewNavigation: false,
                monthViewSettings: MonthViewSettings(
                  appointmentDisplayMode: MonthAppointmentDisplayMode.none,
                  showAgenda: false,
                  dayFormat: 'EEE', // Show only first letter of weekday
                  monthCellStyle: MonthCellStyle(
                    backgroundColor: Colors.transparent,
                  ),
                ),
                monthCellBuilder:
                    (BuildContext context, MonthCellDetails details) {
                  // Determine if there are any events on this day
                  final DateTime cellDate = details.date;
                  final List<Meeting> dayMeetings = _meetings
                      .where((meeting) =>
                          meeting.eventDate.year == cellDate.year &&
                          meeting.eventDate.month == cellDate.month &&
                          meeting.eventDate.day == cellDate.day)
                      .toList();

// Check if this date is today's date
                  if (details.date.weekday == DateTime.sunday) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          color: Color(0xFFFAD6A5),
                          border:
                              Border.all(color: Colors.purpleAccent, width: 1),
                          borderRadius: BorderRadius.circular(12),
                        ), // Sunday color (#FAD6A5)
                        child: Center(
                          child: Text(
                            details.date.day.toString(),
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  }
                  bool isToday = DateTime.now().year == cellDate.year &&
                      DateTime.now().month == cellDate.month &&
                      DateTime.now().day == cellDate.day;
                  return Padding(
                    padding:
                        const EdgeInsets.all(4.0), // Add spacing between cells
                    child: Container(
                      height:
                          120, // Increase cell height to make room for events
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isToday
                            ? Colors.blueAccent.withOpacity(0.5)
                            : dayMeetings.isNotEmpty
                                ? dayMeetings.first.background
                                : Colors.transparent,
                        border:
                            Border.all(color: Colors.purpleAccent, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          // Event icon and title
                          if (dayMeetings.isNotEmpty) ...[
                            Icon(
                              _getEventIcon(dayMeetings.first.eventType),
                              size: 16,
                              color: Colors.white,
                            ),
                            SizedBox(height: 4),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(
                                    0.1), // Background color for text
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                dayMeetings.first.eventName,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                          Spacer(), // Push date number to the bottom
                          // Date number at the bottom
                          Text(
                            cellDate.day.toString(),
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
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
                          details.date, // Use the selected date here
                          ParamType.DateTime,
                        ),
                        'schoolclassref': serializeParam(
                          widget!.schoolclassref,
                          ParamType.DocumentReference,
                        ),
                      }.withoutNulls,
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    final List<Color> colors = [
      Color(0xFFFFF3CD), // Light yellow for birthdays
      Color(0xFFCCE5FF), // Light blue for holidays
      Color(0xFFD4EDDA), // Light green for other events
      Color(0xFFF8D7DA), // Light pink
      Color(0xFFE2E3E5), // Light gray
      // ... add other colors as needed
    ];

    for (var item in widget.timrlinewidget) {
      final DateTime day = item.eventDate ?? DateTime.now();
      final String subject = item.eventTitle ?? "Title not specified";
      final Color color = colors[meetings.length % colors.length];
      meetings.add(Meeting(
        subject,
        day,
        color,
        true,
        _getEventType(subject),
      ));
    }
    return meetings;
  }

  IconData _getEventIcon(String eventType) {
    switch (eventType) {
      case 'Birthday':
        return Icons.cake;
      case 'Holiday':
        return Icons.flag;
      case 'Event':
        return Icons.star;
      default:
        return Icons.event;
    }
  }

  String _getEventType(String subject) {
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
  String eventName;
  DateTime eventDate;
  Color background;
  bool isAllDay;
  String eventType;

  Meeting(this.eventName, this.eventDate, this.background, this.isAllDay,
      this.eventType);
}
