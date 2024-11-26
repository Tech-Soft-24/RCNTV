import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:livetv2024/app/screen/channel_screen.dart';
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


  List imageCarousal = [
    {"id": 0, "img-path": 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXtdXQfOjKC9r0uxgyd4w9AaO8VQea17A4zg&s'},
    {"id": 1, "img-path": 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpZ1m3MwdqALSYQKyfyS87XO68lrU8TuN68Q&s'},
    {"id": 2, "img-path": 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhMiXRDBn6kLVvlNw_p3hKDyEpjcGQT91nMA&s'},
    {"id": 3, "img-path": 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkg0ibnwffJER1eBUbwgzhTaygRqmPAvECDQ&s'},
    {"id": 4, "img-path": 'https://i.ibb.co.com/4Rtb4xf/banner.jpg'}
  ];

  CarouselSliderController carouselSliderController = CarouselSliderController();
  RxInt currentIndex = 0.obs;

  RxString selectedLang = ''.obs;
  List<String> payment = ['Bkash', 'Nagad', 'Rocket', 'Upay'];
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
      CustomSnackBar.showSnackBar(title: 'Error', message: 'Please enter both username and password.');
    } else if (email == 'test' && password == 'test') {
      //splashController.isLogged.value = true;
      box.write('isLogged', true);
      CustomSnackBar.showSnackBar(title: 'Success', message: 'Logging Successfully');
      Get.offAll(const HomeScreen());
      //  showMessage("Login successful!");
    } else {
      CustomSnackBar.showSnackBar(title: 'Error', message: 'Something went wrong');
      //  showMessage("Invalid username or password.");
    }
  }

  paymentOk(){
    box.write('isSubscribe', true);
    CustomSnackBar.showSnackBar(title: 'Pending', message: 'Your Payment is pending');
    Get.off(const ChannelScreen());
  }

  subscribe() {
    var subscribed = box.read('isSubscribe');
    if(subscribed == true) {
      Get.offAll(const ChannelScreen());
    } else {
      Get.off(const SubscribePage());
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
