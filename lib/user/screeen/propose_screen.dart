import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:date_time_picker_selector/date_time_picker_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:linku/common/component/custom_button.dart';
import 'package:linku/common/component/custom_outlined_button.dart';
import 'package:linku/common/component/custom_text_form_field.dart';
import 'package:linku/common/const/color.dart';
import 'package:linku/meet/provider/meet_proposal_provider.dart';
import 'package:linku/tag/model/tag_model.dart';
import 'package:linku/tag/provider/tag_provider.dart';
import 'package:linku/tag/provider/tag_selection_provider.dart';
import 'package:linku/tag/screen/tag_single_screen.dart';
import 'package:linku/user/model/user_model.dart';
import 'package:number_selector/number_selector.dart';
import 'package:search_choices/search_choices.dart';

final isOnlineProvider = StateProvider.autoDispose<bool>((ref) => false);

class ProposeScreen extends ConsumerStatefulWidget {
  const ProposeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProposeScreenState();
}

class _ProposeScreenState extends ConsumerState<ProposeScreen> {
  int filterValue = 2;
  int minAge = 0;
  int maxAge = 99;
  String title = '';
  String place = '';
  String content = '';
  int maxPeople = 1;
  String dateTime = '';
  @override
  Widget build(BuildContext context) {
    bool isOnline = ref.watch(isOnlineProvider);
    TagModel? tag = ref.watch(singleTagSelectionProvider).firstOrNull;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(30),
              child: Center(
                child: SizedBox(
                  width: 60.h,
                  height: 60.h,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedToggleSwitch<int>.rolling(
                  current: filterValue,
                  iconBuilder: (i, isActive) {
                    String label;
                    Color textColor;
                    switch (i) {
                      case 0:
                        label = "남자만";
                        textColor = isActive ? Color(0xFF007BFF) : Colors.grey;
                        break;
                      case 1:
                        label = "여자만";
                        textColor = isActive ? PRIMARY_COLOR : Colors.grey;
                        break;
                      case 2:
                        label = "무관";
                        textColor = isActive ? Color(0xFF009688) : Colors.grey;
                        break;
                      default:
                        label = "";
                        textColor = Colors.grey;
                        break;
                    }
                    return Text(
                      label,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                  values: const [0, 1, 2],
                  onChanged: (i) => setState(() => filterValue = i),
                  style: ToggleStyle(
                    indicatorColor: Colors.white,
                    borderColor: Colors.transparent,
                    backgroundColor: Colors.grey[200],
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 1.5),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  padding: EdgeInsets.all(5),
                  child: AnimatedToggleSwitch<bool>.dual(
                    onChanged: (_) {
                      ref.read(isOnlineProvider.notifier).state =
                          !ref.read(isOnlineProvider.notifier).state;
                    },
                    current: isOnline,
                    first: true,
                    second: false,
                    spacing: 50.0,
                    style: const ToggleStyle(
                      borderColor: Colors.transparent,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: Offset(0, 1.5),
                        ),
                      ],
                    ),
                    borderWidth: 5.0,
                    height: 55,
                    styleBuilder: (b) => ToggleStyle(
                      indicatorColor: b ? PRIMARY_COLOR : Color(0xFF009688),
                    ),
                    iconBuilder: (value) => value
                        ? Icon(Icons.computer)
                        : Icon(Icons.door_front_door_outlined),
                    textBuilder: (value) => value
                        ? Center(child: Text('온라인'))
                        : Center(child: Text('오프라인')),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(padding: EdgeInsets.all(10), child: Text('제목')),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8),
              child: CustomTextFormField(
                onChanged: (value) {
                  title = value;
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(padding: EdgeInsets.all(10), child: Text('태그')),
            ),
            CustomButton(
              text: '태그 선택하기',
              onPressed: () {
                context.push('/tag/single');
              },
            ),
            SizedBox(height: 10.h),
            CustomOutlinedButton(
              text: ref.watch(singleTagSelectionProvider).isEmpty
                  ? '태그를 선택해주세요'
                  : ref.watch(singleTagSelectionProvider).first.name,
              onPressed: () {},
              isSelected: ref.watch(singleTagSelectionProvider).isNotEmpty,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(padding: EdgeInsets.all(10), child: Text('최대인원')),
            ),
            NumberSelector(
              current: 1,
              min: 1,
              max: 50,
              onUpdate: (number) {
                maxPeople = number;
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: DateTimePicker(
                type: DateTimePickerType.dateTimeSeparate,
                dateMask: 'd MMM, yyyy',
                initialValue: DateTime.now().toString(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                icon: Icon(Icons.event),
                dateLabelText: 'Date',
                timeLabelText: "Hour",
                selectableDayPredicate: (date) {
                  return true;
                },
                onChanged: (val) => print(val),
                validator: (val) {
                  return null;
                },
                onSaved: (val) {
                  dateTime = val!;
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(padding: EdgeInsets.all(10), child: Text('장소')),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8),
              child: CustomTextFormField(
                onChanged: (value) {
                  place = value;
                },
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(padding: EdgeInsets.all(10), child: Text('최소나이')),
            ),
            NumberSelector(
              current: 20,
              min: 20,
              max: 100,
              onUpdate: (number) {
                minAge = number;
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(padding: EdgeInsets.all(10), child: Text('최고연령')),
            ),
            NumberSelector(
              current: 99,
              min: 20,
              max: 99,
              onUpdate: (number) {
                maxAge = number;
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(padding: EdgeInsets.all(10), child: Text('내용')),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: CustomTextFormField(
                onChanged: (value) {
                  content = value;
                },
                maxLines: 10,
              ),
            ),
            SizedBox(height: 16.0),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: CustomButton(
                  text: '제출하기',
                  onPressed: () async {
                    final rettitle = title;
                    final retmaxAge = maxAge;
                    final retminAge = minAge;
                    final retisOnline = isOnline;
                    final retplace = place;
                    final retcontent = content;
                    final retmaxPeople = maxPeople;
                    final retdatetime = dateTime; //2023-11-29 23:12
                    final retfilterValue = filterValue > 2
                        ? null
                        : filterValue == 0
                            ? Gender.M
                            : Gender.F;
                    if (tag == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('태그를 선택해주세요'),
                        ),
                      );
                      return;
                    }
                    ref.read(meetProposalProvider.notifier).updateState(
                          title: rettitle,
                          body: retcontent,
                          tagId: tag.id,
                          maxParticipants: retmaxPeople,
                          meetTime: DateTime.tryParse(retdatetime),
                          isOnline: retisOnline,
                          gender: retfilterValue,
                          location: retplace,
                          minAge: retminAge,
                          maxAge: retmaxAge,
                        );

                    await ref.read(meetProposalProvider.notifier).create();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
