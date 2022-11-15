import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../user_view_model/user_model.dart';

class TopListVote extends StatelessWidget {
  const TopListVote({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    context.read<UserModel>().topVoteData();
    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Padding(
          padding:
              const EdgeInsets.all(8.0).add(const EdgeInsets.only(top: 20)),
          child: Card(
              elevation: 20,
              color: Theme.of(context).canvasColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: SizedBox(
                width: 300,
                height: 400,
                child: Center(
                    child: Text(
                  context.read<UserModel>().topvoted.favrt.foodName.toString(),
                  style: theme.textTheme.headlineSmall,
                )),
              )),
        ));
  }
}
