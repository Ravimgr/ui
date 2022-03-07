import 'package:flutter/material.dart';

class CustomDropDownwithText extends StatelessWidget {
  CustomDropDownwithText(
      {Key? key,
      required this.value,
      required this.items,
      required this.focusNode,
      required this.onChanged})
      : super(key: key);

  String value;
  final List<String> items;
  final FocusNode focusNode;
  final Function(String? value) onChanged;
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
              focusNode: focusNode,
              //value: widget.value,
              items: items.map((String item) {
                return DropdownMenuItem(
                  alignment: Alignment.centerLeft,
                  child: Text(item),
                  value: item,
                );
              }).toList(),
              onChanged: onChanged),
        ),
      ],
    );
  }
}
