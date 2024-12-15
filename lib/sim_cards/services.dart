import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linkestan/main_page/app_localozation.dart';
import 'package:linkestan/sim_cards/services_information.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import '../my_constants.dart';

class Services extends StatefulWidget {
  final Color servicesColor;
  final String servicesName;

  const Services(
      {required this.servicesColor, required this.servicesName, super.key});

  @override
  State<Services> createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  final numberController = TextEditingController();
  final amountController = TextEditingController();
  String? message;
  String? number;
  late List<Widget> serviceActions = [
    alertLoan(),
    alertBalance(
        choice: 'check_balance_description',
        function: () => dialUSSD(checkBalance[widget.servicesName] ?? '')),
    alertTransfer(),
    alertApn(contents: apn[widget.servicesName] ?? ''),
    alertBalance(
        choice: 'call_company_description',
        function: () => dialUSSD(customersCare[widget.servicesName] ?? '')),
    alertBalance(
        choice: 'fourGActivate_description',
        function: () {
          if (widget.servicesName == 'awcc') {
            dialUSSD(fourGActivate[widget.servicesName]!['']!);
            return;
          } else if (widget.servicesName == 'mtn') {
            return;
          }
          sendMessage(fourGActivate[widget.servicesName]!.keys.first,
              fourGActivate[widget.servicesName]!.values.first);
          return;
        }),
  ];
  List<ServicesModel> servicesList = [
    ServicesModel(servicesImage: 'loan', serviceName: 'getting loan'),
    ServicesModel(servicesImage: 'balance', serviceName: 'balance'),
    ServicesModel(servicesImage: 'money-transaction', serviceName: 'balance transfer'),
    ServicesModel(servicesImage: 'wireless-access-point', serviceName: 'apn'),
    ServicesModel(servicesImage: 'customer-service', serviceName: 'custom care'),
    ServicesModel(servicesImage: 'location', serviceName: '4g_activate'),
  ];

  Widget transferTextField({required TextEditingController controller, required String hint, required int maxLength}) {
    return TextField(
      controller: controller,
      maxLength: maxLength,
      keyboardType: TextInputType.number,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        label: Text(hint),
        labelStyle: const TextStyle(color: Colors.black,),
        counterStyle: const TextStyle(color: Colors.black),
        border:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.black),
        ),
        enabledBorder:  OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        focusedBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.black)),
      ),
    );
  }

  Future<void> dialUSSD(String number) async {
    final Uri ussdUri = Uri(scheme: 'tel', path: number);

    if (await canLaunchUrl(ussdUri)) {
      await launchUrl(ussdUri);
    } else {
      throw 'Could not launch $ussdUri';
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

  Widget alertTransfer() {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.white,
      title: Text(
        AppLocalizations.of(context).translate('transfer_balance'),
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 25,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          transferTextField(
            controller: numberController,
            hint: AppLocalizations.of(context).translate('number'),
            maxLength: 10,
          ),
          const SizedBox(
            height: 5,
          ),
          transferTextField(
            controller: amountController,
            hint: AppLocalizations.of(context).translate('amount'),
            maxLength: 3,
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
      actions: [
        ElevatedButton.icon(
          onPressed: () {
            if (numberController.text.isEmpty &&
                amountController.text.isEmpty) {
              DelightToastBar(
                builder: (BuildContext context) {
                  return ToastCard(
                      color: Colors.red,
                      title: Text(
                        AppLocalizations.of(context).translate('all_required'),
                        style: TextStyle(color: Colors.white),
                      ));
                },
                position: DelightSnackbarPosition.top,
                autoDismiss: true,
              ).show(
                context,
              );
              return;
            }
            dialUSSD(widget.servicesName == 'mtn'
                ? '${balanceTransfer[widget.servicesName]}${amountController.text}*${numberController.text}#'
                : '${balanceTransfer[widget.servicesName]}${numberController.text}*${amountController.text}#');
            numberController.clear();
            amountController.clear();
            Navigator.pop(context);
          },
          label: Text(AppLocalizations.of(context).translate('send')),
          icon: const Icon(Icons.send),
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.servicesColor,
          ),
        ),
      ],
    );
  }

  Widget alertLoan() {
    final all = loan[widget.servicesName];
    return widget.servicesName == 'salaam' || widget.servicesName == 'roshan'
        ? AlertDialog(
            title: Text(
              AppLocalizations.of(context).translate('warning'),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.green.shade800,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            content: Text(
              AppLocalizations.of(context).translate('get_loan_description'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.green.shade800,
                fontSize: 16,
              ),
            ),
            backgroundColor: Colors.green.shade50,
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: const CircleBorder(),
                ),
                child: const Icon(Icons.close),
              ),
              ElevatedButton(
                onPressed: () {
                  dialUSSD(all![0].values.toString());
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                ),
                child: const Icon(
                  Icons.check,
                ),
              ),
            ],
          )
        : AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              AppLocalizations.of(context)
                  .translate('getting_loan')
                  .toUpperCase(),
              textAlign: TextAlign.center,
            ),
            titleTextStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 25),
            content: SizedBox(
              width: double.maxFinite,
              height: 300, // Adjust height to fit the list
              child: ListView.builder(
                itemCount: all?.length,
                itemBuilder: (context, index) {
                  final map = all?[index];
                  late String loanAmount;
                  late String loanCode;
                  map?.forEach((key, value) {
                    loanAmount = key;
                    loanCode = value;
                  });
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Card(
                      color: Colors.white,
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide(color: widget.servicesColor),
                      ),
                      child: ListTile(
                        title: Text(
                          "${all![index].keys}  ${AppLocalizations.of(context).translate('afghani')}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          sendMessage(loanAmount, loanCode);
                          Navigator.of(context).pop(); // Return selected item
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          );
  }

  Widget alertApn({required var contents}) {
    return AlertDialog(
      backgroundColor: Colors.green.shade50,
      alignment: Alignment.centerLeft,
      actionsAlignment: MainAxisAlignment.center,
      content: Text(
        '''
      Name: ${contents['Name']}
      APN: ${contents['APN']}
      MCC: ${contents['MCC']}
      MCN: ${contents['MCN']}
      ''',
        // textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      actions: [
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.check)),
      ],
    );
  }

  Widget alertBalance({required Function function, required String choice}) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      backgroundColor: Colors.green.shade50,
      title: Text(
        AppLocalizations.of(context).translate('warning'),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.green.shade800,
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ),
      content: Text(
        AppLocalizations.of(context).translate(choice),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.green.shade800,
          fontSize: 16,
        ),
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background container
          Positioned.fill(
            bottom: 570,
            child: Container(
              color: widget.servicesColor,
              height: 200,
              child: Center(
                child: Text(
                  AppLocalizations.of(context).translate(widget.servicesName),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
          ),
          AppBar(
            backgroundColor: Colors.transparent,
          ),
          Positioned(
            top: 150,
            left: 20,
            right: 20,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: GridView.builder(
                itemCount: 6,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => serviceActions[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: widget.servicesColor, width: 2),
                          shape: BoxShape.circle),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        // mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/images/services_image/${servicesList[index].servicesImage}.png',
                            cacheHeight: 60,
                            cacheWidth: 60,
                          ),
                          Text(
                            AppLocalizations.of(context)
                                .translate(servicesList[index].serviceName),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ServicesModel {
  String servicesImage;
  String serviceName;
  ServicesModel({required this.servicesImage, required this.serviceName});
}
