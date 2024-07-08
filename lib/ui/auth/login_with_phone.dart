import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorails/ui/auth/verify_code.dart';
import 'package:firebase_tutorails/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../widget/round_button.dart';


class LoginWithPhoneScreen extends StatefulWidget {
  const LoginWithPhoneScreen({super.key});

  @override
  State<LoginWithPhoneScreen> createState() => _LoginWithPhoneScreenState();
}

class _LoginWithPhoneScreenState extends State<LoginWithPhoneScreen> {
  TextEditingController phoneController = TextEditingController();
  bool loading = false;
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Login Screen',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: '+92 311 4439220',
              ),

            ),
            const SizedBox(height: 80,),


            RoundButton(
                title: 'Login',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true;
                  });
                  auth.verifyPhoneNumber(
                    phoneNumber: phoneController.text,
                      verificationCompleted: (_){
                        setState(() {
                          loading = false;
                        });

                      },
                      verificationFailed: (e){
                        setState(() {
                          loading = false;
                        });
                      Utils().toastMessage(e.toString());
                      },
                      codeSent: (String verification, int? token){
                        setState(() {
                          loading = false;
                        });
                        Navigator.push(context, MaterialPageRoute(builder: (context) =>  VerifyCodeScreen(verificationId: verification,)));



                      },
                      codeAutoRetrievalTimeout: (e){
                        setState(() {
                          loading = false;
                        });
                       Utils().toastMessage(e.toString());
                      }
                  );


                }
            ),

          ],
        ),
      ),

    );
  }
}
