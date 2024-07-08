import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorails/posts/post_screen.dart';
import 'package:firebase_tutorails/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../widget/round_button.dart';

class VerifyCodeScreen extends StatefulWidget {
  String verificationId;
   VerifyCodeScreen({super.key, required this.verificationId});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  TextEditingController smsVerificationController = TextEditingController();
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
              controller: smsVerificationController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Verify',
              ),

            ),
            const SizedBox(height: 80,),


            RoundButton(
                title: 'Verify',
                loading: loading,
                onTap: () async{
                  setState(() {
                    loading = true;
                  });

                  final credential = PhoneAuthProvider.credential(
                      verificationId: widget.verificationId,
                      smsCode: smsVerificationController.text.toString()
                  );

                  try{
                    await auth.signInWithCredential(credential);
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const PostScreen()));

                  }catch(e){
                    setState(() {
                      loading = true;
                    });
                    Utils().toastMessage(e.toString());

                  }




                }
            ),

          ],
        ),
      ),

    );
  }
}
