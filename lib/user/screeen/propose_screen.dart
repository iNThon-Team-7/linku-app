import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:date_time_picker_selector/date_time_picker_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_selector/number_selector.dart';
import 'package:search_choices/search_choices.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final isOnlineProvider = StateProvider.autoDispose<bool>((ref) => false);

class ProposeScreen extends ConsumerStatefulWidget {
  const ProposeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProposeScreenState();
}

class _ProposeScreenState extends ConsumerState<ProposeScreen> {
  final tags = List.generate(10, (index) => 'suggest $index');
  int filterValue = 2;
  int minAge = 0;
  int maxAge = 100;
  String title = '';
  String tag = '';
  String place = '';
  String content = '';
  int maxPeople = 1;
  String dateTime = '';


  @override
  Widget build(BuildContext context) {
    bool isOnline = ref.watch(isOnlineProvider);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AnimatedToggleSwitch<int>.rolling(
                  current: filterValue,
                  iconBuilder: (i, isActive) {
                    String label;
                    Color textColor;
                    switch (i) {
                      case 0:
                        label = "남자만";
                        textColor = isActive ? Colors.red : Colors.grey;
                        break;
                      case 1:
                        label = "여자만";
                        textColor = isActive ? Colors.green : Colors.grey;
                        break;
                      case 2:
                        label = "무관";
                        textColor = isActive ? Colors.blue : Colors.grey;
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
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 10,left: 10),
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
                      boxShadow: const [
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
                        indicatorColor: b ? Colors.red : Colors.green),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextField(
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(
                  hintText: '제목을 입력해주세요',
                  labelText: '제목',
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(padding: EdgeInsets.all(10), child: Text('태그')),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SearchChoices.single(
                items: tags
                    .map(
                      (tag) => DropdownMenuItem(
                        value: tag,
                        child: Text(tag),
                      ),
                    )
                    .toList(),
                // value: selectTagValue,
                value:tag,
                hint: "Select one",
                onChanged: (value) {
                    tag = value;
                },
                isExpanded: true,
              ),
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


            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
              child: TextField(
                onChanged: (value) {
                  place = value;
                },
                readOnly: isOnline,
                decoration: InputDecoration(
                  hintText: '장소를 입력해주세요',
                  labelText: '장소',
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(padding: EdgeInsets.all(10), child: Text('최소나이')),
            ),
            NumberSelector(
              current: 1,
              min: 1,
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
              current: 100,
              min: 1,
              max: 100,
              onUpdate: (number) {
                maxAge = number;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextField(
                onChanged: (value) {
                  content = value;
                },
                decoration: InputDecoration(
                  hintText: '내용을 입력해주세요',
                  labelText: '내용',
                ),
              ),
            ),
            //filter

            SizedBox(height: 16.0),
            //submit
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                      final rettitle =  title;
                      final rettag = tag;
                      final retmaxAge = maxAge;
                      final retminAge = minAge;
                      final retisOnline = isOnline;
                      final retplace = place;
                      final retcontent = content;
                      final retmaxPeople = maxPeople;
                      final retdatetime = dateTime;//2023-11-29 23:12
                      final retfilterValue = filterValue>2?"무관":filterValue==0?"남자만":"여자만";

                  },
                  child: Text('제출하기'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
