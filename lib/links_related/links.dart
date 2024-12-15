import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkestan/databaseHelper/links_m.dart';
import 'package:linkestan/main_page/app_localozation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../my_constants.dart';
import 'add_links.dart';
import 'favorite_links.dart';
import 'links_bloc.dart';
import 'links_event.dart';
import 'links_state.dart';

class Links extends StatefulWidget {
  const Links({super.key});

  @override
  State<Links> createState() => _LinksState();
}

class _LinksState extends State<Links> {
  int _selectedCategoryIndex = 0;
   late List<String> _categories;

  void _openLink(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _copyLink(String url) {
    Clipboard.setData(ClipboardData(text: url));
    ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text(AppLocalizations.of(context).translate('copied'))));
  }

  void _shareLink(String url) {
    Share.share(url);
  }

  @override
  void initState() {
    super.initState();
    context.read<FavoriteLinksBloc>().add(LoadLinksEvent());
  }

  @override
  Widget build(BuildContext context) {
    _categories = [
      AppLocalizations.of(context).translate('ai_tools'),
      AppLocalizations.of(context).translate('scholarships'),
      AppLocalizations.of(context).translate('my_links'),
     ];
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('links')),
      ),
      body: BlocBuilder<FavoriteLinksBloc, FavoriteLinksState>(
        builder: (context, state) {
          if (state is FavoriteLinksLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteLinksLoaded) {
            final allVisitCards = state.link;

            // Categorize visit cards
            final Map<int, List<LinkMap>> categorizedItems = {
              0: [],
              1: [],
              2: [],
            };
            for (var card in allVisitCards) {
              switch (card.type.toLowerCase()) {
                case 'ai':
                  categorizedItems[0]!.add(card);
                  break;
                case 'scholarship':
                  categorizedItems[1]!.add(card);
                  break;
                default:
                  categorizedItems[2]!.add(card); // My Choices
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
          } else if (state is FavoriteLinksError) {
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
              MaterialPageRoute(builder: (context) => const AddLinks()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showLinkOptions(String url) {
    showModalBottomSheet(
      backgroundColor: lightGreen,
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.share),
              title: Text(AppLocalizations.of(context).translate('share_link')),
              iconColor: Colors.red,
              titleTextStyle: TextStyle(
                  color: Colors.green.shade800,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              onTap: () {
                _shareLink(url);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.copy),
              title: Text(AppLocalizations.of(context).translate('copy_link')),
              iconColor: Colors.red,
              titleTextStyle: TextStyle(
                  color: Colors.green.shade800,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              onTap: () {
                _copyLink(url);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.open_in_browser),
              title: Text(AppLocalizations.of(context).translate('open_link')),
              iconColor: Colors.red,
              titleTextStyle: TextStyle(
                  color: Colors.green.shade800,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
              onTap: () {
                _openLink(url);
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
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
                    builder: (context) => const FavoriteLinks(),
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

  Widget _buildLinksTile(LinkMap link) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
      child: ExpansionTile(
        title: Text(link.linkName),
        leading: IconButton(
            onPressed: () {
              context
                  .read<FavoriteLinksBloc>()
                  .add(ToggleFavoriteLinksEvent(link));
            },
            icon: Icon(
              link.favorite == 1 ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            )),
        collapsedShape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.green, width: 2)),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: green, width: 2)),
        collapsedIconColor: Colors.red,
        iconColor: Colors.red,
        backgroundColor: Colors.transparent,
        children: [
          ListTile(
            title: TextButton(
              onPressed: ()=> _showLinkOptions(
        link.link),
              child: Text(
                link.link,
                style: const TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
              ),
            ),
            trailing: Column(
              children: [
                if(link.type == 'my choice')
                  IconButton(onPressed: (){
                    showDialog(context: context,
                        builder: (context) => AlertDialog(
                          title: Text(AppLocalizations.of(context).translate('warning')),
                          content: Text(AppLocalizations.of(context).translate('delete_li')),
                          contentTextStyle: TextStyle(color: Colors.green.shade800),
                          actions: [
                            ElevatedButton(onPressed: (){
                              context.read<FavoriteLinksBloc>().add(DeleteLinksEvent(link));
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

              ],
            ),
            textColor: green,
            shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            // Show pop-up menu when link is tapped
          ),
        ],
      ),
    );
  }
}
