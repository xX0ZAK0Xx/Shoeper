
import 'package:flutter/services.dart' as the_bundle;
import 'package:shoeper/models/sneakers_model.dart';

class Helper {
  Future<List<Sneaker>> getMaleSneakers() async {
    final data = await the_bundle.rootBundle
        .loadString("assets/json/men_shoes.json");

    final maleList = sneakerFromJson(data);
    return maleList;
  }

  Future<List<Sneaker>> getFemaleSneakers() async {
    final data = await the_bundle.rootBundle
        .loadString("assets/json/women_shoes.json");

    final femaleList = sneakerFromJson(data);
    return femaleList;
  }

  Future<List<Sneaker>> getKidsSneakers() async {
    final data = await the_bundle.rootBundle
        .loadString("assets/json/kids_shoes.json");

    final kidsList = sneakerFromJson(data);
    return kidsList;
  }

  Future<Sneaker> getMaleSneakersByID(String id) async {
    final data = await the_bundle.rootBundle
        .loadString("assets/json/men_shoes.json");

    final maleList = sneakerFromJson(data);

    final sneaker = maleList.firstWhere((element) => element.id == id);

    return sneaker;
  }
  Future<Sneaker> getFemaleSneakersByID(String id) async {
    final data = await the_bundle.rootBundle
        .loadString("assets/json/women_shoes.json");

    final femaleList = sneakerFromJson(data);

    final sneaker = femaleList.firstWhere((element) => element.id == id);

    return sneaker;
  }
  Future<Sneaker> getKidsSneakersByID(String id) async {
    final data = await the_bundle.rootBundle
        .loadString("assets/json/kids_shoes.json");

    final kidsList = sneakerFromJson(data);

    final sneaker = kidsList.firstWhere((element) => element.id == id);

    return sneaker;
  }
}
