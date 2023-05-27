import 'package:educator/Models/studentModel.dart';
import 'package:educator/Screens/admin/add_Student_Screen.dart';
import 'package:educator/Screens/widgets/navigation_drawer.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math' as math;


class usersSreen extends StatefulWidget {
  const usersSreen({Key? key}) : super(key: key);

  @override
  State<usersSreen> createState() => _usersSreenState();
}

class _usersSreenState extends State<usersSreen> {

   List<studentModel> studentsList = [] ;
  bool isEndLoading = false;

  @override
  void initState() {
    super.initState();
    getStudents();


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:Stack(
          children: [
          isEndLoading? Column(
           children: [
             SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
             Padding(
               padding: const EdgeInsets.all(15.0),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   InkWell(
                     onTap: (){
                       Navigator.of(context).push(
                           MaterialPageRoute(
                               builder: (context) =>
                                   addStudentScreen()));
                     },
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Material(
                         elevation: 4,
                         color: Colors.blue[900],
                         shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(20)),
                         child: Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Row(
                             children: const [
                               Icon(Icons.add_circle,color: Colors.white,),
                               Text(
                                 " Add New Student   ",
                                 style: TextStyle(
                                     fontFamily: "Poppins", fontSize: 14,color: Colors.white),
                               ),
                             ],
                           ),
                         ),
                       ),
                     ),
                   ),
                 ],),
             ),
             Visibility(
               visible: studentsList.length > 0,
               child: ListView.builder(
                 shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        itemBuilder: (context, index) {
                return InkWell(
                  onTap: () async {
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      elevation: 2,
                      child: ListTile(
                        tileColor: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(studentsList[index].profileImage),
                          radius: 25,
                        ),
                        title: Text(
                          studentsList[index].name,
                          style: const TextStyle(fontSize: 17, fontFamily: "Poppins"),
                        ),
                        subtitle: Text(
                        "Age:  "+  studentsList[index].dateofBirth,
                          style: const TextStyle(fontSize: 15),
                        ),
                        horizontalTitleGap: 10,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ),
                );
        },
        itemCount:studentsList.length,
      ),
             ),
           ],
         ) :
          Container(
            margin: EdgeInsets.only(bottom: 100),
            child: Center(
              child: Center(
                child: Stack(
                  children: [
                    Container(
                        width: 70,
                        height: 70,
                        child: CircularProgressIndicator()),
                    Container(
                        width: 70,
                        height: 70,
                        child: Center(
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: Container(
                              width: 40,
                              height: 40,
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
            NavigationDrawer()


          ],
        )
    );
  }

  Future<void> getStudents() async {
    var data = await FirebaseFirestore.instance.collection("admin").doc("data")
        .collection("students").doc("allStudents").collection("allStudents")
        .get(const GetOptions(source: Source.server));

    if (data.docs.isNotEmpty) {
      print("exisr");
      studentsList =
          List.from(data.docs.map((doc) => studentModel.fromSnapshot(doc)));

      setState(() {

        isEndLoading = true;
        print(studentsList.length);
      });
    }
    else{
      isEndLoading = true;
      setState(() {

      });
    }
  }
}
