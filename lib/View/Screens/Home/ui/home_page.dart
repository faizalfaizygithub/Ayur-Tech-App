import 'package:flutter/material.dart';
import 'package:noviindus_tech/Model/my_booking_model.dart';
import 'package:noviindus_tech/View/Screens/Home/widget/my_booking_widget.dart';
import 'package:noviindus_tech/View/Screens/Home/widget/search_text_field.dart';
import 'package:noviindus_tech/View/theme/colors.dart';
import 'package:noviindus_tech/View/tools/common_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<MyBookingModel> myBookingsList = [
    MyBookingModel(
      doctorName: 'Adhil Latheef',
      packageName: 'Couples Combo Package',
      date: '31/01/2024',
      patientName: 'Adhil',
    ),
    MyBookingModel(
      doctorName: 'Adhil Latheef',
      packageName: 'Couples Combo Package',
      date: '31/01/2024',
      patientName: 'Adhil',
    ),
    MyBookingModel(
      doctorName: 'Adhil Latheef',
      packageName: 'Couples Combo Package',
      date: '31/01/2024',
      patientName: 'Adhil',
    ),
    MyBookingModel(
      doctorName: 'Adhil Latheef',
      packageName: 'Couples Combo Package',
      date: '31/01/2024',
      patientName: 'Adhil',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {}, icon: Icon(Icons.notifications_none_outlined))
        ],
      ),
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        width: MediaQuery.of(context).size.width,
        child: FloatingActionButton(
          backgroundColor: AppPalette.appColor,
          onPressed: () {},
          child: CommonButton(
              buttonText: 'Register Now',
              onPressed: () {
                Navigator.pushNamed(context, 'registerScreen');
              }),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Row(
              children: [
                const Flexible(
                    flex: 6,
                    child: SizedBox(height: 55, child: SearchTexField())),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                    flex: 3,
                    child: CommonButton(buttonText: 'Search', onPressed: () {}))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Sort by:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      //shape: BoxShape.circle,
                      border: Border.all(
                        width: 0.85,
                        color: AppPalette.borderColor,
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 8.0, right: 100),
                        child: Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: AppPalette.appColor,
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(20.0),
              itemCount: myBookingsList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: MyBookingWidget(
                    myBookingModel: myBookingsList[index],
                    count: index + 1,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
