import 'package:flutter/material.dart';
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

  List<String> treatmentList = [
    'Couple combo package',
    'Couple normal package',
    'Single package',
  ];

  @override
  void dispose() {
    nameController.dispose();
    whatsappNumberController.dispose();
    addressController.dispose();
    totalAmountController.dispose();
    discountAmountController.dispose();
    super.dispose();
  }

  void _openTreatmentDialog() {
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
        title: const Text('Register'),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.notifications_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonTextField(
                  hintText: 'Enter your full name',
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
                  hintText: 'Enter your full Address',
                  fieldText: 'Address',
                  controller: addressController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const CommonTextFieldText(text: 'Location'),
                TextFieldWithDropDown(
                  options: keralaStates,
                  hintText: 'Choose your location',
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
                  options: keralaStates,
                  hintText: 'Select the branch',
                  onChanged: (value) {
                    setState(() {
                      selectedBranch = value;
                      debugPrint(selectedBranch); // Update selectedLocation
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
                  onPressed: _openTreatmentDialog,
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
                  controller: discountAmountController,
                  showHintText: false,
                ),
                const SizedBox(
                  height: 20,
                ),
                CommonTextField(
                  hintText: '',
                  fieldText: 'Balance Amount',
                  controller: discountAmountController,
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
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
