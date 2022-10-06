import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextField extends StatefulWidget {
  final String? initialValue;
  final bool enabled;
  final String? hintText;
  final TextEditingController? controller;
  final bool hasSecuredContent;
  final String? label;
  final Widget? preIcon;
  final TextInputType? type;
  final void Function(String? value)? onSaved;
  final String? Function(String? value)? validator;
  final String? Function(String? value)? onSubmit;
  final void Function()? onPreIconTap;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final Color? borderColor;
  final double borderRadiusValue;
  final int maxLines;
  final double? contentVerticalPadding;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? outSideDecorationIcon;
  final bool hasBottomPadding;
  final Color labelColor;
  final TextInputAction textInputAction;
  const DefaultTextField(
      {Key? key,
      this.initialValue,
      this.enabled = true,
      this.controller,
      this.label,
      this.preIcon,
      this.type,
      this.onSaved,
      this.textInputAction = TextInputAction.done,
      this.validator,
      this.hasSecuredContent = false,
      this.onPreIconTap,
      this.onTap,
      this.labelColor = Colors.grey,
      this.borderColor,
      this.onChanged,
      this.onSubmit,
      this.hintText,
      this.borderRadiusValue = 20,
      this.maxLines = 1,
      this.contentVerticalPadding,
      this.inputFormatters,
      this.outSideDecorationIcon,
      this.hasBottomPadding = false})
      : super(key: key);

  @override
  State<DefaultTextField> createState() => _DefaultTextFieldState();
}

class _DefaultTextFieldState extends State<DefaultTextField> {
  var _isContentVisible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.hasBottomPadding
          ? const EdgeInsets.only(bottom: 25)
          : EdgeInsets.zero,
      child: TextFormField(
        inputFormatters: widget.inputFormatters,
        maxLines: widget.maxLines,
        onChanged: widget.onChanged,
        enabled: widget.enabled,
        initialValue: widget.initialValue,
        onFieldSubmitted: widget.onSubmit,
        textInputAction: widget.textInputAction,
        controller: widget.controller,
        onTap: widget.onTap,
        keyboardType: widget.type,
        obscureText: widget.hasSecuredContent
            ? _isContentVisible
                ? false
                : true
            : false,
        decoration: InputDecoration(
            alignLabelWithHint: false,
            hintText: widget.hintText,
            errorStyle: const TextStyle(
              fontSize: 12,
              overflow: TextOverflow.visible,
            ),
            icon: widget.outSideDecorationIcon,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20, vertical: widget.contentVerticalPadding ?? 0),
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadiusValue),
                borderSide:
                    BorderSide(color: widget.borderColor ?? Colors.grey[900]!)),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(widget.borderRadiusValue),
                borderSide:
                    BorderSide(color: widget.borderColor ?? Colors.grey[900]!)),
            label: widget.label == null
                ? null
                : Text(
                    widget.label!,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: widget.labelColor),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
            prefixIcon: widget.preIcon == null
                ? null
                : GestureDetector(
                    onTap: widget.onPreIconTap, child: widget.preIcon),
            suffixIcon: widget.hasSecuredContent
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        _isContentVisible = !_isContentVisible;
                      });
                    },
                    child: Icon(
                      _isContentVisible
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  )
                : null),
        onSaved: widget.onSaved,
        validator: widget.validator,
      ),
    );
  }
}
