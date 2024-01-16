import 'package:flutter/material.dart';
import 'package:shoeper/consts/appstyle.dart';

class ProductCard extends StatelessWidget {
  final String price;
  final String category;
  final String id;
  final String name;
  final String image;
  const ProductCard(
      {super.key,
      required this.price,
      required this.category,
      required this.id,
      required this.name,
      required this.image});

  @override
  Widget build(BuildContext context) {
    bool selected = true;
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.2,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: NetworkImage(image))),
                  ),
                  Positioned(
                    child: GestureDetector(
                      onTap: null,
                      child: Icon(Icons.favorite),
                    ),
                    right: 10,
                    top: 10,
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: appStyleHeight(
                          Colors.black, 25, FontWeight.bold, 1.1),
                    ),
                    Text(
                      category,
                      style:
                          appStyleHeight(Colors.grey, 15, FontWeight.bold, 1),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 8, right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      price,
                      style: appStyle(Colors.black, 30, FontWeight.w700),
                    ),
                    Row(
                      children: [
                        ChoiceChip(
                          padding: EdgeInsets.all(0),
                          shape: CircleBorder(),
                          label: Text(""),
                          showCheckmark: false,
                          selected: selected,
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                        ),
                        ChoiceChip(
                          padding: EdgeInsets.all(0),
                          shape: CircleBorder(),
                          label: Text(""),
                          showCheckmark: false,
                          selected: selected,
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.grey,
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
