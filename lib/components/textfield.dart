
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tetinote_nadc/controllers/getx_controllers.dart';

class TodoTextField extends StatelessWidget {
  TodoTextField(
      {Key? key, required this.label, this.password = false, this.controller, this.prefixIcon, this.suffixIcon})
      : super(key: key);

  final String label;
  final bool password;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      cursorColor: Colors.grey,
      obscureText: password,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        fillColor: Colors.white.withOpacity(0.8),
        focusColor: Colors.grey,
        hoverColor: Colors.grey,
        contentPadding: EdgeInsets.symmetric(vertical: 7.5.h, horizontal: 15.w),
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey[400]??Colors.grey,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10.h),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            style: BorderStyle.solid,
            color: Colors.grey[400]??Colors.grey,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10.w),
        ),
      ),
    );
  }
}

class TodoDateTextField extends StatelessWidget {
  TodoDateTextField(
      {Key? key, required this.label, this.password = false, this.controller,  this.prefixIcon, this.suffixIcon})
      : super(key: key);

  final String label;
  final bool password;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  var format = DateFormat("yyyy-MM-dd");
  DateController dateController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
        child: DateTimeField(
          controller: controller,
          cursorColor: Colors.grey,
          obscureText: password,
          decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          fillColor: Colors.white.withOpacity(0.8),
          focusColor: Colors.grey,
          hoverColor: Colors.grey,
          contentPadding: EdgeInsets.symmetric(vertical: 7.5.h, horizontal: 15.w),
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: label,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey[400]??Colors.grey,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10.w),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey[400]??Colors.grey,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(10.w),
          ),
        ),
          format: format,
          onChanged: (dateTime){
            dateController.todoDateTime.value = dateTime;
          },
          onShowPicker: (context, currentValue) {
            return showDatePicker(
                context: context,
                firstDate: DateTime(2000),
                initialDate: currentValue ?? DateTime.now(),
                lastDate: DateTime(2050));
          },
        ));
  }
}
