class RelativeDateFormat {
  static const num ONE_MINUTE = 60000;
  static const num ONE_HOUR = 3600000;
  static const num ONE_DAY = 86400000;
  static const num ONE_WEEK = 604800000;

  static const String ONE_SECOND_AGO = "秒前";
  static const String ONE_MINUTE_AGO = "分钟前";
  static const String ONE_HOUR_AGO = "小时前";
  static const String ONE_DAY_AGO = "天前";
  static const String ONE_MONTH_AGO = "月前";
  static const String ONE_YEAR_AGO = "年前";

  static String timeStamp2Str(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String month = date.month < 10 ? '0${date.month}' : '${date.month}';
    String day = date.day < 10 ? '0${date.day}' : '${date.day}';
    String hour = date.hour < 10 ? '0${date.hour}' : '${date.hour}';
    String minute = date.minute < 10 ? '0${date.minute}' : '${date.minute}';
    return "${date.year}-$month-$day $hour:$minute";
  }

  static String format(DateTime date) {
    num delta =
        DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;
    if (delta < 1 * ONE_MINUTE) {
      num seconds = toSeconds(delta);
      return (seconds <= 0 ? 1 : seconds).toInt().toString() + ONE_SECOND_AGO;
    }
    if (delta < 45 * ONE_MINUTE) {
      num minutes = toMinutes(delta);
      return (minutes <= 0 ? 1 : minutes).toInt().toString() + ONE_MINUTE_AGO;
    }
    if (delta < 24 * ONE_HOUR) {
      num hours = toHours(delta);
      String tmp = (hours <= 0 ? 1 : hours).toInt().toString();
      if (tmp == "0") {
        return "1小时内";
      } else {
        return tmp + ONE_HOUR_AGO;
      }
    }
    if (delta < 48 * ONE_HOUR) {
      return "昨天";
    }
    if (delta < 30 * ONE_DAY) {
      num days = toDays(delta);
      return (days <= 0 ? 1 : days).toInt().toString() + ONE_DAY_AGO;
    }
    if (delta < 12 * 4 * ONE_WEEK) {
      num months = toMonths(delta);
      return (months <= 0 ? 1 : months).toInt().toString() + ONE_MONTH_AGO;
    } else {
      num years = toYears(delta);
      return "${date.year}-${date.month}-${date.day} ${date.hour}:${date.minute}";
    }
  }

  static num toSeconds(num date) {
    return date / 1000;
  }

  static num toMinutes(num date) {
    return toSeconds(date) / 60;
  }

  static num toHours(num date) {
    return toMinutes(date) / 60;
  }

  static num toDays(num date) {
    return toHours(date) / 24;
  }

  static num toMonths(num date) {
    return toDays(date) / 30;
  }

  static num toYears(num date) {
    return toMonths(date) / 365;
  }
}
