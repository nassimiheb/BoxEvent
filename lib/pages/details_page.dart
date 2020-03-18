
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hackin/src/SearchBar.dart';

class details_page extends StatefulWidget {
  @override
  _details_pageState createState() => _details_pageState();
}

class _details_pageState extends State<details_page> {
  Widget _buildBody(BuildContext context) {
    return StreamBuilder/*define the type <Type>*/(
      stream: null,
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
              child: Text(
                'Organisateur',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              )),
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
            child: Text('Razof Khaled'/*<---from DB*/, style: TextStyle(fontSize: 18)),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            child: Text('Département Logistic'/*<---from DB*/, style: TextStyle(fontSize: 16)),
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

  Widget _buildList(BuildContext context, List/*see the comment on the same fonction in main.dart*/ snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, String/*see the comment on the same fonction in main.dart*/ data) {
    final bool task1 =true;/*getting the tasks of the orgniser from DB*/

    return 
       Container(
        decoration: BoxDecoration(
         
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
          title: Text('Activité'),
          trailing: Text(task1.toString()),
          onTap: () {},
        ),
     
    );
  }
}


