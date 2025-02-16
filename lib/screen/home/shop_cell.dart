import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:medicare/common/color_extension.dart';

class ShopCell extends StatelessWidget {
  final Map obj;
  final VoidCallback onPressed;

  const ShopCell({super.key, required this.obj, required this.onPressed});

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
                obj["img"],
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              obj["name"],
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
              obj["address"],
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

