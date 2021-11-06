import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'register_user_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';




class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';
  // final String userName;
  // final String age;
  // final String gender;
  // final String matiralStats;
  // final String occupation;
  // final String monthlyIncome;
  // final String nmbOfChild;
  final User loggedUser;


  HomeScreen(this.loggedUser);


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        stream: FirebaseFirestore.instance.collection('User_Info').where('email',isEqualTo: widget.loggedUser.email).snapshots(),
          builder:(context,snapshot) {
            if (!snapshot.hasData) {
              return CircularProgressIndicator(
                backgroundColor: Colors.blueAccent,
              );
            }

            final usersInfo = snapshot.data.docs;
            List<String> UserInformation = [];
            //getting the user information here by adding it to a list "its the only way i found to fetch data from firebase :("
            for(var userInfo in usersInfo){
              UserInformation.add(userInfo.get('userName')); // index = 0
              UserInformation.add(userInfo.get('age')); // index = 1
              UserInformation.add(userInfo.get('gender')); // index = 2
              UserInformation.add(userInfo.get('matiralStats')); // index = 3
              UserInformation.add(userInfo.get('occupation')); // index = 4
              UserInformation.add(userInfo.get('monthlyIncome')); // index = 5
              UserInformation.add(userInfo.get('nmbOfChild')); //index= 6
            }



              return Center(
                child: Column(

            children: [
                Text(UserInformation[0],
                  style: TextStyle(
                    fontSize: 30,
                  ),),
                Text(UserInformation[1], style: TextStyle(
                    fontSize: 30
                ),),
                Text(UserInformation[2],style: TextStyle(
                    fontSize: 30
                ),),
                Text(UserInformation[3],style: TextStyle(
                    fontSize: 30
                ),),
                Text(UserInformation[4],style: TextStyle(
                    fontSize: 30
                ),),
                Text(UserInformation[5],style: TextStyle(
                    fontSize: 30
                ),),

                Container(
            child: isEnable
                  ? Text(UserInformation[6],
            style: TextStyle(
                fontSize: 30
            ),)
                  : Container(
              width: 100,
                    child: TextFormField(
                    initialValue: UserInformation[6],
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (value) {
                      setState(() {
                        isEnable = true;
                        for (var userInfo in usersInfo) {
                          //Here we update the Number of Childs
                          userInfo.reference.update({'nmbOfChild': value});
                          print(UserInformation[6]);
                        }
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

                 for(var userInfo in usersInfo){
                   userInfo.reference.update({'age' : '80'});
                   print(UserInformation[1]);

                 }


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
