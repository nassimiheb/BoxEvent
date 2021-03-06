import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:hackin/pages/details_page.dart';
import 'package:hackin/pages/details_page_participant.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'controllers/dataHelper.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import 'src/SearchBar.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Uint8List bytes = Uint8List(0);
  TextEditingController _inputController;
  TextEditingController _outputController;
  String currentProfilePic =
      "https://avatars3.githubusercontent.com/u/16825392?s=460&v=4";
  String otherProfilePic =
      "https://yt3.ggpht.com/-2_2skU9e2Cw/AAAAAAAAAAI/AAAAAAAAAAA/6NpH9G8NWf4/s900-c-k-no-mo-rj-c0xffffff/photo.jpg";
  createPopUp(BuildContext context) {
    final popup = BeautifulPopup(
      context: context,
      template: TemplateAuthentication,
    );
    popup.show(
      title: 'Remarque',
      content:
          'Le scanne du Code QR est bien effectuer. Voulez-vous confirmer ? ( Cette action est irriversible )',
      actions: [
       
        popup.button(
          label: 'DONE',
          onPressed: Navigator.of(context).pop,
        ),
      ],
      // bool barrierDismissible = false,
      // Widget close,
    );
  }

  createPopUpFaux(BuildContext context) {
    final popup = BeautifulPopup(
      context: context,
      template: TemplateAuthentication,
    );
    popup.show(
      title: 'Confirmation',
      content: '',
      actions: [
        popup.button(
          label: 'NON',
          onPressed: Navigator.of(context).pop,
        ),
        popup.button(
          label: 'OUI',
          onPressed: Navigator.of(context).pop,
        ),
      ],
      // bool barrierDismissible = false,
      // Widget close,
    );
  }

  @override
  initState() {
    super.initState();
    this._inputController = new TextEditingController();
    this._outputController = new TextEditingController();
  }

  void switchAccounts() {
    String picBackup = currentProfilePic;
    this.setState(() {
      currentProfilePic = otherProfilePic;
      otherProfilePic = picBackup;
    });
  }

  @override
  Widget build(BuildContext context) {




 Widget _buildListItem(BuildContext context, String/*shouldnt be String it should be the type of the document that we bring fromDB*/ data) {
    
    /*Participant info from DB*/
    final String nom="";
    final String role="";
    final String status="";
     final String organization="";

    return 
       
    
     GestureDetector(
       child:  Container(
        padding: EdgeInsets.all(10),
       decoration: BoxDecoration(
         border: Border(bottom: BorderSide(width: 0.5,color: Colors.grey))
         
       ),
       child: Row(
         children:<Widget>[
            Center(
              child: Container(
                  height: 100,
                  width: 100,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      
                      child:Image.asset('assets/men.jpg'),
          
        ), 
                  ))),
          
          Container(
            margin: EdgeInsets.only(left:20),
            child:Column(
         crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            
            Row(children: <Widget>[
              Icon(Icons.person),
              SizedBox(width: 4,),
              Text(nom,style: TextStyle(fontWeight: FontWeight.w500),)
            ]),
            Row(children: <Widget>[
              Icon(Icons.person,color: Colors.grey,),
              SizedBox(width: 4,),
              Text(role,style: TextStyle(color: Colors.grey),)
            ]),
            Row(children: <Widget>[
              Icon(Icons.person,color: Colors.grey,),
              SizedBox(width: 4,),
              Text(status,style: TextStyle(color: Colors.grey),)
            ]),Row(children: <Widget>[
              Icon(Icons.school,color: Colors.grey,),
              SizedBox(width: 4,),
              Text(organization,style: TextStyle(color: Colors.grey),)
            ])
          ],))
       ])
   ),
       onTap: (){
         print(nom);
          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            details_participant(nom: nom,)
                                ),
                      );
       },)
     ;
  }  
 
  Widget _buildList(BuildContext context, List snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }


Widget _buildBody(BuildContext context) {
    return StreamBuilder/*difine the type*/(
      stream: null/*stream of participant*//*will not show anything now*/,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }



    return MaterialApp(
      home: Scaffold(
        appBar: SearchBar(
            defaultBar: AppBar(
              title: Text('Home'),
          backgroundColor: Colors.white,
          leading: new Padding(
            padding: const EdgeInsets.all(0.0),
            child: 
               Icon(
              Icons.menu,
              color: Colors.grey,
            ),
            
           
          ),
        )),
        backgroundColor: Colors.white,
        body: Center(
          child: Builder(
            builder: (BuildContext context) {
              return _buildBody(context);
              
            },
          ),
        ),


      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 50),
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                ),
                onPressed: () {
                  
                },
              ),
            ),
            Expanded(child: SizedBox()),
            Container(
              margin: EdgeInsets.only(right: 50),
              child: IconButton(
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                onPressed: () {
                  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            details_page()
                                ),
                      );
               
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {_scan(context)},
        tooltip: 'Take a Photo',
        child: const Icon(Icons.camera_alt),
      ),
      ),
    );
  }

  Widget _qrCodeWidget(Uint8List bytes, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        elevation: 6,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4), topRight: Radius.circular(4)),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(left: 40, right: 40, top: 30, bottom: 10),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 190,
                    child: bytes.isEmpty
                        ? Center(
                            child: Text('Empty code ... ',
                                style: TextStyle(color: Colors.black38)),
                          )
                        : Image.memory(bytes),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 7, left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            child: Text(
                              'remove',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue),
                              textAlign: TextAlign.left,
                            ),
                            onTap: () =>
                                this.setState(() => this.bytes = Uint8List(0)),
                          ),
                        ),
                        Text('|',
                            style:
                                TextStyle(fontSize: 15, color: Colors.black26)),
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () async {
                              final success =
                                  await ImageGallerySaver.saveImage(this.bytes);
                              SnackBar snackBar;
                              if (success) {
                                snackBar = new SnackBar(
                                    content:
                                        new Text('Successful Preservation!'));
                                Scaffold.of(context).showSnackBar(snackBar);
                              } else {
                                snackBar = new SnackBar(
                                    content: new Text('Save failed!'));
                              }
                            },
                            child: Text(
                              'save',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.blue),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Divider(height: 2, color: Colors.black26),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.history, size: 16, color: Colors.black38),
                  Text('  Generate History',
                      style: TextStyle(fontSize: 14, color: Colors.black38)),
                  Spacer(),
                  Icon(Icons.chevron_right, size: 16, color: Colors.black38),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            )
          ],
        ),
      ),
    );
  }

   _scan(BuildContext context) async {
    int i = 0;
    bool checked;
    String barcode = await scanner.scan();

    DateTime startTime = DateTime(2020, 3, 07, 12, 00);
    DateTime endTime = DateTime(2020, 3, 07, 17, 30);
   
   
    final currentTime = DateTime.now();
     DataHelper databaseHelper = new DataHelper();
    if (currentTime.isAfter(startTime) && currentTime.isBefore(endTime)) {
      if (barcode == null) {
        print('nothing return.');
      } else {
        this._outputController.text = barcode;
        /*Add check in here*/
        databaseHelper.editarProduct(barcode, "checkIn");
      }
    }
   
  
  }


}










