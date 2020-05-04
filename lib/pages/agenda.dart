import 'dart:developer';
import 'package:flutter/gestures.dart';

import '../src/my_flutter_app_icons.dart' as myicons;
import 'package:flutter/material.dart';
import 'dart:math' as math;
// import 'dart:typed_data';

// import 'package:flutter_beautiful_popup/main.dart';
// import 'package:hackin/pages/details_page.dart';
// import 'package:hackin/pages/details_page_participant.dart';
// import 'package:image_gallery_saver/image_gallery_saver.dart';

// import 'package:qrscan/qrscan.dart' as scanner;

// import 'src/SearchBar.dart';

class Activity{
  //TimeOfDay beginTime,TimeOfDay endTime, String name,String place,bool checked
  TimeOfDay beginTime;
  TimeOfDay endTime;
  String name;
  String place;
  bool checked;

  Activity(TimeOfDay beginTime,TimeOfDay endTime, String name,String place,bool checked ){
    this.beginTime=beginTime;
    this.endTime=endTime;
    this.name=name;
    this.place=place;
    this.checked=checked;
  }
  void checkActivity(){
    this.checked=true;
  }
}
class Activities{
  String day;
  int dayDate;
  var dayActivities= <Activity>[] ;
  Activities(String day,int dayDate, activities){
    this.day=day;
    this.dayDate=dayDate;
    this.dayActivities=activities;
  }
   addActivity(Activity a){
    this.dayActivities.add(a);
  }
}

List<Activities> days=[]; // i tried to manipulate the state by modifying this table and then set the state of the app
 // by copying this table to the table in the app state 

void init(){
  var a=<Activity>[];
  var a1=<Activity>[];
  a.add(  new Activity(TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 8, minute: 0),'ww', 'Esi', false) );
  a1.add(  new Activity(TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 8, minute: 0),'ww', 'Esi', false) );
  a1.add(  new Activity(TimeOfDay(hour: 8, minute: 0), TimeOfDay(hour: 8, minute: 0),'ww', 'Esi', false) );
       
    
  addDay('Friday', 15, a);
  addDay('Saturday', 16, a1);
}

var myApp=new MyApp();

void miseAJour(){
  myApp.myHomePage.homePage.maj();
}

void addDay(String day,int dayDate,List<Activity> activities){
    days.add( new Activities(day,dayDate,activities) );
   
  
}

void addActivity(int day,int beginTimeHour,int beginTimeminute,int endTimeHour,int endTimeMinute, String name,String place,bool checked){
  days[day-1].addActivity( new Activity(TimeOfDay(hour: beginTimeHour, minute: beginTimeminute), TimeOfDay(hour: endTimeHour, minute: endTimeMinute),name, place, checked));
 
}

void checkActivity(int day,int nmrActivity,bool checked){
  days[day-1].dayActivities[nmrActivity-1].checked=checked;

}

void main() { 
  init();
  runApp(myApp);
addActivity(1, 8, 0,  8, 0,'test', 'Esi', false); 
addActivity(1, 8, 0,  8, 0,'test', 'Esi', false); 
checkActivity(1, 2, true);
addActivity(1, 8, 0,  8, 0,'test', 'Esi', false); 
addActivity(1, 8, 0,  8, 0,'test', 'Esi', false); 
addActivity(1, 8, 0,  8, 0,'test', 'Esi', false); 
addActivity(1, 8, 0,  8, 0,'test', 'Esi', false);  
addActivity(1, 8, 0,  8, 0,'test', 'Esi', true);    

miseAJour();

}



class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final myHomePage=new  MyHomePage(title: 'Flutter Demo Home Page');
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // theme: ThemeData(
     debugShowCheckedModeBanner: false, 
     
      //   primarySwatch: Colors.blue,
      // ),
      home: myHomePage, 
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);


  final String title;
  final homePage=new _MyHomePageState();

  @override
  _MyHomePageState createState() => homePage;
}

class _MyHomePageState extends State<MyHomePage> {
 
  List<Activities> _days=[];
  int _day=0;
 
  
  void initState(){
     
    _days=days;
   
  }
  
  void maj(){
    setState(() {
      _days=days;
    });
  }
 

  void _nextDay(){
    var a=this._day;
    if (a!=(_days.length-1)){ 
      a++;
    } 
 
    setState(() {
      _day=a;
     
    });
 
  }
   
  void  _previousDay(){
    var a=this._day;
    if (a!=0){
      a--;
    }
    
    setState(() {
      this._day=a;
    });
 
  }
   
