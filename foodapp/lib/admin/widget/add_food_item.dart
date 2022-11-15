import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../user_view_model/user_model.dart';

class AddFoodItem extends StatefulWidget {
  const AddFoodItem({super.key});

  @override
  State<AddFoodItem> createState() => _AddFoodItemState();
}

class _AddFoodItemState extends State<AddFoodItem> {
  TextEditingController fooditem = TextEditingController();
  TextEditingController price = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void loginToast(String msg) {
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
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0)
                          .add(const EdgeInsets.only(top: 100)),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: fooditem,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter Food Item",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Food Item is required.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: const [
                                    BoxShadow(
                                        color:
                                            Color.fromRGBO(143, 148, 251, .2),
                                        blurRadius: 20.0,
                                        offset: Offset(0, 10))
                                  ]),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: 50,
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      controller: price,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Enter Food Price",
                                          hintStyle: TextStyle(
                                              color: Colors.grey[400])),
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Food Price is required.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: (() {
                                if (_formKey.currentState!.validate()) {
                                  context.read<UserModel>().foodData(
                                      fooditem.text.toString().trim(),
                                      int.parse(price.text));
                                  loginToast("Food Item successfully Added");

                                  //context.read<UserModel>().fetchFood();
                                  fooditem.clear();
                                  price.clear();
                                }
                              }),
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Theme.of(context).canvasColor,
                                ),
                                child: const Center(
                                  child: Text(
                                    "Add Item",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
