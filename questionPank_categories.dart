import 'package:flutter/material.dart';

class questionPankCategories extends StatefulWidget {
  const questionPankCategories({Key? key}) : super(key: key);

  @override
  State<questionPankCategories> createState() => _questionPankCategoriesState();
}

class _questionPankCategoriesState extends State<questionPankCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [

          ],
        )
    );
  }

  serviceContainer(String name) {
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
                      ("assets/classes.png",
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
