import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkestan/main_page/app_localozation.dart';
import 'package:linkestan/sim_cards/services.dart';
import 'package:linkestan/sim_cards/sim_cards_bloc.dart';
import 'package:linkestan/sim_cards/sim_cards_state.dart';
import 'bundles.dart';

var currentIndex = 0;
String networkName = '';
class SIMCards extends StatelessWidget {
  const SIMCards({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SIMCardsBloc(),
      child: BlocBuilder<SIMCardsBloc, SIMCardsState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<SIMCardsBloc>(context);
          final activePageIndex = state.activePageIndex;
          final isValidPageIndex = activePageIndex < state.services.length;
          networkName = state.pageTitles[activePageIndex].toLowerCase();

          return Scaffold(
            appBar: AppBar(
              title:  Text(AppLocalizations.of(context).translate('afghan sim cards')),
              backgroundColor: state.pageColors[activePageIndex],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  // PageView
                  SizedBox(
                    height: 150,
                    child: PageView.builder(
                      controller: PageController(initialPage: activePageIndex),
                      onPageChanged: (index) => bloc.add(ChangePageEvent(index)),
                      itemCount: state.pageTitles.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: state.pageColors[index],
                            borderRadius:  BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).translate(state.pageTitles[index]),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      state.pageTitles.length,
                          (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: activePageIndex == index ? 20 : 10,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: activePageIndex == index
                              ? state.pageColors[index]
                              : Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Services Header
                  Center(
                    child: Text(AppLocalizations.of(context).translate("services"),
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: state.pageColors[activePageIndex],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // GridView or Placeholder
                  Expanded(
                    child: isValidPageIndex &&
                        state.services[activePageIndex].isNotEmpty
                        ? GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: state.services[activePageIndex].length,
                      itemBuilder: (context, index) {
                        final service =
                        state.services[activePageIndex][index];
                        return InkWell(
                          onTap: () {
                            currentIndex = index;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => service['onPress'] ==
                                    'bundles'
                                    ? Bundles(
                                  appBarColor: state.pageColors[
                                  activePageIndex],
                                  bundleName: service['label'],
                                  companyName: state.pageTitles[activePageIndex].toLowerCase(),
                                )
                                    :  Services(
                                  servicesColor: state.pageColors[activePageIndex],
                                  servicesName: state.pageTitles[activePageIndex].toLowerCase(),),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color:
                                state.pageColors[activePageIndex],
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  service['icon'],
                                  size: 40,
                                  color: state.pageColors[activePageIndex],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  AppLocalizations.of(context).translate(service['label']),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: state.pageColors[activePageIndex],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : Center(
                      child: Text(
                        'No services available for this page.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
