import 'package:chatapp_fluttebase/helper/helper_function.dart';
import 'package:chatapp_fluttebase/pages/auth/login_page.dart';
import 'package:chatapp_fluttebase/pages/home_page.dart';
import 'package:chatapp_fluttebase/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
      options: FirebaseOptions(apiKey: Constants.apiKey, appId: Constants.appId,
        messagingSenderId: Constants.messagingSenderId, projectId: Constants
            .projectId,)
    );
  } else{

    await Firebase.initializeApp();
  }

runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserLoggedInStatus();
  }
  getUserLoggedInStatus()async{
    await HelperFunction.getUserLoggedInStatus().then((value) {
      if (value !=null){
        _isSignedIn = value;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:_isSignedIn? HomePage(): LoginPage(),
    );
  }
}
