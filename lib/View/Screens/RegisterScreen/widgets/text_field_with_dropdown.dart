import 'package:flutter/material.dart';
import 'package:noviindus_tech/View/theme/colors.dart';

class TextFieldWithDropDown extends StatefulWidget {
  final List<String> options;
  final String? value;
  final String hintText;
  final ValueChanged<String?>? onChanged;

  const TextFieldWithDropDown({
    super.key,
    required this.options,
    this.value,
    required this.hintText,
    this.onChanged,
  });

  @override
  State<TextFieldWithDropDown> createState() => _TextFieldWithDropDownState();
}

class _TextFieldWithDropDownState extends State<TextFieldWithDropDown> {
  late String? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      isExpanded: true,
      icon: const Icon(
        Icons.keyboard_arrow_down,
        color: AppPalette.appColor,
      ),
      value: _selectedValue,
      onChanged: (String? newValue) {
        setState(() {
          _selectedValue = newValue;
        });
        if (widget.onChanged != null) {
          widget.onChanged!(newValue);
        }
      },
      decoration: InputDecoration(
          fillColor: Colors.grey.shade100,
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400)),
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.grey.shade400)),
      items: widget.options
          .map((String option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ))
          .toList(),
    );
  }
}
