import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:linku/meet/screen/meet_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MeetPaginationScreen();
  }
}

// class HomeScreen extends ConsumerStatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   ConsumerState<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends ConsumerState<HomeScreen>
//     with SingleTickerProviderStateMixin {
//   late Animation<double> _animation;
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     _animationController = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 260),
//     );

//     final curvedAnimation =
//         CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
//     _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);

//     super.initState();
//   }

//   Map<String, List> _elements = {
//     '칵테일': ['Klay Lewis', 'Ehsan Woodard', 'River Bains'],
//     '롤': ['Toyah Downs', 'Tyla Kane'],
//     '러닝': ['Marcus Romero', 'Farrah Parkes', 'Fay Lawson', 'Asif Mckay'],
//   };

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.all(10),
//                 child: Center(
//                   child: SizedBox(
//                     width: 60.h,
//                     height: 60.h,
//                     child: Image.asset(
//                       'assets/images/logo.png',
//                       fit: BoxFit.contain,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 700.h,
//               child: GroupListView(
//                 sectionsCount: _elements.keys.toList().length,
//                 countOfItemInSection: (int section) {
//                   return _elements.values.toList()[section].length;
//                 },
//                 itemBuilder: (context, index){
//                   return ProposeCard(
//                     imageUrl: 'https://docs.flutter.dev/assets/images/dash/dash-fainting.gif',
//                     title: 'Klay Lewis',
//                     startDate: '201311010102',
//                   );
//                 },
//                 groupHeaderBuilder: (BuildContext context, int section) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                     child: Text(
//                       _elements.keys.toList()[section],
//                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) => SizedBox(height: 10),
//                 sectionSeparatorBuilder: (context, section) => SizedBox(height: 10),
//               ),
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionBubble(
//         // Menu items
//         items: <Bubble>[
//           // Floating action menu item
//           Bubble(
//             title: "Edit Profile",
//             iconColor: Colors.white,
//             bubbleColor: Colors.blue,
//             icon: Icons.edit,
//             titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//             onPress: () {
//               _animationController.reverse();
//               context.push('/edit_profile');
//             },
//           ),
//           // Floating action menu item
//           Bubble(
//             title: "generate QR",
//             iconColor: Colors.white,
//             bubbleColor: Colors.blue,
//             icon: Icons.mail_outline,
//             titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//             onPress: () {
//               _animationController.reverse();
//               context.push('/propose');
//             },
//           ),
//           //Floating action menu item
//           Bubble(
//             title: "Search",
//             iconColor: Colors.white,
//             bubbleColor: Colors.blue,
//             icon: Icons.search,
//             titleStyle: TextStyle(fontSize: 16, color: Colors.white),
//             onPress: () {
//               _animationController.reverse();
//               context.push('/search');
//             },
//           ),
//         ],

//         // animation controller
//         animation: _animation,

//         // On pressed change animation state
//         onPress: () => _animationController.isCompleted
//             ? _animationController.reverse()
//             : _animationController.forward(),

//         // Floating Action button Icon color
//         iconColor: Colors.blue,

//         // Flaoting Action button Icon
//         iconData: Icons.ac_unit,
//         backGroundColor: Colors.white,
//       ),
//     );
//   }
// }
