import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:livetv2024/app/screen/home_screen.dart';

import '../app/controller/splash_controller.dart';
import '../app/screen/auth/login_screen.dart';

class AppController extends GetxController {
  //SplashController splashController = Get.put(SplashController());

  RxBool loggedIn = false.obs;
  RxBool signedIn = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController transactionController = TextEditingController();


  List imageCarousal = [
    {"id": 0, "img-path": 'https://i.ibb.co.com/4Rtb4xf/banner.jpg'},
    {"id": 1, "img-path": 'https://i.ibb.co.com/4Rtb4xf/banner.jpg'},
    {"id": 2, "img-path": 'https://i.ibb.co.com/4Rtb4xf/banner.jpg'},
    {"id": 3, "img-path": 'https://i.ibb.co.com/4Rtb4xf/banner.jpg'},
    {"id": 4, "img-path": 'https://i.ibb.co.com/4Rtb4xf/banner.jpg'}
  ];

  CarouselSliderController carouselSliderController = CarouselSliderController();
  RxInt currentIndex = 0.obs;

  RxString selectedLang = ''.obs;
  List<String> payment = ['Bkash', 'Nagad', 'Rocket', 'UPay'];
  final box = GetStorage();


  RxInt selectIndex = 0.obs;
  List subscribeList = [
    'Monthly', 'Yearly'
  ];
  RxBool monthSelect = true.obs;

  //
  // splashOpen(){
  //   if(loggedIn.value){
  //     Future.delayed(const Duration(seconds: 4), () => Get.offAll(const HomeScreen()));
  //   } else {
  //     Future.delayed(const Duration(seconds: 4), () => Get.off(const LoginScreen()));
  //   }
  // }



  login(String email, String password) {
    // Simple login logic using if-else
    if (email.isEmpty || password.isEmpty) {
      //  showMessage("Please enter both username and password.");
    } else if (email == 'subrato' && password == 'admin') {
      //splashController.isLogged.value = true;
      box.write('isLogged', true);
      Get.offAll(const HomeScreen());
      //  showMessage("Login successful!");
    } else {
      //  showMessage("Invalid username or password.");
    }
  }

  // void logout() {
  //   // On logout
  //   splashController.updateLoginState(false);
  // }

  @override
  void onInit() {
    super.onInit();
  }
}
