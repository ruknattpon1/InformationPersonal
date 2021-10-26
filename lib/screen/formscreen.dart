import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:information_personal/model/information.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  information myInformation = information();
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  CollectionReference _informationcollection =
      FirebaseFirestore.instance.collection("Personal Information");

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Error'),
            ),
            body: Center(
              child: Text('${snapshot.error}'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Register Information'),
            ),
            body: Center(
              child: Container(
                padding: EdgeInsets.all(20),
                child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'First Name',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: 'Please Fill Information'),
                            onSaved: (var fname) {
                              myInformation.fname = fname;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Last Name',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: 'Please Fill Information'),
                            onSaved: (var lname) {
                              myInformation.lname = lname;
                            },
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Gender',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            validator: RequiredValidator(
                                errorText: 'Please Fill Information'),
                            onSaved: (var gender) {
                              myInformation.Gender = gender;
                            },
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    formKey.currentState!.save();
                                    await _informationcollection.add({
                                      "fname": myInformation.fname,
                                      "lname": myInformation.lname,
                                      "Gender": myInformation.Gender,
                                    });
                                    formKey.currentState!.reset();
                                  }
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyle(fontSize: 20),
                                )),
                          )
                        ],
                      ),
                    )),
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      future: firebase,
    );
  }
}
