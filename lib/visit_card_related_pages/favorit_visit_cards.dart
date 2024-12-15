import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkestan/visit_card_related_pages/visit_cards.dart';
import 'package:linkestan/visit_card_related_pages/visit_cards_detail_page.dart';
import 'package:url_launcher/url_launcher.dart';
import '../databaseHelper/favorite_bloc.dart';
import '../databaseHelper/favorite_event.dart';
import '../databaseHelper/favorite_state.dart';
import '../main_page/app_localozation.dart';
import '../my_constants.dart';

class FavoriteVisitCards extends StatelessWidget {
  const FavoriteVisitCards({super.key});

  static Future<void> _makePhoneCall(String? phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Row(
          children: [
            const Icon(Icons.favorite, color: Colors.red),
            Text(AppLocalizations.of(context).translate('favorite_visit_cards')),
          ],
        ),
      ),
      body: BlocBuilder<FavoriteVisitCardBloc, FavoriteVisitCardState>(
        builder: (context, state) {
          if (state is FavoriteVisitCardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteVisitCardLoaded) {
            final favoriteVisitCards = state.visitCards
                .where((visitCard) => visitCard.favorite == 1)
                .toList();

            if (favoriteVisitCards.isEmpty) {
              return  Center(
                child: Text(
                  AppLocalizations.of(context).translate('not_found'),
                  style: TextStyle(fontSize: 16),
                ),
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: favoriteVisitCards.length,
              itemBuilder: (context, index) {
                final visitCard = favoriteVisitCards[index];

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
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: 170,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: displayVisitCardImage(visitCard.imageUrl),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.6),
                            borderRadius: const BorderRadius.vertical(
                              bottom: Radius.circular(8),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(onPressed: (){
                                showDialog(context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        AppLocalizations.of(context).translate('warning'),
                                        textAlign: TextAlign.center,),
                                      titleTextStyle: TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green.shade800),
                                      content:  Text(
                                        '${AppLocalizations.of(context).translate('call_description')} ${visitCard.phoneNumber}',
                                        textAlign: TextAlign.center,),
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
                              Text(
                                visitCard.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
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
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {
                                      context.read<FavoriteVisitCardBloc>().add(
                                        ToggleFavoriteVisitCardEvent(visitCard),
                                      );
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
              },
            );
          } else if (state is FavoriteVisitCardError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else {
            return const Center(child: Text('Unexpected state.'));
          }
        },
      ),
    );
  }
}
