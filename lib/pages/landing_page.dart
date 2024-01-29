import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
        
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset("images/building.jpg",
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height/1.5 ,
            fit: BoxFit.cover,),
          ),
          SizedBox(height: 10,),
          Text("News around the world",style: TextStyle(color: Colors.black,fontSize: 27,fontWeight: FontWeight.bold),),
          SizedBox(height:10),
          Text("Take your time a bit to know \n what's going on around you",style: TextStyle(color: Colors.black45,fontSize: 24,fontWeight: FontWeight.w600),),
          SizedBox(height: 10,) ,
          Container(
            width: MediaQuery.of(context).size.width/1.2,
            child: Material(
              borderRadius: BorderRadius.circular(30),
              elevation: 5.0,
              child: Container(
                
                padding: EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30)),
                
                child:
                
                Center(
                  child: Text(
                    "Get Started",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),),
                ),
              ),
            ),
          )
        ],
      ),) ,
    );
  }
}