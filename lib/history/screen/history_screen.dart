import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linku/common/pagination/default_pagination_view.dart';
import 'package:linku/history/component/history_view.dart';
import 'package:linku/history/model/history_model.dart';
import 'package:linku/history/provider/history_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: DefaultPaginationView<HistoryModel>(
        provider: historyPaginationProvider,
        itemBuilder: (context, item, index) {
          return Column(
            children: [
              HistoryView.fromModel(item),
              SizedBox(height: 10.h),
            ],
          );
        },
      ),
    );
  }
}
