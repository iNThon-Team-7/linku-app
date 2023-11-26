import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linku/common/style/default_text_style.dart';

class DefaultLayout extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final String? title;
  final Widget? titleWidget;
  final Widget? bottomNavigationBar;

  const DefaultLayout({
    required this.child,
    this.backgroundColor,
    this.title,
    this.titleWidget,
    this.bottomNavigationBar,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: defaultTextStyle,
      child: Scaffold(
        backgroundColor: backgroundColor ?? Colors.white,
        appBar: renderAppBar(context),
        body: child,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }

  AppBar? renderAppBar(BuildContext context) {
    if (title != null && title != '') {
      return AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          title!,
          style: defaultTextStyle.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        foregroundColor: Colors.black,
      );
    }
    if (titleWidget == null) {
      return null;
    }
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
          size: 20.w,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(right: 20.0.w),
        child: titleWidget,
      ),
      foregroundColor: Colors.black,
    );
  }
}
