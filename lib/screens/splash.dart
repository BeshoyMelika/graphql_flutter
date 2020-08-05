import 'package:graphql_flutter_demo/components/utils.dart';
import 'package:graphql_flutter_demo/config/client.dart';
import 'package:graphql_flutter_demo/services/auth.dart';

import '../services/shared_preferences_service.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  const Splash({
    Key key,
  }) : super(key: key);

  initMethod(context) async {
    await sharedPreferenceService.getSharedPreferencesInstance();
    String _token = await sharedPreferenceService.token;
    if (_token == null || _token == "") {
      // Navigator.of(context).pushReplacementNamed('/login');
      _token = await hasuraAuth.login(
        "beshoygamal310@gmail.com",
        "123!@#qwe",
      );
      if (_token != null) {
        UtilFs.showToast("Login Successful", context);
        await sharedPreferenceService.setToken(_token);
        Config.initailizeClient(_token);
        Navigator.pushReplacementNamed(context, "/dashboard");
      } else
        UtilFs.showToast("Login Failed", context);
    } else
      Navigator.of(context).pushReplacementNamed('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => initMethod(context));

    return Scaffold(
      body: Center(
        child: new CircularProgressIndicator(),
      ),
    );
  }
}
