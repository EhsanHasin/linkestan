import 'package:flutter/material.dart';

import '../main_page/app_localozation.dart';

class Sharei extends StatefulWidget {
  const Sharei({super.key});

  @override
  State<Sharei> createState() => _ShareiState();
}

class _ShareiState extends State<Sharei> {
  List<String> image = [
    'assets/images/LinkestanLogo.png',
    'assets/images/LinkestanLogo.png',
    'assets/images/LinkestanLogo.png',
    'assets/images/LinkestanLogo.png',
    'assets/images/LinkestanLogo.png',
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('tools')),
          toolbarHeight: 31,
          bottom:  TabBar(
            indicatorColor: Colors.red,
            dividerColor: Colors.lightGreen,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            tabs: [
              Text(
                AppLocalizations.of(context).translate('prayer_times'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppLocalizations.of(context).translate('converter'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppLocalizations.of(context).translate('compass'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                AppLocalizations.of(context).translate('comingSoon'),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AvghatSharei(imageUrl: image),
            const DateConverter(),
            const Compass(),
            const ComingSoon(),
          ],
        ),
      ),
    );
  }
}

class AvghatSharei extends StatelessWidget {
  final List<String> imageUrl;

  const AvghatSharei({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
        child: ListView.builder(
          itemCount: imageUrl.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 300,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.green.shade200,
                image: DecorationImage(
                  image: AssetImage(imageUrl[index]),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Compass extends StatefulWidget {
  const Compass({super.key});

  @override
  State<Compass> createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Compass Page'),
      ),
    );
  }
}

class DateConverter extends StatefulWidget {
  const DateConverter({super.key});

  @override
  State<DateConverter> createState() => _DateConverterState();
}

class _DateConverterState extends State<DateConverter> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Date Converter Page'),
      ),
    );
  }
}

class ComingSoon extends StatefulWidget {
  const ComingSoon({super.key});

  @override
  State<ComingSoon> createState() => _ComingSoonState();
}

class _ComingSoonState extends State<ComingSoon> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Coming Soon Page'),
      ),
    );
  }
}
