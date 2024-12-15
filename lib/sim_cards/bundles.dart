import 'package:flutter/material.dart';
import 'package:linkestan/sim_cards/sim_cards.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main_page/app_localozation.dart';
import 'bundle_information.dart';

class Bundles extends StatefulWidget {
  final Color appBarColor;
  final String bundleName;
  final String companyName;
  const Bundles(
      {required this.appBarColor,
      required this.bundleName,
      required this.companyName,
      super.key});

  @override
  State<Bundles> createState() => _BundlesState();
}

class _BundlesState extends State<Bundles> {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.appBarColor,
          title: Text(AppLocalizations.of(context)
              .translate(widget.bundleName.toLowerCase())),
          bottom: TabBar(
            labelStyle: const TextStyle(fontSize: 15),
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey[400],
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: AppLocalizations.of(context).translate('monthly')),
              Tab(text: AppLocalizations.of(context).translate('nightly')),
              Tab(text: AppLocalizations.of(context).translate('weekly')),
              Tab(text: AppLocalizations.of(context).translate('daily')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            PackageList(
              category: 'monthly',
              companyName: widget.companyName,
              bundleName: widget.bundleName,
            ),
            PackageList(
              category: 'nightly',
              companyName: widget.companyName,
              bundleName: widget.bundleName,
            ),
            PackageList(
              category: 'weekly',
              companyName: widget.companyName,
              bundleName: widget.bundleName,
            ),
            PackageList(
              category: 'daily',
              companyName: widget.companyName,
              bundleName: widget.bundleName,
            ),
          ],
        ),
      ),
    );
  }
}

List<Map<String, String>> bundleList = [];

class PackageList extends StatelessWidget {
  final String category;
  final String companyName;
  final String bundleName;

  const PackageList({
    super.key,
    required this.category,
    required this.companyName,
    required this.bundleName,
  });

  @override
  Widget build(BuildContext context) {
    final bundles = companiesBundles[companyName]?.firstWhere(
        (bundle) => bundle.containsKey(bundleName),
        orElse: () => {})[bundleName];
    switch (category) {
      case 'monthly':
        bundleList = bundles?.monthly ?? [];
        break;
      case 'nightly':
        bundleList = bundles?.nightly ?? [];
        break;
      case 'weekly':
        bundleList = bundles?.weekly ?? [];
        break;
      case 'daily':
        bundleList = bundles?.daily ?? [];
        break;
      default:
        bundleList = [];
    }

    if (bundleList.isEmpty) {
      return Center(
        child: Text(
          AppLocalizations.of(context).translate("no_bundles"),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );
    }


    return ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: bundleList.length,
        itemBuilder: (context, index) {
          final bundle = bundleList[index];
          // final bundle = monthlyBundles[index];
          return PackageContainer(
            name: bundle['title'] ?? '',
            details: bundle['description'] ?? '',
            // bundle['description'] ?? '',
            companyName: companyName,
            bundleName: bundleName,
            category: category,
            index: index,
          );
        });
  }
}

class PackageContainer extends StatelessWidget {
  final String name;
  final String details;
  final String companyName;
  final String bundleName;
  final String category;
  final int index;

  const PackageContainer(
      {super.key,
      required this.name,
      required this.details,
      required this.companyName,
      required this.bundleName,
      required this.category,
      required this.index});

  static Future<void> _makePhoneCall(String? phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }

  Future<void> sendMessage(String message, String number) async {
    final Uri smsUri = Uri(
      scheme: 'sms',
      path: number,
      queryParameters: {'body': message},
    );
    if (await canLaunchUrl(smsUri)) {
      await launchUrl(smsUri);
    } else {
      throw 'Could not launch $smsUri';
    }
  }

  Widget alertBalance(BuildContext context,
      {required Function function, required String choice}) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.white,
      title: Text(
        AppLocalizations.of(context).translate('warning'),
        style: const TextStyle(color: Colors.black),
      ),
      content: Text(
        AppLocalizations.of(context).translate(choice),
        style: const TextStyle(color: Colors.black),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            function();
            Navigator.pop(context);
          },
          child: const Icon(Icons.check),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.close),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    String? activate = bundleList[index]["activation"];
    String? deactivate = bundleList[index]["deactivation"];
    String? number = bundleList[index]["number"];

    return Card(
      color: Colors.white,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
            const SizedBox(height: 8.0),
            Text(
              details,
              style: const TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => alertBalance(context,
                          function: () => networkName == 'awcc' ||
                                  (networkName == 'mtn' &&
                                      bundleName == 'internet bundles')
                              ? _makePhoneCall(activate)
                              : sendMessage(activate ?? '', number ?? ''),
                          choice: 'activate_package_prompt'),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('activate'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => alertBalance(context,
                          function: () => networkName == 'awcc' ||
                                  (networkName == 'mtn' &&
                                      bundleName == 'internet bundles')
                              ? _makePhoneCall(deactivate)
                              : sendMessage(
                                  deactivate ?? '111',
                                  number ?? '111',
                                ),
                          choice: 'deactivate_package_prompt'),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('deactivate'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
