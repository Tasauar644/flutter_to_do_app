
import 'package:donation_app/user_to_do_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class UserhomeScreen extends StatelessWidget{

  var userEmail,description,title;
  UserhomeScreen(this.userEmail);

  CollectionReference users= FirebaseFirestore.instance.collection('users');



  @override
  Widget build(BuildContext context) {
   // print(userEmail); Received successfully


    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("To Do List"),
      ),

      body:Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Enter your task title and description!!",style: TextStyle(fontSize: 25,color: Colors.blue,fontWeight: FontWeight.w500),),
              Container(height: 11),
              TextField(
                onChanged: (value){
                  title=value;
                },
                decoration: InputDecoration(
                    hintText: "TITLE",
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
                  description=value;

                },
                decoration: InputDecoration(
                    hintText: "DESCRIPTION",
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
                    await users.add(
                        {'description': description,
                          'email': userEmail,
                          'title':title})
                        .then((value) => print("Added Successfully"));

                  }, child: Text("Save")),
              Container(height: 11),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DataFetcherWidget(userEmail)));


              }, child: Text("To do list")),
              
              ElevatedButton(
                  onPressed: ()async{
                Navigator.pop(context);

              }, child: Text("Log out")),

            ],
          ))




    );
  }


}