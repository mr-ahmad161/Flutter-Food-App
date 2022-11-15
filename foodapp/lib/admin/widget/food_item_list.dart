import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../model/food.dart';
import '../../user_view_model/user_model.dart';

// ignore: must_be_immutable
class FoodItemCrad extends StatelessWidget {
  List<Food> listFood;
  int index;

  FoodItemCrad({super.key, required this.listFood, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(
          color: theme.canvasColor,
        ),
        child: FoodListTile(
          listFood: listFood,
          index: index,
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class FoodListTile extends StatelessWidget {
  List<Food> listFood;
  int index;
  FoodListTile({super.key, required this.listFood, required this.index});

  void msgToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromARGB(255, 65, 113, 153),
        textColor: Colors.white,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:
                  Border(right: BorderSide(width: 1.0, color: Colors.white24))),
          child: const Icon(Icons.restaurant, color: Colors.white),
        ),
        title: Text(
          listFood[index].foodName,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

        // subtitle: Row(
        //   children: const [
        //     Icon(Icons.linear_scale, color: Colors.yellowAccent),
        //     Text(" Intermediate", style: TextStyle(color: Colors.white))
        //   ],
        // ),
        trailing: IconButton(
            iconSize: 30,
            onPressed: () async {
              String message = await context
                  .read<UserModel>()
                  .upVoteData(listFood[index].id);
              msgToast(message);
              // ignore: use_build_context_synchronously
            },
            icon: const Icon(
              Icons.how_to_vote_outlined,
              color: Colors.white,
            )));
  }
}
