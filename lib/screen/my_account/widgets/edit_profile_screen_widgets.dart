import 'package:flutter/material.dart';
import 'package:foods_hub/core/constant/colors.dart';
import 'package:foods_hub/core/constant/text_style.dart';
import 'package:foods_hub/core/utils/validation/validation.dart';

class EditAccountTextField extends StatefulWidget {
  const EditAccountTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.onUpdate,
    required this.onCancel,
    this.isEdit = true,
  });

  final TextEditingController controller;
  final String labelText;
  final VoidCallback onUpdate;
  final VoidCallback onCancel;
  final bool isEdit;

  @override
  State<EditAccountTextField> createState() => _EditAccountTextFieldState();
}

class _EditAccountTextFieldState extends State<EditAccountTextField> {
  bool isReadOnly = true;
  late String initialValue;

  @override
  void initState() {
    super.initState();
    initialValue = widget.controller.text; // Store initial value
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: widget.controller,
          readOnly: isReadOnly,
          keyboardType: TextInputType.name,
          style: size14_M_bold(textColor: blackType1),
          // maxLength: 10,
          decoration: InputDecoration(
            counterText: '',
            errorStyle: size14_M_bold().copyWith(
              color: Colors.red[900],
            ),
            labelText: widget.labelText,
            suffix: isReadOnly && widget.isEdit
                ? InkWell(
                    onTap: () {
                      setState(() {
                        isReadOnly = false;
                      });
                    },
                    child: Text(
                      'EDIT',
                      style: size12_M_bold(textColor: primaryOrange),
                    ),
                  )
                : const SizedBox.shrink(),
            labelStyle: size14_M_bold(
                textColor: isReadOnly ? accountSmallText : primaryOrange),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: isReadOnly ? const Color(0xffD4D1D1) : primaryOrange,
                  width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: isReadOnly ? const Color(0xffD4D1D1) : primaryOrange,
                  width: 1.5),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: isReadOnly ? const Color(0xffD4D1D1) : primaryOrange,
                  width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: isReadOnly ? const Color(0xffD4D1D1) : primaryOrange,
                  width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                  color: isReadOnly ? const Color(0xffD4D1D1) : primaryOrange,
                  width: 1.5),
            ),
            filled: true,
            fillColor: Colors.transparent,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: (value) => validationPhone(value),
        ),
        const SizedBox(height: 25),
        !isReadOnly
            ? Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: EditAccountCustomButton(
                          color: const Color(0xffE3E2E7),
                          onTap: () {
                            widget.onUpdate();
                            setState(() {
                              isReadOnly = true;
                            });
                          },
                          title: 'Update',
                          titleColor: hintTextColor,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: EditAccountCustomButton(
                          color: primaryOrange.withOpacity(0.15),
                          onTap: () {
                            widget.onCancel();
                            setState(() {
                              isReadOnly = true;
                            });
                          },
                          title: 'Cancel',
                          titleColor: primaryOrange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
                ],
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class EditAccountCustomButton extends StatelessWidget {
  const EditAccountCustomButton({
    super.key,
    required this.color,
    required this.onTap,
    required this.title,
    required this.titleColor,
  });
  final Color titleColor;
  final Color color;
  final Function onTap;
  final String title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 42,
        width: double.infinity,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
            child: Text(
          title,
          style: size14_M_bold(textColor: titleColor),
        )),
      ),
    );
  }
}
