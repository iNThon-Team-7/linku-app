import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:linku/user/model/login_model.dart';
import 'package:linku/user/provider/auth_provider.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation =
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

    super.initState();
  }

  Map<String, List> _elements = {
    'Team A': [['Klay Lewis'], 'Ehsan Woodard', 'River Bains'],
    'Team B': ['Toyah Downs', 'Tyla Kane'],
    'Team C': ['Marcus Romero', 'Farrah Parkes', 'Fay Lawson', 'Asif Mckay'],
    'Team D': [
      'Casey Zuniga',
      'Ayisha Burn',
      'Josie Hayden',
      'Kenan Walls',
      'Mario Powers'
    ],
    'Team Q': ['Toyah Downs', 'Tyla Kane', 'Toyah Downs'],
  };

  @override
  Widget build(BuildContext context) {
    print(_elements.keys.toList().length);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
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
            ),
            Container(
              height: 700.h,
              child: GroupListView(
                sectionsCount: _elements.keys.toList().length,
                countOfItemInSection: (int section) {
                  return _elements.values.toList()[section].length;
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
                      _elements.keys.toList()[section],
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(height: 10),
                sectionSeparatorBuilder: (context, section) => SizedBox(height: 10),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionBubble(
        // Menu items
        items: <Bubble>[
          // Floating action menu item
          Bubble(
            title: "Edit Profile",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.edit,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
              context.push('/edit_profile');
            },
          ),
          // Floating action menu item
          Bubble(
            title: "generate QR",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.mail_outline,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
          //Floating action menu item
          Bubble(
            title: "Search",
            iconColor: Colors.white,
            bubbleColor: Colors.blue,
            icon: Icons.search,
            titleStyle: TextStyle(fontSize: 16, color: Colors.white),
            onPress: () {
              _animationController.reverse();
            },
          ),
        ],

        // animation controller
        animation: _animation,

        // On pressed change animation state
        onPress: () => _animationController.isCompleted
            ? _animationController.reverse()
            : _animationController.forward(),

        // Floating Action button Icon color
        iconColor: Colors.blue,

        // Flaoting Action button Icon
        iconData: Icons.ac_unit,
        backGroundColor: Colors.white,
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.title,required this.imageUrl});
  final String title;
  final String imageUrl;

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
          trailing: Icon(Icons.arrow_forward_ios),
        ),
      ),
    );
  }
}

