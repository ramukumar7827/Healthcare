import 'package:flutter/material.dart';
import 'package:medicare/common/color_extension.dart';
import 'package:medicare/screen/home/appointment_booking_screen.dart';

class OnlyDoctorProfileScreen extends StatelessWidget {
  final Map doctorDetails;
  const OnlyDoctorProfileScreen({super.key, required this.doctorDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: TColor.primary,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, color: Colors.white, size: 25),
        ),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("assets/img/u1.png"),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    doctorDetails["fullName"],
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      doctorDetails["specialization"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: TColor.secondaryText,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctorDetails["experience"],
                      style: TextStyle(
                        color: TColor.primary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Text(
                      "Years Experience",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      doctorDetails["fees"],
                      style: TextStyle(
                        color: TColor.primary,
                        fontSize: 14,
                      ),
                    ),
                    const Text(
                      "Fees",
                      style: TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(color: Colors.black26),
            ListTile(
              leading: Icon(Icons.access_time, color: TColor.primary),
              title: const Text("Timings"),
              subtitle: Text(
                doctorDetails["timings"],
                style: TextStyle(color: TColor.unselect, fontSize: 12),
              ),
            ),
            const Divider(color: Colors.black26),
            ListTile(
              leading: Icon(Icons.location_on, color: TColor.primary),
              title: const Text("Address"),
              subtitle: Text(
                doctorDetails["address"],
                style: TextStyle(color: TColor.unselect, fontSize: 12),
              ),
            ),
            const Divider(color: Colors.black26),
            ListTile(
              leading: Icon(Icons.phone, color: TColor.primary),
              title: const Text("Contact"),
              subtitle: Text(
                doctorDetails["contactNumber"],
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              trailing: InkWell(
                onTap: () {},
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: TColor.green,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.phone, color: Colors.white, size: 15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Spacer(),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                             AppointmentBookingScreen(doctorUserName:doctorDetails["userName"],),
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: TColor.primary,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Book",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
