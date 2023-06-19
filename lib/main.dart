import 'package:flutter/material.dart';
import 'package:donation_app/sign_up_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:donation_app/user_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: showHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class showHomePage extends StatelessWidget{
  final _auth=FirebaseAuth.instance;
  late String Email;
  late String Password;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("To Do App"),
        ),
        body: Center(
          child: Container(
            width: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  onChanged: (value){
                    Email=value;
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
                      )
                  ),

                ),
                Container(height: 11),
                TextField(
                  onChanged: (value){
                    Password=value;
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "password",
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
                   final user=  await _auth.signInWithEmailAndPassword(email: Email, password: Password);
                   if(user!=null) {
                     Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => UserhomeScreen(Email)));

                   }

                    }, child: Text("Sign in")),
                Container(height: 11),
                Text("Don't have an account?"),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpScreen()));

                    }, child: Text("Sign up")),
              ],
            ),
          ),
        )

    );



  }


}
