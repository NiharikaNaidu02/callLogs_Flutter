import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CallLogs {
  void call(String text) async {
    bool? res = await FlutterPhoneDirectCaller.callNumber(text);
  }

  getAvator(CallType callType) {
    switch (callType) {
      case CallType.outgoing:
        return Icon(
          Icons.call_made,
          size: 30,
          color: Colors.green,
        );
      case CallType.missed:
        return Icon(
          Icons.call_missed,
          size: 30,
          color: Colors.red[400],
        );
      case CallType.incoming:
        return Icon(
          Icons.call_received,
          size: 30,
          color: Colors.indigo[700],
        );
      default:
        return Icon(
          Icons.phone,
          size: 60,
          color: Colors.grey,
        );
    }
  }

  Future<Iterable<CallLogEntry>> getCallLogs() {
    return CallLog.get();
  }

  String formatDate(DateTime dt) {
    return DateFormat('d-MMM-y H:m:s').format(dt);
  }

  getTitle(CallLogEntry entry) {
    if (entry.name == null) return Text(entry.number ?? '');
    if (entry.name?.isEmpty ?? true)
      return Text(entry.number ?? '');
    else
      return Text(entry.number ?? '');
  }

  String getTime(int duration) {
    Duration d1 = Duration(seconds: duration);
    String formatedDuration = "";
    if (d1.inHours > 0) {
      formatedDuration += d1.inHours.toString() + "h ";
    }
    if (d1.inMinutes > 0) {
      formatedDuration += d1.inMinutes.toString() + "m ";
    }
    if (d1.inSeconds > 0) {
      formatedDuration += d1.inSeconds.toString() + "s";
    }
    if (formatedDuration.isEmpty) return "0s";
    return formatedDuration;
  }
}
