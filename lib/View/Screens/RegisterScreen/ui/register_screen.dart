import 'package:flutter/material.dart';
import 'package:noviindus_tech/Controller/provider/registration_provider.dart';
import 'package:noviindus_tech/View/Screens/RegisterScreen/model/treatment_model.dart';
import 'package:noviindus_tech/View/Screens/RegisterScreen/widgets/add_treatment_dialogue.dart';
import 'package:noviindus_tech/View/Screens/RegisterScreen/widgets/payment_option.dart';
import 'package:noviindus_tech/View/Screens/RegisterScreen/widgets/text_field_with_dropdown.dart';
import 'package:noviindus_tech/View/Screens/RegisterScreen/widgets/textfield_with_date_picker.dart';
import 'package:noviindus_tech/View/Screens/RegisterScreen/widgets/time_picker_with_dropdown.dart';
import 'package:noviindus_tech/View/Screens/RegisterScreen/widgets/treatment_widget.dart';
import 'package:noviindus_tech/View/theme/colors.dart';
import 'package:noviindus_tech/View/tools/widgets/commom_text_field.dart';
import 'package:noviindus_tech/View/tools/widgets/common_button.dart';
import 'package:noviindus_tech/View/tools/widgets/common_text_field_text.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final whatsappNumberController = TextEditingController();
  final addressController = TextEditingController();
  final totalAmountController = TextEditingController();
  final discountAmountController = TextEditingController();
  final advanceAmountController = TextEditingController();
  final balanceAmountController = TextEditingController();
  final dateController = TextEditingController();
  String? selectedLocation;
  String? selectedBranch;
  String? paymentMethod;
  String? selectedHour;
  String? selectedMinutes;
  String? selectedTreatment;
  List<Treatment> treatments = [];
  List<String> keralaStates = [
    'Alappuzha',
    'Ernakulam',
    'Idukki',
    'Kannur',
    'Kasaragod',
    'Kollam',
    'Kottayam',
    'Kozhikode',
    'Malappuram',
    'Palakkad',
    'Pathanamthitta',
    'Thiruvananthapuram',
    'Thrissur',
    'Wayanad',
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<RegistrationScreenProvider>(context, listen: false)
          .getTreatmentList();
      Provider.of<RegistrationScreenProvider>(context, listen: false)
          .getBranchList();
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    whatsappNumberController.dispose();
    addressController.dispose();
    totalAmountController.dispose();
    discountAmountController.dispose();
    super.dispose();
  }

  void _openTreatmentDialog(List<String> treatmentList) {
    showDialog(
      context: context,
      builder: (context) {
        return TreatmentDialog(
          treatmentList: treatmentList,
          onSave: (treatment) {
            setState(() {
              treatments.add(treatment);
              debugPrint('Added treatment: ${treatment.type}');
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications_none_outlined))
        ],
        bottom: PreferredSize(
          preferredSize: Size(double.infinity, 30),
          child: Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Register',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )),
          ),
        ),
      ),
      body: Consumer<RegistrationScreenProvider>(
        builder: (context, provider, _) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextField(
                      hintText: 'Enter your name',
                      fieldText: 'Name',
                      controller: nameController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonTextField(
                      hintText: 'Enter your whatsapp number',
                      fieldText: 'Whatsapp Number',
                      controller: whatsappNumberController,
                      textInputType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonTextField(
                      hintText: 'Enter your Address',
                      fieldText: 'Address',
                      controller: addressController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CommonTextFieldText(text: 'Location'),
                    TextFieldWithDropDown(
                      options: keralaStates,
                      hintText: 'Select your location',
                      onChanged: (value) {
                        setState(() {
                          selectedLocation = value;
                          debugPrint(selectedLocation);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CommonTextFieldText(text: 'Branch'),
                    TextFieldWithDropDown(
                      options: provider.branchList
                          .map((branch) => branch.name!)
                          .toList(), // Use branchList from provider
                      hintText: 'Select your branch',
                      onChanged: (value) {
                        setState(() {
                          selectedBranch = value;
                          debugPrint(selectedBranch);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CommonTextFieldText(text: 'Treatments'),
                    for (var treatment in treatments)
                      TreatmentsWidget(
                        treatment: treatment,
                      ),
                    CommonButton(
                      buttonText: '+ Add Treatment',
                      onPressed: () {
                        _openTreatmentDialog(provider.treatmentList);
                      },
                      color: AppPalette.lightGreenColor,
                      textColor: Colors.black,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonTextField(
                      hintText: '',
                      fieldText: 'Total Amount',
                      controller: totalAmountController,
                      showHintText: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonTextField(
                      hintText: '',
                      fieldText: 'Discount Amount',
                      controller: discountAmountController,
                      showHintText: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CommonTextFieldText(
                      text: 'Payment Options',
                    ),
                    PaymentOptionsRow(
                      options: const ['Cash', 'Card', 'UPI'],
                      onChanged: (value) {
                        setState(() {
                          paymentMethod = value;
                          debugPrint(paymentMethod);
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonTextField(
                      hintText: '',
                      fieldText: 'Advance Amount',
                      controller: advanceAmountController,
                      showHintText: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonTextField(
                      hintText: '',
                      fieldText: 'Balance Amount',
                      controller: balanceAmountController,
                      showHintText: false,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CommonTextFieldText(text: 'Treatment Date'),
                    TextFieldWithDatePicker(
                      hintText: 'Treatment Date',
                      controller: dateController,
                      onDateChanged: (date) {
                        debugPrint('Select treatment date: $date');
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const CommonTextFieldText(text: 'Treatment Time'),
                    TimePickerDropdown(
                      onHourChanged: (hour) {
                        setState(() {
                          selectedHour = hour;
                        });
                      },
                      onMinuteChanged: (minute) {
                        setState(() {
                          selectedMinutes = minute;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CommonButton(buttonText: 'Save', onPressed: () {}),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
