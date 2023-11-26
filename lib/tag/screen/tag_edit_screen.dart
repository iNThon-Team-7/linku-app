import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:linku/common/component/custom_button.dart';
import 'package:linku/common/component/custom_outlined_button.dart';
import 'package:linku/common/layout/default_layout.dart';
import 'package:linku/tag/component/selectable_tag_view.dart';
import 'package:linku/tag/model/tag_model.dart';
import 'package:linku/tag/provider/tag_provider.dart';
import 'package:linku/tag/provider/tag_selection_provider.dart';
import 'package:linku/user/provider/user_provider.dart';

class TagEditScreen extends ConsumerWidget {
  const TagEditScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagSelection = ref.watch(tagSelectionProvider);
    final tags = ref.watch(tagProvider);

    onTap(TagModel tag) {
      if (tagSelection.contains(tag)) {
        ref.read(tagSelectionProvider.notifier).remove(tag);
      } else {
        ref.read(tagSelectionProvider.notifier).add(tag);
      }
    }

    return DefaultLayout(
      title: 'Tag Edit',
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.0.w,
          vertical: 12.0.h,
        ),
        child: Column(
          children: [
            Flexible(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 70.w,
                    child: CustomOutlinedButton(
                      text: tagSelection[index].name,
                      onPressed: () {},
                      isSelected: true,
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 6.0.w);
                },
                itemCount: tagSelection.length,
              ),
            ),
            SizedBox(height: 12.0.h),
            Flexible(
              flex: 15,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: tags.length,
                itemBuilder: (context, index) {
                  if (index % 2 == 0) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectableTagView.fromModel(
                          tags[index],
                          tagSelection.any(
                            (element) => element.id == tags[index].id,
                          ),
                          () => onTap(tags[index]),
                        ),
                        SizedBox(width: 12.0.w),
                        if (index + 1 < tags.length)
                          SelectableTagView.fromModel(
                            tags[index + 1],
                            tagSelection.any(
                              (element) => element.id == tags[index + 1].id,
                            ),
                            () => onTap(tags[index + 1]),
                          ),
                      ],
                    );
                  }
                  return SizedBox(height: 12.0.h);
                },
              ),
            ),
            CustomButton(
              text: 'Save',
              onPressed: () {
                ref.read(userProvider.notifier).getMe();
                context.pop();
              },
            ),
          ],
        ),
      ),
    );
  }
}
