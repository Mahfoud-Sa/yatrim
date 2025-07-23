import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:country_code_picker/country_code_picker.dart';

Widget buildInputField({
  required String hint,
  required ValueChanged<String> onChanged,
  required RxString error,
  bool obscureText = false,
  Widget? suffixIcon,
  TextInputType? type,
}) {
  return Obx(() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: type,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFFB8B8B8),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            filled: true,
            fillColor: const Color(0xFFfcfcff),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: error.isNotEmpty ? Colors.red : const Color(0xFFE9E9E9),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: error.isNotEmpty ? Colors.red : const Color(0xFF00BB6E),
              ),
            ),
            suffixIcon: suffixIcon,
          ),
        ),
        if (error.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              error.value,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  });
}

Widget buildPhoneNumberInputField({
  required RxString phoneNumber,
  required RxString error,
  required ValueChanged<String> onChanged,
  required ValueChanged<CountryCode> onChangedCode,
}) {
  return Obx(() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          onChanged: onChanged,
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'رقم الهاتف',
            hintStyle: const TextStyle(
              color: Color(0xFFB8B8B8),
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
            filled: true,
            fillColor: const Color(0xFFfcfcff),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: error.isNotEmpty ? Colors.red : const Color(0xFFE9E9E9),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: error.isNotEmpty ? Colors.red : const Color(0xFF00BB6E),
              ),
            ),
            prefixIcon: CountryCodePicker(
              onChanged: onChangedCode,
              initialSelection: 'YE', // Set the default country code
              showFlag: true,
              showFlagDialog: true,
              showFlagMain: true,
              textStyle: const TextStyle(
                color: Color(0xFF707070),
                fontSize: 14,
              ),
            ),
          ),
        ),
        if (error.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              error.value,
              style: const TextStyle(
                color: Colors.red,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  });
}
