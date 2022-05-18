import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dock(),
    );
  }
}

class Dock extends StatefulWidget {
  const Dock({Key? key}) : super(key: key);

  @override
  State<Dock> createState() => _DockState();
}

class _DockState extends State<Dock> {

  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();

  var incomingName = "";
  var incomingSurname = "";
  var incomingGender = "";
  var incomingEmail = "";

  CreateData(){
    FirebaseFirestore.instance
        .collection("Users")
        .doc(t1.text)
        .set({'name': t1.text, 'surname': t2.text, 'gender': t3.text, 'email': t4.text})
        .whenComplete(() => print("text added"));
  }

  UpdateData(){
    FirebaseFirestore.instance
        .collection("Users")
        .doc(t1.text)
        .update({'name': t1.text, 'surname': t2.text, 'gender': t3.text, 'email': t4.text})
        .whenComplete(() => print("text updated"));
  }

  DeleteData(){
    FirebaseFirestore.instance
        .collection("Users")
        .doc(t1.text)
        .delete()
        .whenComplete(() => print("text deleted"));
  }

  ReadData(){
    FirebaseFirestore.instance
        .collection("Users")
        .doc(t1.text)
        .get()
        .then((incomingData) {
          setState(() {
            incomingName = incomingData.data()!['name'];
            incomingSurname = incomingData.data()!['surname'];
            incomingGender = incomingData.data()!['gender'];
            incomingEmail = incomingData.data()!['email'];
          });
    })
        .whenComplete(() => print("text read"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assignment 8"),
      ),
      body: Container(
        margin: EdgeInsets.all(5),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(child: TextField(controller: t1,
                    decoration: InputDecoration(
                        labelText: "Name",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,
                                width: 1.0)
                        )
                    ),))
                ],
              ),
              Row(
                children: [
                  Expanded(child: TextField(controller: t2,
                    decoration: InputDecoration(
                        labelText: "Surname",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,
                                width: 1.0)
                        )
                    ),))
                ],
              ),
              Row(
                children: [
                  Expanded(child: TextField(controller: t3,
                    decoration: InputDecoration(
                        labelText: "Gender",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,
                                width: 1.0)
                        )
                    ),))
                ],
              ),
              Row(
                children: [
                  Expanded(child: TextField(controller: t4,
                    decoration: InputDecoration(
                        labelText: "Email",
                        fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue,
                                width: 1.0)
                        )
                    ),))
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                RaisedButton(
                  color: Colors.green,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Create"),
                    textColor: Colors.white,
                    onPressed: CreateData),
                RaisedButton(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Read"),
                    textColor: Colors.white,
                    onPressed: ReadData),
                RaisedButton(
                    color: Colors.orange,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Update"),
                    textColor: Colors.white,
                    onPressed: UpdateData),
                RaisedButton(
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Text("Delete"),
                    textColor: Colors.white,
                    onPressed: DeleteData),
              ],),

              ListTile(
                title: Text(incomingName),
                subtitle: Text(incomingSurname),
              ),
              ListTile(
                title: Text(incomingEmail),
                subtitle: Text(incomingGender),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

