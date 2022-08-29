import 'package:flutter/material.dart';

class TextFieldNorm extends StatelessWidget {
  final String label;
  final double height;
  final double width;
  final String hintText;
  int? maxLines;
  Widget? suffixIcon;
  TextFieldNorm(
      {Key? key,
      required this.label,
      required this.height,
      required this.width,
      required this.hintText,
      this.suffixIcon,
      this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
          height: height,
          width: width,
          margin: EdgeInsets.only(top: 10),
          child: TextField(
            maxLines: maxLines ?? 1,
            style: const TextStyle(
                fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
            decoration: InputDecoration(
                suffixIcon: suffixIcon,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                hintText: hintText,
                hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                fillColor: Colors.grey.withOpacity(.1),
                enabled: true,
                filled: true),
          ),
        ),
      ],
    );
  }
}
