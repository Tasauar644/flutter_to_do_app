import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:donation_app/main.dart';

class SignUpScreen extends StatelessWidget{

  final _auth=FirebaseAuth.instance;
  late String signUpEmail;
  late String signUpPassword;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text("Donation app"),
      ),

      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Sign Up!!",style: TextStyle(fontSize: 25,color: Colors.blue,fontWeight: FontWeight.w500),),
              Container(height: 11),
              TextField(
                onChanged: (value){
                  signUpEmail=value;
                },
                decoration: InputDecoration(
                    hintText: "Email",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(
                          color: Colors.deepOrange,
                          width: 2,
                        )

                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(
                          color: Colors.orange,
                        )

                    )
                ),

              ),
              Container(height: 11),
              TextField(
                onChanged: (value){
                  signUpPassword=value;
                },
                obscureText: true,
                decoration: InputDecoration(
                    hintText: "Password",
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(
                          color: Colors.deepOrange,
                          width: 2,
                        )

                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(21),
                        borderSide: BorderSide(
                          color: Colors.orange,
                        )

                    )
                ),

              ),
              Container(height: 11),
              ElevatedButton(
                  onPressed: ()async {
                   await _auth.createUserWithEmailAndPassword(email: signUpEmail, password: signUpPassword);
                   Navigator.push(
                       context,
                       MaterialPageRoute(builder: (context) => showHomePage()));

                  }, child: Text("Sign up")),

            ],
          )),





    );


  }


}