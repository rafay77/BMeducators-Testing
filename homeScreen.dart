import 'package:educator/Screens/videos_Lecture_Scree.dart';
import 'package:educator/Screens/widgets/tiktokVideo_Item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'students/login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'students/main_menuScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homeScreen extends StatefulWidget {
  const homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

class _homeScreenState extends State<homeScreen> {

  var li = [
    'https://vt.tiktok.com/ZSLde5Ue4/?t=1',
    'https://vt.tiktok.com/ZSLde5Ue4/?t=1'
  ];

  String name = "";

  late SharedPreferences pref;
  @override
  void initState() {
    super.initState();
    init();
  }
  Future init() async {
    pref = await SharedPreferences.getInstance();
    setState(() {
      name = pref.getString("name")!;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: SafeArea(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Container(
                      width: 70,
                      child: Text("")),

                     Image.asset("assets/textlogo.png",width: MediaQuery.of(context).size.width * 0.42,),
                      StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.active) {
                    // Checking if the snapshot has any data or not
                    if (snapshot.hasData) {
                      // if(message!=""){
                      //   print('vvvvvvvvvvvvvvv=');
                      //   String firstpart =message.substring(0,message.indexOf("+"));
                      //   String secongpart =message.substring(message.indexOf("+")+1,message.length);
                      //
                      //   String name = firstpart.substring(0,firstpart.indexOf("-"));
                      //   String id = firstpart.substring(firstpart.indexOf("-")+1,firstpart.length);
                      //   String peername = secongpart.substring(0,secongpart.indexOf("-"));
                      //   String url = secongpart.substring(secongpart.indexOf("-")+1,secongpart.length);
                      //
                      //   chat.add(name);
                      //   chat.add(id);
                      //   chat.add(peername);
                      //   chat.add(url);
                      // }
                      // if(message == ""){
                      //   print("empty");
                      // }
                      // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
                      return InkWell(
                        onTap: (){
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => mainMenu()));

                        },
                        child: Container(
                          child: Material(
                            elevation: 4,
                            color: Colors.green[300],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 1),
                                child:Row(
                                  children: [
                                    Text(
                                      name.toUpperCase(),
                                      style: const TextStyle(
                                          fontFamily: "PoppinRegular", fontSize: 14,color: Colors.white),
                                    ),
                                  ],
                                )
                            ))),
                      );
                    } else if (snapshot.hasError) {
                      return Container(
                          width: 80,
                          child: Material(
                              elevation: 4,
                              color: Colors.green[300],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 1),
                                  child:Text(
                                    "    Login    ",
                                    style: const TextStyle(
                                        fontFamily: "Poppins", fontSize: 14,color: Colors.white),
                                  )
                              )));
                    }
                  }
                  // means connection to future hasnt been made yet
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return InkWell(
                    onTap: (){
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(builder: (context) => loginScreen()));

                    },
                    child: Container(
                        width: 80,
                        child: Material(
                            elevation: 4,
                            color: Colors.green[300],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                                padding: const EdgeInsets.fromLTRB(10, 0, 10, 1),
                                child:Text(
                                  "    Login    ",
                                  style: const TextStyle(
                                      fontFamily: "Poppins", fontSize: 14,color: Colors.white),
                                )
                            ))),
                  );
                },
              ),
                    ])),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35,vertical: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Our Services",style: TextStyle(fontFamily: "Poppins",fontSize: 23),),
                          SizedBox(height: 15,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              serviceContainer("license","License"),
                              serviceContainer("language","Language Course  "),

                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              serviceContainer("passport","Nationality"),

                            ],
                          ),


                        ],
                      ),
                    ),
                    Divider(thickness: 4,color: Colors.grey,),

                    SizedBox(
                      height: 10,
                    ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 20),child:
                      Text("Trend",style: TextStyle(fontFamily: "Poppins",fontSize: 24),),
                          )
                    ,  SizedBox(
                      height: 10,
                    ),

                  ],

                ),

              // SizedBox(
              //   height: 400,
              // child:   ListView.builder(
              //     scrollDirection: Axis.horizontal,
              //     itemCount: 60,
              //     itemBuilder:(BuildContext context,int i) => Card(
              //       child: Card(
              //         child:videoLectureScreen(url: 'https://www.tiktok.com/@Scout2015/video/6718335390845095173'),
              //       ),
              //     )),),

                Container(
                  height: 300,
                  child: GridView.count(
                    shrinkWrap: true,
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 20),
                    scrollDirection: Axis.horizontal,
                    crossAxisCount: 1,
                    childAspectRatio: (1 / 0.7),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 5,
                    children: List.generate(
                      li.length,
                          (int i) {
                        return AnimationConfiguration.staggeredGrid(
                            position: i,
                            duration: const Duration(
                                milliseconds: 375),
                            columnCount: 2,
                            child: ScaleAnimation(
                              child: FadeInAnimation(
                                  child:Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: videoLectureScreen(url:"https://vt.tiktok.com/ZSLde5Ue4/?t=1"),
                                  )
                              ),
                            ));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

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
          },
          child:  Container(

            width: MediaQuery.of(context).size.width*0.38,
            height:MediaQuery.of(context).size.height*0.15,
            child: Card(

                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    color: Colors.blue.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    elevation: 30,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Image.asset
                      ("assets/${image}.png",
                            width: MediaQuery.of(context).size.width*0.35,
                            height: 130,
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                         width: MediaQuery.of(context).size.width*0.38,
                          height: 28,
                          color: Colors.blue.withOpacity(0.8),
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
                    ),),
          ));

  }

}
