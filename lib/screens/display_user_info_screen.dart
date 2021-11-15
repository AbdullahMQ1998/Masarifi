import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'register_user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class DisplayUserInfoScreen extends StatefulWidget {
  static const String id = 'home_screen';
  final User loggedUser;


  DisplayUserInfoScreen(this.loggedUser);


  @override
  _DisplayUserInfoScreen  createState() => _DisplayUserInfoScreen ();
}

class _DisplayUserInfoScreen extends State<DisplayUserInfoScreen> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  User loggedUser;
  bool isEnable = true;
  @override

  @override
  Widget build(BuildContext context){




    return Scaffold (
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            StreamBuilder<QuerySnapshot> (
              // Here in the stream we get the user info from the database based on his email, we will get all of his information
                stream: FirebaseFirestore.instance.collection('User_Info').where('email',isEqualTo: widget.loggedUser.email).snapshots(),
                builder:(context,snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                    );
                  }

                  final usersInfo = snapshot.data.docs;

                  return Center(
                    child: Column(

                      children: [
                        Text(usersInfo[0].get('userName'),
                          style: TextStyle(
                            fontSize: 30,
                          ),),
                        Text(usersInfo[0].get('age'), style: TextStyle(
                            fontSize: 30
                        ),),
                        Text(usersInfo[0].get('gender'),style: TextStyle(
                            fontSize: 30
                        ),),
                        Text(usersInfo[0].get('matiralStats'),style: TextStyle(
                            fontSize: 30
                        ),),
                        Text(usersInfo[0].get('monthlyIncome'),style: TextStyle(
                            fontSize: 30
                        ),),
                        Text(usersInfo[0].get('occupation'),style: TextStyle(
                            fontSize: 30
                        ),),

                        Container(
                            child: isEnable
                                ? Text(usersInfo[0].get('nmbOfChild'),
                              style: TextStyle(
                                  fontSize: 30
                              ),)
                                : Container(
                              width: 100,
                              child: TextFormField(
                                  initialValue: usersInfo[0].get('nmbOfChild'),
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (value) {
                                    setState(() {
                                      isEnable = true;

                                      //Here we update the Number of Childs
                                      usersInfo[0].reference.update({'nmbOfChild': value});
                                      print(usersInfo[0].get('nmbOfChild'));

                                    }
                                    );
                                  }),
                            )),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            setState(() {
                              isEnable= false;
                            }
                            );
                          },
                        ),

                        FloatingActionButton(onPressed: () {


                          usersInfo[0].reference.update({'age' : '80'});
                          print(usersInfo[0].get('nmbOfChild'));




                        }),

                        FloatingActionButton(
                          onPressed: () {
                            _auth.signOut();
                            Navigator.pop(context);
                          },
                          backgroundColor: Colors.red,
                          child:Text('Sign Out'),
                        ),
                      ],
                    ),
                  );
                }
            ),



          ],
        ),
      ),
    );
  }
}
