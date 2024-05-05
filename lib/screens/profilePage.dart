import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class profilePage extends StatefulWidget{
  const profilePage({Key? key}) : super(key: key);
  @override
  State<profilePage> createState() => _profilePageState();
}

class _profilePageState extends State<profilePage>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
        IconButton(onPressed: () async{
          await FirebaseAuth.instance.signOut();
          Navigator.pop(context);
        },
          icon: const Icon(Icons.logout),
        )
      ],
      ),
    );
  }
}