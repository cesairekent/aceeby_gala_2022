import 'package:aceeby_gala_2022/core/app_colors.dart';
import 'package:aceeby_gala_2022/view_models/base_view_model.dart';
import 'package:aceeby_gala_2022/view_models/guest_view_model.dart';
import 'package:aceeby_gala_2022/view_models/home_view_model.dart';
import 'package:aceeby_gala_2022/view_models/table_view_model.dart';
import 'package:aceeby_gala_2022/views/home_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
    cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
  );

  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BaseVM()),
        ChangeNotifierProvider(create: (_) => HomeVM()),
        ChangeNotifierProvider(create: (_) => GuestVM()),
        ChangeNotifierProvider(create: (_) => TableVM()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
  }) : super(key: key);

  static Map<int, Color> color = {
    50: HexColor(AppColors.primary).withOpacity(.1),
    100: HexColor(AppColors.primary).withOpacity(.2),
    200: HexColor(AppColors.primary).withOpacity(.3),
    300: HexColor(AppColors.primary).withOpacity(.4),
    400: HexColor(AppColors.primary).withOpacity(.5),
    500: HexColor(AppColors.primary).withOpacity(.6),
    600: HexColor(AppColors.primary).withOpacity(.7),
    700: HexColor(AppColors.primary).withOpacity(.8),
    800: HexColor(AppColors.primary).withOpacity(.9),
    900: HexColor(AppColors.primary).withOpacity(1),
  };
  final MaterialColor primeColor =
      MaterialColor(HexColor(AppColors.primary).value, color);
  final MaterialColor accentColor =
      MaterialColor(HexColor(AppColors.secondary).value, color);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: const [
        // AppLocalizations.delegate,
        // CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        FormBuilderLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fr'), // French, no country code
        Locale('en'), // English, no country code
      ],
      // locale: provider.locale,
      localeResolutionCallback: (locale, supportedLocales) {
        return locale;
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: primeColor,
      ),
      home: const HomeView(),
    );
  }
}
