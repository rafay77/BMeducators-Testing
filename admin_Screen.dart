import 'package:educator/Screens/admin/add_Question_screen.dart';
import 'package:educator/Screens/admin/add_Student_Screen.dart';
import 'package:educator/Screens/admin/lectures.dart';
import 'package:educator/Screens/admin/questionBank.dart';
import 'package:educator/Screens/admin/usersScreen.dart';
import 'package:educator/Screens/admin/videoScreenAdmin.dart';
import 'package:educator/Screens/students/quiz_screen.dart';
import 'package:flutter/material.dart';
import 'package:educator/Screens/videos_Lecture_Scree.dart';

import '../widgets/navigation_drawer.dart';


class adminScreen extends StatefulWidget {
  const adminScreen({Key? key}) : super(key: key);

  @override
  State<adminScreen> createState() => _adminScreenState();
}

class _adminScreenState extends State<adminScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children:
          [

            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
              children: [


                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                const Text(
                  "Admin Panel",
                  style: TextStyle(fontFamily: "Poppins", fontSize: 25),
                ),



                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children:[
                    serviceContainer("users.jpeg", "Users"),
                    serviceContainer("progress.jpeg", "Progress"),
                  ]
                ),
                SizedBox(height: 30,),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children:[
                    serviceContainer("questions.jpeg", "Question Bank"),
                    serviceContainer("classes.png", "Classes"),
                  ]
                ),
                SizedBox(height: 30,),

                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                    children:[
                    serviceContainer("lectures.jpeg", "Video Lectures"),
                    serviceContainer("tiktok.png", "TikTok"),
                  ]
                ),
                ]),
            ),
            NavigationDrawer()

          ]
        )

    );
  }

  serviceContainer(String image,String name) {
    return
      InkWell(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.grey,
          onTap: () {
            if(name == "Users"){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          usersSreen()));
            }
            else if(name == "Question Bank"){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          questionBank()));
            }
            else if(name == "Progress"){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          addQuestio()));
            }
            else if(name == "Video Lectures"){
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) =>
                          adminVideoScreen()));
            }
          },
          child: Container(
            width: MediaQuery.of(context).size.width * 0.35,
            child: Card(
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                ),
                elevation: 10,
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset(
                      "assets/${image}",
                      width: MediaQuery.of(context).size.width * 0.35
                      ,height: 100,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      height: 25,
                      width: MediaQuery.of(context).size.width*0.35,
                      color: Colors.blue.withOpacity(0.7),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,

                        child: Text(
                          name,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: "Poppins",fontSize: 14,
                              letterSpacing: 1),
                        ),
                      ),
                    )
                  ],
                )),
          ));

  }

}
