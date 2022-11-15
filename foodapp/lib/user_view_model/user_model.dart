// ignore_for_file: constant_identifier_names
import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:foodapp/model/top_voted.dart';
import 'package:foodapp/model/vote_list.dart';
import '../model/all_user.dart';
import '../model/food.dart';
import '../model/user.dart';
import '../service/user_api.dart';

enum HomeState {
  Initial,
  Loading,
  Loaded,
  Error,
}

class UserModel with ChangeNotifier {
  HomeState _homeState = HomeState.Initial;
  List<GetUser> users = [];
  User loginUser = User();
  List<Food> food = [];
  String message = '';
  String vote = "";
  Vote topvoted = Vote(message: "", favrt: Favrt(foodName: "", id: "", v: 0));
  VoteListData voteList = VoteListData();

  UserModel() {
    fetchUsers();
    fetchFood();
    profileData();
    topVoteListData();
  }

  HomeState get homeState => _homeState;

  Future<void> profileData() async {
    _homeState = HomeState.Loading;
    try {
      final apiusers = await UserApi.instance!.profileStatus();

      if (apiusers.fullName.isNotEmpty) {
        loginUser = apiusers;
        // ignore: avoid_print
        print(loginUser.role.toString());
        _homeState = HomeState.Loaded;
        log('User Rule:');
        log(apiusers.role.toString());

        notifyListeners();
      } else {
        loginUser.message = apiusers.message;

        notifyListeners();
      }
    } catch (e) {
      message = '$e';
      _homeState = HomeState.Error;
      loginUser.message = 'An error occurred';
      notifyListeners();
    }
  }

  Future<bool> userData(String email, String password) async {
    log("before sendData Call");
    _homeState = HomeState.Loading;
    try {
      final apiusers = await UserApi.instance!.login(email, password);
      log("After sendData Call");
      // ignore: avoid_print
      print(apiusers.role);
      if (apiusers.fullName.isNotEmpty) {
        loginUser = apiusers;
        // ignore: avoid_print
        print(loginUser.role.toString());
        _homeState = HomeState.Loaded;

        notifyListeners();
        return true;
      } else {
        loginUser.message = apiusers.message;

        notifyListeners();
        return false;
      }
    } catch (e) {
      message = '$e';
      _homeState = HomeState.Error;
      loginUser.message = 'An error occurred';
      notifyListeners();
      return false;
    }
  }

  Future<void> foodData(String email, int foodPrice) async {
    log("before FoodData Call");
    _homeState = HomeState.Loading;
    try {
      await UserApi.instance!.createFood(
        email,
        foodPrice,
      );

      await fetchFood();
      log("After FoodData Call");
      // ignore: avoid_print
      print(loginUser.role.toString());
      _homeState = HomeState.Loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<void> fetchUsers() async {
    _homeState = HomeState.Loading;
    try {
      final apiusers = await UserApi.instance?.getAllUser();
      users = apiusers!;
      log(users.toList().toString());
      _homeState = HomeState.Loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<void> fetchFood() async {
    _homeState = HomeState.Loading;
    try {
      final apiusers = await UserApi.instance?.getAllFood();
      food = apiusers!;
      log(food.toList().toString());
      _homeState = HomeState.Loaded;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.Error;
    }
    notifyListeners();
  }

  Future<String> upVoteData(String foodId) async {
    log(foodId);
    _homeState = HomeState.Loading;
    try {
      final apiusers = await UserApi.instance?.upVote(foodId);
      vote = apiusers!;
      _homeState = HomeState.Loaded;

      notifyListeners();
      return vote;
    } catch (e) {
      message = '$e';
      _homeState = HomeState.Error;
      notifyListeners();
      return message;
    }
  }

  Future<void> topVoteData() async {
    _homeState = HomeState.Loading;
    try {
      final apiusers = await UserApi.instance?.getTopVote();
      topvoted = apiusers!;
      _homeState = HomeState.Loaded;
      notifyListeners();
    } catch (e) {
      message = '$e';
      _homeState = HomeState.Error;
      notifyListeners();
    }
  }

  Future<void> topVoteListData() async {
    _homeState = HomeState.Loading;
    try {
      final apiusers = await UserApi.instance?.getVoteList();
      voteList = apiusers!;
      _homeState = HomeState.Loaded;
      notifyListeners();
    } catch (e) {
      message = '$e';
      _homeState = HomeState.Error;
      notifyListeners();
    }
  }
}
