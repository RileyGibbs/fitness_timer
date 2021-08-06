import 'package:flutter/material.dart';
import 'styles.dart';

class LapListView extends StatelessWidget {
  LapListView({Key? key, required this.lapList,}) : super(key: key);

  final List<Duration> lapList;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: lapList.length,
      itemBuilder: (context, index) => ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: standardPadding * 2),
        leading: Text(
          'Lap ${index + 1}',
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
        title: Text(
          '${lapList[index].toString()}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ),
  );
}