import 'package:flutter/material.dart';
import 'package:shoeper/components/stagger_tile.dart';
import 'package:shoeper/models/sneakers_model.dart';

class LatestShoes extends StatelessWidget {
  const LatestShoes({
    super.key,
    required Future<List<Sneaker>> shoeList,
  }) : _shoeList = shoeList;

  final Future<List<Sneaker>> _shoeList;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _shoeList,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            print("Error: ${snapshot.error}");
            return Text("Error: ${snapshot.error}");
          } else {
            final male = snapshot.data;
            return GridView.builder(
              itemCount: male!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                final maleShoe = snapshot.data![index];
                return StaggerTile(
                    imageUrl: maleShoe.imageUrl[1],
                    name: maleShoe.name,
                    price: maleShoe.price);
              },
            );
          }
        }));
  }
}
