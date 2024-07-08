import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_tutorails/utils/utils.dart';
import 'package:firebase_tutorails/widget/round_button.dart';
import 'package:flutter/material.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  bool loading = false;
  TextEditingController postController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Screen',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body:  Padding(
        padding:  const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30,),
            TextFormField(
              controller: postController,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'What is in your mind?',
                border: OutlineInputBorder()
              ),

            ),
            const SizedBox(height: 30,),
            RoundButton(
                title: 'Add',
                loading: loading,
                onTap: (){
                  setState(() {
                    loading = true;
                  });
                  databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).child('path').set({
                  // databaseRef.child(DateTime.now().millisecondsSinceEpoch.toString()).set({
                    'title': postController.text.toString(),
                    'id': DateTime.now().millisecondsSinceEpoch.toString()

                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage('Post Added');


                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage(error.toString());
                  });


                }
            )


          ],
        ),
      ),

    );
  }
}
