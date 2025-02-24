import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ksn_mobile_customer/core/constant/colors.dart';
import 'package:ksn_mobile_customer/core/constant/text_style.dart';
import 'package:ksn_mobile_customer/screens/home/notification/widget/notification_app_bar.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<Map<String, String>> _notifications = [
    {
      'title': 'Uday, still hungry 🤤?',
      'subtitle': 'Here are the best offers on top foods',
    },
    {
      'title': 'Uday, still hungry 🤤?',
      'subtitle': 'Hurry, limited time offer!',
    },
    {
      'title': 'Uday, still hungry 🤤?',
      'subtitle': 'For orders over ₹99',
    },
    {
      'title': 'Uday, still hungry 🤤?',
      'subtitle': 'Check out exciting new dishes',
    },
  ];

  void _deleteNotification(int index) {
    setState(() {
      _notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationAppBarWidget(
      height: 133,
      title: 'Notifications',
      listView: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final item = _notifications[index];

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            child: Slidable(
              key: ValueKey(item),
              endActionPane: ActionPane(
              motion: const BehindMotion(),
              extentRatio: 0.20,
              children: [
                Expanded(
                  child: Container(
                    color: Colors.transparent, 
                  ),
                ),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ), 
                  child: Container(
                    color: Colors.red,
                    alignment: Alignment.center,
                    child: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white, size: 30),
                      onPressed: () => _deleteNotification(index),
                    ),
                  ),
                ),
              ],
            ),

              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  color: notificationAppBarColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.only(
                      top: 10, left: 33, bottom: 10, right: 16),
                  title: Text(
                    item['title'] ?? '',
                    style: size14_M_bold().copyWith(fontSize: 15),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      item['subtitle'] ?? '',
                      style: size12_M_regular().copyWith(fontSize: 11),
                    ),
                  ),
                  onTap: () {
                    // TODO: handle tapping on the notification, if needed
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
// import 'package:ksn_mobile_customer/core/constant/colors.dart';
// import 'package:ksn_mobile_customer/core/constant/text_style.dart';
// import 'package:ksn_mobile_customer/screens/home/notification/widget/notification_app_bar.dart';

// class NotificationPage extends StatefulWidget {
//   const NotificationPage({super.key});

//   @override
//   State<NotificationPage> createState() => _NotificationPageState();
// }

// class _NotificationPageState extends State<NotificationPage> {
//   final List<Map<String, String>> _notifications = [
//     {
//       'title': 'Uday, still hungry 🤤?',
//       'subtitle': 'Here are the best offers on top foods',
//     },
//     {
//       'title': 'Uday, still hungry 🤤?',
//       'subtitle': 'Hurry, limited time offer!',
//     },
//     {
//       'title': 'Uday, still hungry 🤤?',
//       'subtitle': 'For orders over ₹99',
//     },
//     {
//       'title': 'Uday, still hungry 🤤?',
//       'subtitle': 'Check out exciting new dishes',
//     },
//   ];

//   void _deleteNotification(int index) {
//     setState(() {
//       _notifications.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return NotificationAppBarWidget(
//       height: 133,
//       title: 'Notifications',
//       listView: ListView.builder(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         itemCount: _notifications.length,
//         itemBuilder: (context, index) {
//           final item = _notifications[index];

//           return Container(
//             margin: const EdgeInsets.symmetric(vertical: 5),
//             child: Slidable(
//               key: ValueKey(item),
//               endActionPane: ActionPane(
//                 motion: const BehindMotion(),
//                 extentRatio: 0.09,
//                 children: [
//                   // Removed SizedBox and Padding to allow more space for the icon
//                   CustomSlidableAction(
//                     onPressed: (context) => _deleteNotification(index),
//                     backgroundColor: Colors.red,
//                     borderRadius: const BorderRadius.all(Radius.circular(10)),
//                     // Adjusted padding to provide more space for the icon
//                     padding: const EdgeInsets.all(10),
//                     child: Image.asset(
//                       'assets/icons/icon_delete.png',
//                       // Increased the size of the icon
//                       width: 40,  
//                       height: 40, 
//                       fit: BoxFit.contain, // Ensures the image scales correctly
//                     ),
//                   ),
//                 ],
//               ),
//               // endActionPane: ActionPane(
//               //   motion: const BehindMotion(),
//               //   extentRatio: 0.18,
//               //   children: [
//               //     SizedBox(
//               //       width: 65,
//               //       child: Padding(
//               //         padding: const EdgeInsets.only(left: 15),
//               //         child: CustomSlidableAction(
//               //           onPressed: (context) => _deleteNotification(index),
//               //           backgroundColor: Colors.red,
//               //           borderRadius: const BorderRadius.all(Radius.circular(10)),
//               //           flex: 1,
//               //           child: Container(
//               //             alignment: Alignment.center,
//               //             child: Image.asset(
//               //               'assets/icons/icon_delete.png',
//               //               width: 40,  
//               //               height: 40, 
//               //               fit: BoxFit.contain,
//               //             ),
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //   ],
//               // ),
//               child: Container(
//                 height: 80,
//                 decoration: BoxDecoration(
//                   color: notificationAppBarColor.withOpacity(0.8),
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: ListTile(
//                   contentPadding:
//                       const EdgeInsets.only(top: 10, left: 33, bottom: 10, right: 16),
//                   title: Text(
//                     item['title'] ?? '',
//                     style: size14_M_bold().copyWith(fontSize: 15),
//                   ),
//                   subtitle: Padding(
//                     padding: const EdgeInsets.only(top: 4),
//                     child: Text(
//                       item['subtitle'] ?? '',
//                       style: size12_M_regular().copyWith(fontSize: 11),
//                     ),
//                   ),
//                   onTap: () {
//                     // TODO: handle tapping on the notification, if needed
//                   },
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


