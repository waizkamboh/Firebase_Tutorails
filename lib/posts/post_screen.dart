import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_tutorails/posts/add_post.dart';
import 'package:firebase_tutorails/utils/utils.dart';
import 'package:flutter/material.dart';

import '../ui/auth/login_screen.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Post Screen',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: (){
                auth.signOut().then((value) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));


                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());

                });

          },
              icon: const Icon(Icons.logout, color: Colors.white,),

          ),
          const SizedBox(width: 20,)
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const AddPostScreen()));

      },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query: ref,
                defaultChild: const Text('Loading'),
                itemBuilder: (context, snapshot, animation, index){
                  return ListTile(
                    title: Text(snapshot.child('title').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                  );
                }
            ),
          )
        ],
      ),

    );
  }
}
