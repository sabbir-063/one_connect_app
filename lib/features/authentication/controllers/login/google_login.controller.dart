import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:one_connect_app/curr_user.dart';
import 'package:one_connect_app/utils/helpers/helper_functions.dart';
import '../../../../../navigation_bar.dart';
import '../../../../models/UserModel/user_model.dart';
import '../../../ProfilePage/controllers/profile.controller.dart';

class GoogleLoginController extends GetxController {
  final ProfileController userController = Get.put(ProfileController());

  final gemail = "".obs;
  final photoUrl = "".obs;
  final firstName = "".obs;
  final lastName = "".obs;

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  void signInWithGoogle() async {
    try {
      GoogleSignInAccount? guser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await guser?.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      if (userCredential.user != null) {
        // print(userCredential.user?.displayName); print(userCredential.user?.phoneNumber); print(userCredential.user?.photoURL); print(userCredential.user?.providerData);
        OneUser.isGoogleAccount = true;
        OneUser.currUserId = userCredential.user?.uid ?? '';
        gemail.value = userCredential.user?.email ?? '';
        if (await isEmailUsed() == false) {
          createUserViaGmail(userCredential);
          print("notun user create hoise gmail die");
        }
        userController.fetchUserData(OneUser.currUserId);
        Get.offAll(() => const NavigationBarMenu());
        OneHelperFunctions.showCustomSnackBar(
            'Success', 'User logged in successfully', true);
      }
    } catch (e) {
      OneHelperFunctions.showCustomSnackBar(
          "Error", "Google Sign in Error", false);
    }
  }

  Future<bool> isEmailUsed() async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('Users')
          .where('email', isEqualTo: gemail.value)
          .get();
      print("isEmail used function called");
      print(result.docs);
      return result.docs.isNotEmpty;
    } catch (e) {
      print('Error fetching fata from Users table when google sign in trying');
      return false;
    }
  }

  void createUserViaGmail(UserCredential userCredential) async {
    try {
      firstName.value = userCredential.user?.displayName ?? '';
      photoUrl.value = userCredential.user?.photoURL ?? '';
      int currValue = 0;

      final centralFundDoc = FirebaseFirestore.instance
          .collection('CentralFund')
          .doc(OneUser.centralFundId);

      final centralFundSnapshot = await centralFundDoc.get();

      if (centralFundSnapshot.exists) {
        currValue = centralFundSnapshot.data()?['user_count'] ?? 0;
        await centralFundDoc.update({
          'user_count': currValue + 1,
        });
      }

      currValue++;
      int len = currValue.toString().length;
      int zeros = 8 - len;

      String userName = 'user_';

      for (int i = 0; i < zeros; i++) {
        userName += '0';
      }

      userName += currValue.toString();

      UserModel newUser = UserModel(
        firstName: firstName.value,
        lastName: "",
        userNameAuto: userName,
        email: gemail.value,
        phone: "",
        country: "",
        state: "",
        city: "",
        birthday: "",
        password: "",
        profileUrl: photoUrl.value,
      );
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(OneUser.currUserId)
          .set(newUser.toMap());
    } catch (e) {
      print("Error creating user via gmail");
    }
  }
}
