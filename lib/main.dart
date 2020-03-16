import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_beautiful_popup/main.dart';
import 'package:hackin/pages/details_page.dart';
import 'package:hackin/pages/details_page_participant.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

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




 Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

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
              Text(record.nom,style: TextStyle(fontWeight: FontWeight.w500),)
            ]),
            Row(children: <Widget>[
              Icon(Icons.person,color: Colors.grey,),
              SizedBox(width: 4,),
              Text(record.role,style: TextStyle(color: Colors.grey),)
            ]),
            Row(children: <Widget>[
              Icon(Icons.person,color: Colors.grey,),
              SizedBox(width: 4,),
              Text(record.status,style: TextStyle(color: Colors.grey),)
            ]),Row(children: <Widget>[
              Icon(Icons.school,color: Colors.grey,),
              SizedBox(width: 4,),
              Text(record.organization,style: TextStyle(color: Colors.grey),)
            ])
          ],))
       ])
   ),
       onTap: (){
         print(record.nom);
          Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            details_participant(nom: record.nom,)
                                ),
                      );
       },)
     ;
  }  
 
  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }


Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('Participants').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

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
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountEmail: new Text("hi_aouadj@esi.dz"),
                accountName: new Text("Nassim"),
                currentAccountPicture: new GestureDetector(
                  child: new CircleAvatar(
                    backgroundImage: new NetworkImage(currentProfilePic),
                  ),
                  onTap: () => print("This is your current account."),
                ),
                otherAccountsPictures: <Widget>[
                  new GestureDetector(
                    child: new CircleAvatar(
                      backgroundImage: new NetworkImage(otherProfilePic),
                    ),
                    onTap: () => switchAccounts(),
                  ),
                ],
                decoration: new BoxDecoration(
                    image: new DecorationImage(
                        image: new NetworkImage(
                            "https://img00.deviantart.net/35f0/i/2015/018/2/6/low_poly_landscape__the_river_cut_by_bv_designs-d8eib00.jpg"),
                        fit: BoxFit.fill)),
              ),
              new ListTile(
                  title: new Text("Profil"),
                  trailing: new Icon(Icons.arrow_upward),
                  onTap: () {
                    /*igator.of(context).pop();
                Navigator.of(context).push(new MaterialPNavageRoute(builder: (BuildContext context) => new Page("First Page")));*/
                  }),
              new ListTile(
                  title: new Text(""),
                  trailing: new Icon(Icons.arrow_right),
                  onTap: () {
                    /* Navigator.of(context).pop();
                Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new Page("Second Page")));*/
                  }),
              new Divider(),
              new ListTile(
                title: new Text("Cancel"),
                trailing: new Icon(Icons.cancel),
                onTap: () => Navigator.pop(context),
              ),
            ],
          ),
        ),
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

  Future<String> _scan(BuildContext context) async {
    int i = 0;
    bool checked;
    String barcode = await scanner.scan();
    DateTime startTime = DateTime(2020, 3, 07, 12, 00);
    DateTime endTime = DateTime(2020, 3, 07, 17, 30);
    String tache = "IsChecked";
    final currentTime = DateTime.now();

    if (currentTime.isAfter(startTime) && currentTime.isBefore(endTime)) {
      if (barcode == null) {
        print('nothing return.');
      } else {
        this._outputController.text = barcode;

        DocumentReference documentReference =
            Firestore.instance.collection("Praticipant").document(barcode);
        documentReference.get().then((datasnapshot) {
          if (datasnapshot.exists) {
            checked = datasnapshot.data['IsChecked'];

            if (checked) {
              SnackBar sk = SnackBar(content: Text('Error'));
            } else {
              createPopUp(context);
              Firestore.instance
                  .collection('Praticipant')
                  .document(barcode)
                  .updateData({
                'IsChecked': true,
              });
            }
          } else {
            print("No such user");
          }
        });
      }
    }
    startTime = DateTime(2020, 3, 06, 16, 30);
    endTime = DateTime(2020, 3, 06, 19, 30);
    tache = "Breakfest";

    if (currentTime.isAfter(startTime) && currentTime.isBefore(endTime)) {
      if (barcode == null) {
        print('nothing return.');
      } else {
        this._outputController.text = barcode;

        DocumentReference documentReference =
            Firestore.instance.collection("Praticipant").document(barcode);
        documentReference.get().then((datasnapshot) {
          if (datasnapshot.exists) {
            checked = datasnapshot.data[tache];

            if (checked) {
            } else {
              Firestore.instance
                  .collection('Praticipant')
                  .document(barcode)
                  .updateData({
                tache: true,
              });
            }
          } else {
            print("No such user");
          }
        });
      }
    }
    return tache;
  }

  Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    this._outputController.text = barcode;
  }

  Future _scanPath(String path) async {
    String barcode = await scanner.scanPath(path);
    this._outputController.text = barcode;
  }

  Future _generateBarCode(String inputCode) async {
    Uint8List result = await scanner.generateBarCode(inputCode);
    this.setState(() => this.bytes = result);
  }
}

Future<void> _ackAlert(BuildContext context) {
  print("###################################################");
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Not in stock'),
        content: const Text('This item is no longer available'),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

class Record{
 final String nom;
 final String role;
 final String status;
 final String organization;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['nom'] != null),
        assert(map['role'] != null),
        assert(map['status'] != null),
        assert(map['organization'] != null),
        nom = map['nom'],
        role = map['role'],
        status = map['status'],
        organization = map['organization'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

  @override
  String toString() => "Record<>";
}
