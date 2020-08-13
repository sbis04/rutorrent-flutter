import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rutorrentflutter/api/api_conf.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:rutorrentflutter/screens/configurations_screen.dart';
import 'package:rutorrentflutter/screens/home_screen.dart';
import 'package:rutorrentflutter/services/preferences.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool isLoading = true;
  bool isUserLoggedIn = false;

  _checkSavedAccounts() async {
    List<Api> apis = await Preferences.fetchSavedLogin();
    if (apis.isEmpty) {
      isUserLoggedIn = false;
    } else {
      Api api = Provider.of<Api>(context, listen: false);
      api.setUrl(apis[0].url);
      api.setUsername(apis[0].username);
      api.setPassword(apis[0].password);
      isUserLoggedIn = true;
    }
    setState(() {
      isLoading = false;
      print('Done');
    });
  }

  @override
  void initState() {
    super.initState();
    _checkSavedAccounts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: SplashScreen.navigate(
              height: 240,
              name: 'assets/animation/diamond.flr',
              next: (_) =>
                  isUserLoggedIn ? HomeScreen() : ConfigurationsScreen(),
              isLoading: isLoading,
              loopAnimation: 'tofro',
              startAnimation: 'tofro',
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 32),
            child: Image(
              height: 40,
              image: AssetImage('assets/logo/name_logo.png'),
            ),
          )
        ],
      ),
    );
  }
}