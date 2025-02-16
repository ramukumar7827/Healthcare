import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:medicare/common/color_extension.dart';

class MedicalShopProfileScreen extends StatefulWidget {
  const MedicalShopProfileScreen({super.key});

  @override
  State<MedicalShopProfileScreen> createState() =>
      _MedicalShopProfileScreenState();
}

class _MedicalShopProfileScreenState extends State<MedicalShopProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            "assets/img/bms1.png",
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Jai Ambey Medical",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "Plot No. 123, Behind Somalwada Highschool, Shankar Nagar, Nagpur",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 12,
                      ),
                    ),
                  ),
                 
                  const Divider(color: Colors.black26),
                  Text("14 Years Experience",
                      style: TextStyle(color: TColor.primary)),
                  Text("2021 Votes", style: TextStyle(color: TColor.primary)),
                  const Divider(color: Colors.black26),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Timings",
                          style: TextStyle(fontWeight: FontWeight.w600)),
                      Text("Mon-Fri (11:00 AM - 05:00 PM)",
                          style:
                              TextStyle(color: TColor.unselect, fontSize: 12)),
                    ],
                  ),
                  const Divider(color: Colors.black26),
                  Text("Contact",
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Row(
                    children: [
                      Icon(Icons.phone, size: 18, color: TColor.primary),
                      const SizedBox(width: 8),
                      Text("+91 987654321",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w600)),
                      const Spacer(),
                      IconButton(
                        icon: Icon(Icons.phone, size: 18, color: TColor.green),
                        onPressed: () {},
                      ),
                      
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
