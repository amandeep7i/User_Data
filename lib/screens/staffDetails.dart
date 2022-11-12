import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:staffs/DBfirebase/staff.dart';

class StaffDetails extends StatefulWidget {
  final User user;
  const StaffDetails({super.key, required this.user});

  @override
  State<StaffDetails> createState() => _StaffDetailsState();
}

class _StaffDetailsState extends State<StaffDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(widget.user.imgUrl),
                        fit: BoxFit.fill)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                widget.user.name,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Age: ${widget.user.age}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Mobile: ${widget.user.phone}"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Department: ${widget.user.dept}"),
            ),
          ],
        ),
      ),
    );
  }
}
