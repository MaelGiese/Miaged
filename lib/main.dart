import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'common/theme.dart';
import 'models/panier.dart';
import 'models/acheter.dart';
import 'screens/panier.dart';
import 'screens/acheter.dart';
import 'screens/profil.dart';
import 'screens/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(

      providers: [
        Provider(create: (context) => AcheterModel()),
        ChangeNotifierProxyProvider<AcheterModel, PanierModel>(
          create: (context) => PanierModel(),
          update: (context, achat, panier) {
            panier.achat = achat;
            return panier;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Miaged',
        theme: appTheme,
        initialRoute: '/',
        routes: {
          '/': (context) => MyLogin(),
          '/acheter': (context) => Acheter(),
          '/panier': (context) => Panier(),
          '/profil': (context) => Profil(),
        },
      ),
    );
  }
}