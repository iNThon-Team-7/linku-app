import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linku/user/provider/auth_provider.dart';
import 'package:textfield_tags/textfield_tags.dart';

class BoolSwitch extends StatefulWidget {
  BoolSwitch({super.key, required this.func, required this.isSwitched});

  bool isSwitched;
  final Function func;

  @override
  State<BoolSwitch> createState() => _BoolSwitchState();
}

class _BoolSwitchState extends State<BoolSwitch> {
  @override
  Widget build(BuildContext context) {
    return AnimatedToggleSwitch<bool>.dual(
      onChanged: (_) {
        setState(() {
          widget.isSwitched = !widget.isSwitched;
          widget.func!(!widget.isSwitched);
        });
      },
      current: widget.isSwitched,
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
      styleBuilder: (b) =>
          ToggleStyle(indicatorColor: b ? Colors.red : Colors.green),
      iconBuilder: (value) => value ? Icon(Icons.male) : Icon(Icons.female),
      textBuilder: (value) =>
          value ? Center(child: Text('남자')) : Center(child: Text('여자')),
    );
  }
}

class EditingField extends StatefulWidget {
  EditingField({Key? key,required this.controller}) : super(key: key);
  TextfieldTagsController controller;
  @override
  State<EditingField> createState() => _EditingFieldState();
}

class _EditingFieldState extends State<EditingField> {
  double _distanceToField = 0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldTags(
          textfieldTagsController: widget.controller,
          initialTags: const [
            'pick',
            'your',
            'favorite',
            'programming',
            'language'
          ],
          textSeparators: const [' ', ','],
          letterCase: LetterCase.normal,
          validator: (String tag) {
            if (tag == 'php') {
              return 'No, please just no';
            } else if (widget.controller.getTags!.contains(tag)) {
              return 'you already entered that';
            }
            return null;
          },
          inputfieldBuilder: (context, tec, fn, error, onChanged, onSubmitted) {
            return ((context, sc, tags, onTagDelete) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: tec,
                  focusNode: fn,
                  decoration: InputDecoration(
                    isDense: true,
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 74, 137, 92),
                        width: 3.0,
                      ),
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color.fromARGB(255, 74, 137, 92),
                        width: 3.0,
                      ),
                    ),
                    helperText: 'Enter language...',
                    helperStyle: const TextStyle(
                      color: Color.fromARGB(255, 74, 137, 92),
                    ),
                    hintText: widget.controller.hasTags ? '' : "Enter tag...",
                    errorText: error,
                    prefixIconConstraints:
                        BoxConstraints(maxWidth: _distanceToField * 0.74),
                    prefixIcon: tags.isNotEmpty
                        ? SingleChildScrollView(
                            controller: sc,
                            scrollDirection: Axis.horizontal,
                            child: Row(
                                children: tags.map((String tag) {
                              return Container(
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20.0),
                                  ),
                                  color: Color.fromARGB(255, 74, 137, 92),
                                ),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      child: Text(
                                        '#$tag',
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                      onTap: () {
                                        //print("$tag selected");
                                      },
                                    ),
                                    const SizedBox(width: 4.0),
                                    InkWell(
                                      child: const Icon(
                                        Icons.cancel,
                                        size: 14.0,
                                        color:
                                            Color.fromARGB(255, 233, 233, 233),
                                      ),
                                      onTap: () {
                                        onTagDelete(tag);
                                      },
                                    )
                                  ],
                                ),
                              );
                            }).toList()),
                          )
                        : null,
                  ),
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                ),
              );
            });
          },
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 74, 137, 92),
            ),
          ),
          onPressed: () {
            widget.controller.clearTags();
          },
          child: const Text('CLEAR TAGS'),
        ),
      ],
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  final TextEditingController nickNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextfieldTagsController tagsController = TextfieldTagsController();
  bool _isSwitched = false;

  void onSwitchChanged(bool value) {
    _isSwitched = value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Center(
                          child: Text(
                            '프로필',
                            style: TextStyle(fontSize: 30),
                          )),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(children: [
                          TextField(
                            controller: nickNameController,
                            decoration: InputDecoration(
                              hintText: '닉네임을 입력해주세요',
                              labelText: '닉네임',
                            ),
                          ),
                          TextField(
                            controller: ageController,
                            decoration: InputDecoration(
                              hintText: '나이을 입력해주세요',
                              labelText: '나이',
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: BoolSwitch(
                              func: onSwitchChanged,
                              isSwitched:_isSwitched,
                            ),
                          )
                        ]),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '관심사',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          )),
                      EditingField(controller: tagsController,),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.all(16),
                  child: MaterialButton(
                    onPressed: () {
                      // validation
                      if (nickNameController.text.isEmpty || ageController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('데이터를 입력해주세요'),
                          ),
                        );
                        return;
                      }
                      List tagList = [];
                      tagsController.getTags!.forEach((element) {
                        tagList.add(element);
                      });
                      final nickName = nickNameController.text;
                      final age = ageController.text;
                      final isMale = _isSwitched;
                      final tags = tagList;


                      //todo: send auth to server

                      //route to profile editting screen
                    },
                    padding: EdgeInsets.all(0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Color(0xffff6666),
                      ),
                      height: 54,
                      child: Center(
                          child: Text(
                            '완료',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

