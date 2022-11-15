import 'package:flutter/material.dart';
import 'package:foodapp/model/all_user.dart';
import 'package:provider/provider.dart';
import '../../user_view_model/user_model.dart';

class Member extends StatelessWidget {
  const Member({super.key});
  @override
  Widget build(BuildContext context) {
      final theme = Theme.of(context);
      List<GetUser> user= context.watch<UserModel>().users;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ListView.builder(
              padding: const EdgeInsets.only(top: 10),
              itemCount: user.length,
               itemBuilder: (context, index){
                  return     Card(
                   
      elevation: 8.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration:  BoxDecoration(color: theme.canvasColor,),
        child:  ListTile(
        contentPadding:const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: const EdgeInsets.only(right: 12.0),
          decoration: const BoxDecoration(
              border:  Border(
                  right:  BorderSide(width: 1.0, color: Colors.white24))),
          child: const Icon(Icons.person, color: Colors.white),
        ),
        title:  Text(
        user[index].fullName,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children:  [
           // const Icon(Icons.linear_scale, color: Colors.yellowAccent),
            Text(  user[index].email, style:const TextStyle(color: Colors.white))
          ],
        ),
        trailing:
             Text( user[index].role, style:const TextStyle(color: Colors.white)))
      ),
    );
               },
         
    ),
    );
                
            
              
  }
}

