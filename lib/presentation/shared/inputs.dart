import 'package:flutter/material.dart';

import '../../core/constants/constants.dart';

class GenericInput extends StatelessWidget {
  const GenericInput(
      {super.key,
      required this.hintText,
      required this.dataMap,
      required this.fieldKey,
      this.keyboardType,
      this.obscureText,
      this.initialValue,
      this.suffixIcon,
      this.contentPadding,
      this.onFieldSubmitted,
      this.textInputAction,
      this.maxLines,
      this.onChanged});

  final String hintText;
  final TextInputType? keyboardType;
  final bool? obscureText;
  final String? initialValue;
  final String fieldKey;
  final Map<String, dynamic> dataMap;
  final Widget? suffixIcon;
  final EdgeInsetsGeometry? contentPadding;
  final void Function(String)? onFieldSubmitted;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    if (initialValue != null) {
      dataMap[fieldKey] = initialValue;
    }
    return TextFormField(
      validator: (value) {
        return validator(
          value: value,
          isRequired: true,
        );
      },
      textInputAction: textInputAction,
      initialValue: initialValue,
      obscureText: obscureText ?? false,
      maxLines: maxLines ?? 1,
      minLines: maxLines ?? 1,
      keyboardType: keyboardType,
      style: TextStyle(
          color: Theme.of(context).primaryColorDark,
          fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        contentPadding: contentPadding ??
            const EdgeInsets.symmetric(
              vertical: kPadding,
              horizontal: kPadding,
            ),
        filled: true,
      ),
      onFieldSubmitted: onFieldSubmitted,
      onChanged: (value) {
        dataMap[fieldKey] = value;
        if (onChanged != null) {
          // ignore: prefer_null_aware_method_calls
          onChanged!(value);
        }
      },
    );
  }
}

String? validator({
  required String? value,
  required bool isRequired,
  int? valueLength,
  int? minLength,
  int? maxLength,
}) {
  if (isRequired) {
    if (value!.isEmpty) {
      return 'Este campo es obligatorio';
    }
  }
  if (valueLength != null) {
    if (value!.length != valueLength) {
      return 'Este campo es de $valueLength caracteres';
    }
  }
  if (minLength != null) {
    if (value!.length < minLength) {
      return 'Escribe al menos $minLength caracteres';
    }
  }
  if (maxLength != null) {
    if (value!.length >= maxLength) {
      return 'Este campo solo admite menos de $maxLength caracteres';
    }
  }

  return null;
}
