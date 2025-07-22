
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TColor {
  static Color get primary => const Color.fromARGB(255, 57, 86, 189);
  static Color get secondary => const Color.fromARGB(255, 50, 100, 58);

  static Color get primaryText => const Color(0xff666666);
  static Color get primaryTextW => const Color(0xffFFFFFF);
  static Color get secondaryText => const Color(0xff7C7C7C);
  static Color get placeholder => const Color(0xffA3A3A3);
  static Color get titleText => const Color(0xff656565);
  static Color get black => const Color(0xff000000);

  static Color get rate => const Color(0xffDE6732);
  static Color get rateInActive => const Color(0xff7B7B7B);
  static Color get unselect => const Color(0xff969696);
  static Color get red => const Color(0xffEB1C4F);
  static Color get green => const Color(0xff15977C);

  static Color get bg => const Color(0xffF5F5F5);

}

extension AppContext on BuildContext {
  Size get size => MediaQuery.sizeOf(this);
  double get width => size.width;
  double get height => size.height;

  Future push(Widget widget) async {
    return Navigator.push(this, MaterialPageRoute(builder: (context) => widget ) );
  }

  void pop() async {
    return Navigator.pop(this);
  }
}

extension DateTimeExtension on DateTime {

  String get date{
    return DateFormat('yyyy/MM/dd').format(this);
  }

}
