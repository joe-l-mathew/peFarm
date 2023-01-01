import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'bloc/agri/agri_bloc.dart';
import 'bloc/agri_screen/agri_screen_bloc.dart';
import 'bloc/auth/auth_bloc.dart';
import 'bloc/expense/expense_bloc.dart';
import 'bloc/harvest/harvest_bloc.dart';
import 'bloc/income/income_bloc.dart';
import 'observer.dart';
import 'presentation/auth/phone_number_auth_screen.dart';
import 'presentation/home/home_screen.dart';
import 'presentation/loading/error_screen.dart';
import 'presentation/loading/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
        BlocProvider<IncomeBloc>(
            create: (BuildContext context) => IncomeBloc()),
        BlocProvider<ExpenseBloc>(
            create: (BuildContext context) => ExpenseBloc()),
        BlocProvider<AgriBloc>(create: (BuildContext context) => AgriBloc()),
        BlocProvider<HarvestBloc>(
            create: (BuildContext context) => HarvestBloc()),
        BlocProvider<AgriScreenBloc>(
          create: (BuildContext context) => AgriScreenBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        // title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: GoogleFonts.urbanistTextTheme(Theme.of(context).textTheme),
        ),
        home: LoadingPage(),
      ),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      // initialData: initialData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return const HomeScreen();
          }
          if (snapshot.hasError) {
            return const ErrorScreen();
          }
          return PhoneNumberAuthScreen();
        }
        return const SplashScreen();
      },
    );
  }
}
