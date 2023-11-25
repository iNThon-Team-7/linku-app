import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:linku/user/screeen/widgets/profile_card.dart';
import 'package:search_choices/search_choices.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  final tags =
  List.generate(10, (index) => 'suggest $index');

  String selectedValueSingleDialog = 'suggest 0';
  Map<String, List> searchResults = {
    'Team D': [
      'Casey Zuniga',
      'Ayisha Burn',
      'Josie Hayden',
      'Kenan Walls',
      'Mario Powers',
    ],
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: SearchChoices.single(
                items: tags.map((tag) => DropdownMenuItem(
                  value: tag,
                  child: Text(tag),
                ),).toList(),
                value: selectedValueSingleDialog,
                hint: "Select one",
                onChanged: (value) {
                  setState(() {
                    selectedValueSingleDialog = value;
                    print(selectedValueSingleDialog);
                  });
                },
                isExpanded: true,
              ),
            ),
            Text(selectedValueSingleDialog),
            Container(
              height: 700.h,
              child: GroupListView(
                sectionsCount: searchResults.keys.toList().length,
                countOfItemInSection: (int section) {
                  return searchResults.values.toList()[section].length;
                },
                itemBuilder: (context, index){
                  return ProfileCard(
                    imageUrl: 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
                    title: 'Klay Lewis',
                  );
                },
                groupHeaderBuilder: (BuildContext context, int section) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    child: Text(
                      searchResults.keys.toList()[section],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
                sectionSeparatorBuilder: (context, section) => SizedBox(height: 10),
              ),
            ),
          ],
        ),
        ),
    );
  }
}

