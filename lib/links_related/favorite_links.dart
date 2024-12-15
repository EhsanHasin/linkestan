import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkestan/databaseHelper/links_m.dart';
import 'package:linkestan/links_related/links_state.dart';
import 'package:linkestan/main_page/app_localozation.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../my_constants.dart';
import 'links_bloc.dart';
import 'links_event.dart';

class FavoriteLinks extends StatefulWidget {
  const FavoriteLinks({super.key});

  @override
  _FavoriteLinksState createState() => _FavoriteLinksState();
}

class _FavoriteLinksState extends State<FavoriteLinks> {
  final List<LinkMap> favoriteItems = [];

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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.favorite, color: Colors.red),
            Text(AppLocalizations.of(context).translate('favorite_links')),
          ],
        ),
      ),
      body: BlocBuilder<FavoriteLinksBloc, FavoriteLinksState>(
          builder: (context, state) {
        if (state is FavoriteLinksLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FavoriteLinksLoaded) {
          final favoriteLinks =
              state.link.where((visitCard) => visitCard.favorite == 1).toList();

          if (favoriteLinks.isEmpty) {
            return Center(
              child: Text(
                AppLocalizations.of(context).translate('not_found'),
                style: const TextStyle(fontSize: 16),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: favoriteLinks.length,
            itemBuilder: (context, index) {
              final item = favoriteLinks[index];
              return Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                child: ExpansionTile(
                  title: Text(item.linkName),
                  leading: IconButton(
                      onPressed: () {
                        context
                            .read<FavoriteLinksBloc>()
                            .add(ToggleFavoriteLinksEvent(item));
                      },
                      icon: Icon(
                        item.favorite == 1
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      )),
                  collapsedShape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide:
                          const BorderSide(color: Colors.green, width: 2)),
                  shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: green, width: 2)),
                  collapsedIconColor: Colors.red,
                  iconColor: Colors.red,
                  backgroundColor: Colors.transparent,
                  children: [
                    ListTile(
                      trailing: Column(
                        children: [
                          if(item.type == 'my choice')
                            IconButton(onPressed: (){
                              showDialog(context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(AppLocalizations.of(context).translate('warning')),
                                    content: Text(AppLocalizations.of(context).translate('delete_li')),
                                    actions: [
                                      ElevatedButton(onPressed: (){
                                        context.read<FavoriteLinksBloc>().add(DeleteLinksEvent(item));
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
                      title: Text(
                        item.link,
                        style: const TextStyle(
                            color: Colors.blue,
                            decoration: TextDecoration.underline),
                      ),
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      onTap: () => _showLinkOptions(item.description),
                    ),
                  ],
                ),
              );
            },
          );
        } else if (state is FavoriteLinksError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: Text('Unexpected state.'));
        }
      }),
    );
  }
}
