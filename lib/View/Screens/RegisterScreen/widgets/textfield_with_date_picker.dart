import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noviindus_tech/View/theme/colors.dart';

class TextFieldWithDatePicker extends StatefulWidget {
  final String hintText;
  final ValueChanged<DateTime?>? onDateChanged;
  final TextEditingController controller;

  const TextFieldWithDatePicker({
    super.key,
    required this.hintText,
    this.onDateChanged,
    required this.controller,
  });

  @override
  _TextFieldWithDatePickerState createState() =>
      _TextFieldWithDatePickerState();
}

class _TextFieldWithDatePickerState extends State<TextFieldWithDatePicker> {
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        widget.controller.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
      if (widget.onDateChanged != null) {
        widget.onDateChanged!(pickedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400)),
        hintText: widget.hintText,
        suffixIcon: const Icon(
          Icons.calendar_today,
          color: AppPalette.appColor,
        ),
      ),
      readOnly: true,
      onTap: () => _selectDate(context),
    );
  }
}
