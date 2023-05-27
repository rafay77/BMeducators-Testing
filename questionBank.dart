import 'package:educator/Screens/admin/editQuestionDialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../../Models/question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class questionBank extends StatefulWidget {
  const questionBank({Key? key}) : super(key: key);

  @override
  State<questionBank> createState() => _questionBankState();
}

class _questionBankState extends State<questionBank> {
  late List<QuestionModel> questioList;

  bool isEndLoading = false;

  @override
  void initState() {
    super.initState();
    getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(onPressed: () {
                      Navigator.pop(context);
                    },
                        icon: const Icon(
                          Icons.arrow_back_ios, color: Colors.blue,)),
                  ],
                ),
              ),

              const Text(
                "Question Bank",
                style: TextStyle(fontFamily: "Poppins", fontSize: 25),
              ),
              isEndLoading
                  ? ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(10),
                        elevation: 2,
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.edit, color: Colors.grey[200],),
                                ),
                                Image.network(
                                  questioList[index].image, width: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.6,
                                  height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.1,
                                ),
                                InkWell(
                                  onTap: () {
                                    _showEditDialog(
                                        context, questioList[index]);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(
                                      Icons.edit, color: Colors.blue,),
                                  ),
                                )
                              ],
                            )
                            ,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    Icons.edit, color: Colors.transparent,),
                                ),
                                Container(
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width * 0.7,

                                  child: Text(questioList[index].statement
                                    , style: TextStyle(
                                        fontFamily: "PoppinRegular"),
                                    maxLines: 2,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                InkWell(
                                  onTap: (){
                                    _showDeleteDialog(context, questioList[index]);
                                  },

                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Icon(Icons.delete_outline_outlined,
                                      color: Colors.red,),
                                  ),
                                )
                              ],
                            )

                          ],
                        )
                    ),
                  );
                },
                itemCount: questioList.length,
              )
                  : Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 150),
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
            ],
          ),
        ));
  }

  Future<void> getQuestions() async {
    var data = await FirebaseFirestore.instance
        .collection('questions')
        .get(const GetOptions(source: Source.server));

    if (data.docs.isNotEmpty) {
      print("exisr");
      setState(() {
        questioList =
            List.from(data.docs.map((doc) => QuestionModel.fromSnapshot(doc)));
        isEndLoading = true;
        print(questioList.length);
      });
    }
  }

  Future<void> _showEditDialog(BuildContext context, QuestionModel q) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              contentPadding: EdgeInsets.zero,
              content: editQuestion(questionModel: q));
        });
  }

  Future<void>? _showDeleteDialog(BuildContext context, QuestionModel q) async {
    return (
        await showDialog(context: context,
        builder: (context)
    =>
        AlertDialog(
          content: const Text("Do you want to exit?",
            style: TextStyle(fontFamily: "PoppinRegular"),),
          actions: [
            TextButton(onPressed: () {
              Navigator.pop(context);
            },
              child: const Text(
                  "No", style: TextStyle(fontFamily: "Poppins")),),
            TextButton(onPressed: () {
              FirebaseFirestore.instance.collection("questions").doc(q.statement).delete();
            },
              child: const Text("Yes", style: TextStyle(
                  color: Colors.grey, fontFamily: "Poppins")),),
          ],
        )
    )
    );


  }
}