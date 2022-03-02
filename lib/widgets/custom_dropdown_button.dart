import 'package:flutter/material.dart';

class CustomDropDownwithText extends StatefulWidget {
  CustomDropDownwithText({Key? key, required this.value, required this.items})
      : super(key: key);

  String value;
  final List<String> items;

  @override
  _CustomDropDownwithTextState createState() => _CustomDropDownwithTextState();
}

class _CustomDropDownwithTextState extends State<CustomDropDownwithText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Expanded(
          child: Text(
            'I am a',
            style: TextStyle(
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Expanded(
          child: DropdownButtonFormField(
              value: widget.value,
              items: widget.items.map((String item) {
                return DropdownMenuItem(
                  alignment: Alignment.centerLeft,
                  child: Text(item),
                  value: item,
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  widget.value = value!;
                });
              }),
        ),
      ],
    );
  }
}
