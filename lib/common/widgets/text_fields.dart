import 'package:flutter/services.dart';
import 'package:auspower_flutter/common/widgets/dropdown.dart';
import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/size_unit.dart';

import 'package:auspower_flutter/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:auspower_flutter/theme/theme_guide.dart';
import 'package:auspower_flutter/utilities/extensions/string_extenstion.dart';

class TextFormFieldCustom extends StatefulWidget {
  final TextEditingController controller;

  final String? label, hint, initialValue;
  final TextInputType? keyboardType;
  final bool isOptional;
  final bool? enabled, readOnly;
  final int? maxLength;
  final bool isCaptalizeAll, obscured;
  final Widget? suffix, prefix;
  final String? Function(String? input)? validator;
  final BorderRadius? borderRadius;
  final Function(String)? onChanged;
  final VoidCallback? onTap;
  final bool isBorderLess;

  const TextFormFieldCustom({
    super.key,
    required this.controller,
    this.label,
    this.keyboardType,
    this.maxLength,
    this.isOptional = false,
    this.enabled,
    this.validator,
    this.isCaptalizeAll = false,
    this.obscured = false,
    this.suffix,
    required this.hint,
    this.prefix,
    this.borderRadius,
    this.onChanged,
    this.onTap,
    this.isBorderLess = false,
    this.readOnly = false,
    this.initialValue,
  });

  @override
  State<TextFormFieldCustom> createState() => _TextFormFieldCustomState();
}

class _TextFormFieldCustomState extends State<TextFormFieldCustom> {
  bool isVisible = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      maxLength: widget.maxLength,
      initialValue: widget.initialValue,
      enabled: widget.enabled,
      readOnly: widget.readOnly ?? false,
      onTap: widget.onTap,
      inputFormatters: getInputFormatters,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      obscureText: widget.obscured && !isVisible,
      onChanged: widget.onChanged,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (i) {
        String input = i ?? '';
        // Checks if the field is optional and input is empty
        if (!widget.isOptional && input.isEmpty) {
          return "The ${widget.label} is required";
        }
        if (!widget.isOptional &&
            widget.keyboardType == TextInputType.emailAddress &&
            !input.isEmail) {
          return "Kindly enter valid mail";
        }
        // If the validator is not null custom validation logic to be performed
        if (widget.validator != null) {
          return widget.validator!(input);
        }
        // No validation errors
        return null;
      },
      decoration: InputDecoration(
          prefixIcon: widget.prefix,
          counterText: '',
          suffixIcon: suffix,
          errorStyle: const TextStyle(fontSize: 13, color: Palette.red),
          filled: true,
          fillColor: Colors.white,
          labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
          hintStyle: TextStyle(
              color: Palette.dark.withOpacity(.6),
              fontSize: 14,
              fontFamily: "Poppins"),
          labelText: widget.label,
          hintText: widget.hint,
          contentPadding: const EdgeInsets.symmetric(
              horizontal: SizeUnit.lg, vertical: SizeUnit.lg),
          border: ThemeGuide.focussedBorder,
          errorBorder: ThemeGuide.errorBorder,
          enabledBorder: ThemeGuide.defaultBorder(
              color: widget.isBorderLess ? null : Palette.muted),
          focusedBorder: ThemeGuide.focussedBorder),
    );
  }

  Widget? get suffix {
    return widget.obscured
        ? InkWell(
            onTap: () {
              isVisible = !isVisible;
              setState(() {});
            },
            child: !isVisible
                ? const Icon(
                    Icons.visibility_off_outlined,
                    size: 18,
                  )
                : const Icon(
                    Icons.visibility_outlined,
                    size: 18,
                  ),
          )
        : widget.suffix;
  }

  List<TextInputFormatter> get getInputFormatters {
    if (widget.keyboardType == TextInputType.number ||
        widget.keyboardType == const TextInputType.numberWithOptions()) {
      return [FilteringTextInputFormatter.digitsOnly];
    }
    if (widget.isCaptalizeAll) {
      return [UpperCaseTextFormatter()];
    }
    if (widget.keyboardType == TextInputType.emailAddress) {
      return [LowerCaseTextFormatter()];
    }
    return <TextInputFormatter>[];
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}

// ignore: must_be_immutable
class MobileTextField extends StatelessWidget {
  MobileTextField(
      {super.key, required this.contMobile, this.selectedCode, this.onChanged});
  final TextEditingController contMobile;
  final String? selectedCode;
  final Function(String?)? onChanged;
  List<String> countryCodes = ['+91', '+92'];
  @override
  Widget build(BuildContext context) {
    return TextFormFieldCustom(
      controller: contMobile,
      label: 'Mobile',
      hint: 'Enter you mobile',
      maxLength: 10,
      keyboardType: TextInputType.number,
      prefix: Row(mainAxisSize: MainAxisSize.min, children: [
        SizedBox(
            width: 80,
            child: DropDownCustom(
                value: selectedCode,
                isFilled: false,
                items: countryCodes
                    .map(
                        (e) => DropdownMenuItem(value: e, child: TextCustom(e)))
                    .toList(),
                isNoBorder: true,
                contentPadding: const EdgeInsets.fromLTRB(
                    SizeUnit.lg, SizeUnit.lg, SizeUnit.sm, SizeUnit.lg),
                onChanged: onChanged)),
        Container(
          width: 1,
          height: 45,
          color: Palette.muted,
          margin: const EdgeInsets.only(right: SizeUnit.lg),
        )
      ]),
    );
  }
}
