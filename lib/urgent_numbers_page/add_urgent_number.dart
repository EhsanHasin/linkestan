import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkestan/databaseHelper/urgent_numbers_m.dart';
import 'package:linkestan/main_page/app_localozation.dart';
import 'package:linkestan/urgent_numbers_page/urgent_bloc.dart';
import 'package:linkestan/urgent_numbers_page/urgent_event.dart';
import '../my_constants.dart';

class AddUrgentNumber extends StatefulWidget {
  const AddUrgentNumber({super.key});

  @override
  State<AddUrgentNumber> createState() => _AddUrgentNumberState();
}

class _AddUrgentNumberState extends State<AddUrgentNumber> {
  final numberNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final descriptionController = TextEditingController();

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
                title: Text(
                    AppLocalizations.of(context).translate('add_urgent_number')
                ),
              ),
            ],
          ),
          const SizedBox(height: 60),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    AddingUrgentNumber(
                      icon: Icons.person,
                      label: AppLocalizations.of(context).translate('name'),
                      textFieldController: numberNameController,
                      keyboard: TextInputType.text,
                    ),
                    const SizedBox(height: 10),
                    AddingUrgentNumber(
                      icon: Icons.phone,
                      label: AppLocalizations.of(context).translate('phone_number'),
                      textFieldController: phoneNumberController,
                      keyboard: TextInputType.number,
                      maxLength: 10,
                    ),
                    const SizedBox(height: 10),
                    AddingUrgentNumber(
                      icon: Icons.description_outlined,
                      label: AppLocalizations.of(context).translate('description'),
                      textFieldController: descriptionController,
                      keyboard: TextInputType.multiline,
                    ),

                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (numberNameController.text.isNotEmpty &&
                            phoneNumberController.text.isNotEmpty) {
                          final newUrgentNumber = UrgentNumberMap(
                              numberName: numberNameController.text,
                              number: phoneNumberController.text,
                              description: descriptionController.text,
                              type: "my choice",
                              createdAt: DateTime.now().toString());

                          context
                              .read<FavoriteUrgentBloc>()
                              .add(AddUrgentEvent(newUrgentNumber));

                          numberNameController.clear();
                          phoneNumberController.clear();
                          descriptionController.clear();

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

class AddingUrgentNumber extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextInputType keyboard;
  final TextEditingController textFieldController;
  final int? maxLength;
  const AddingUrgentNumber(
      {super.key,
        required this.icon,
        required this.label,
        required this.textFieldController,
        required this.keyboard,
        this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textFieldController,
      maxLines: null,
      maxLength: maxLength,
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
