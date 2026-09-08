import 'package:flutter/material.dart';
import 'package:movies_app/modules/onBoarding/screens/onboarding4_screen.dart';
import 'package:movies_app/modules/onBoarding/screens/onboarding6_screen.dart';
// import 'package:provider/provider.dart';

// import '../../../core/app_provider/app_provider.dart';
import '../../../localization/app_localizations.dart';

class onBoarding5 extends StatelessWidget {
  const onBoarding5({super.key});

  @override
  Widget build(BuildContext context) {
    //var theme = Theme.of(context);
    //var provider = Provider.of<AppProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/onboarding5.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.red],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                decoration: const BoxDecoration(
                  color: Color(0xff121312),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.rateReviewAndLearn,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      AppLocalizations.of(
                        context,
                      )!.rateReviewAndLearnDescription,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const onBoarding6(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffffc107),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.next,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const onBoarding4(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff121312),
                          foregroundColor: Color(0xffF6BD00),

                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: const BorderSide(
                              color: Color(0xffF6BD00),
                              width: 2,
                            ),
                          ),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.back,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
