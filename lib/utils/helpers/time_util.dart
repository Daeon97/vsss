// ignore_for_file: public_member_api_docs

import 'package:intl/intl.dart';

final class TimeUtil {
  static String computeHourMinuteAmPm(
    int timestamp,
  ) =>
      DateFormat.jm().format(
        DateTime.fromMillisecondsSinceEpoch(
          timestamp,
        ),
      );

  static int get currentDateTimeMilliseconds =>
      DateTime.now().millisecondsSinceEpoch;
}
