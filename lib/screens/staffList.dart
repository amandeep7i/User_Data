import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:staffs/Constants/routes.dart';
import 'package:staffs/DBfirebase/dbFunctions.dart';
import 'package:staffs/DBfirebase/staff.dart';
import 'package:staffs/screens/staffDetails.dart';

class StaffList extends StatefulWidget {
  final List<User> list;
  const StaffList({super.key, required this.list});
  @override
  State<StaffList> createState() => _StaffListState();
}

class _StaffListState extends State<StaffList> {
  /// Will used to access the Animated list
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  /// This holds the items
  List<User> _items = [];

  /// This holds the item count
  int counter = 0;
  Widget slideIt(BuildContext context, int index, animation) {
    log("items" + _items.toString());
    User item = _items[index];
    TextStyle? textStyle = Theme.of(context).textTheme.headline4;
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(animation),
      child: SizedBox(
        // Actual widget to display
        height: 128.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(item.imgUrl), fit: BoxFit.fill)),
            ),
            Card(
              color: Colors.white,
              child: TextButton(
                  onPressed: () {
                    log("clicked itme");
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => StaffDetails(
                                  user: item,
                                )));
                  },
                  child: Text(item.name)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _items = widget.list;
    return Scaffold(
        body: AnimatedList(
      key: listKey,
      initialItemCount: _items.length,
      itemBuilder: (context, index, animation) {
        return slideIt(context, index, animation); // Refer step 3
      },
    ));
  }
}
