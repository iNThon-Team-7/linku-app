import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.title,required this.imageUrl, required this.subTitle});
  final String title;
  final String imageUrl;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 8,
        child: ListTile(
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 18, vertical: 10.0),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              height: 50.h,
              width: 50.h,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          subtitle: Text(
            subTitle,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
          ),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}
