import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:one_connect_app/utils/constants/image_strings.dart';

import '../../../controllers/signup/email_verification.controller.dart';

class EmailVerificationPage extends StatelessWidget {
  final EmailVerificationController _controller =
      Get.put(EmailVerificationController());

  EmailVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                    child: Image.asset(
                  OneImages.onBoardingImage1,
                  height: 150,
                  width: 150,
                )),
                const SizedBox(height: 40),
                const Text(
                  'Verify Your Email Address',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'We have sent a 6-digit code to your email address. Please enter the code below to verify your email.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 60),
                Form(
                  child: Obx(() => TextFormField(
                        controller: _controller.codeController,
                        maxLength: 6,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintText: 'Enter 6-digit code',
                          counterText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: _controller.isCodeValid.value
                                  ? Colors.grey
                                  : Colors.red,
                            ),
                          ),
                          errorText: _controller.isCodeValid.value ? null : '',
                          errorStyle: const TextStyle(height: 0),
                          contentPadding: const EdgeInsets.all(15.0),
                        ),
                        style:
                            const TextStyle(fontSize: 24, letterSpacing: 2.0),
                      )),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _controller.verifyCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Verify'),
                ),
                Obx(() => _controller.isCodeValid.value
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          _controller.errorMessage.value,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
