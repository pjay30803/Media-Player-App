import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderComponent extends StatefulWidget {
  const CarouselSliderComponent({super.key});

  @override
  State<CarouselSliderComponent> createState() =>
      _CarouselSliderComponentState();
}

class _CarouselSliderComponentState extends State<CarouselSliderComponent> {
  List<String> allproducts = [
    "https://tse3.mm.bing.net/th?id=OIP.tk1WxPmoD3j6HUbW1gkHFQHaHa&pid=Api&P=0&h=180",
    "https://tse4.mm.bing.net/th?id=OIP.hfNK8S7ywtaPVr8WGTV4-wHaE7&pid=Api&P=0&h=180",
    "https://tse4.mm.bing.net/th?id=OIP.voVmH_P-WhYnjVZYb-WUhwHaHa&pid=Api&P=0&h=180",
    "https://tse2.mm.bing.net/th?id=OIP.zuj7kANit3527OCU_UP2YAHaFm&pid=Api&P=0&h=180",
    "https://tse4.mm.bing.net/th?id=OIP.cw3oQxXYcZaNyrQNoYHSYAAAAA&pid=Api&P=0&h=180",
    "https://tse1.mm.bing.net/th?id=OIP.6Ckm4MGXRjZgWQyRkjDDPgHaEK&pid=Api&P=0&h=180"
  ];

  // List<Color> allColors = [
  //   Colors.red.shade200,
  //   Colors.green.shade200,
  //   Colors.blue.shade200,
  //   Colors.purple.shade200,
  //   Colors.brown.shade200,
  //   Colors.green.shade200,
  // ];

  int initialCarouselIndex = 0;
  CarouselSliderController carouselSliderController =
      CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 15,
      children: [
        CarouselSlider(
          carouselController: carouselSliderController,
          options: CarouselOptions(
              scrollDirection: Axis.horizontal,
              height: 300,
              viewportFraction: 0.8,
              enlargeCenterPage: true,
              autoPlay: true,
              onPageChanged: (val, _) {
                setState(() {
                  initialCarouselIndex = val;
                });
              }),
          items: List.generate(allproducts.length, (i) {
            return Container(
              alignment: Alignment.center,
              child: Image.network(allproducts[i]),
              color: Colors.white,
            );
          }),
        ),
        Container(
          width: 150,
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(allproducts.length, (i) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    initialCarouselIndex = i;
                  });

                  carouselSliderController.animateToPage(i,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut);
                },
                child: CircleAvatar(
                  radius: 5,
                  backgroundColor:
                      (i == initialCarouselIndex) ? Colors.white : Colors.black,
                ),
              );
            }),
          ),
        )
      ],
    );
  }
}
