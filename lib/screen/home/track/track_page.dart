import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/screen/home/track/widgets/track_widgets.dart';
import 'package:foods_hub/screen/tab_controller.dart';

class TrackPage extends StatefulWidget {
  const TrackPage({super.key});

  @override
  State<TrackPage> createState() => _TrackPageState();
}

class _TrackPageState extends State<TrackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Navigation',
                          style: size16_M_bold(textColor: Colors.black),
                        ),
                        const SizedBox(height: 8),
                        Image.asset('assets/images/map_location.png'),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/track.png',
                          ),
                        ),
                        const SizedBox(height: 28),
                        const Padding(
                          padding: EdgeInsets.only(left: 40),
                          child: Stack(
                            children: [
                              Positioned(
                                left: 16,
                                top: 0,
                                bottom: 0,
                                child: DottedVerticalDivider(),
                              ),
                              Column(
                                children: [
                                  TrackStep(
                                    imagePath: 'assets/icons/track1.png',
                                    title: 'Order Received',
                                    description: 'Done',
                                  ),
                                  SizedBox(height: 59),
                                  TrackStep(
                                    imagePath: 'assets/icons/track2.jpg',
                                    title: 'Preparing Order',
                                    description: '10Hr:00Min:10Sec',
                                  ),
                                  SizedBox(height: 50),
                                  TrackStep(
                                    imagePath: 'assets/icons/track3.jpg',
                                    title: 'Order Packed',
                                    description: '10Hr:00Min:10Sec',
                                  ),
                                  SizedBox(height: 55),
                                  TrackStep(
                                    imagePath: 'assets/icons/track4.jpg',
                                    title: 'Order Delivered',
                                    description: '10Hr:00Min:10Sec',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 44),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TabScreen(index: 1),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: greenColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 44),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            'Order Details',
                            style: size16_M_bold(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 104),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
