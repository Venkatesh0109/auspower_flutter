import 'package:auspower_flutter/common/widgets/text.dart';
import 'package:auspower_flutter/constants/space.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TextWidget extends StatefulWidget {
  const TextWidget({super.key});

  @override
  State<TextWidget> createState() => _TextWidgetState();
}

class _TextWidgetState extends State<TextWidget> {
  int _currentIndex = 0;
  final List<String> imagePaths = [
    "assets/images/Banner.png",
    "assets/images/Banner.png",
    "assets/images/Banner.png",
  ];
  List categories = [
    {"name": "All", "image": "assets/images/cat_all.png"},
    {"name": "Nearest", "image": "assets/images/cat_nearest.png"},
    {"name": "Best", "image": "assets/images/cat_best.png"},
  ];

  Map selectedCat = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Entry"),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 12),
            CarouselSlider(
              items: imagePaths
                  .map(
                    (imagePath) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        image: DecorationImage(
                          image: AssetImage(imagePath),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                enlargeCenterPage: true,
                viewportFraction: 0.9,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index % imagePaths.length;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: imagePaths.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => setState(() {
                    _currentIndex = entry.key;
                  }),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentIndex == entry.key
                          ? Colors.blue
                          : Colors.grey,
                    ),
                  ),
                );
              }).toList(),
            ),
            const TextCustom(
              "All Categories",
              fontWeight: FontWeight.bold,
              size: 20,
              color: Colors.black,
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 50, // Adjust height for category containers
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final bool isSelected = selectedCat == categories[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedCat = categories[index];
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.orange : Colors.white,
                        border: Border.all(color: Colors.orange),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: isSelected
                                    ? null
                                    : [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 6,
                                          offset: const Offset(0, 3),
                                        ),
                                      ]),
                            child: Image.asset(
                              categories[index]["image"],
                              height: 24,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            categories[index]["name"],
                            style: TextStyle(
                              color: isSelected ? Colors.white : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextCustom(
                  "Popular Restaurant",
                  fontWeight: FontWeight.bold,
                  size: 20,
                  color: Colors.black,
                ),
                TextCustom(
                  "See All",
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ],
            ),
            const HeightFull(),
            ListView.builder(
              itemCount: 2,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12)),
                            child: Image.asset(
                              "assets/images/popular_restarant.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const TextCustom("Rose Garden Restaurant"),
                          const SizedBox(height: 6),
                          const TextCustom("Burdger - Chicken - Riche - Wings"),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    "assets/images/Star 1.png",
                                    height: 16,
                                  ),
                                  const WidthHalf(),
                                  const TextCustom("4.7")
                                ],
                              ),
                              const WidthFull(),
                              Row(
                                children: [
                                  Image.asset("assets/images/van.png",
                                      height: 16),
                                  const WidthHalf(),
                                  const TextCustom("Free")
                                ],
                              ),
                              const WidthFull(),
                              Row(
                                children: [
                                  Image.asset("assets/images/Clock.png",
                                      height: 16),
                                  const WidthHalf(),
                                  const TextCustom("20 min")
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const HeightFull(),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class TextSearch extends StatefulWidget {
  const TextSearch({super.key});

  @override
  State<TextSearch> createState() => _TextSearchState();
}

class _TextSearchState extends State<TextSearch> {
  final List<String> categories = ["Popular", "Fast Food", "Biryani", "Pizza"];
  final List food = [
    {"name": "Chicken Briyani", "location": "Arafa Restaurant"},
    {"name": "Buffalo Pizza", "location": "Cafenio Coffee Club"},
    {"name": "Buffalo Wing", "location": "Arafa Restaurant"},
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Text Entry"),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                hintText: "Search for food...",
                filled: true,

                fillColor:
                    Colors.grey.shade300, // Background color for the text field
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 16.0),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(34.0), // Overall border radius
                  borderSide: BorderSide.none, // No border outline
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(34.0),
                  borderSide:
                      const BorderSide(color: Colors.transparent // Border width
                          ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(34.0),
                  borderSide: const BorderSide(color: Colors.transparent),
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.black),
                suffixIcon: const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Adjust size to fit icons
                    children: [
                      Icon(Icons.mic, color: Colors.black),
                      SizedBox(width: 12), // Spacing between icons
                      Icon(Icons.tune, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(categories.length, (index) {
                    final bool isSelected = selectedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 12.0),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.pinkAccent.shade100
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(24.0),
                        ),
                        child: Text(
                          categories[index],
                          style: TextStyle(
                            color: isSelected
                                ? const Color.fromARGB(255, 240, 5, 111)
                                : Colors.black,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const TextCustom(
              "Suggested Restaurant",
              fontWeight: FontWeight.bold,
              size: 20,
              color: Colors.black,
            ),
            const HeightFull(),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: 3,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6)),
                          child: Image.asset(
                            "assets/images/popular_restarant.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                        const WidthHalf(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const TextCustom("Pansi Restaurant"),
                            const HeightHalf(),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/Star 1.png",
                                  height: 16,
                                  color: Colors.pinkAccent,
                                ),
                                const WidthHalf(),
                                const TextCustom("4.7")
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                    Divider(
                      thickness: .8,
                      color: Colors.grey.shade600,
                    ),
                  ],
                );
              },
            ),
            const HeightFull(),
            const TextCustom(
              "Popular Fast Food",
              fontWeight: FontWeight.bold,
              size: 20,
              color: Colors.black,
            ),
            const HeightFull(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(food.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        children: [
                          Container(
                              height: 60,
                              width: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Image.asset(
                                  "assets/images/popular_restarant.png")),
                        ],
                      ),
                    );
                  }),
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 12),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Container(
            //         clipBehavior: Clip.antiAlias,
            //         decoration:
            //             BoxDecoration(borderRadius: BorderRadius.circular(12)),
            //         child: Image.asset(
            //           "assets/images/popular_restarant.png",
            //           fit: BoxFit.cover,
            //         ),
            //       ),
            //       SizedBox(height: 6),
            //       TextCustom("Rose Garden Restaurant"),
            //       SizedBox(height: 6),
            //       TextCustom("Burdger - Chicken - Riche - Wings"),
            //       Row(
            //         children: [
            //           Row(
            //             children: [
            //               Image.asset(
            //                 "assets/images/Star 1.png",
            //                 height: 24,
            //               ),
            //               TextCustom("4.7")
            //             ],
            //           ),
            //           WidthFull(),
            //           Row(
            //             children: [
            //               Image.asset("assets/images/van.png", height: 24),
            //               TextCustom("Free")
            //             ],
            //           ),
            //           WidthFull(),
            //           Row(
            //             children: [
            //               Image.asset("assets/images/Clock.png", height: 24),
            //               TextCustom("20 min")
            //             ],
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
