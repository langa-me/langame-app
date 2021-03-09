// import 'dart:math';
//
// import 'package:after_layout/after_layout.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
// import 'package:langame/protos/api.pb.dart';
// import 'package:langame/providers/interest_provider.dart';
// import 'package:provider/provider.dart';
//
// /// Setup the app for the user (interests, friends...)
// class Setup extends StatefulWidget {
//   @override
//   _SetupState createState() => _SetupState();
// }
//
// class _SetupState extends State with AfterLayoutMixin {
//   List<Widget> interests = [];
//   List<StaggeredTile> interestsTiles = [];
//   final controller = PageController(initialPage: 0, viewportFraction: 0.9);
//
//   @override
//   void afterFirstLayout(BuildContext context) {
//     final provider = Provider.of<InterestProvider>(context, listen: false);
//
//     provider.getAllInterests();
//     interests.clear();
//     interestsTiles.clear();
//     provider.interestsStream.listen((snapshot) {
//       print('zz $snapshot');
//       interests.add(InterestCard(snapshot));
//       int count = Random().nextInt(4);
//       interestsTiles.add(StaggeredTile.count(count, count));
//       // Notify refresh of interests lists
//       setState(() {});
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(children: [
//       Container(
//           child: Align(
//         alignment: Alignment.topRight,
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: FlatButton(
//             onPressed: () async {
//               controller.nextPage(
//                   duration: new Duration(seconds: 1), curve: Curves.bounceOut);
//               print(controller.page); // TODO: should end setup at latest step
//               // if (controller.page >= 2.0) {
//               //   // Register that this user has already done the setup
//               //   SharedPreferences prefs = await SharedPreferences.getInstance();
//               //   prefs.setBool('setup', true);
//               //   Navigator.pushReplacement(
//               //     context,
//               //     MaterialPageRoute(builder: (context) => RandomTemporary()),
//               //   );
//               // }
//             },
//             child: Text('Skip'),
//           ),
//         ),
//       )),
//       Expanded(
//         child: PageView(
//           controller: controller,
//           children: <Widget>[
//             Container(
//                 color: Colors.teal,
//                 child: Center(child: Text('Invite friends'))),
//             Padding(
//                 padding: const EdgeInsets.only(top: 12.0),
//                 child: interests.length == 0
//                     ? Center(
//                         child: CircularProgressIndicator(),
//                       )
//                     : StaggeredGridView.countBuilder(
//                         crossAxisCount: 4,
//                         staggeredTileBuilder: (index) => interestsTiles[index],
//                         itemCount: interests.length,
//                         itemBuilder: (context, index) {
//                           return interests[index];
//                         })),
//             Container(
//                 color: Colors.red, child: Center(child: Text('What else?'))),
//           ],
//         ),
//       ),
//     ]);
//   }
// }
//
// class InterestCard extends StatelessWidget {
//   const InterestCard(this.interest);
//   final Interest interest;
//   @override
//   Widget build(BuildContext context) {
//     return new Card(
//       child: new InkWell(
//         onTap: () {},
//         child: new Center(
//           child: new Padding(
//             padding: const EdgeInsets.all(4.0),
//             child: Text(this.interest.value),
//           ),
//         ),
//       ),
//     );
//   }
// }
