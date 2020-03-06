
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:qrscan/qrscan.dart' as scanner;

void main() {
  runApp(MyApp());
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
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: new Text(""),
          backgroundColor: Colors.redAccent,
        ),
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
                  title: new Text(""),
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
              return Container(child: Text('dsdsds'),) ;
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _scan(),
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


  Future _scan() async {
    int i =0;
    String barcode = await scanner.scan();
    /*if (barcode == null) {
      print('nothing return.');
    } else {
      this._outputController.text = barcode;
     
     print(barcode.split(" ")[0]+"/"+barcode.split(" ")[1]+"/"+barcode.split(" ")[2]);
      Firestore.instance
          .collection('bus').document(barcode.split(" ")[0]).collection('seats').document(barcode.split(" ")[2])
          .updateData({
        'num': int.parse(barcode.split(" ")[1]),
        'primaryRes': true,
        'finalRes': true
      });
     
          
      
          
          
        
         
    }*/
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
class Seats {
  /*final int num;
  final bool primaryRes;
  final bool finalRes;
  final DocumentReference reference;
  Seats.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['num'] != null),
        assert(map['primaryRes'] != null),
        assert(map['finalRes'] != null),
        num = map['num'],
        primaryRes = map['primaryRes'],
        finalRes = map['finalRes'];
  Seats.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);*/
}