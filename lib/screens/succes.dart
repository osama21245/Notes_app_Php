import 'package:flutter/material.dart';

class Sucess extends StatelessWidget {
  const Sucess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'تم انشاء الحساب بنجاح يمكنك تسجيل الدخول',
              style: TextStyle(fontSize: 23),
            ),
            MaterialButton(
              child: Text("تسجيل الدخول"),
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("./", (route) => false);
              },
              color: Colors.grey,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
