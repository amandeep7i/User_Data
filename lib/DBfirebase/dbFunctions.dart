import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:staffs/DBfirebase/staff.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DBfunctions {
  static late FirebaseDatabase database;
  static late DatabaseReference ref;
  static late FirebaseStorage storage;
  static late Reference storageRef;
  static void DBInitalize() {
    database = FirebaseDatabase.instance;
    ref = FirebaseDatabase.instance.reference();
    storage = FirebaseStorage.instance;
    storageRef = FirebaseStorage.instance.ref().child("images");
  }

  static Future<bool> setStaff(User value) async {
    try {
      await ref.child('Staffs/${value.id}').set({
        "_id": value.id,
        "name": value.name,
        "age": value.age,
        "phone": value.phone,
        "dept": value.dept,
        "imgUrl": value.imgUrl
      });
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<List<User>> getStaffList() async {
    List<User> val = [];
    dynamic value, data, temp;
    await ref.child("Staffs").once().then((DataSnapshot snapshot) {
      value = snapshot.value;
      log("$value");
      for (var temp in value.values) {
        log(temp['_id']);
        val.add(User(
          age: temp["age"],
          dept: temp['dept'],
          id: temp['_id'],
          imgUrl: temp['imgUrl'],
          name: temp['name'],
          phone: temp['phone'],
        ));
      }
    });

    return val;
  }

  static Future<String> getCount() async {
    String val = "0";
    ref.child("count").onValue.listen((event) {
      val = event.snapshot.value.toString();
    });
    log("getCount $val");
    return val;
  }

  static Future<bool> setCount() async {
    try {
      String val = await getCount();
      ref.child("count").update({"count": int.parse(val) + 1});
      log("setCount $val+1");
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  static Future<String> getStaffImg(
      BuildContext context, String imgPath) async {
    String url = await storageRef.child(imgPath).getDownloadURL();
    log("getStaffImg $url");
    return url;
  }

  static Future<String> uploadImageToFirebase(
      File _imageFile, String id) async {
    String fileName = _imageFile.path.toString();
    String url = "";
    UploadTask uploadTask = storageRef.child("$id").putFile(_imageFile);
    await uploadTask
        .whenComplete(() => uploadTask.snapshot.ref.getDownloadURL().then(
              (value) => url = value,
            ));
    log("upload image to firebase $url");
    return url;
  }
}
