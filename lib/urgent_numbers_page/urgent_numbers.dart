import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkestan/databaseHelper/urgent_numbers_m.dart';
import 'package:linkestan/main_page/app_localozation.dart';
import 'package:linkestan/urgent_numbers_page/add_urgent_number.dart';
import 'package:linkestan/urgent_numbers_page/favorite_urgent_numbers.dart';
import 'package:linkestan/urgent_numbers_page/urgent_bloc.dart';
import 'package:linkestan/urgent_numbers_page/urgent_event.dart';
import 'package:linkestan/urgent_numbers_page/urgent_state.dart';
import 'package:url_launcher/url_launcher.dart';
import '../my_constants.dart';
import '../visit_card_related_pages/visit_cards.dart';

class UrgentNumbers extends StatefulWidget {
  const UrgentNumbers({super.key});

  @override
  State<UrgentNumbers> createState() => _UrgentNumbersState();
}

class _UrgentNumbersState extends State<UrgentNumbers> {
  int _selectedCategoryIndex = 0;
   late List<String> _categories;


  Future<void> _makePhoneCall(String phoneNumber) async {
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
    context.read<FavoriteUrgentBloc>().add(LoadUrgentEvent());
  }

  @override
  Widget build(BuildContext context) {
    _categories = [
      AppLocalizations.of(context).translate('urgent_numbers'),
      AppLocalizations.of(context).translate('my_number'),
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('urgent_numbers')),
      ),
      body: BlocBuilder<FavoriteUrgentBloc, FavoriteUrgentState>(
        builder: (context, state) {
          if (state is FavoriteUrgentLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteUrgentLoaded) {
            final allUrgentNumbers = state.urgent;

            final Map<int, List<UrgentNumberMap>> categorizedItems = {
              0: [],
              1: [],
            };
            for (var card in allUrgentNumbers) {
              switch (card.type.toLowerCase()) {
                case 'urgent':
                  categorizedItems[0]!.add(card);
                  break;
                default:
                  categorizedItems[1]!.add(card); // My Choices
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
                      return _buildLinksTile(item);
                    },
                  ),
                ),
              ],
            );
          } else if (state is FavoriteUrgentError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            );
          }
          return Center(child: Text(AppLocalizations.of(context).translate('not_found')));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUrgentNumber()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoriteUrgentNumbers(),
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

  Widget _buildLinksTile(UrgentNumberMap urgent) {
    return Padding(
          padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
          child: ListTile(
            title: Text(urgent.numberName),
            subtitle: Text(urgent.number),
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(color: Colors.green.shade800, width: 2),
            ),
            leading: CircleAvatar(
              foregroundColor: Colors.green.shade800,
              backgroundColor: Colors.white,
              child: Text(urgent.numberName[0]),
            ),
            onTap: () {
              showDialog(context: context,
                  builder: (context) => detailDialog(context, urgent.description));
              },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  onPressed: () {
                    context.read<FavoriteUrgentBloc>()
                     .add(ToggleFavoriteUrgentEvent(urgent));
                  },
                  icon: Icon(
                    urgent.favorite == 1 ? Icons.favorite :
                      Icons.favorite_border,
                      color: Colors.red,
                  ),
                ),
                if(urgent.type == 'my choice')
                  IconButton(onPressed: (){
                    showDialog(context: context,
                        builder: (context) => AlertDialog(
                          title: Text(AppLocalizations.of(context).translate('warning')),
                          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade800),
                          content: Text(AppLocalizations.of(context).translate('delete_un')),
                          contentTextStyle: TextStyle(color: Colors.green.shade800),
                          actions: [
                            ElevatedButton(onPressed: (){
                              context.read<FavoriteUrgentBloc>().add(DeleteUrgentEvent(urgent));
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
                  onPressed: () {
                    _makePhoneCall(urgent.number);
                  },
                  icon: const Icon(
                    Icons.phone,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        );
      }
  }

