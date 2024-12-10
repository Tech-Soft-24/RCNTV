import 'dart:async';

import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:livetv2024/app/screen/channel/channel_screen.dart';
import 'package:livetv2024/app/screen/home_screen.dart';
import 'package:livetv2024/app/screen/splash_screen.dart';
import 'package:livetv2024/app/screen/subscribe/subscribe_page.dart';
import 'package:livetv2024/app/widgets/snackbar.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AppController extends GetxController {
  RxBool loggedIn = false.obs;
  RxBool signedIn = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController transactionController = TextEditingController();

  TextEditingController mobileotpController = TextEditingController();


  RxString formattedDate = ''.obs;

  /*
  List imageCarousal = [
    {
      "id": 0,
      "img-path":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXtdXQfOjKC9r0uxgyd4w9AaO8VQea17A4zg&s'
    },
    {
      "id": 1,
      "img-path":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpZ1m3MwdqALSYQKyfyS87XO68lrU8TuN68Q&s'
    },
    {
      "id": 2,
      "img-path":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhMiXRDBn6kLVvlNw_p3hKDyEpjcGQT91nMA&s'
    },
    {
      "id": 3,
      "img-path":
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkg0ibnwffJER1eBUbwgzhTaygRqmPAvECDQ&s'
    },
    {"id": 4, "img-path": 'https://i.ibb.co.com/4Rtb4xf/banner.jpg'}
  ];
  */

  CarouselSliderController carouselSliderController =
      CarouselSliderController();
  RxInt currentIndex = 0.obs;

  RxString selectedLang = ''.obs;
  List<String> payment = ['Bkash', 'Nagad', 'Rocket', 'Upay'];
  final box = GetStorage();

  RxInt selectIndex = 0.obs;
  List subscribeList = ['Monthly', 'Yearly'];

  RxBool monthSelect = true.obs;
  RxList<dynamic> channel = <Map<String, dynamic>>[].obs;
  RxList<Map<String, String>> headers = <Map<String, String>>[].obs;
  RxList imageCarousal = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> users = <Map<String, dynamic>>[].obs;

  RxInt selectedIndex = 0.obs;
  List catList = ['All', 'News', 'Sports', 'Kids', 'Entertainment', 'Movie'];

  RxBool news = false.obs;
  RxBool sports = false.obs;
  RxBool kids = false.obs;
  RxBool entertainment = false.obs;
  RxBool movie = false.obs;

  TextEditingController pinController = TextEditingController();
  FocusNode focusNode = FocusNode();

  RxBool fullscreen = false.obs;
  RxString paymentValue = ''.obs;

  fetchData() async {
    channel.clear();
    try {
      await FirebaseFirestore.instance
          .collection('ch_list')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          channel.add({
            'title': element['title'],
            'img': element['img'],
            'url': element['url'],
            'cat': element['cat'],
            'document_id': element.id,
          });
        });
      });
    } catch (e) {
      // TODO
    }
  }

  fetchSlider() async {
    imageCarousal.clear();
    try {
      await FirebaseFirestore.instance
          .collection('slider')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          imageCarousal.add({
            'img-path': element['img'],
            'document_id': element.id,
          });
        });
      });
    } catch (e) {
      // TODO
    }
  }

  ///
  // login(String email, String password) {
  //   // Simple login logic using if-else
  //   if (email.isEmpty || password.isEmpty) {
  //     CustomSnackBar.showSnackBar(
  //         title: 'Error', message: 'Please enter both username and password.');
  //   } else if (email == 'test' && password == 'test') {
  //     //splashController.isLogged.value = true;
  //     box.write('isLogged', true);
  //     CustomSnackBar.showSnackBar(
  //         title: 'Success', message: 'Logging Successfully');
  //     Get.offAll(const HomeScreen());
  //     //  showMessage("Login successful!");
  //   } else {
  //     CustomSnackBar.showSnackBar(
  //         title: 'Error', message: 'Something went wrong');
  //     //  showMessage("Invalid username or password.");
  //   }
  // }
  ///
  // otpConfirm({required String pin}) {
  //   box.write('isLogged', true);
  //   if (pin == '1234') {
  //     CustomSnackBar.showSnackBar(title: 'Success', message: 'OTP verification successfully');
  //     Get.offAll(const HomeScreen());
  //   } else {
  //     CustomSnackBar.showSnackBar(title: 'Failed', message: 'Incorrect OTP',color: Colors.red);
  //   }
  // }

  paymentOk(
      {required String payMob,
      required String payId,
      required String package,
      required int endTime}) async {
    var userNumber = box.read('phoneNumber');
    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userNumber)
          .update({'payment': 'pending'});
      await FirebaseFirestore.instance
          .collection("Transactions")
          .doc(userNumber)
          .set({
        'user': userNumber,
        'package': package,
        'payMob': payMob,
        'payId': payId,
        'payTime': Timestamp.now(),
        'endTime': Timestamp.fromDate(DateTime.now().add(Duration(days: endTime)))
      });
      await getUser();
      CustomSnackBar.showSnackBar(
          title: 'Payment Pending', message: 'Check Again Later');

      Get.off(const HomeScreen());
    } catch (e) {
      // TODO
    }

  }

  /// Listens for changes in Firestore for the endTime
   listenForEndTime() {
    var userNumber = box.read('phoneNumber');
    try {
      FirebaseFirestore.instance
          .collection("Transactions")
          .doc(userNumber)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.exists) {
          Timestamp? endTime = snapshot.data()?['endTime'];
          if (endTime != null) {
            checkEndTime(endTime);
          }
        }
      });
    } catch (e) {
      // TODO
    }
  }

  /// Check if the current time matches or surpasses the endTime
   checkEndTime(Timestamp endTime) async {
    DateTime currentTime = DateTime.now();
    DateTime endDateTime = endTime.toDate();

    try {
      if (currentTime.isAfter(endDateTime) ||
          currentTime.isAtSameMomentAs(endDateTime)) {
      await  updatePaymentStatus();
      }
    } catch (e) {
      // TODO
    }
  }

  /// Periodic check every minute as a fallback
   startPeriodicCheck() {
    try {
      ever(paymentValue, (value) {
        if (value == 'paid') {
          Timer.periodic(const Duration(minutes: 1), (timer) async {
            var userNumber = box.read('phoneNumber');
            DocumentSnapshot snapshot = await FirebaseFirestore.instance
                .collection("Transactions")
                .doc(userNumber)
                .get();

            if (snapshot.exists) {
              Map<String, dynamic>? data =
                  snapshot.data() as Map<String, dynamic>?;
              Timestamp? endTime = data?['endTime'];
              if (endTime != null) {
                checkEndTime(endTime);
              }
            }
          });
        }
      });
    } catch(e) { // TODO
       }
  }


  /// Update the payment status to "active" in Firestore
  updatePaymentStatus() async {
    try {
      var userNumber = box.read('phoneNumber');
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userNumber)
          .update({'payment': 'active'});

      print("Payment status updated to active.");
    } catch (e) {
      print("Failed to update payment status: $e");
    }
  }


  paymentCheck() {
    //paymentValue.value = box.read('payment');
    if (paymentValue.value == 'paid') {
      //  CustomSnackBar.showSnackBar(title: 'Congratulation', message: 'You are Now Premium User');
    } else if (paymentValue.value == 'pending') {
      CustomSnackBar.showSnackBar(title: 'Payment Pending', message: 'Refresh Again Later');
    }
  }

  paymentPaidAlert() {
    //  var paid = box.read('payment');
    //  paymentValue.value = box.read('payment');
    if (paymentValue.value == 'active') {
      print(paymentValue.value);
    } else if (paymentValue.value == 'pending') {
      Future.delayed(
          const Duration(seconds: 5),
          () => CustomSnackBar.showSnackBar(
              title: 'Payment Pending', message: 'Refresh This Page'));
    } else if (paymentValue.value == 'paid') {
      Future.delayed(
          const Duration(seconds: 5),
          () => CustomSnackBar.showSnackBar(
              title: 'Premium User', message: 'You are enjoying 300+ channel'));
    }
  }

  subscribe() {
    //  var payment = box.read('payment');
    //  var isSubscribe = box.read('isSubscribe');
    if (paymentValue.value == 'paid') {
      Get.to(const ChannelScreen());
    } else {
      if (paymentValue.value == 'pending') {
        CustomSnackBar.showSnackBar(
            title: 'Payment Pending', message: 'Refresh This Page');
      } else if (paymentValue.value == 'active') {
        Get.to(const SubscribePage());
      } else {
        print(paymentValue.value);
      }
    }
  }

  toggleFullscreen(bool value) {
    fullscreen.value = value;
  }

  headersData() async {
    headers.clear();
    await FirebaseFirestore.instance
        .collection('toffee')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((element) {
        headers.add({
          'Host': element['Host'],
          'cookie': element['cookie'],
          'user-agent': element['user-agent'],
          'client-api-header': element['client-api-header'],
          'accept-encoding': element['accept-encoding'],
          'document_id': element.id,
        });
      });
    });
  }

  Future<void> getTransactions() async {
    var userNumber = box.read('phoneNumber');

    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('Transactions')
          .where('user', isEqualTo: userNumber)
          .get();

      if(querySnapshot.docs.isNotEmpty) {
        final firstDocument = querySnapshot.docs.first;
      //  box.write('endTime', firstDocument['endTime']);
        Timestamp endDate = firstDocument['endTime'];
        DateTime dateTime = endDate.toDate();

        DateFormat outputFormat = DateFormat('dd/MM/yy');
        formattedDate.value = outputFormat.format(dateTime);
      }


    } catch (e) {
      // TODO
    }
  }

  Future<void> getUser() async {
    var userNumber = box.read('phoneNumber');


    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .where('phoneNumber', isEqualTo: userNumber)
              .get();


      // Clear the headers to avoid duplicates
      users.clear();


      if (querySnapshot.docs.isNotEmpty) {
        // Add the payment from the first document only
        final firstDocument = querySnapshot.docs.first;
        box.write('payment', firstDocument['payment']);
        //  box.write('isSubscribe', firstDocument['isSubscribe']);
        paymentValue.value = firstDocument['payment'];


      }


      // Print headers for debugging
      print("paymentValue**********");
      print(paymentValue.value);
    } catch (e) {
      print('Error getting user: $e');
    }
  }

  logout() async {
    await box.remove('phoneNumber');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    paymentValue.value = 'active';
    box.write('isLogged', false);
    Get.offAll(() => const SplashScreen());
  }

  @override
  void onInit() async {
    await listenForEndTime();
    await startPeriodicCheck();
    await getUser();
    await getTransactions();
    await paymentPaidAlert();
    await fetchData();
    await fetchSlider();
    await headersData();

    super.onInit();
  }
}
