import 'dart:developer';
import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:image_picker/image_picker.dart';
import 'package:staffs/DBfirebase/dbFunctions.dart';
import 'package:staffs/DBfirebase/staff.dart';
import '../Constants/constant.dart';

class StaffEntry extends StatefulWidget {
  const StaffEntry({super.key});

  @override
  State<StaffEntry> createState() => _StaffEntryState();
}

class _StaffEntryState extends State<StaffEntry>
    with SingleTickerProviderStateMixin {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  // Initial Selected Value
  String dropdownvalue = 'HR';
  var items = [
    'HR',
    'FINANCE',
    'MARKETING',
    'HOUSE KEEPING',
  ];
  bool isLoading = false;
  final picker = ImagePicker();
  late File _imageFile;
  Future pickImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = File(pickedFile.path);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _ageController.dispose();
    _phoneController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'User Name',
              hintText: 'Enter Your Name',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _ageController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'User Age',
              hintText: 'Enter Your Age',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'User Phone No.',
              hintText: 'Enter Your Phone Number',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              const Text(
                "Department",
                style: TextStyle(color: Colors.purple),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: DropdownButton(
                  // Initial Value
                  value: dropdownvalue,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),

                  // Array list of items
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
              onPressed: () async {
                await pickImage();
              },
              child: const Text("Select Profile Photo")),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Colors.purple,
                  strokeWidth: 8,
                )
              : ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    String count = await DBfunctions.getCount();
                    String _id = _nameController.text + count;
                    log(_id);
                    String url = await DBfunctions.uploadImageToFirebase(
                        _imageFile, _id);

                    await DBfunctions.setStaff(User(
                        id: _id,
                        name: _nameController.text,
                        age: int.parse(_ageController.text),
                        phone: int.parse(_phoneController.text),
                        dept: dropdownvalue,
                        imgUrl: url));
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Data Added Succesfully"),
                    ));
                    bool comp = await DBfunctions.setCount();
                    setState(() {
                      if (comp) {
                        isLoading = false;
                      } else {
                        isLoading = true;
                      }
                    });
                    dispose();
                  },
                  child: const Text("Save Data")),
        ),
      ],
    ));
  }
}
