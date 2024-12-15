import 'dart:io';
import 'package:flutter/material.dart';
import 'package:linkestan/my_constants.dart';
import '../main_page/app_localozation.dart';

class VisitCardsDetailPage extends StatefulWidget {
  final String name;
  final String description;
  final String imageUrl;
  final String address;
  final String phoneNumber;
  final String type;
  const VisitCardsDetailPage(
      {super.key,
        required this.name,
        required this.description,
        required this.imageUrl,
        required this.address,
        required this.phoneNumber,
        required this.type});

  @override
  State<VisitCardsDetailPage> createState() => _VisitCardsDetailPageState();
}

class _VisitCardsDetailPageState extends State<VisitCardsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.name}  ${AppLocalizations.of(context).translate('detail')}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
              child: widget.imageUrl.startsWith('assets')
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.asset(
                  widget.imageUrl,
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              )
                  : ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: Image.file(
                  File(widget.imageUrl),
                  width: MediaQuery.of(context).size.width,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                widget.name,
                textAlign: TextAlign.center,
                style: textStyle,
              ),
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.green,
                  size: 30,
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Text(
                    widget.address,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.green,
                  size: 30,
                ),
                const SizedBox(width: 25),
                Expanded(
                  child: Text(
                    widget.phoneNumber,
                    style: const TextStyle(
                      fontStyle: FontStyle.italic,
                      fontSize: 22,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.description,
              textAlign: TextAlign.justify,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
