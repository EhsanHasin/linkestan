import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkestan/databaseHelper/visit_cards_m.dart';
import 'package:linkestan/main_page/app_localozation.dart';
import 'package:linkestan/visit_card_related_pages/favorit_visit_cards.dart';
import 'package:linkestan/visit_card_related_pages/visit_cards_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../databaseHelper/favorite_bloc.dart';
import '../databaseHelper/favorite_event.dart';
import '../databaseHelper/favorite_state.dart';
import '../my_constants.dart';
import 'add_visit_card.dart';

class VisitCards extends StatefulWidget {
  const VisitCards({super.key});

  @override
  State<VisitCards> createState() => _VisitCardsState();
}

class _VisitCardsState extends State<VisitCards> {
  int _selectedCategoryIndex = 0;
  late List<String> _categories;

  final TextEditingController _searchController = TextEditingController();
  List<VisitCardMap> _allVisitCards = [];
  List<VisitCardMap> _filteredVisitCards = [];

  static Future<void> _makePhoneCall(String? phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<FavoriteVisitCardBloc>().add(LoadVisitCardsEvent());

    // Initialize search listener
    _searchController.addListener(() {
      _filterVisitCards();
    });
  }

  void _filterVisitCards() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredVisitCards = _allVisitCards
          .where((card) => card.name.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _categories = [
      AppLocalizations.of(context).translate('gyms'),
      AppLocalizations.of(context).translate('pools'),
      AppLocalizations.of(context).translate('academies'),
      AppLocalizations.of(context).translate('universities'),
      AppLocalizations.of(context).translate('restaurants'),
      AppLocalizations.of(context).translate('my_visit_cards'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('visit_cards'),
        style: const TextStyle(fontSize: 17),),
        actions: [
          SizedBox(
            width: 200, // Adjust width as needed
            height: 40, // Adjust height as needed
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: TextField(
                controller: _searchController,
                cursorColor: Colors.black,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: AppLocalizations.of(context).translate('search'),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white, width: 1), // White border
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                ),
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<FavoriteVisitCardBloc, FavoriteVisitCardState>(
        builder: (context, state) {
          if (state is FavoriteVisitCardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteVisitCardLoaded) {
            _allVisitCards = state.visitCards;
            _filteredVisitCards = _searchController.text.isEmpty
                ? _allVisitCards
                : _filteredVisitCards;

            final Map<int, List<VisitCardMap>> categorizedItems = {
              0: [],
              1: [],
              2: [],
              3: [],
              4: [],
              5: [],
            };
            for (var card in _filteredVisitCards) {
              switch (card.type.toLowerCase()) {
                case 'gyms':
                  categorizedItems[0]!.add(card);
                  break;
                case 'pools':
                  categorizedItems[1]!.add(card);
                  break;
                case 'academies':
                  categorizedItems[2]!.add(card);
                  break;
                case 'universities':
                  categorizedItems[3]!.add(card);
                  break;
                case 'restaurants':
                  categorizedItems[4]!.add(card);
                  break;
                default:
                  categorizedItems[5]!.add(card); // My Choices
              }
            }

            final categoryItems =
                categorizedItems[_selectedCategoryIndex] ?? [];

            return Column(
              children: [
                _buildCategoryChips(),
                Expanded(
                  child: ListView.builder(
                    itemCount: categoryItems.length,
                    itemBuilder: (context, index) {
                      final item = categoryItems[index];
                      return _buildVisitCard(item);
                    },
                  ),
                ),
              ],
            );
          } else if (state is FavoriteVisitCardError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          return const Center(child: Text('No Visit Cards Available'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddVisitCard()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      // color: lightGreen,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavoriteVisitCards(),
                  ),
                );
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 35,
              ),
            ),
            Row(
              children: List.generate(_categories.length, (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: ChoiceChip(
                    label: Text(_categories[index]),
                    selected: _selectedCategoryIndex == index,
                    onSelected: (bool selected) {
                      setState(() {
                        _selectedCategoryIndex = index;
                      });
                    },
                    side: BorderSide(color: Colors.green.shade800),
                    checkmarkColor: Colors.white,
                    selectedColor: green,
                    backgroundColor: lightGreen,
                    labelStyle: TextStyle(
                      color: _selectedCategoryIndex == index
                          ? Colors.white
                          : Colors.green.shade800,
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildVisitCard(VisitCardMap visitCard) {
    return InkWell(
      onTap: () => Navigator.push(context,
      MaterialPageRoute(builder: (context)=>
        VisitCardsDetailPage(
          name: visitCard.name,
                description: visitCard.description,
                imageUrl: visitCard.imageUrl,
                address: visitCard.address,
                phoneNumber: visitCard.phoneNumber,
                type: visitCard.type,
        ),
      ),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              child: displayVisitCardImage(visitCard.imageUrl),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius:
                const BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextButton(onPressed: (){
                      showDialog(context: context,
                          builder: (context) => AlertDialog(
                            title: Text(
                              AppLocalizations.of(context).translate('warning'),
                              textAlign: TextAlign.center,),
                            titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade800),
                            content:  Text('${AppLocalizations.of(context).translate('call_description')} ${visitCard.phoneNumber}',textAlign: TextAlign.center,),
                            contentTextStyle: TextStyle(color: Colors.green.shade800),
                            actions: [
                              ElevatedButton(onPressed: (){
                                _makePhoneCall(visitCard.phoneNumber);
                                Navigator.pop(context);
                              }, child: const Icon(Icons.check)),
                              ElevatedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                child: const Icon(Icons.close),),
                            ],
                            backgroundColor: lightGreen,
                            actionsAlignment: MainAxisAlignment.center,
                          ));
                    },
                      child: Text(
                        visitCard.phoneNumber,
                        style: const TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),),
                  ),
                  Expanded(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      visitCard.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      if(visitCard.type == 'my choice')
                        IconButton(onPressed: (){
                          showDialog(context: context,
                              builder: (context) => AlertDialog(
                                title: Text(AppLocalizations.of(context).translate('warning')),
                                titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade800),
                                content: Text(AppLocalizations.of(context).translate('delete_vc')),
                                contentTextStyle: TextStyle(color: Colors.green.shade800),
                                actions: [
                                  ElevatedButton(onPressed: (){
                                    context.read<FavoriteVisitCardBloc>().add(DeleteVisitCardEvent(visitCard));
                                    Navigator.pop(context);
                                  }, child: const Icon(Icons.check)),
                                  ElevatedButton(
                                    onPressed: (){
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red),
                                    child: const Icon(Icons.close),),
                                ],
                                backgroundColor: lightGreen,
                                actionsAlignment: MainAxisAlignment.center,
                              ));
                        }, icon: const Icon(Icons.delete, color: Colors.red,)),
                      IconButton(
                        icon: Icon(
                          visitCard.favorite == 1
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          // Dispatch the toggle event
                          context
                              .read<FavoriteVisitCardBloc>()
                              .add(ToggleFavoriteVisitCardEvent(visitCard));
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget detailDialog(BuildContext context, String card) {
  return AlertDialog(
    backgroundColor: lightGreen,
    title: Text(
      AppLocalizations.of(context).translate('description'),
      textAlign: TextAlign.center,
    ),
    titleTextStyle: TextStyle(
        color: Colors.green.shade900,
        fontWeight: FontWeight.bold,
        fontSize: 25),
    content: Text(
      card,
      textAlign: TextAlign.justify,
    ),
    contentTextStyle: TextStyle(
      color: Colors.green.shade900,
      fontSize: 18,
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: Text(
          AppLocalizations.of(context).translate('close'),
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      )
    ],
  );
}

Widget displayVisitCardImage(String imagePath) {
  try {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: imagePath.startsWith('assets/')
          ? ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          imagePath,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
      )
          : ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.file(
          File(imagePath),
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
      ),
    );
  } catch (e) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey[300],
      ),
      child: const Icon(
        Icons.broken_image,
        size: 50,
        color: Colors.grey,
      ),
    );
  }
}
