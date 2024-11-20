import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_rim/controllers/home_controller.dart';
import 'package:my_school_rim/tools/constants/sizes.dart';
import 'package:my_school_rim/views/pages/notifications_page.dart';
import 'package:my_school_rim/views/pages/profiles_page.dart';
import 'package:my_school_rim/views/widgets/my_app_bar.dart';

import '../../main.dart';
import '../../tools/constants/colors.dart';
import '../../tools/constants/expression.dart';
import '../../tools/constants/fonts.dart';
import '../widgets/container_indicator.dart';
import '../widgets/my_floating_action_button.dart';
import '../widgets/my_icon.dart';
import '../widgets/my_list_tile_in_drawer.dart';
import '../widgets/my_text.dart';
import 'login_page.dart';
import 'comptes_page.dart';
import 'version_activate_page.dart';
import 'version_distribue_page.dart';
import 'version_install_page.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.find();
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: MyFloatingActionButton(
          icon: Icons.add_home_work,
          onPressed: () {
            homeController.scannBarCode();
          },
        ),
        appBar: MyAppBar(
          title: 'الرئيسية',
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    homeController.savemydata();
                  },
                  icon: const MyIcon(
                    icon: Icons.save,
                    color: white,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await homeController.deleteBase();
                    Get.offAll(() => LoginPage());
                  },
                  icon: const MyIcon(
                    icon: Icons.delete,
                    color: white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    homeController.getToken(context);
                  },
                  icon: const MyIcon(
                    icon: Icons.token,
                    color: orang,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    mySharedPreferences!
                        .setBool(sharedPreferencesLogined, false);
                    Get.offAll(() => LoginPage());
                  },
                  icon: const MyIcon(
                    icon: Icons.stop_circle_outlined,
                    color: red,
                    size: size24,
                  ),
                ),
              ],
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                    gradient:
                        LinearGradient(colors: [Color(blue), Color(white)])),
                child: Center(
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/logo.png"),
                    radius: 50,
                  ),
                ),
              ),
              mySharedPreferences!.getBool(sharedPreferencesING) == true
                  ? MyListTileInDrawer(
                      data: 'المستخدمون',
                      icon: Icons.person,
                      icondetail: Icons.arrow_back_outlined,
                      onTap: () {
                        Get.back();
                        Get.to(() => const ComptesPage());
                      },
                    )
                  : const SizedBox(),
              mySharedPreferences!.getBool(sharedPreferencesDRC) == true
                  ? Column(
                      children: [
                        MyListTileInDrawer(
                          data: 'تثبيت نسخة',
                          icon: Icons.local_activity,
                          icondetail: Icons.arrow_back_outlined,
                          onTap: () {
                            Get.back();
                            Get.to(() => VersionInstallPage());
                          },
                        ),
                        MyListTileInDrawer(
                          data: 'تفعيل نسخة',
                          icon: Icons.local_activity,
                          icondetail: Icons.arrow_back_outlined,
                          onTap: () {
                            Get.back();
                            Get.to(() => VersionActivatePage());
                          },
                        ),
                        MyListTileInDrawer(
                          data: 'توزيع نسخة',
                          icon: Icons.local_activity,
                          icondetail: Icons.arrow_back_outlined,
                          onTap: () {
                            Get.back();
                            Get.to(() => VersionDistributionPage());
                          },
                        ),
                        MyListTileInDrawer(
                          data: 'الإذن باشعارات المؤسسة',
                          icon: Icons.local_activity,
                          icondetail: Icons.arrow_back_outlined,
                          onTap: () {
                            Get.back();
                            Get.to(() => NotificationsPage());
                          },
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
        body: Stack(
          children: [
            GetBuilder<HomeController>(builder: (controller) {
              return RefreshIndicator(
                  onRefresh: () async {
                    await controller.getAllEcoles();
                  },
                  child: controller.mapEcoles.isEmpty
                      ? const Center()
                      : ListView.builder(
                          itemCount: controller.mapEcoles.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                index == 0
                                    ? const Column(
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              MyText(
                                                data: 'لائحة مدارسي',
                                                color: red,
                                                fontSize: font16,
                                                decoration:
                                                    TextDecoration.underline,
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                                Card(
                                  child: ListTile(
                                      onTap: () {
                                        Get.to(() => ProfilePage(), arguments: {
                                          keyQRecolename:
                                              '${controller.mapEcoles[index][controller.sqlDB.champEcoName]}',
                                          keyQRprofiles:
                                              '${controller.mapEcoles[index][controller.sqlDB.champEcoYourProfile]}',
                                          keyQRecoleID:
                                              '${controller.mapEcoles[index][controller.sqlDB.champEcoCode]}',
                                        });
                                      },
                                      title: Row(
                                        children: [
                                          Expanded(
                                            flex: 5,
                                            child: MyText(
                                              data:
                                                  '${controller.mapEcoles[index][controller.sqlDB.champEcoName]}',
                                              color: blue,
                                              fontSize: font16,
                                            ),
                                          ),
                                        ],
                                      ),
                                      subtitle: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const MyText(
                                              data: 'كود المدرسة',
                                              color: green,
                                              fontSize: font12),
                                          MyText(
                                              data:
                                                  '${controller.mapEcoles[index][controller.sqlDB.champEcoCode]}',
                                              color: green,
                                              fontSize: font12),
                                        ],
                                      )),
                                ),
                              ],
                            );
                          },
                        ));
            }),
            GetBuilder<HomeController>(
              builder: (controller) => Container(
                child: controller.loading == true
                    ? const ContainerIndicator(
                        opacity: 1,
                      )
                    : null,
              ),
            )
          ],
        ));
  }
}