  Widget buildUpperPage(){
   
    return  Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.only(top:27,right: 25,left: 25),
            decoration: BoxDecoration(
              border: Border(
                bottom:BorderSide(
                color: Color(0xFFE6E6E6), 
                
              ),
              )
            ),
            child: Column(
              children: <Widget>[
                Stack(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: <Widget>[
                    Text('Home',
                    style: TextStyle(
                          fontFamily: 'Nunito-Bold', 
                          fontSize: 24,
                          color: Color(0xFF030F09),
                          fontWeight: FontWeight.bold,
                        ),
                    ),
                    //logo
                    Center(
                      child: Image.asset('assets/logo/logo.png',
                      width: 51, 

                      ),
                    ), 
                    Positioned(
                      right: 0, 
                       child: Row(
                        children: <Widget>[
                          Container(
                            child:IconButton(
                             icon:Icon(myicons.MyFlutterApp.layer_2),    
                             onPressed: (){

                             },
                          ),
                          margin: EdgeInsets.only(right:0),
                          ),
                          IconButton(
                              icon:Icon(
                        myicons.MyFlutterApp.dashboard,
                      ),
                      onPressed: (){

                      },
                          )
                        ],
                      ),
                    ),
                    
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, 
                  children: <Widget>[
                    IconButton(
                      icon: Icon(myicons.MyFlutterApp.left_open_big,size: 33,   
                      color:(this._day==0)? Colors.grey : Colors.black, 
                      ), 
                       onPressed: _previousDay,
                       ),
                    
                    Column(
                       
                      children: <Widget>[
                        Text(this._days[_day].day,    
                        style: TextStyle(
                          fontFamily: 'Nunito',   
                          fontSize: 20,
                          color: Color(0xFF030F09)
                        ),
                        ),
                        Text(this._days[_day].dayDate.toString(), 
                        style: TextStyle(
                           fontFamily: 'Nunito',     
                          fontSize: 60,
                          color: Color(0xFF030F09),
                          fontWeight: FontWeight.bold,
                        ),
                        )
                      ],
                    ),
                    IconButton(
                      icon: Icon(myicons.MyFlutterApp.right_open_big,size: 33,  
                      
                     color:(this._day==(this._days.length-1))? Colors.grey : Colors.black,    
                     
                    ),
                       onPressed: _nextDay, 
                       ),
                  ],
                )
              ],
            ),
          );
      
  }

