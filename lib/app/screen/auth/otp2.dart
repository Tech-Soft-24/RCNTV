import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:http/http.dart' as http;
import 'package:livetv2024/app/screen/home_screen.dart';
import 'package:pinput/pinput.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../bcodez/app_controller.dart';
import '../../constant/color.dart';
import '../../constant/text.dart';
import '../../widgets/button.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/snackbar.dart';


class VerifyOtpScreen extends StatefulWidget {
  final String generatedOtp;
  final String phoneNumber;

  const VerifyOtpScreen(this.generatedOtp, this.phoneNumber, {super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  AppController controller = Get.put(AppController());

  final TextEditingController pinController = TextEditingController();
  final FocusNode focusNode = FocusNode();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final box = GetStorage();

  late Timer _timer;
  int _countdown = 30;
  int _otpSentCount = 0;

  @override
  void initState() {
    super.initState();
    startTimer();
    loadOtpSentCount();
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_countdown > 0) {
            _countdown--;
          } else {
            _timer.cancel();
          }
        });
      }
    });
  }

  void loadOtpSentCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _otpSentCount = prefs.getInt('otpSentCount') ?? 0;
      });
    }
  }

  void saveOtpSentCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('otpSentCount', _otpSentCount);
  }

  void incrementOtpSentCount() {
    if (mounted) {
      setState(() {
        _otpSentCount++;
      });
    }
    saveOtpSentCount();
  }

  void resetOtpSentCount() {
    if (mounted) {
      setState(() {
        _otpSentCount = 0;
      });
    }
    saveOtpSentCount();
  }

  void resendOtp() async {
    String phoneNumber = widget.phoneNumber;

    if (_validatePhoneNumber(phoneNumber)) {
      if (_otpSentCount < 4) {
        String? generatedOtp = await sendOtp(phoneNumber);
        if (generatedOtp != null) {
          CustomSnackBar.showSnackBar(title: 'Failed', message: 'Resend OTP to $phoneNumber',color: Colors.red);
          _countdown = _calculateCountdown();
          startTimer();
          incrementOtpSentCount();
        } else {
          CustomSnackBar.showSnackBar(title: 'Failed', message: 'Failed to resend OTP',color: Colors.red);
        }
      } else {
        CustomSnackBar.showSnackBar(title: 'Something went wrong', message: 'Try again after 24 hours',color: Colors.red);
      }
    } else {
      CustomSnackBar.showSnackBar(title: 'Failed', message: 'Invalided mobile number',color: Colors.red);
    }
  }

  int _calculateCountdown() {
    // Return different countdown values based on the number of attempts
    if (_otpSentCount == 0) {
      return 30;
    } else if (_otpSentCount == 1) {
      return 60;
    } else {
      return 120;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar((){Get.back();}, ''),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                150.verticalSpace,
                Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/logo.png',
                            height: 24, width: 98),
                        16.verticalSpace,
                         const Text('We’ve sent a verification code to your mobile. Enter it to complete the sign-up process.',style: AppTextStyle.grey20w600,),
                      ],
                    )),
                24.verticalSpace,
                Pinput(
                  controller: pinController,
                  focusNode: focusNode,
                  // androidSmsAutofillMethod: AndroidSmsAutofillMethod
                  //     .smsUserConsentApi,
                  defaultPinTheme: PinTheme(
                    width: 56,
                    height: 56,
                    textStyle: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  onCompleted: (pin) {
                    if (pin == widget.generatedOtp && _validatePhoneNumber(widget.phoneNumber)) {
                      CustomSnackBar.showSnackBar(title: 'Success', message: 'OTP verification successfully');
                      _navigateToGDetails();
                    } else {
                      CustomSnackBar.showSnackBar(title: 'Failed', message: 'Incorrect OTP',color: Colors.red);
                    }
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _countdown == 0
                        ? TextButton(
                      onPressed: () {
                        resendOtp();
                        startTimer(); // Start the timer again when resending
                      },
                      child: const Text('Resend OTP', style: AppTextStyle.purple14w600,
                      ),
                    )
                        : Container(),
                  ],
                ),
                _countdown > 0 ? const SizedBox(height: 16.0) : const SizedBox(),
                // To add spacing only when the countdown is active
                _countdown > 0
                    ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('Resend OTP ', style: AppTextStyle.purple14w600),
                    Text('$_countdown seconds', style: AppTextStyle.purple14w600,
                    ),
                  ],
                )
                    : const SizedBox(),
                // To show countdown text only when the countdown is active
                16.verticalSpace,
                CustomButton(
                  title: 'Verify OTP',
                  //color: AppColor.teal,
                  gradient: AppColor.gradient,
                  onTap: () {
                    focusNode.unfocus();
                      if (formKey.currentState!.validate() && pinController.text == widget.generatedOtp) {
                        _navigateToGDetails();
                        controller.getUser();
                        box.write('isLogged', true);
                        Get.offAll(()=>const HomeScreen());
                      }},
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToGDetails() async {
    // Check if the phone number already exists in Firestore
    final data = await _checkPhoneNumberExists(widget.phoneNumber);
    if (data.isNotEmpty) {
      // Save the data in SharedPreferences
    //  final SharedPreferences prefs = await SharedPreferences.getInstance();
    //  prefs.setString('phoneNumber', data['phoneNumber']);


      //prefs.setString('phoneNumber', data['phoneNumber']).whenComplete(() => getuserNumber(),);
      // log(prefs.getString('phoneNumber').toString());
    //  Get.put(MainScreenController()).currentIndex(0);

    } else {
      print('Phone number does not exist in Firestore');
    }
  }

  Future<String> get deviceToken async => await FirebaseMessaging.instance.getToken() ?? '';
  Future<Map<String, dynamic>> _checkPhoneNumberExists(String phoneNumber) async {
    String token = await deviceToken;
    // Check if the phone number already exists in Firestore
    QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseServices.getUser(phoneNumber);
    if (snapshot.docs.isNotEmpty) {
      await FirebaseFirestore.instance.collection('Users').doc(phoneNumber).update({'deviceToken': token, 'active': true});
      var data = snapshot.docs.first.data();
      box.write('phoneNumber', data['phoneNumber']);
    //  print(data.toString());
      return data;
    } else {
      await FirebaseServices.createUser(phoneNumber, token);
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseServices.getUser(phoneNumber);
      var data = snapshot.docs.first.data();
      box.write('phoneNumber', data['phoneNumber']);
    //  print(data.toString());
      return data;
    }
  }


  bool _validatePhoneNumber(String phoneNumber) {
    RegExp regex = RegExp(r'^01\d{9}$');
    return regex.hasMatch(phoneNumber);
  }

  Future<String?> sendOtp(String phoneNumber) async {
    String apiKey = '178438612649861920231205025339am5pks6rmx';
    String emailId = 'belalhoshan89@gmail.com';
    String senderId = '227';
    String apiUrl = 'https://24bulksms.com/24bulksms/api/otp-api-sms-send';
    String otpMessage = 'Your OTP for Authentication is: ';
    String otp = _generateOtp();
    String message = '$otpMessage$otp';
    Map<String, String> data = {
      'api_key': apiKey,
      'sender_id': senderId,
      'message': message,
      'mobile_no': phoneNumber,
      'user_email': emailId,
    };
    http.Response response = await http.post(Uri.parse(apiUrl), body: data);
    if (response.statusCode == 200) {
      CustomSnackBar.showSnackBar(title: 'Success', message: 'OTP send successfully');
      Future.delayed(const Duration(seconds: 5), () =>CustomSnackBar.showSnackBar(title: otp, message: 'Developer mode OTP',color: AppColor.black, duration: const Duration(seconds: 10)));
      print(otp);
      return otp;
    } else {
      print('Failed to send OTP. Response code: ${response.statusCode}');
      print('Response body: ${response.body}');
      print(otp);
      return null;
    }
  }

  String _generateOtp() {
    return ((1000 + DateTime.now().microsecondsSinceEpoch % 9000)).toString();
  }
}

class FirebaseServices {
  static Future<void> createUser(String phoneNumber, String deviceToken) async {
    await FirebaseFirestore.instance.collection("Users").doc(phoneNumber).set({
      'createAt': Timestamp.now(),
      "phoneNumber": phoneNumber,
      "profile_img": "",
      "name": "unknown",
      "address": "unknown",
      "deviceToken": deviceToken,
      'active': true,
      'payment': 'active',
      'endTime': Timestamp.now(),
    });
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getUser(String phoneNumber) async {
    return await FirebaseFirestore.instance.collection('Users').where(
        'phoneNumber', isEqualTo: phoneNumber).get();
  }

}
