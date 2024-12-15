import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkestan/main_page/app_localozation.dart';
import '../databaseHelper/favorite_bloc.dart';
import '../databaseHelper/favorite_event.dart';
import '../databaseHelper/visit_cards_m.dart'; // To access VisitCardMap
import '../my_constants.dart';

class AddVisitCard extends StatefulWidget {
  const AddVisitCard({super.key});

  @override
  State<AddVisitCard> createState() => _AddVisitCardState();
}

class _AddVisitCardState extends State<AddVisitCard> {
  final companyNameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final descriptionController = TextEditingController();

  File? _selectedImage; // To hold the selected image

  // Function to pick an image
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                    AppLocalizations.of(context).translate('add_visit_card')
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  children: [
                    AddingVisitCard(
                      icon: Icons.person,
                      label:  AppLocalizations.of(context).translate('name'),
                      textFieldController: companyNameController,
                      keyboard: TextInputType.text,
                      maxLength: null,
                    ),
                    const SizedBox(height: 10),
                    AddingVisitCard(
                      icon: Icons.directions,
                      label:  AppLocalizations.of(context).translate('address'),
                      textFieldController: addressController,
                      keyboard: TextInputType.text,
                      maxLength: null,
                    ),
                    const SizedBox(height: 10),
                    AddingVisitCard(
                      icon: Icons.phone_android,
                      label:  AppLocalizations.of(context).translate('phone_number'),
                      textFieldController: phoneNumberController,
                      keyboard: TextInputType.number,
                      maxLength: 10,
                    ),
                    const SizedBox(height: 10),
                    AddingVisitCard(
                      icon: Icons.description_outlined,
                      label:  AppLocalizations.of(context).translate('description'),
                      textFieldController: descriptionController,
                      keyboard: TextInputType.multiline,
                      maxLength: null,
                    ),
                    const SizedBox(height: 20),

                    // Button to pick image from gallery
                    ElevatedButton.icon(
                      icon: const Icon(Icons.image),
                      label: Text( AppLocalizations.of(context).translate('pick_image')),
                      onPressed: _pickImage,
                    ),

                    // Display the selected image
                    if (_selectedImage != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Image.file(
                          _selectedImage!,
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                      ),

                    // Save button
                    ElevatedButton(
                      onPressed: () {
                        if (companyNameController.text.isNotEmpty &&
                            addressController.text.isNotEmpty &&
                            phoneNumberController.text.isNotEmpty) {
                          final newVisitCard = VisitCardMap(
                            name: companyNameController.text,
                            address: addressController.text,
                            phoneNumber: phoneNumberController.text,
                            description: descriptionController.text,
                            imageUrl: _selectedImage?.path ?? 'assets/images/LinkestanLogo.png', // Save the image path
                            type: 'my choice', // Default or user-selected type
                            createdAt: DateTime.now().toString(),
                          );

                          // Dispatch the AddVisitCardEvent to add the new card
                          context.read<FavoriteVisitCardBloc>().add(AddVisitCardEvent(newVisitCard));

                          // Clear the inputs after saving
                          companyNameController.clear();
                          addressController.clear();
                          phoneNumberController.clear();
                          descriptionController.clear();
                          setState(() {
                            _selectedImage = null;
                          });

                          // Navigate back
                          Navigator.pop(context);
                        } else {
                          // Show an error message if any field is empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(AppLocalizations.of(context).translate('all_required'))),
                          );
                        }
                      },
                      child: Text( AppLocalizations.of(context).translate('save')),
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

class AddingVisitCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextInputType keyboard;
  final TextEditingController textFieldController;
  final int? maxLength;
  const AddingVisitCard(
      {super.key,
        required this.icon,
        required this.label,
        required this.textFieldController,
        required this.keyboard,
        required this.maxLength});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textFieldController,
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

