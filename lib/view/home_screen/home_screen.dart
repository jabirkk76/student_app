import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:student_app/controller/add_student_controller.dart';
import 'package:student_app/controller/home_controller.dart';
import 'package:student_app/controller/settings_controller.dart';
import 'package:student_app/helpers/app_colors.dart';
import 'package:student_app/services/prefs_manager.dart';
import 'package:student_app/view/add_student_screen/add_student_screen.dart';

import '../../helpers/app_sizes.dart';
import 'widgets/dialog_box_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final homeController =
      Provider.of<HomeController>(context, listen: false);
  final userId = PrefsManager().getUserId();

  @override
  void initState() {
    homeController.getAllStudents();
    Provider.of<SettingsController>(context, listen: false).fetchUserName();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            actions: [
              IconButton(
                onPressed: () {
                  homeController.gotoSettings(context);
                },
                icon: const Icon(Icons.settings),
              ),
            ],
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.primary,
            centerTitle: true,
            flexibleSpace: Consumer<SettingsController>(
              builder: (context, v, child) => Container(
                color: AppColors.primary,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Hi, ${v.storedUserName}',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      getWish(),
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            expandedHeight: 150,
            pinned: true,
          ),
          Consumer<HomeController>(builder: (context, value, child) {
            if (value.isLoading) {
              return const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (value.errorMsg != '') {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    value.errorMsg,
                    style: TextStyle(fontSize: 22, color: AppColors.red),
                  ),
                ),
              );
            } else if (value.students.isEmpty) {
              return SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Text(
                    'No student found',
                    style: TextStyle(fontSize: 22, color: AppColors.black),
                  ),
                ),
              );
            } else {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 20, right: 20),
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Slidable(
                          actions: [
                            IconSlideAction(
                              caption: 'Edit',
                              color: Colors.green,
                              icon: Icons.archive,
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AddStudentScreen(
                                    twoScreens: TwoScreens.edit,
                                  ),
                                ));
                                Provider.of<AddStudentController>(context,
                                        listen: false)
                                    .getStudentDetails(
                                  context,
                                  value.students[index].id,
                                );
                              },
                            ),
                            IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => DialogBoxWidget(
                                    text: 'Do you want to Delete ?',
                                    onTap: () {
                                      value.deleteStudent(context,
                                          studentId:
                                              Provider.of<HomeController>(
                                                      context,
                                                      listen: false)
                                                  .students[index]
                                                  .id);
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                          actionExtentRatio: 0.5,
                          actionPane: const SlidableDrawerActionPane(),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(20),
                              ),
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary.withOpacity(0.8),
                                  AppColors.blue.withOpacity(0.4),
                                ],
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Image.asset(
                                  value.students[index].gender == 'Male'
                                      ? 'assets/man.png'
                                      : 'assets/woman.png',
                                  height: 40,
                                  width: 40,
                                ),
                                AppSizes.szdw20,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      value.students[index].name,
                                      style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Domain: ${value.students[index].domain}',
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Text(
                                  value.students[index].age.toString(),
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: value.students.length,
                ),
              );
            }
          })
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.primary,
        label: Text(
          'ADD',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.white,
          ),
        ),
        icon: Icon(
          Icons.add,
          color: AppColors.white,
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) =>
                const AddStudentScreen(twoScreens: TwoScreens.add),
          ));
        },
      ),
    );
  }

  String getWish() {
    if (DateTime.now().hour < 12 && DateTime.now().hour > 0) {
      return 'Good morning';
    } else if (DateTime.now().hour > 12 && DateTime.now().hour < 15) {
      return 'Good afternoon';
    } else if (DateTime.now().hour > 15 && DateTime.now().hour < 19) {
      return 'Good evening';
    } else {
      return 'Good night';
    }
  }
}
