import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/vote_list.dart';
import '../../user_view_model/user_model.dart';

class VoteList extends StatelessWidget {
  const VoteList({super.key});
  @override
  Widget build(BuildContext context) {
    //context.read<UserModel>().topVoteListData();
    final theme = Theme.of(context);
    VoteListData votelist = context.watch<UserModel>().voteList;
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Builder(builder: (context) {
          final model = Provider.of<UserModel>(context, listen: false);

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
          return ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: votelist.data!.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 8.0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                child: Container(
                    decoration: BoxDecoration(
                      color: theme.canvasColor,
                    ),
                    child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                        leading: Container(
                          padding: const EdgeInsets.only(right: 12.0),
                          decoration: const BoxDecoration(
                              border: Border(
                                  right: BorderSide(
                                      width: 1.0, color: Colors.white24))),
                          child: const Icon(Icons.person, color: Colors.white),
                        ),
                        title: votelist.data == null
                            ? const Center(child: CircularProgressIndicator())
                            : Text(
                                votelist.data![index].foodId!.foodName
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                        subtitle: votelist.data == null
                            ? const Center(child: CircularProgressIndicator())
                            : Row(
                                children: [
                                  // const Icon(Icons.linear_scale, color: Colors.yellowAccent),
                                  Text(
                                      votelist.data![index].userId!.fullName
                                          .toString(),
                                      style:
                                          const TextStyle(color: Colors.white))
                                ],
                              ),
                        trailing: votelist.data == null
                            ? const Center(child: CircularProgressIndicator())
                            : Text(votelist.data![index].count.toString(),
                                style: const TextStyle(color: Colors.white)))),
              );
            },
          );
        }));
  }
}