  Widget buildBody(){
    return Container(
            height: 0.529*MediaQuery.of(context).size.height,   
            margin: EdgeInsets.fromLTRB(0, 17, 0, 0), 
            color: Colors.white,  

            child: Stack(
              children: <Widget>[
                //first : timeline
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 9,
                      height: 9, 
                      margin: EdgeInsets.fromLTRB(40, 0, 0, 0), 
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF707070), 
                      ),
                    ),
                    Container(
                    height: 0.5*MediaQuery.of(context).size.height,  
                    width: 0,
                    margin: EdgeInsets.fromLTRB(44.65, 0, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xFF707070),
                      ),
                    ),
                  ),
                   Container(
                      width: 12,
                      height: 12, 
                      margin: EdgeInsets.fromLTRB(39, 0, 0, 0),  
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,  
                        border: Border.all(
                        color: Color(0xFF707070),
                      ),
                      ),
                    ),
                  ],
                ),
                 
                
                //second : activities
             Container(
                margin: EdgeInsets.fromLTRB(0, 9, 0,11),           
                
                child: buildActivities(), 
        
                ),
             

            
              ],
            ),
          );
  }

 Widget buildActivity(TimeOfDay beginTime,TimeOfDay endTime, String name,String place,bool checked){
   return Container(
                  margin: EdgeInsets.fromLTRB(36, 0, 0, 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,  
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      //the check icon
                      Container(
                        width: 17,
                        height: 17,
                        margin: EdgeInsets.fromLTRB(0, 18, 9, 0),
                        decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: checked?Color(0xFFA9206D):Colors.white ,
                        border: checked?Border.all(width: 0,color: Colors.white): Border.all(color: Color(0xFF34A8D8)), 
                        ),
                        child: checked? Icon(Icons.check, size: 13, color: Colors.white,):SizedBox(), 
                        ), 
                      //second child:the activity
                      Stack(
                        children: <Widget>[
                          Container(
                            width: 260,
                            height: 74,
                            margin: EdgeInsets.fromLTRB(9, 0, 0,0),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                 boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.16),
                                    blurRadius: 6.0, // has the effect of softening the shadow
                                    spreadRadius: 0.0, // has the effect of extending the shadow
                                    offset: Offset(
                                      00.0, // horizontal, move right 10
                                      3.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                              ),
                          ),
                          Container(
                             width: 20,
                            height: 20,
                            margin: EdgeInsets.fromLTRB(0, 18, 0,0), 
                           
                              child: Transform.rotate(angle: math.pi / 4,
                              child: Container(
                                decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                color: Colors.white,
                                boxShadow: [
                                BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.16),
                                    blurRadius: 1,  // has the effect of softening the shadow
                                    spreadRadius: 0.0, // has the effect of extending the shadow
                                    offset: Offset(
                                      -1, // horizontal, move right 10
                                      1,  // vertical, move down 10
                                    ),
                                  )],
                              ),
                              ),
                              ),

                          ),
                           
                           Container(
                             padding: EdgeInsets.fromLTRB(24, 8.5, 0, 8),
                              
                              width: 269,
                              height: 74,

                              child: Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,        
                              children: <Widget>[
                                Icon(Icons.access_time, 
                                size: 10,
                                
                                ),
                                Icon(myicons.MyFlutterApp.work, 
                                size: 10,
                                ),
                                Icon(myicons.MyFlutterApp.place, 
                                size: 10,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 4, 
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisAlignment: MainAxisAlignment.spaceAround,  
                              children: <Widget>[
                                Text(beginTime.format(context)+' - '+endTime.format(context),   
                                style: TextStyle(fontSize: 12,
                                  fontFamily: 'Nunito' 
                                ),
                                ),
                                Text(name,
                                style: TextStyle(fontSize: 12,
                                  fontFamily: 'Nunito' ),
                                ),
                                Text(place,
                                style: TextStyle(fontSize: 12,
                                  fontFamily: 'Nunito' ),  
                                ), 

                              ],
                            ),
                          ],
                        ),
                      ),
                        
                        ],
                            
                      ),
                      ],
                  ),
                );
           
        
 }

  ListView buildActivities(){

   var a= <Widget>[];
   for (var i = 0; i < this._days[_day].dayActivities.length; i++) {
     a.add( buildActivity(this._days[_day].dayActivities[i].beginTime,this._days[_day].dayActivities[i].endTime, this._days[_day].dayActivities[i].name , this._days[_day].dayActivities[i].place, this._days[_day].dayActivities[i].checked));
   }
   return ListView(
    //  padding: EdgeInsets.only(top:6),
          
     children: a,
   );

 }

  @override
  Widget build(BuildContext context) {
    // this.initState();    
    return Scaffold(
      backgroundColor: Colors.white,

      body:Column(
        children: <Widget>[
          buildUpperPage(), 
            //body
          buildBody(),
        ],
      ),
      
      
     
       bottomNavigationBar: Container(
         height: 64,
          decoration: BoxDecoration(
             boxShadow: [
                              BoxShadow(
                                    color: Color.fromRGBO(0, 0, 0, 0.16),
                                    blurRadius: 6.0, // has the effect of softening the shadow
                                    spreadRadius: 0.0, // has the effect of extending the shadow
                                    offset: Offset(
                                      00.0, // horizontal, move right 10
                                      -3.0, // vertical, move down 10
                                    ),
                                  )
                                ],
          ),
         child: BottomAppBar(
          color: Colors.white,
          
          child: Stack(
            // mainAxisSize: MainAxisSize.max,
            // mainAxisAlignment: MainAxisAlignment.start,    
            children: <Widget>[
              //home
              Positioned(
                left:32.5,   
                
                child: Container(
                  height: 64,
                  child:Row(
                    
                    children: <Widget>[
                      Container(
                      margin: EdgeInsets.only(right:5), 
                      width: 34, 
                      height: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,  
                        color: Color(0xFFA9206D),
                        
                      ),
                ),
                      Container(
                        
                      
                     
                        child: Text('HOME',
                        style: TextStyle(
                        
                          fontFamily: 'BebasNeue' ,     
                          fontSize: 13,
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.bold,
                        ),
                        ),
                      )
                    ],
                  ),
          ),
              ),
              // the home icon
             Positioned( 
               left: 31,
               child: Container(
                 width: 34,
                 height: 64, 
                 child: IconButton(   
                                icon: Icon( 
                                  myicons.MyFlutterApp.home,
                                  color: Colors.white,  
                                  size: 20,   
                                ),
                                onPressed: () {
                                  
                                },
                              
                              ),
               ),
             ),
              // scan
               Center( 
                 child: Container(
                  // margin: EdgeInsets.only(right:90),   
                  child: IconButton(
                    icon: Icon(
                      myicons.MyFlutterApp.groupe_7,  
                      color: Colors.black,
                      size: 23,
                    ),
                    onPressed: () {
                     
                         
                    },
                  ),
              ),
               ),
             
              Positioned(
                
                right: 54,
              
                  child: Container(
                 height: 64,
                  child: IconButton(
                    icon: Icon(
                      myicons.MyFlutterApp.groupe_3, 
                      color: Colors.black,
                      size: 20, 
                    ),
                    onPressed: () {
                     
                   
                    },
                  ),
                ),
              )
            ],
          ),
      ),
       ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
 