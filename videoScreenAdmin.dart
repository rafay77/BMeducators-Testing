import 'package:educator/Models/videoLectureModel.dart';
import 'package:educator/Screens/admin/add_videoLecture.dart';
import 'package:educator/Screens/students/customVideoPlayerScree.dart';
import 'package:educator/Screens/widgets/tiktokVideo_Item.dart';
import 'package:educator/Screens/widgets/videoPlayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:educator/Screens/widgets/videoPlayerforUrl.dart';

import '../videos_Lecture_Scree.dart';
class adminVideoScreen extends StatefulWidget {
  const adminVideoScreen({Key? key}) : super(key: key);

  @override
  State<adminVideoScreen> createState() => _adminVideoScreenState();
}

class _adminVideoScreenState extends State<adminVideoScreen> {

  List<videoLectureModel> videosList = [] ;
  bool isEndLoading = false;
 late YoutubePlayerController controller;

  @override
  void initState() {
    super.initState();
    getlectures();
    String url = "https://www.youtube.com/watch?v=YE7VzlLtp-4";
    controller = YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(url)!);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: ClampingScrollPhysics(),
          child: SafeArea(
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(onPressed: () {
                      Navigator.pop(context);
                    },
                        icon: const Icon(
                          Icons.arrow_back_ios, color: Colors.blue,)),
                    InkWell(
                      onTap: (){
                        Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    addVideoLecture()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Material(
                          elevation: 4,
                          color: Colors.blue[600],

                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: const [
                                Icon(Icons.add_circle,color: Colors.white,),
                                Text(
                                  " Add New Lecture   ",
                                  style: TextStyle(
                                      fontFamily: "Poppins", fontSize: 14,color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Text(
                "    Video Lectures",
                style: TextStyle(fontFamily: "Poppins", fontSize: 27),
              ),

              SizedBox(height: 30,),

              Container(
                width: MediaQuery.of(context).size.width,
                child: GridView.count(
                  shrinkWrap: true,
                  physics:  NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 2,
                  childAspectRatio: (1 / 0.8),
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: List.generate(
                    videosList.length,
                        (int i) {
                      return AnimationConfiguration.staggeredGrid(
                          position: i,
                          duration: const Duration(
                              milliseconds: 375),
                          columnCount: 2,
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                                child:InkWell(
                                  onTap: (){
                                    print(videosList[i].url);
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                customVideoPlayer(url: videosList[i].url)));
                                  },
                                  child: Material(
                                    elevation: 20,
                                    borderRadius: BorderRadius.circular(5),
                                    clipBehavior: Clip.antiAlias,
                                    child: Stack(

                                        children:[
                                          // videoPlayerForUrl(url: ""
                                          //     "https://firebasestorage.googleapis.com/v0/b/bmeducator-54d26.appspot.com/o/admin%2Fdata%2FvideoLecture%2Fdata%2Fuser%2F0%2Fcom.educator.educator%2Fcache%2F148a77d3-dce3-456f-82cd-817abc1c9040%2FVID-20230524-WA0027.mp4)?alt=media&token=adcae65a-e3b1-41f7-9295-2bb8babd0995"),

                                          Image.network(videosList[i].thumbnail,
                                            width: MediaQuery.of(context).size.width * 0.5,
                                            fit: BoxFit.cover,
                                            errorBuilder:(BuildContext context,Object exception,StackTrace? stacktrace){
                                              return Padding(
                                                padding: const EdgeInsets.only(bottom: 1),
                                                child: Center(
                                                    child:CircularProgressIndicator()
                                                ),
                                              );
                                            },
                                          ),
                                          Center(child:Icon(Icons.play_arrow_outlined,color: Colors.white60,size: 60,) ,),
                                          Positioned(
                                              bottom: 0,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(horizontal: 5),
                                                width: MediaQuery.of(context).size.width* 0.5,
                                                color: Colors.black.withOpacity(0.5),
                                                child: Text(videosList[i].caption,maxLines: 2,style: TextStyle(color: Colors.white,fontFamily: "PoppinRegular"),),
                                              ))

                                        ] ),
                                  ),
                                )
                            ),
                          ));
                    },
                  ),
                ),
              ),
            ],
          ),),
        )
      
    );
  }


  Future<void> getlectures() async {
    var data =  await FirebaseFirestore.instance.collection("admin").doc(
        "data").collection("videos")
        .doc("lecture").collection("all")
        .get(const GetOptions(source: Source.server));

    if (data.docs.isNotEmpty) {
      print("exisr");
      videosList =
          List.from(data.docs.map((doc) => videoLectureModel.fromSnapshot(doc)));

      setState(() {

        isEndLoading = true;
        print(videosList.length);
      });
    }
    else{
      isEndLoading = true;
      setState(() {

      });
    }
  }
}
