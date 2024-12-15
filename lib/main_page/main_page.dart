import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../my_constants.dart';
import 'app_localozation.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MainPageCard> cardInfo = [];

  final List<String> imageUrl = [
    'assets/images/LinkestanLogo.png',
    'assets/images/LinkestanLogo.png',
    'assets/images/LinkestanLogo.png',
    'assets/images/LinkestanLogo.png',
    'assets/images/LinkestanLogo.png',
  ];
  @override
  Widget build(BuildContext context) {
    cardInfo = [
      MainPageCard(
          name: AppLocalizations.of(context).translate('visitCard'),
          photo: 'assets/images/visit_card.png',
          onPress: ROUTE_VISIT_CARD_PAGE),
      MainPageCard(
          name: AppLocalizations.of(context).translate('links'),
          photo: 'assets/images/links_.png',
          onPress: ROUTE_LINKS_PAGE),
      MainPageCard(
          name: AppLocalizations.of(context).translate('urgentNumber'),
          photo: 'assets/images/phone.png',
          onPress: ROUTE_URGENT_NUMBER_PAGE),
      MainPageCard(
          name: AppLocalizations.of(context).translate('simCards'),
          photo: 'assets/images/simCard.png',
          onPress: ROUTE_SIM_CARDS_PAGE),
      MainPageCard(
          name: AppLocalizations.of(context).translate('generalTools'),
          photo: 'assets/images/mosque.jpg',
          onPress: ROUTE_SHAREI_PAGE),
      MainPageCard(
          name: AppLocalizations.of(context).translate('settings'),
          photo: 'assets/images/settings.jpg',
          onPress: ROUTE_SETTINGS_PAGE),
    ];

    return Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: Text(AppLocalizations.of(context).translate('appTitle')),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 180,
            child: CarouselSlider(
              options: CarouselOptions(
                height: 150.0,
                enlargeCenterPage: true,
                enableInfiniteScroll: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 5),
              ),
              items: imageUrl.map((color) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.8,
                      margin: const EdgeInsets.symmetric(horizontal: 8.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(color)),
                        color: Colors.green.shade200,
                        borderRadius: BorderRadius.circular(25),
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 7,
                  crossAxisSpacing: 7,
                ),
                itemCount: cardInfo.length,
                itemBuilder: (context, index) {
                  final cards = cardInfo[index];
                  return GridTile(
                    child: Column(
                      children: [
                        Expanded(
                          child: InkResponse(
                            onTap: () => Navigator.pushNamed(context, cards.onPress),
                            child: Container(
                              margin: const EdgeInsets.only(top: 10, right: 5, left: 5),
                              width: double.infinity,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(cardInfo[index].photo),
                                ),
                                borderRadius: BorderRadius.circular(25),

                              ),
                            ),
                          ),
                        ),
                        Text(
                          cardInfo[index].name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MainPageCard {
  String name;
  String photo;
  String onPress;

  MainPageCard({required this.name, required this.photo, required this.onPress});
}