import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noviindus_tech/Controller/provider/home_provider.dart';
import 'package:noviindus_tech/Model/home_patient_model.dart';
import 'package:noviindus_tech/View/Screens/Home/widget/my_booking_widget.dart';
import 'package:noviindus_tech/View/Screens/Home/widget/search_text_field.dart';
import 'package:noviindus_tech/View/theme/colors.dart';
import 'package:noviindus_tech/View/tools/widgets/common_button.dart';
import 'package:noviindus_tech/View/tools/widgets/common_loading_widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchPatients();
    });
    super.initState();
  }

  Future<void> _fetchPatients() async {
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    await homeProvider.fetchPatients();
  }

  Future<void> _onRefresh() async {
    await _fetchPatients();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, value, child) {
        return LoadingWidget(
          isLoading: value.isLoading,
          child: Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.notifications_none_rounded))
              ],
            ),
            floatingActionButton: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              width: MediaQuery.of(context).size.width,
              child: FloatingActionButton(
                backgroundColor: AppPalette.appColor,
                onPressed: () {},
                child: CommonButton(
                    buttonText: 'Register Now',
                    onPressed: () {
                      Navigator.pushNamed(context, '/RegisterScreen');
                    }),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: RefreshIndicator(
              displacement: 0,
              edgeOffset: 0,
              strokeWidth: 0,
              color: Colors.transparent,
              backgroundColor: Colors.transparent,
              onRefresh: _onRefresh,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Row(
                      children: [
                        const Flexible(
                            flex: 6,
                            child:
                                SizedBox(height: 55, child: SearchTexField())),
                        const SizedBox(
                          width: 10,
                        ),
                        Flexible(
                            flex: 3,
                            child: CommonButton(
                                buttonText: 'Search', onPressed: () {}))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Sort by:',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
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
                                    top: 8.0,
                                    bottom: 8.0,
                                    left: 8.0,
                                    right: 100),
                                child: Text(
                                  'Date',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
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
                  value.errorMessage != null
                      ? Center(
                          child: Text(value.errorMessage!),
                        )
                      : value.patients == null || value.patients!.isEmpty
                          ? const Center(child: Text('No patients found'))
                          : Expanded(
                              child: ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20.0, horizontal: 20),
                                itemCount: value.patients!.length,
                                itemBuilder: (context, index) {
                                  PatientElement patient =
                                      value.patients![index];
                                  String treatmentNames =
                                      patient.patientdetailsSet != null
                                          ? patient.patientdetailsSet!
                                              .map((e) => e.treatmentName)
                                              .join(', ')
                                          : 'No Treatment';
                                  String formattedDate =
                                      patient.dateNdTime != null
                                          ? DateFormat('dd-MM-yyyy')
                                              .format(patient.dateNdTime!)
                                          : 'No Date';

                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 10.0),
                                    child: MyBookingWidget(
                                      count: index + 1,
                                      patientName: patient.name ?? 'No Name',
                                      packageName: treatmentNames,
                                      doctorName: patient.name ?? 'No Name',
                                      date: formattedDate,
                                    ),
                                  );
                                },
                              ),
                            ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
