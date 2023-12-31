import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProposeCard extends StatelessWidget {
  const ProposeCard(
      {super.key,
      required this.title,
      required this.imageUrl,
      required this.startDate});

  final String title;
  final String imageUrl;
  final String startDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Card(
        color: Colors.white,
        elevation: 8,
        child: ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.fill,
              height: 60.h,
              width: 60.h,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            startDate.substring(0, 4) +
                '년 ' +
                startDate.substring(4, 6) +
                '월 ' +
                startDate.substring(6, 8) +
                '일' +
                startDate.substring(8, 10) +
                '시' +
                startDate.substring(10, 12) +
                '분' + '에 모임',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
