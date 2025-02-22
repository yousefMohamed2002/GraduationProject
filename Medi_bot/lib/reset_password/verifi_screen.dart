// Youssef Yasser
import 'package:flutter/material.dart';
import 'create_password.dart';

class VerificationScreen extends StatefulWidget {
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  final List<TextEditingController> controllers = List.generate(4, (index) => TextEditingController());
  final List<FocusNode> focusNodes = List.generate(4, (index) => FocusNode());

  void verifyCode(BuildContext context) {
    String otp = controllers.map((controller) => controller.text).join();

    if (otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid 4-digit code"))
      );
      return;
    }

    // Navigate to create new password screen
    Navigator.push(context, MaterialPageRoute(builder: (_) => CreateNewPasswordScreen()));
  }

  void handleOtpInput(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      FocusScope.of(context).requestFocus(focusNodes[index + 1]);
    } else if (value.isEmpty && index > 0) {
      FocusScope.of(context).requestFocus(focusNodes[index - 1]);
    }

    if (index == 3 && controllers[index].text.isNotEmpty) {
      verifyCode(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(), backgroundColor: Colors.white),
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Verification",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue),
              ),
              const SizedBox(height: 10),
              const Text("Enter the verification code we just sent to your email."),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) => SizedBox(
                  width: 50,
                  child: TextField(
                    controller: controllers[index],
                    focusNode: focusNodes[index],
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      counterText: "",
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) => handleOtpInput(value, index),
                  ),
                )),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => verifyCode(context),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Colors.blue[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Verify", style: TextStyle(color: Colors.white, fontSize: 18)),
              ),
              const Spacer(),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Didn't receive code?"),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement OTP resend functionality
                      },
                      child: const Text(
                        "Resend",
                        style: TextStyle(
                          color: Color.fromRGBO(54, 106, 166, 100),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
