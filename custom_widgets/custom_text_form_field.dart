import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// [CustomTextFormField] is a Flutter widget that shows a TextField
/// with the functionality to show custom suffix icons for [obscureText]
/// and show error border when [enableError] is set to true.
///
/// Example usage:
/// ```dart
/// CustomTextField(
///   enabledBorderColor: Colors.blue,
///   focusedBorderColor: Colors.green,
///   errorBorderColor: Colors.red,
///   obscureText: true,
///   canToggleObscureText: true,
///   obscureShowSuffixIcon: Text('Show'),
///   obscureHideSuffixIcon: Text('Hide'),
///   obscureSuffixIconColor: Colors.blue,
/// )
///
class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.padding,
    this.hintText,
    this.textStyle,
    this.hintStyle,
    this.controller,
    this.onChanged,
    this.onSaved,
    this.obscureText = false,
    this.obscureSuffixIconColor,
    this.canToggleObscureText = true,
    this.decoration,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureHideSuffixIcon = const Icon(Icons.visibility_off),
    this.obscureShowSuffixIcon = const Icon(Icons.visibility),
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.onTap,
    this.enabled,
    this.initialValue,
    this.validator,
    this.keyboardType,
    this.enableError,
    this.maxLength,
    this.textAlign = TextAlign.start,
    this.maxLines = 1,
    this.minLines,
    this.focusNode,
    this.inputFormatters,
    this.enabledBorderColor = const Color(0xFFAC99B5),
    this.focusedBorderColor = const Color(0xFF7BC2B6),
    this.errorBorderColor = const Color(0xFFDA4A4A),
  });

  final String? initialValue;
  final EdgeInsets? padding;
  final String? hintText;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String?>? onSaved;

  /// Determines if text field is obscured or not
  final bool obscureText;

  /// The functionality to show/hide obscured text only works
  /// if both [obscureText] and [canToggleObscureText] are true
  ///  - Set [canToggleObscureText] to false to hide [obscureShowSuffixIcon]
  ///  and [obscureHideSuffixIcon] icons and also disable show/hide functionality
  final bool canToggleObscureText;
  final Color? obscureSuffixIconColor;
  final InputDecoration? decoration;
  final Widget? prefixIcon;

  /// Custom [suffixIcon] is only shown if [obscureText] and/or [canToggleObscureText] are false
  /// otherwise [obscureShowSuffixIcon]/[obscureShowSuffixIcon] icons are shown as [suffixIcon]
  final Widget? suffixIcon;

  /// [obscureShowSuffixIcon] is shown when both [obscureText] and [canToggleObscureText] are true
  /// and text is obscured
  final Widget obscureShowSuffixIcon;

  /// [obscureHideSuffixIcon] is shown when both [obscureText] and [canToggleObscureText] are true
  /// and text is not obscured
  final Widget obscureHideSuffixIcon;
  final GestureTapCallback? onTap;
  final bool? enabled;
  final FormFieldValidator? validator;
  final TextInputType? keyboardType;
  final bool? enableError;
  final int? maxLength;
  final TextAlign textAlign;
  final int? maxLines;
  final int? minLines;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;

  @override
  State<StatefulWidget> createState() {
    return _CustomTextFormFieldState();
  }
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _showObscuredText;

  final TextStyle _defaultTextStyle = const TextStyle(
    fontFamily: 'DM Sans',
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: Color(0xFF514F52),
  );

  @override
  void initState() {
    super.initState();
    _showObscuredText = false;
  }

  @override
  Widget build(BuildContext context) {
    InputDecoration defaultDecoration = InputDecoration(
      isDense: true,
      hintText: widget.hintText,
      hintStyle: widget.hintStyle,
      border: widget.border ?? const OutlineInputBorder(),
      prefixIcon: widget.prefixIcon,
      suffixIcon: widget.obscureText && widget.canToggleObscureText
          ? IconButton(
              color: widget.obscureSuffixIconColor,
              icon: DefaultTextStyle(
                style: TextStyle(color: widget.obscureSuffixIconColor),
                child: _showObscuredText
                    ? widget.obscureHideSuffixIcon
                    : widget.obscureShowSuffixIcon,
              ),
              onPressed: () {
                setState(() {
                  _showObscuredText = !_showObscuredText;
                });
              },
            )
          : widget.suffixIcon,
      enabledBorder: widget.enabledBorder ??
          OutlineInputBorder(
              borderSide: BorderSide(color: widget.enabledBorderColor)),
      focusedBorder: widget.focusedBorder ??
          OutlineInputBorder(
              borderSide: BorderSide(color: widget.focusedBorderColor)),
      errorBorder: widget.errorBorder ??
          OutlineInputBorder(
              borderSide: BorderSide(color: widget.errorBorderColor)),
    );

    if (widget.enableError ?? false) {
      defaultDecoration = defaultDecoration.copyWith(
        enabledBorder: widget.enabledBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: widget.errorBorderColor),
            ),
        focusedBorder: widget.focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: widget.errorBorderColor),
            ),
        errorBorder: widget.errorBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: widget.errorBorderColor),
            ),
      );
    }

    return Container(
      padding: widget.padding,
      child: TextFormField(
        initialValue: widget.initialValue,
        validator: widget.validator,
        enabled: widget.enabled,
        onTap: widget.onTap,
        controller: widget.controller,
        decoration: widget.decoration ?? defaultDecoration,
        obscureText: widget.obscureText ? !_showObscuredText : false,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        style: widget.textStyle ?? _defaultTextStyle,
        keyboardType: widget.keyboardType,
        maxLength: widget.maxLength,
        textAlign: widget.textAlign,
        maxLines: widget.maxLines,
        minLines: widget.minLines,
        focusNode: widget.focusNode,
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}
