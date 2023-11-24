import 'package:get/get.dart';
import 'package:whos_that_pokemon/app/routes/app_pages.dart';

class LoginController extends GetxController {
  void loginGuess() {
    Get.offNamed(Routes.HOME, arguments: 'GUESS');
  }
}
