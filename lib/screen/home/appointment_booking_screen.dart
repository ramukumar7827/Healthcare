import 'dart:convert';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:medicare/common/color.dart';
import 'package:medicare/screen/home/patient_main_tab_screen.dart';
import 'package:medicare/service/data_service.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AppointmentBookingScreen extends StatefulWidget {
  final doctorUserName;
  const AppointmentBookingScreen({super.key, required this.doctorUserName});

  @override
  State<AppointmentBookingScreen> createState() =>
      _AppointmentBookingScreenState();
}

class _AppointmentBookingScreenState extends State<AppointmentBookingScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  DateTime? selectDate;
  final storage = FlutterSecureStorage();
  var _razorpay = Razorpay();
  void _onSubmit() async {
  print("Submit button pressed");
  final patientUserName = await storage.read(key: 'userName');
  print("Username from storage: $patientUserName");
  print(selectDate);
  if (_formKey.currentState!.validate() && selectDate != null) {
    Map<String, dynamic> orderBody = {
      "amount": 500,
    };

    var responseFromServer = await DataService().generateOrderId('/generateOrderId', orderBody);
    if (responseFromServer != null) {
      Map<String, dynamic> jsonResponse = await json.decode(responseFromServer);
      if (jsonResponse['success'] == true) {
        String orderId = jsonResponse['orderId'];

        Map<String, String> data = {
          "patientUserName": patientUserName.toString(),
          "doctorUserName": widget.doctorUserName,
          "date": selectDate!.toIso8601String(),
          "reason": _reasonController.text,
          "message": _messageController.text,
          "patientContactNumber": "7827733004"
        };

        var options = {
          'key': 'rzp_test_UtF2C3eSj6GxNe',
          'amount': 500,
          'name': patientUserName.toString(),
          'currency': 'INR',
          'order_id': orderId,
          'description': 'Appointment Booking',
          'prefill': {'contact': '7827733004', 'email': 'test@example.com'},
        };

        try {
          _razorpay.open(options);
        } catch (e) {
          print(e);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(jsonResponse['error'])),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to generate order ID')),
      );}
}
}


  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Map<String, String> data = {
      "patientUserName": "ramu",
      "doctorUserName": widget.doctorUserName,
      "date": selectDate!.toIso8601String(),
      "reason": _reasonController.text,
      "message": _messageController.text,
      "patientContactNumber": "7827733004",
      "paymentId": response.paymentId!,
    };

    var responseFromServer =
        await DataService().bookAppointment('/bookAppointment', data);
    if (responseFromServer != null) {
      Map<String, dynamic> jsonResponse = await json.decode(responseFromServer);
      if (jsonResponse['success'] == false) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(jsonResponse['error'])));
      } else if (jsonResponse['success'] == true) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => MainTabScreen()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Booking failed, please try again.')),
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment failed: ${response.message}')),
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('External wallet selected: ${response.walletName}')),
    );
  }

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _messageController.dispose();
    _razorpay.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.primary,
        elevation: 0,
        title: Text(
          "Appointment Booking",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Date",
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              InkWell(
                onTap: () async {
                  var results = await showCalendarDatePicker2Dialog(
                    context: context,
                    config: CalendarDatePicker2WithActionButtonsConfig(
                      firstDayOfWeek: 1,
                      calendarType: CalendarDatePicker2Type.single,
                      selectedDayTextStyle: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                      selectedDayHighlightColor: TColor.primary,
                      centerAlignModePicker: true,
                      customModePickerIcon: const SizedBox(),
                    ),
                    dialogSize: const Size(325, 400),
                    value: [],
                    borderRadius: BorderRadius.circular(15),
                  );

                  if (results != null) {
                    setState(() {
                      selectDate = results.first;
                    });
                  }
                },
                child: Container(
                    height: 50,
                    padding: EdgeInsets.only(left: 10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: const []),
                    alignment: Alignment.center,
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            selectDate?.date ?? "Select Date",
                            style: TextStyle(
                              color: selectDate == null
                                  ? TColor.secondaryText
                                  : TColor.primaryText,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Icon(
                          Icons.date_range,
                          color: TColor.primary,
                          size: 30,
                        ),
                      ],
                    )),
              ),
              const SizedBox(height: 20),
              Text(
                "Reason For Visit",
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextFormField(
                  controller: _reasonController,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Enter Your Reason For Visit",
                    hintStyle:
                        TextStyle(color: TColor.secondaryText, fontSize: 14),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your reason for visit";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Message",
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Container(
                padding: EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    boxShadow: const []),
                child: TextFormField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: "Enter Your Message",
                    hintStyle:
                        TextStyle(color: TColor.secondaryText, fontSize: 14),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your message";
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    "Fees - ",
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "500Rs",
                    style: TextStyle(
                      color: TColor.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              InkWell(
                onTap: _onSubmit,
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: TColor.primary,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Make a Payment",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
