import 'package:incubate_app/models/user.model.dart';
import 'package:enum_to_string/enum_to_string.dart';

class Utils {
  static String getInitials(String name) {
    var buffer = StringBuffer();
    var split = name.split(' ');
    for (var i = 0; i < split.length; i++) {
      buffer.write(split[i][0]);
    }
    return buffer.toString();
  }

  static convertUpperToEnum<T>(List<T> enumVals, String val) {
    return EnumToString.fromString(enumVals, val.toLowerCase());
  }

  static convertEnumToUpper(dynamic enumValue) {
    return enumValue.toString().split('.').last.toUpperCase();
  }

  static convertStringsToEnums<T>(List<T> enumVals, List<dynamic> listString) {
    List<T?> res = [];
    for (var i = 0; i < listString.length; i++) {
      res.add(EnumToString.fromString(
          enumVals, listString[i].toString().toLowerCase()));
    }
    return res;
  }

  static convertEnumsToDBStrings<T>(List<T>? enumVals) {
    List<String> res = [];
    if (enumVals == null) return res;

    for (var i = 0; i < enumVals.length; i++) {
      res.add(convertEnumToUpper(enumVals[i]));
    }
    return res;
  }

  static getFirstName(String name) {
    return name.split(' ')[0];
  }
}
