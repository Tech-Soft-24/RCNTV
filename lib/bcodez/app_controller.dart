import 'package:carousel_slider/carousel_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:livetv2024/app/screen/channel/channel_screen.dart';
import 'package:livetv2024/app/screen/home_screen.dart';
import 'package:livetv2024/app/screen/subscribe/subscribe_page.dart';
import 'package:livetv2024/app/widgets/snackbar.dart';

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
  RxList imageCarousal = <Map<String, dynamic>>[].obs;

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

  //
  // splashOpen(){
  //   if(loggedIn.value){
  //     Future.delayed(const Duration(seconds: 4), () => Get.offAll(const HomeScreen()));
  //   } else {
  //     Future.delayed(const Duration(seconds: 4), () => Get.off(const LoginScreen()));
  //   }
  // }

  fetchData() async {
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
  }

  fetchSlider() async {
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
  }

  createUser({required String phoneNumber, required String deviceToken}) async {
    await FirebaseFirestore.instance.collection("Users").doc(phoneNumber).set({
      'createAt': Timestamp.now(),
      "phoneNumber": phoneNumber,
      "profile_img": "unknown",
      "name": "unknown",
      "address": "unknown",
      "deviceToken": deviceToken,
      'active': true,
      'payment': 'pending'
    });
  }

  login(String email, String password) {
    // Simple login logic using if-else
    if (email.isEmpty || password.isEmpty) {
      CustomSnackBar.showSnackBar(
          title: 'Error', message: 'Please enter both username and password.');
    } else if (email == 'test' && password == 'test') {
      //splashController.isLogged.value = true;
      box.write('isLogged', true);
      CustomSnackBar.showSnackBar(
          title: 'Success', message: 'Logging Successfully');
      Get.offAll(const HomeScreen());
      //  showMessage("Login successful!");
    } else {
      CustomSnackBar.showSnackBar(
          title: 'Error', message: 'Something went wrong');
      //  showMessage("Invalid username or password.");
    }
  }

  otpConfirm({required String pin}) {
    box.write('isLogged', true);
    if (pin == '1234') {
      CustomSnackBar.showSnackBar(title: 'Success', message: 'OTP verification successfully');
      Get.offAll(const HomeScreen());
    } else {
      CustomSnackBar.showSnackBar(title: 'Failed', message: 'Incorrect OTP',color: Colors.red);
    }

  }


  paymentOk() {
    box.write('isSubscribe', 'pending');
    CustomSnackBar.showSnackBar(title: 'Payment Pending', message: 'ReOpen the App');
    Get.off(const HomeScreen());
  }

  paymentPaidAlert() {
    var paid = box.read('payment');
    if(paid == 'paid'){
      Future.delayed(const Duration(seconds: 5), () =>CustomSnackBar.showSnackBar(title: 'Premium User', message: 'You are enjoying 300+ channel'));
    }
  }

  subscribe() {
    var subscribed = box.read('payment');
    var pending = box.read('isSubscribe');
    if (subscribed == 'paid') {
      Get.offAll(const ChannelScreen());
    } else {
      if(pending == 'pending'){
        CustomSnackBar.showSnackBar(title: 'Please wait', message: 'Your Payment is pending');
      } else {
        Get.off(const SubscribePage());
      }
    }
  }

   toggleFullscreen(bool value) {
      fullscreen.value = value;
  }

  // void logout() {
  //   // On logout
  //   splashController.updateLoginState(false);
  // }

  @override
  void onInit() async {
    await paymentPaidAlert();
    await fetchData();
    await fetchSlider();
    super.onInit();
  }
}
