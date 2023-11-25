import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:date_time_picker_selector/date_time_picker_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:number_selector/number_selector.dart';
import 'package:search_choices/search_choices.dart';

final isOnlineProvider = StateProvider.autoDispose<bool>((ref) => false);
final selectTagValueProvider = StateProvider.autoDispose<String>((ref) => '');

class ProposeScreen extends ConsumerStatefulWidget {
  const ProposeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProposeScreenState();
}

class _ProposeScreenState extends ConsumerState<ProposeScreen> {
  final tags = List.generate(10, (index) => 'suggest $index');

  @override
  Widget build(BuildContext context) {
    bool isOnline = ref.watch(isOnlineProvider);
    String selectTagValue = ref.watch(selectTagValueProvider);

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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: '제목을 입력해주세요',
                  labelText: '제목',
                ),
              ),
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
                value: selectTagValue,
                hint: "Select one",
                onChanged: (value) {
                  ref.read(selectTagValueProvider.notifier).state = value;
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
                // Your magic here
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
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: EdgeInsets.all(10),
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextField(
                readOnly: isOnline,
                decoration: InputDecoration(
                  hintText: '장소를 입력해주세요',
                  labelText: '장소',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
