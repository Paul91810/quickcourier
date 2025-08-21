import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickcourier/providers/textfield_provider.dart';
import 'package:quickcourier/core/constants/app_sizes.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.validator,
    this.isPassword = false,
    this.focusNode,
    this.nextFocus,
    this.onChanged, 
  });

  final TextEditingController controller;
  final String label;
  final Validator validator;
  final bool isPassword;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final ValueChanged<String>? onChanged; 

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CustomTextfieldProvider(validator, isPassword: isPassword),
      child: Consumer<CustomTextfieldProvider>(
        builder: (context, provider, _) {
          return Column(
            children: [
              TextFormField(
                controller: controller,
                focusNode: focusNode,
                obscureText: provider.obscureText,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => validator(value ?? ''),
                onChanged: (value) {
                  provider.updateValue(value);
                  if (onChanged != null) {
                    onChanged!(value);
                  }
                },
                textInputAction:
                    nextFocus != null ? TextInputAction.next : TextInputAction.done,
                onFieldSubmitted: (_) {
                  if (nextFocus != null) {
                    FocusScope.of(context).requestFocus(nextFocus);
                  } else {
                    FocusScope.of(context).unfocus();
                  }
                },
                decoration: InputDecoration(
                  labelText: label,
                  errorText: provider.error,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  suffixIcon: isPassword
                      ? IconButton(
                          icon: Icon(
                            provider.obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () => provider.toggleObscureText(),
                        )
                      : null,
                ),
              ),
              AppSizes.appHeight10(context),
            ],
          );
        },
      ),
    );
  }
}
