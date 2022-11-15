import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:foodapp/model/top_voted.dart';
import 'package:foodapp/model/user.dart';
import 'package:foodapp/model/vote_list.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import '../model/all_user.dart';
import '../model/food.dart';

var usremail = Hive.box('userBox').get('email');

class UserApi {
  static UserApi? _instance;

  UserApi._();

  static UserApi? get instance {
    // ignore: prefer_conditional_assignment
    if (_instance == null) {
      _instance = UserApi._();
    }
    return _instance;
  }

  Future<User> login(String email, String password) async {
    log(email);
    log(password);
    // log("Before api Call");
    await Hive.box('userBox').put('email', email);
    log(Hive.box('userBox').get('email'));
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8500/user/login'),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(<String, String>{
              'email': email,
              'password': password,
            }));
    // log("After api Call");
    // log("Body");
    log(response.body);

    if (response.statusCode != 200) {
      return User()..message = jsonDecode(response.body)['message'];
    }
    return User.fromJson(jsonDecode(response.body));
  }

  Future<User> profileStatus() async {
    // log(email);
    // log(password);
    // log("Before api Call");
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8500/user/me?email=$usremail'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    // log("After api Call");
    // log("Body");
    log(response.body);

    if (response.statusCode != 200) {
      return User()..message = jsonDecode(response.body)['message'];
    }
    return User.fromJson(jsonDecode(response.body));
  }

  Future<void> createFood(String foodName, int foodPrice) async {
    // log(email);
    // log(foodPrice);
    // log(foodName);

    log("Before api Call");
    log(usremail);
    final response = await http.post(Uri.parse('http://10.0.2.2:8500/food/add'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'email': usremail,
          'foodPrice': foodPrice,
          'foodName': foodName,
        }));
    // log("After api Call");
    log("Body food created");
    log(response.body);
  }

  Future<List<GetUser>> getAllUser() async {
    log("Before All User");
    final getUser =
        await http.get(Uri.parse('http://10.0.2.2:8500/user/find'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    log("Bsfore All User");
    log(getUser.body);
    var tagObjsJson = jsonDecode(getUser.body)['data'] as List;
    List<GetUser> tagObjs =
        tagObjsJson.map((tagJson) => GetUser.fromJson(tagJson)).toList();
    // log("After All User");
    //  ignore: avoid_print
    // print(tagObjs);
    return tagObjs;
  }

  Future<List<Food>> getAllFood() async {
    // log("Before All User");
    final getFood =
        await http.get(Uri.parse('http://10.0.2.2:8500/food/find'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    });
    // log("Bsfore All Food");
    log(getFood.body);
    var objsJson = jsonDecode(getFood.body)['data'] as List;
    List<Food> objs = objsJson.map((json) => Food.fromJson(json)).toList();
    log("After All Food");
    // ignore: avoid_print
    print(objs);
    return objs;
  }

  Future<String> upVote(String foodId) async {
    log("Ar All User");
    log(usremail);
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8500/ufood/vote'),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(<String, String>{
              'foodId': foodId,
              'email': usremail,
            }));
    log(response.body);
    if (response.statusCode != 200) {
      return "UpVoted UnSuccessfuly";
    } else {
      return "UpVoted Successfuly";
    }
  }

  Future<Vote> getTopVote() async {
    // log("Before All User");
    final response = await http.get(
      Uri.parse('http://10.0.2.2:8500/voot/up'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
    );
    log("Vote ---> ");
    // log(response.body);
    // print(response.bodyBytes);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    print('Response Request: ${response..request}');

    return Vote.fromJson(jsonDecode(response.body));
  }

  Future<VoteListData> getVoteList() async {
    // log("Before All User");
    final response =
        await http.post(Uri.parse('http://10.0.2.2:8500/ufood/people'),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(<String, String>{
              'email': usremail,
            }));
    // log("Vote List ");
    // log(response.body);
    // var objsJson = jsonDecode(response.body)['data'] as List;
    // List<VoteListData> objs =
    //     objsJson.map((json) => VoteListData.fromJson(json)).toList();
    // ignore: avoid_print
    var objs = VoteListData.fromJson(jsonDecode(response.body));
    log("TESTING");
    log(objs.toString());
    return objs;
  }
}
