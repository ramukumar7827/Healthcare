import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:medicare/common/color_extension.dart';
import 'package:medicare/screen/home/only_docter_profile_screen.dart';

class DoctorCell extends StatefulWidget {
  final Map obj;
  const DoctorCell({super.key, required this.obj});

  @override
  State<DoctorCell> createState() => _DoctorCellState();
}

class _DoctorCellState extends State<DoctorCell> {
  void onPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              OnlyDoctorProfileScreen(doctorDetails: widget.obj)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.asset(
                "assets/img/u1.png",
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              widget.obj["fullName"],
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: TColor.black,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.obj["degrees"],
              textAlign: TextAlign.center,
              maxLines: 2,
              style: TextStyle(
                color: TColor.secondaryText,
                fontSize: 10,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "(4.0)",
              style: TextStyle(
                color: TColor.secondaryText,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

