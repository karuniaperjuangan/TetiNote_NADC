import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:tetinote_nadc/components/textfield.dart';
import 'package:tetinote_nadc/controllers/getx_controllers.dart';
import 'package:tetinote_nadc/controllers/model.dart';

void addTodoBottomSheet() {
  TextEditingController _todoTitleController = TextEditingController();
  DateController _dateController = Get.find();
  TextEditingController _todoDetailController = TextEditingController();
  var box = Hive.box<Todo>('todoBox');

  Get.bottomSheet(Container(
    padding: EdgeInsets.all(20.sp),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.w),
        topRight: Radius.circular(30.w),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Buat Agenda", style: TextStyle(fontSize: 16),),
        SizedBox(
          height: 12.h,
        ),
        TodoTextField(
          controller: _todoTitleController,
          label: "Judul Agenda",
        ),
        SizedBox(
          height: 12.h,
        ),
        TodoTextField(
          label: "Detail Agenda",
          controller: _todoDetailController,
        ),
        SizedBox(
          height: 12.h,
        ),
        TodoDateTextField(label: "Waktu Agenda"),
        SizedBox(
          height: 12.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (_todoTitleController.text.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Judul agenda tidak boleh kosong",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  box.add(Todo(
                    title: _todoTitleController.text,
                    description: _todoDetailController.text,
                    date: _dateController.todoDateTime.value,
                    isDone: false,
                  ));
                  Get.back();
                },
                child: const Text("Tambahkan")),
          ],
        )
      ],
    ),
  ));
}

void updateTodoBottomSheet(
    {required int index,
    required String title,
    required bool isDone,
    required DateTime? date,
    required String description}) {
  TextEditingController _todoTitleController = TextEditingController();
  DateController _dateController = Get.find();
  TextEditingController _todoDetailController = TextEditingController();
  var box = Hive.box<Todo>('todoBox');

  _todoTitleController.text = title;
  _todoDetailController.text = description;
  _dateController.todoDateTime.value = date;
  Get.bottomSheet(Container(
    padding: EdgeInsets.all(20.sp),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.w),
        topRight: Radius.circular(30.w),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Ubah Agenda", style: TextStyle(fontSize: 16),),
        SizedBox(
          height: 12.h,
        ),
        TodoTextField(
          controller: _todoTitleController,
          label: "Judul Agenda",
        ),
        SizedBox(
          height: 12.h,
        ),
        TodoTextField(
          label: "Detail Agenda",
          controller: _todoDetailController,
        ),
        SizedBox(
          height: 12.h,
        ),
        TodoDateTextField(label: "Waktu Agenda"),
        SizedBox(
          height: 12.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  if (_todoTitleController.text.isEmpty) {
                    Get.snackbar(
                      "Error",
                      "Judul agenda tidak boleh kosong",
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                    return;
                  }
                  box.putAt(
                      index,
                      Todo(
                        title: _todoTitleController.text,
                        description: _todoDetailController.text,
                        date: _dateController.todoDateTime.value,
                        isDone: isDone,
                      ));
                  Get.back();
                },
                child: const Text("Tambahkan")),
          ],
        )
      ],
    ),
  ));
}
