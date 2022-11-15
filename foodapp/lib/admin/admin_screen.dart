import 'package:flutter/material.dart';
import 'package:foodapp/admin/widget/member_list.dart';
import 'package:foodapp/core/app_colors.dart';
import 'package:foodapp/core/user-role.enum.dart';
import 'package:foodapp/model/food.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import '../user_view_model/user_model.dart';
import 'widget/add_food_item.dart';
import 'widget/food_item_list.dart';
import 'widget/toplited_vote.dart';
import 'widget/vote_list.dart';

class AdminPage extends StatelessWidget {
  AdminPage({Key? key}) : super(key: key);

  final _controller = SidebarXController(selectedIndex: 0, extended: true);
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      key: _key,
      appBar: isSmallScreen
          ? AppBar(
              backgroundColor: AppColors.canvasColor,
              title: Text(_getTitleByIndex(_controller.selectedIndex)),
              leading: IconButton(
                onPressed: () {
                  // if (!Platform.isAndroid && !Platform.isIOS) {
                  //   _controller.setExtended(true);
                  // }
                  _key.currentState?.openDrawer();
                },
                icon: const Icon(Icons.menu),
              ),
            )
          : null,
      drawer: ExampleSidebarX(controller: _controller),
      body: Row(
        children: [
          if (!isSmallScreen) ExampleSidebarX(controller: _controller),
          Expanded(
            child: Center(
              child: _ScreensExample(
                controller: _controller,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExampleSidebarX extends StatelessWidget {
  ExampleSidebarX({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);

  final SidebarXController _controller;
  final List<SidebarXItem> sidebarItems = [
    SidebarXItem(
      icon: Icons.home,
      label: 'Home',
      onTap: () {
        debugPrint('Home');
      },
    ),
    const SidebarXItem(
      icon: Icons.add,
      label: 'Add Item',
    ),
    const SidebarXItem(
      icon: Icons.people,
      label: 'Member',
    ),
    const SidebarXItem(
      icon: Icons.calendar_month,
      label: 'Report',
    ),
    const SidebarXItem(
      icon: Icons.favorite,
      label: 'Favorites',
    ),
    const SidebarXItem(
      icon: Icons.logout,
      label: 'Log Out',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final model = Provider.of<UserModel>(context, listen: false);
        if (model.loginUser.role == UserRole.User) {
          sidebarItems.removeWhere((element) => element.label == 'Add Item');
        }

        if (model.homeState == HomeState.Loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (model.homeState == HomeState.Error) {
          // showDialog(
          //       context: context,
          //       builder: (ctx) => AlertDialog(
          //         title: const Text("Alert Dialog Box"),
          //         content:  Text('An Error Occured ${model.message}'),
          //         actions: <Widget>[
          //           TextButton(
          //             onPressed: () {
          //               Navigator.of(ctx).pop();
          //             },
          //             child: Container(
          //               color: Colors.green,
          //               padding: const EdgeInsets.all(14),
          //               child: const Text("okay"),
          //             ),
          //           ),
          //         ],
          //       ),
          //     );
          Center(child: Text('An Error Occured ${model.message}'));
        }
        return SidebarX(
            controller: _controller,
            theme: SidebarXTheme(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.canvasColor,
                borderRadius: BorderRadius.circular(20),
              ),
              hoverColor: AppColors.scaffoldBackgroundColor,
              textStyle: TextStyle(color: Colors.white.withOpacity(0.7)),
              selectedTextStyle: const TextStyle(color: Colors.white),
              itemTextPadding: const EdgeInsets.only(left: 30),
              selectedItemTextPadding: const EdgeInsets.only(left: 30),
              itemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColors.canvasColor,
                ),
              ),
              selectedItemDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: actionColor.withOpacity(0.37),
                ),
                gradient: const LinearGradient(
                  colors: [accentCanvasColor, AppColors.canvasColor],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.28),
                    blurRadius: 30,
                  )
                ],
              ),
              iconTheme: IconThemeData(
                color: Colors.white.withOpacity(0.7),
                size: 20,
              ),
              selectedIconTheme: const IconThemeData(
                color: Colors.white,
                size: 20,
              ),
            ),
            extendedTheme: const SidebarXTheme(
              width: 200,
              decoration: BoxDecoration(
                color: AppColors.canvasColor,
              ),
            ),
            footerDivider: divider,
            headerBuilder: (context, extended) {
              return SizedBox(
                height: 100,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset('assets/images/user_profile.jpeg'),
                ),
              );
            },
            items: sidebarItems);
      },
    );
  }
}

class _ScreensExample extends StatelessWidget {
  const _ScreensExample({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SidebarXController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Food> listFood = context.watch<UserModel>().food;

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final pageTitle = _getTitleByIndex(controller.selectedIndex);
        switch (controller.selectedIndex) {
          case 0:
            return ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: listFood.length,
                itemBuilder: (context, index) => FoodItemCrad(
                      listFood: listFood,
                      index: index,
                    )

                // Container(
                //   height: 100,
                //   width: double.infinity,
                //   margin: const EdgeInsets.only(bottom: 10, right: 10, left: 10),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20),
                //     color: Theme.of(context).canvasColor,
                //     boxShadow: const [BoxShadow()],

                //   ),

                // ),
                );

          case 1:
            return const AddFoodItem();
          case 2:
            return const Member();
          case 3:
            return const VoteList();
          case 4:
            return const TopListVote();

          default:
            return Text(
              pageTitle,
              style: theme.textTheme.headlineSmall,
            );
        }
      },
    );
  }
}

String _getTitleByIndex(int index) {
  switch (index) {
    case 0:
      return 'Home';
    case 1:
      return 'Add Item';
    case 2:
      return 'Member';
    case 3:
      return 'Report';
    case 4:
      return 'Favorites';
    case 5:
      return 'Logout';
    default:
      return 'Not found page';
  }
}

const accentCanvasColor = Color(0xFF3E3E61);
const white = Colors.white;
final actionColor = const Color(0xFF5F5FA7).withOpacity(0.6);
final divider = Divider(color: white.withOpacity(0.3), height: 1);
