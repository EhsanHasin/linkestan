import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../databaseHelper/links_m.dart';
import '../main_page/app_localozation.dart';
import '../my_constants.dart';
import 'links_bloc.dart';
import 'links_event.dart';

class AddLinks extends StatefulWidget {
  const AddLinks({super.key});

  @override
  State<AddLinks> createState() => _AddLinksState();
}

class _AddLinksState extends State<AddLinks> {
  final linkNameController = TextEditingController();
  final linkController = TextEditingController();
  final linkDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 180,
                  color: Colors.green.shade200,
                ),
              ),
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 155,
                  color: Colors.green,
                ),
              ),
              AppBar(
                title: Text(AppLocalizations.of(context).translate('add_link')),
              ),
            ],
          ),
          const SizedBox(height: 100),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    AddingLinks(
                      icon: Icons.drive_file_rename_outline,
                      label: AppLocalizations.of(context).translate('name'),
                      textFieldController: linkNameController,
                      keyboard: TextInputType.text,
                    ),
                    const SizedBox(height: 10),
                    AddingLinks(
                      icon: Icons.link,
                      label: AppLocalizations.of(context).translate('link'),
                      textFieldController: linkController,
                      keyboard: TextInputType.text,
                    ),
                    const SizedBox(height: 10),
                    AddingLinks(
                      icon: Icons.description_outlined,
                      label: AppLocalizations.of(context).translate('description'),
                      textFieldController: linkDescriptionController,
                      keyboard: TextInputType.multiline,
                    ),
                    const SizedBox(height: 20),

                    // Save button
                    ElevatedButton(
                      onPressed: () {
                        if (linkNameController.text.isNotEmpty &&
                            linkController.text.isNotEmpty) {
                          final newVisitCard = LinkMap(
                              linkName: linkNameController.text,
                              link: linkController.text,
                              description: linkDescriptionController.text,
                              type: 'my choice',
                              createdAt: DateTime.now().toString());

                          context
                              .read<FavoriteLinksBloc>()
                              .add(AddLinksEvent(newVisitCard));

                          linkNameController.clear();
                          linkController.clear();
                          linkDescriptionController.clear();

                          Navigator.pop(context);
                        } else {
                          // Show an error message if any field is empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(AppLocalizations.of(context).translate('all_required'))),
                          );
                        }
                      },
                      child: Text(AppLocalizations.of(context).translate('save')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddingLinks extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextInputType keyboard;
  final TextEditingController textFieldController;
  const AddingLinks(
      {super.key,
      required this.icon,
      required this.label,
      required this.textFieldController,
      required this.keyboard});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textFieldController,
      maxLines: null,
      cursorColor: Colors.green.shade800,
      style: TextStyle(color: green),
      decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: green,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: green,
            ),
            borderRadius: BorderRadius.circular(25),
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.red,
          ),
          border: const OutlineInputBorder(),
          label: Text(
            label,
            style: TextStyle(color: green),
          )),
      keyboardType: keyboard,
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    debugPrint(size.width.toString());
    var path = Path();
    path.lineTo(0, size.height);

    var firstStart = Offset(size.width / 5, size.height);
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);

    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10);

    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
