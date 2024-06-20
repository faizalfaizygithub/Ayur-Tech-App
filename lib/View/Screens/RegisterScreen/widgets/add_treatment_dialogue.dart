import 'package:flutter/material.dart';
import 'package:noviindus_tech/View/Screens/RegisterScreen/model/treatment_model.dart';
import 'package:noviindus_tech/View/Screens/RegisterScreen/widgets/gender_counter.dart';
import 'package:noviindus_tech/View/Screens/RegisterScreen/widgets/text_field_with_dropdown.dart';
import 'package:noviindus_tech/View/tools/widgets/common_button.dart';

class TreatmentDialog extends StatefulWidget {
  final List<String> treatmentList;
  final ValueChanged<Treatment> onSave;

  const TreatmentDialog({
    super.key,
    required this.treatmentList,
    required this.onSave,
  });

  @override
  _TreatmentDialogState createState() => _TreatmentDialogState();
}

class _TreatmentDialogState extends State<TreatmentDialog> {
  String? selectedTreatment;
  int maleCount = 0;
  int femaleCount = 0;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Choose Treatment'),
              TextFieldWithDropDown(
                options: widget.treatmentList,
                hintText: 'Choose preferred treatment',
                onChanged: (value) {
                  setState(() {
                    selectedTreatment = value;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              const Text('Add Patients'),
              GenderCounterWidget(
                onMaleCountChanged: (count) {
                  setState(() {
                    maleCount = count;
                  });
                },
                onFemaleCountChanged: (count) {
                  setState(() {
                    femaleCount = count;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              CommonButton(
                buttonText: 'Save',
                onPressed: () {
                  if (selectedTreatment != null) {
                    final treatment = Treatment(
                      type: selectedTreatment!,
                      malePatients: maleCount,
                      femalePatients: femaleCount,
                    );
                    widget.onSave(treatment);
                    Navigator.of(context).pop();
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
