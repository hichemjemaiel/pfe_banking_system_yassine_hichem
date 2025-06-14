import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCRYJPu3JvCr5PJqPCmla2-rst5TcqaSmg",
          appId: "1:335898239301:android:71880bbbc125c93a759e2c",
          messagingSenderId: "335898239301",
          projectId: "pfebanksystem",
          storageBucket: "pfebanksystem.firebasestorage.app"
      ),
    );
  }
}