import 'product_data.dart';
import 'recipe_category_data.dart';
import 'translation.dart';
import 'user_data.dart';

class RecipeData {
  RecipeData({
    int? id,
    String? image,
    int? status,
    int? activeTime,
    int? totalTime,
    int? calories,
    int? shopId,
    UserData? user,
    Translation? translation,
    List<Nutritions>? nutritions,
    List<Instructions>? instructions,
    List<RecipeProduct>? recipeProducts,
    RecipeCategoryData? category,
  }) {
    _id = id;
    _image = image;
    _status = status;
    _activeTime = activeTime;
    _totalTime = totalTime;
    _calories = calories;
    _shopId = shopId;
    _user = user;
    _translation = translation;
    _nutritions = nutritions;
    _instructions = instructions;
    _products = recipeProducts;
    _category = category;
  }

  RecipeData.fromJson(dynamic json) {
    _id = json['id'];
    _image = json['image'];
    _status = json['status'];
    _activeTime = json['active_time'];
    _totalTime = json['total_time'];
    _calories = json['calories'];
    _shopId = json['shop_id'];
    _user = json['user'] != null ? UserData.fromJson(json['user']) : null;
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
    if (json['nutritions'] != null) {
      _nutritions = [];
      json['nutritions'].forEach((v) {
        _nutritions?.add(Nutritions.fromJson(v));
      });
    }
    if (json['instructions'] != null) {
      _instructions = [];
      json['instructions'].forEach((v) {
        _instructions?.add(Instructions.fromJson(v));
      });
    }
    if (json['products'] != null) {
      _products = [];
      json['products'].forEach((v) {
        _products?.add(RecipeProduct.fromJson(v));
      });
    }
    _category = json['category'] != null
        ? RecipeCategoryData.fromJson(json['category'])
        : null;
  }

  int? _id;
  String? _image;
  int? _status;
  int? _activeTime;
  int? _totalTime;
  int? _calories;
  int? _shopId;
  UserData? _user;
  Translation? _translation;
  List<Nutritions>? _nutritions;
  List<Instructions>? _instructions;
  List<RecipeProduct>? _products;
  RecipeCategoryData? _category;

  RecipeData copyWith({
    int? id,
    String? image,
    int? status,
    int? activeTime,
    int? totalTime,
    int? calories,
    int? shopId,
    UserData? user,
    Translation? translation,
    List<Nutritions>? nutritions,
    List<Instructions>? instructions,
    List<RecipeProduct>? recipeProducts,
    RecipeCategoryData? category,
  }) =>
      RecipeData(
        id: id ?? _id,
        image: image ?? _image,
        status: status ?? _status,
        activeTime: activeTime ?? _activeTime,
        totalTime: totalTime ?? _totalTime,
        calories: calories ?? _calories,
        shopId: shopId ?? _shopId,
        user: user ?? _user,
        translation: translation ?? _translation,
        nutritions: nutritions ?? _nutritions,
        instructions: instructions ?? _instructions,
        recipeProducts: recipeProducts ?? _products,
        category: category ?? _category,
      );

  int? get id => _id;

  String? get image => _image;

  int? get status => _status;

  int? get activeTime => _activeTime;

  int? get totalTime => _totalTime;

  int? get calories => _calories;

  int? get shopId => _shopId;

  UserData? get user => _user;

  Translation? get translation => _translation;

  List<Nutritions>? get nutritions => _nutritions;

  List<Instructions>? get instructions => _instructions;

  List<RecipeProduct>? get recipeProducts => _products;

  RecipeCategoryData? get category => _category;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['image'] = _image;
    map['status'] = _status;
    map['active_time'] = _activeTime;
    map['total_time'] = _totalTime;
    map['calories'] = _calories;
    map['shop_id'] = _shopId;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    if (_nutritions != null) {
      map['nutritions'] = _nutritions?.map((v) => v.toJson()).toList();
    }
    if (_instructions != null) {
      map['instructions'] = _instructions?.map((v) => v.toJson()).toList();
    }
    if (_products != null) {
      map['products'] = _products?.map((v) => v.toJson()).toList();
    }
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    return map;
  }
}

class Nutritions {
  Nutritions({
    int? id,
    String? weight,
    String? percentage,
    Translation? translation,
  }) {
    _id = id;
    _weight = weight;
    _percentage = percentage;
    _translation = translation;
  }

  Nutritions.fromJson(dynamic json) {
    _id = json['id'];
    _weight = json['weight'];
    _percentage = json['percentage'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  String? _weight;
  String? _percentage;
  Translation? _translation;

  Nutritions copyWith({
    int? id,
    String? weight,
    String? percentage,
    Translation? translation,
  }) =>
      Nutritions(
        id: id ?? _id,
        weight: weight ?? _weight,
        percentage: percentage ?? _percentage,
        translation: translation ?? _translation,
      );

  int? get id => _id;

  String? get weight => _weight;

  String? get percentage => _percentage;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['weight'] = _weight;
    map['percentage'] = _percentage;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}

class Instructions {
  Instructions({int? id, Translation? translation}) {
    _id = id;
    _translation = translation;
  }

  Instructions.fromJson(dynamic json) {
    _id = json['id'];
    _translation = json['translation'] != null
        ? Translation.fromJson(json['translation'])
        : null;
  }

  int? _id;
  Translation? _translation;

  Instructions copyWith({int? id, Translation? translation}) =>
      Instructions(id: id ?? _id, translation: translation ?? _translation);

  int? get id => _id;

  Translation? get translation => _translation;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    if (_translation != null) {
      map['translation'] = _translation?.toJson();
    }
    return map;
  }
}

class RecipeProduct {
  RecipeProduct({
    int? id,
    String? measurement,
    int? quantity,
    ProductData? product,
  }) {
    _id = id;
    _measurement = measurement;
    _quantity = quantity;
    _shopProduct = product;
  }

  RecipeProduct.fromJson(dynamic json) {
    final measurement = json['measurement'];
    _id = json['id'];
    _measurement = measurement;
    _quantity = measurement == null ? 0 : int.tryParse(measurement);
    _shopProduct = json['shopProduct'] != null
        ? ProductData.fromJson(json['shopProduct'])
        : null;
  }

  int? _id;
  String? _measurement;
  int? _quantity;
  ProductData? _shopProduct;

  RecipeProduct copyWith({
    int? id,
    String? measurement,
    int? quantity,
    ProductData? product,
  }) =>
      RecipeProduct(
        id: id ?? _id,
        measurement: measurement ?? _measurement,
        quantity: quantity ?? _quantity,
        product: product ?? _shopProduct,
      );

  int? get id => _id;

  String? get measurement => _measurement;

  int? get quantity => _quantity;

  ProductData? get product => _shopProduct;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['measurement'] = _measurement;
    if (_shopProduct != null) {
      map['shopProduct'] = _shopProduct?.toJson();
    }
    return map;
  }
}
