import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/extensions.dart';
import '../theme/colors.dart';
import '../theme/dimens.dart';

class PokedexFormField extends StatefulWidget {
  final bool isPasswordField;
  final bool isEmailField;
  final bool isDefaultField;
  final bool isExpandedField;
  final String? hintText;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function()? validator;
  final bool hasError;
  final FocusNode? focusNode;
  final TextInputAction textInputAction;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final bool enabled;
  final String? initialValue;
  final TextCapitalization? textCapitalization;
  final AutovalidateMode autovalidateMode;
  final int? maxLength;
  final Function()? onTap;
  final String? errorText;
  final Function(bool)? hasFocus;
  final bool filled;
  final Color fillColor;

  const PokedexFormField({
    Key? key,
    this.isPasswordField = false,
    this.isEmailField = false,
    this.isDefaultField = true,
    this.isExpandedField = false,
    this.hintText,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.focusNode,
    this.textInputAction = TextInputAction.done,
    this.keyboardType,
    this.prefixIcon,
    this.inputFormatters,
    this.controller,
    this.enabled = true,
    this.initialValue,
    this.textCapitalization,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.maxLength,
    this.onTap,
    this.hasError = false,
    this.errorText,
    this.hasFocus,
    this.filled = true,
    this.fillColor = Colors.white,
  })  : assert(isDefaultField || isPasswordField || isEmailField),
        super(key: key);
  @override
  _PokedexFormFieldState createState() => _PokedexFormFieldState();
}

class _PokedexFormFieldState extends State<PokedexFormField> {
  bool _showPassword = false;
  late FocusNode _currentFocus;
  bool _hasFocus = false;

  late TextEditingController _textEditingController;

  void _focusListener() {
    setState(() {
      _hasFocus = _currentFocus.hasFocus;
      if (widget.hasFocus != null) {
        widget.hasFocus!(_hasFocus);
      }
    });
  }

  @override
  void initState() {
    _currentFocus = widget.focusNode ?? FocusNode();
    _currentFocus.addListener(() {
      _focusListener();
    });

    _textEditingController = widget.controller ?? TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _currentFocus.removeListener(() {
      _focusListener();
    });

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size1 = context.constSize1;
    return TextFormField(
      onTap: widget.onTap,
      controller: _textEditingController,
      initialValue: widget.initialValue,
      inputFormatters: widget.inputFormatters,
      onChanged: widget.onChanged,
      focusNode: widget.focusNode,
      onFieldSubmitted: widget.onFieldSubmitted,
      cursorHeight: size1 * 25.0,
      cursorWidth: size1 * 2.5,
      textCapitalization: widget.textCapitalization != null
          ? widget.textCapitalization!
          : TextCapitalization.none,
      maxLines: widget.isExpandedField ? 6 : 1,
      maxLength: widget.maxLength,
      obscureText: widget.isPasswordField ? !_showPassword : _showPassword,
      style: Theme.of(context).textTheme.bodyText1!.merge(
            TextStyle(
              fontSize: size1 * 20,
              color: (widget.enabled)
                  ? ThemeColors.textColor
                  : ThemeColors.disableTextColor,
            ),
          ),
      enabled: widget.enabled,
      validator: widget.validator != null
          ? (v) {
              return widget.validator?.call();
            }
          : null,
      autovalidateMode: widget.autovalidateMode,
      textInputAction: widget.textInputAction,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        filled: widget.filled,
        hintText: widget.hintText,
        labelStyle: Theme.of(context).textTheme.bodyText1!.merge(
              TextStyle(
                fontSize: size1 * 20,
                color: _hasFocus
                    ? ThemeColors.primaryColorDark
                    : widget.enabled
                        ? ThemeColors.textColor
                        : ThemeColors.disableTextColor,
              ),
            ),
        alignLabelWithHint: true,
        fillColor: widget.enabled ? widget.fillColor : ThemeColors.disableColor,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPasswordField
            ? InkWell(
                onTap: () => setState(() {
                  _showPassword = !_showPassword;
                }),
                borderRadius: BorderRadius.circular(
                  size1 * ThemeDimensSize.giantSpace,
                ),
                splashColor: ThemeColors.primaryColor.withOpacity(0.1),
                highlightColor: ThemeColors.primaryColor.withOpacity(0.5),
                radius: size1 * ThemeDimensSize.giantSpace,
                child: Icon(
                  _showPassword ? Icons.visibility : Icons.visibility_off,
                  color: ThemeColors.primaryColorDark,
                ),
              )
            : null,
        hintStyle: Theme.of(context)
            .textTheme
            .bodyText1!
            .merge(TextStyle(fontSize: size1 * 20)),
        errorMaxLines: 3,
        enabled: widget.enabled,
        errorText: widget.errorText,
      ),
    );
  }
}
