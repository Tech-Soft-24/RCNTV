import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:livetv2024/app/screen/home_screen.dart';
import 'package:livetv2024/bcodez/app_controller.dart';
import '../screen/auth/otp1.dart';

class SplashController extends GetxController {
  AppController controller = Get.put(AppController());

  final box = GetStorage();

  //RxBool isLogged = loggedIn.obs;

  splashOpen() {
    var loggedIn = box.read('isLogged');
    if (loggedIn == true) {
      Future.delayed(
          const Duration(seconds: 4), () => Get.off(const HomeScreen()));
    } else {
      // Future.delayed(const Duration(seconds: 4), () => Get.off(const OtpSignupScreen()));
      Future.delayed(const Duration(seconds: 4),
          () => Get.off(const SignInOrSignUpWithPhone()));
    }
  }

  @override
  void onInit() {
    //isLogged.value = controller.loggedIn.value;
    splashOpen();
    super.onInit();
  }
}
