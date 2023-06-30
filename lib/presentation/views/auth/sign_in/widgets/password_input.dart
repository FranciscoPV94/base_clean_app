import 'package:flutter/material.dart';
import '/presentation/shared/inputs.dart';

class PasswordInput extends StatefulWidget {
  const PasswordInput({
    super.key,
    required this.hintText,
    required this.dataMap,
    required this.fieldKey,
    this.keyboardType,
    this.obscureText,
    this.initialValue,
  });

  final String hintText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? initialValue;
  final String fieldKey;
  final Map<String,dynamic> dataMap;
  

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {

  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GenericInput(
      hintText: widget.hintText,
      dataMap: widget.dataMap,
      fieldKey: widget.fieldKey,
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      suffixIcon: IconButton(
        icon: _obscureText
        ?  
        Icon(
          Icons.remove_red_eye_outlined,
          color: Theme.of(context).primaryColor,
        )
        :  
        Icon(
            Icons.lock_outlined,
            color: Theme.of(context).primaryColor,
        ),
        onPressed: _toggle,
      ),
    );
  }
}
