import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/add_student_controller.dart';
import 'package:student_app/helpers/app_colors.dart';
import 'package:student_app/helpers/app_sizes.dart';
import 'package:student_app/widgets/drop_down_form_field_widget.dart';

import '../../controller/home_controller.dart';

enum TwoScreens {
  add,
  edit,
}

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key, required this.twoScreens});
  final TwoScreens twoScreens;

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: widget.twoScreens == TwoScreens.add
            ? Text(
                'Add Screen',
                style: TextStyle(color: AppColors.white),
              )
            : Text(
                'Edit Screen',
                style: TextStyle(color: AppColors.white),
              ),
        backgroundColor: AppColors.primary,
      ),
      body: Consumer<AddStudentController>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (value.errorMsg != '') {
            return Center(
              child: Text(
                value.errorMsg,
                style: TextStyle(fontSize: 22, color: AppColors.red),
              ),
            );
          } else {
            return SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          AppSizes.szdh20,
                          TextFormField(
                            controller: widget.twoScreens == TwoScreens.add
                                ? value.nameController
                                : value.nameController,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Valid Credential';
                              } else {
                                return null;
                              }
                            },
                          ),
                          AppSizes.szdh20,
                          TextFormField(
                            keyboardType: TextInputType.phone,
                            controller: widget.twoScreens == TwoScreens.add
                                ? value.ageController
                                : value.ageController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Age',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter Valid Credential';
                              } else {
                                return null;
                              }
                            },
                          ),
                          AppSizes.szdh20,
                          widget.twoScreens == TwoScreens.add
                              ? DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Choose Domain',
                                  ),
                                  value: null,
                                  items: value.domainList.map((String items) {
                                    return DropdownMenuItem<String>(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (newIndex) {
                                    value
                                        .changeDomainIndex(newIndex.toString());
                                  },
                                )
                              : DropDownFormFieldWidget(
                                  hint: 'Choose Domain',
                                  value: value.domainChosen,
                                  items: value.domainList.map((String items) {
                                    return DropdownMenuItem<String>(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onTap: (newIndex) {
                                    value
                                        .changeDomainIndex(newIndex.toString());
                                  },
                                ),
                          AppSizes.szdh20,
                          widget.twoScreens == TwoScreens.add
                              ? DropdownButtonFormField<String>(
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    hintText: 'Choose Gender',
                                  ),
                                  value: null,
                                  items: value.genderList.map((String items) {
                                    return DropdownMenuItem<String>(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onChanged: (newIndex) {
                                    value
                                        .changeGenderIndex(newIndex.toString());
                                  },
                                )
                              : DropDownFormFieldWidget(
                                  hint: 'Choose Gender',
                                  value: value.genderChosen,
                                  items: value.genderList.map((String items) {
                                    return DropdownMenuItem<String>(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  onTap: (newIndex) {
                                    value
                                        .changeGenderIndex(newIndex.toString());
                                  },
                                ),
                          AppSizes.szdh20,
                          widget.twoScreens == TwoScreens.edit
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        value.editStudent(context,
                                            studentId: value
                                                    .studentModel?.student.id ??
                                                "");
                                        Provider.of<HomeController>(context,
                                                listen: false)
                                            .getAllStudents();
                                        //
                                      });
                                    }
                                  },
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(
                                        fontSize: 20, color: AppColors.white),
                                  ),
                                )
                              : ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primary),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      setState(() {
                                        value.addStudent(
                                          context,
                                        );
                                      });
                                    }
                                  },
                                  child: Text(
                                    'SAVE',
                                    style: TextStyle(
                                        fontSize: 20, color: AppColors.white),
                                  ),
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
