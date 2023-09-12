import 'package:intl/intl.dart';

class DateFormatter {
  DateTime get now => DateTime.now();

  static toDDMMMYYYY(String? input) {
    var dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var date = dateFormat.parse(input!);
    var output = DateFormat('dd MMM yyyy');
    return output.format(date);
  }

  static toDDMMMYYYYText(String? input) {
    var dateFormat = DateFormat('yyyy-MM-dd');
    var date = dateFormat.parse(input!);
    var output = DateFormat('dd-MM-yyyy');
    return output.format(date);
  }

  static toDDMMYYYY(String? input) {
    var dateFormat = DateFormat('yyyy-MM-dd');
    var date = dateFormat.parse(input!);
    var output = DateFormat('dd-MM-yyyy');
    return output.format(date);
  }

  static toYYYYMMDD(String? input) {
    var dateFormat = DateFormat('dd-MM-yyyy');
    var date = dateFormat.parse(input!);
    var output = DateFormat('yyyy-MM-dd');
    return output.format(date);
  }

  static toYYYYMMDDHHmmss(String? input) {
    var dateFormat = DateFormat('yyyy-MM-dd HH:mm:ss');
    var date = dateFormat.parse(input!, true).toLocal();
    var output = DateFormat('yyyy-MM-dd HH:mm:ss');
    return output.format(date);
  }

  static toLocalTimeZone(String? input) {
    String myOwnTimeZoneFormatter(Duration offset) =>
        "${offset.isNegative ? "-": "+"}${offset.inHours.toString().padLeft(2, "0")}:${
            (offset.inMinutes - offset.inHours * 60).toString().padLeft(2, "0")}";

    DateTime date = DateTime.parse(input!);
    return date.toIso8601String() + myOwnTimeZoneFormatter(date.timeZoneOffset);
  }

  static toDDMMMYYYYHHmm(String? input) {
    var dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var date = dateFormat.parse(input!, true).toLocal();
    var output = DateFormat('dd MMM yyyy HH:mm');
    return output.format(date);
  }

  static toHHmm(String? input) {
    var dateFormat = DateFormat('yyyy-MM-ddTHH:mm:ss');
    var date = dateFormat.parse(input!, true).toLocal();
    var output = DateFormat('HH:mm');
    return output.format(date);
  }
}
