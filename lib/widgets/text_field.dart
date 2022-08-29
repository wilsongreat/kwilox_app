import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
  final Widget prefixIcon;
  final String hintText;
  final bool hasSuffixIcon;
  final TextEditingController inputController;
  final bool isPassword;
  final Function validator;
  final Function onSaved;
  final TextInputType keyBoardType;
  final TextInputAction? textInputAction;
  const InputField(
      {Key? key,
      required this.inputController,
      required this.isPassword,
      required this.prefixIcon,
      required this.hintText,
      required this.hasSuffixIcon,
      required this.validator,
      required this.onSaved,
      required this.keyBoardType,
      this.textInputAction})
      : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _obscureText = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextFormField(
        validator: (value) => widget.validator(value),
        controller: widget.inputController,
        onChanged: (value) {
          //Do something wi
        },
        keyboardType: widget.keyBoardType,
        autocorrect: true,
        textCapitalization: TextCapitalization.words,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        onSaved: (value) => widget.onSaved(value),
        style: const TextStyle(
            fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          filled: false,
          focusColor: Colors.red,
          hintText: widget.hintText,
          hintStyle: TextStyle(
              color: Colors.grey.withOpacity(.75),
              fontSize: 14,
              fontWeight: FontWeight.bold),
          suffixIcon: widget.hasSuffixIcon == true
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                      print(_obscureText);
                    });
                  },
                  child: _obscureText
                      ? Icon(Icons.remove_red_eye_outlined)
                      : Image.asset('assets/obscure_close.png'),
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF333333), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF3D16D6), width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF333333), width: 0.7),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
        obscureText: _obscureText,
      ),
    );
  }
}
