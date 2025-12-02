import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:trip_match/baseScaffold.dart';
import 'IAM/presentation/bloc/authBloc.dart';
import 'IAM/presentation/pages/authView.dart';
import 'UI/HomePanel.dart';
import 'UI/terms.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        initialRoute: "/auth",
        routes: {
          "/auth": (context) => const AuthView(),
          "/terms": (context) => const TermsView(),
          "/home": (context) => BaseScaffold(
              body: HomePanel(),
              currentIndex: 0
          ),
        },
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('es', 'ES'),
        ],
        theme: ThemeData(
          primaryColor: const Color(0xFF2EBFAF),
          fontFamily: 'Poppins',
        ),
      )
    );
  }
}

