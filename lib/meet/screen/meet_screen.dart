import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linku/common/pagination/default_pagination_view.dart';
import 'package:linku/meet/component/meet_view.dart';
import 'package:linku/meet/model/meet_model.dart';
import 'package:linku/meet/provider/meet_provider.dart';

class MeetPaginationScreen extends ConsumerWidget {
  const MeetPaginationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: DefaultPaginationView<MeetModel>(
        provider: meetPaginationProvider,
        itemBuilder: (context, item, index) {
          return Column(
            children: [
              MeetView.fromModel(item),
              SizedBox(height: 10.h),
            ],
          );
        },
      ),
    );
  }
}
