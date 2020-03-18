
import 'package:flutter/material.dart';

class details_participant  extends StatefulWidget {
  final String nom;

  const details_participant({Key key, this.nom}) : super(key: key);
  @override
  _details_participant  createState() => _details_participant ();
}

class _details_participant extends State<details_participant > {

    Widget _buildBody(BuildContext context) {
    return StreamBuilder/*difine the type*/(
      stream:null/*straem from DB using nom or an ID to get the other info the participant*/,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                   Navigator.pop(
                        context,
                        );
                      
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
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        tooltip: 'Take a Photo',
        child: const Icon(Icons.camera_alt),
      ),
      resizeToAvoidBottomInset: false,
     appBar: AppBar(title: Text("Détails",style: TextStyle(color: Colors.black),),backgroundColor: Colors.white,)
     ,
      body: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
              ),
          Center(
              child: Container(
                  height: 150,
                  width: 150,
                  child: CircleAvatar(
                   
                    backgroundColor: Colors.transparent,
                    child: ClipOval(
                      
                      child:Image.asset('assets/men.jpg'),
          
        ), 
                  ))),
          Container(
            margin: EdgeInsets.only(top: 20, bottom: 20),
            child: Text(widget.nom, style: TextStyle(fontSize: 18)),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text('Participant', style: TextStyle(fontSize: 16)),
          ),
          Divider(
            height: 30,
            thickness: 2,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: Text(
                "Activities",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          
          Divider(
            height: 30,
            thickness: 2,
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.3,
            child: _buildBody(context),
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, List snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, String /*see the comment on the same fonction in main.dart*/ data) {
    final bool ischecked=true;/*from DB*/

    return 
       Container(
        decoration: BoxDecoration(
         
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text('Check In'),
          trailing: ischecked ?Icon(Icons.check):Icon(Icons.close),
          onTap: () {},
        ),
     
    );
  }
  }

