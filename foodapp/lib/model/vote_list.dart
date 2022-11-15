class VoteListData {
  String? status;
  List<Data>? data;

  VoteListData({this.status, this.data});

  VoteListData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? sId;
  FoodId? foodId;
  UserId? userId;
  int? count;
  String? createdAt;
  String? updatedAt;
  int? iV;

  Data(
      {this.sId,
      this.foodId,
      this.userId,
      this.count,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    foodId = json['foodId'] != null ? FoodId.fromJson(json['foodId']) : null;
    userId = json['userId'] != null ? UserId.fromJson(json['userId']) : null;
    count = json['count'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    if (foodId != null) {
      data['foodId'] = foodId!.toJson();
    }
    if (userId != null) {
      data['userId'] = userId!.toJson();
    }
    data['count'] = count;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}

class FoodId {
  String? sId;
  String? foodName;

  FoodId({this.sId, this.foodName});

  FoodId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    foodName = json['foodName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['foodName'] = foodName;
    return data;
  }
}

class UserId {
  String? sId;
  String? fullName;

  UserId({this.sId, this.fullName});

  UserId.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    fullName = json['fullName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['fullName'] = fullName;
    return data;
  }
}
