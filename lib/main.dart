import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pfe_banking_system/FCMDebugScreen.dart';

import 'package:pfe_banking_system/chat/ChatScreen.dart';
import 'package:pfe_banking_system/chat/UserSelectionScreen.dart';
import 'package:pfe_banking_system/screens/AjoutCompte.dart';
import 'package:pfe_banking_system/screens/Auth.dart';
import 'package:pfe_banking_system/screens/CodeVerif.dart';
import 'package:pfe_banking_system/screens/CompteDetails.dart';
import 'package:pfe_banking_system/screens/ConfirmAccount.dart';
import 'package:pfe_banking_system/screens/Contacts/provider/ContactDtoProvider.dart';
import 'package:pfe_banking_system/screens/Contacts/provider/ContactProvider.dart';
import 'package:pfe_banking_system/screens/Contacts/screens/Cone.dart';
import 'package:pfe_banking_system/screens/Contacts/screens/Cthree.dart';
import 'package:pfe_banking_system/screens/Contacts/screens/Ctwo.dart';
import 'package:pfe_banking_system/screens/CreateAccount.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/network/DioClient.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/screens/CreationEntrepriseNine.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/network/EndPoints.dart';
import 'package:dio/dio.dart';

// Other imports remain the same...
import 'package:pfe_banking_system/screens/CreationEntreprise/provider/MoralPersonProvider.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/screens/CreatioEntrepriseeight.dart';
import 'package:pfe_banking_system/screens/CreationEntreprise/screens/CreationEntreprise.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/AgencyProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/ClientDtoProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/DepositAccountProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/LesDeuxAccountProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/PersonProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/provider/SavingAccountProvider.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/screens/CreationParticulier.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/screens/CreationParticulierSix.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/screens/CreationParticuliereight.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/screens/CreationParticuliernine.dart';
import 'package:pfe_banking_system/screens/Depot/provider/BankingOpProvider.dart';
import 'package:pfe_banking_system/screens/Depot/provider/CardDtoProvider.dart';
import 'package:pfe_banking_system/screens/Depot/provider/CardProvider.dart';
import 'package:pfe_banking_system/screens/Depot/provider/DepositOpProvider.dart';
import 'package:pfe_banking_system/screens/Depot/provider/OperateurProvider.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Done.dart';
import 'package:pfe_banking_system/screens/FAQ/Fone.dart';
import 'package:pfe_banking_system/screens/FcmApiService.dart';
import 'package:pfe_banking_system/screens/Firebase/FirebaseService.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/provider/DechargeCardDTOProvider.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/provider/RechargeCardDTOProvider.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/screens/McOne.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/screens/Mcfour.dart';
import 'package:pfe_banking_system/screens/OTP/provider/OtpProvider.dart';
import 'package:pfe_banking_system/screens/Pack.dart';
import 'package:pfe_banking_system/screens/PaiementD.dart';
import 'package:pfe_banking_system/screens/Placement/Plone.dart';
import 'package:pfe_banking_system/screens/Profile/Prone.dart';
import 'package:pfe_banking_system/screens/Profile/Prtwo.dart';
import 'package:pfe_banking_system/screens/QrScan.dart';
import 'package:pfe_banking_system/screens/Recharge%20de%20compte/Rone.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/provider/DechargeCardProvider.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/provider/RechargeCardProvider.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/screens/Rctone.dart';
import 'package:pfe_banking_system/screens/Reclamations/provider/ReclamationDtoProvider.dart';
import 'package:pfe_banking_system/screens/Reclamations/provider/ReclamationProvider.dart';
import 'package:pfe_banking_system/screens/Reclamations/screens/RcOne.dart';
import 'package:pfe_banking_system/screens/Reset%20password/provider/MailSenderProvider.dart';
import 'package:pfe_banking_system/screens/Reset%20password/screens/Psone.dart';
import 'package:pfe_banking_system/screens/Reset%20password/screens/Psthree.dart';
import 'package:pfe_banking_system/screens/Reset%20password/screens/Pstwo.dart';
import 'package:pfe_banking_system/screens/Retrait/provider/WithdrawlOpProvider.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/Reone.dart';
import 'package:pfe_banking_system/screens/TransactionAcat.dart';
import 'package:pfe_banking_system/screens/TransactionsCertif.dart';
import 'package:pfe_banking_system/screens/Virement/screens/permanent/Ptwo.dart';
import 'package:pfe_banking_system/screens/authentication/proivder/AuthProvider.dart';
import 'package:pfe_banking_system/screens/authentication/screens/Login.dart';
import 'package:pfe_banking_system/screens/chatbot/provider/ChatProvider.dart';
import 'package:pfe_banking_system/screens/chatbot/screens/ChatScreenAi.dart';
import 'package:pfe_banking_system/screens/configuration/CnOne.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/provider/RendezDtoProvider.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/provider/RendezVousProvider.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/EpargneProvider.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/EpargneProviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/EspecesProvider.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/EspecesProviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/ExpenseProvider.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/FamilleProvider.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/FamilleproviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/MaxBudgetProvider.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/ShoppingProvider.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/ShoppingProviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/SoinProviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/Soinprovider.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/TransportProvider.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/TransportProviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/Statistiques.dart';
import 'package:pfe_banking_system/screens/Transfert%20rapide/Tone.dart';
import 'package:pfe_banking_system/screens/Virement/provider/TransferOpProvider.dart';
import 'package:pfe_banking_system/screens/Virement/screens/ChoixVirement.dart';
import 'package:pfe_banking_system/screens/Virement/screens/virement%20ver%20mes%20comptes/Mone.dart';
import 'package:pfe_banking_system/screens/Virement/screens/virement%20vers%20autre%20compte/AOne.dart';
import 'package:pfe_banking_system/screens/historique/provider/BankOpDTOProvider.dart';
import 'package:pfe_banking_system/screens/historique/screens/Hone.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/screens/RnOne.dart';
import 'package:provider/provider.dart';
import 'FCMService.dart';
import 'chat/FirebaseConfig.dart';
import 'screens/MainScreen.dart';

// Global key for navigator
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// Background message handler (must be top-level function)
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('=== Background Message Handler ===');
  print('Message ID: ${message.messageId}');
  print('From: ${message.from}');
  print('Data: ${message.data}');
  print('Notification Title: ${message.notification?.title}');
  print('Notification Body: ${message.notification?.body}');
  print('================================');

  // Initialize Firebase for background handler if needed
  await Firebase.initializeApp();

  // You can process the notification data here if needed
  // For banking operations, you might want to update local database
  // or trigger some background sync

  // Note: You cannot show notifications here directly,
  // as this handler is for data processing only
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Firebase first
    await Firebase.initializeApp();
    print("✅ Firebase connected successfully");

    // Initialize your custom Firebase config
    await FirebaseConfig.initialize();
    print("✅ FirebaseConfig initialized");

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    print("✅ FCM background handler set");

  } catch (e) {
    print("❌ Firebase initialization failed: $e");
  }
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => PersonProvider()),
      ChangeNotifierProvider(create: (_) => DepositAccountProvider()),
      ChangeNotifierProvider(create: (_) => SavingAccountProvider()),
      ChangeNotifierProvider(create: (_) => LesDeuxAccountProvider()),
      ChangeNotifierProvider(create: (_) => BankingProvider()),
      ChangeNotifierProvider(create: (_) => AgencyProvider()),
      ChangeNotifierProvider(create: (_) => MoralPersonProvider()),
      ChangeNotifierProvider(create: (_) => BankingAccountDTOProvider()),
      ChangeNotifierProvider(create: (_) => DepositOpProvider()),
      ChangeNotifierProvider(create: (_) => BankingOpProvider()),
      ChangeNotifierProvider(create: (_) => CardDtoProvider()),
      ChangeNotifierProvider(create: (_) => OperateurProvider()),
      ChangeNotifierProvider(create: (_) => WithdrawlOpProvider()),
      ChangeNotifierProvider(create: (_) => TransferOpProvider()),
      ChangeNotifierProvider(create: (_) => BankOpDTOProvider()),
      ChangeNotifierProvider(create: (_) => ClientDTOProvider()),
      ChangeNotifierProvider(create: (_) => ExpenseProvider()),
      ChangeNotifierProvider(create: (_) => ShoppingProvider()),
      ChangeNotifierProvider(create: (_) => MaxBudgetProvider()),

      ChangeNotifierProvider(create: (_) => RendezVousProvider()),
      ChangeNotifierProvider(create: (_) => RendezDtoProvider()),
      ChangeNotifierProvider(create: (_) => ReclamationProvider()),
      ChangeNotifierProvider(create: (_) => ReclamationDtoProvider()),
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => OtpProvider()),
      ChangeNotifierProvider(create: (_) => MailSenderProvider()),
      ChangeNotifierProvider(create: (_) => ContactProvider()),
      ChangeNotifierProvider(create: (_) => ContactDtoProvider()),
      ChangeNotifierProvider(create: (_) => CardProvider()),
      ChangeNotifierProvider(create: (_) => RechargerCardProvider()),
      ChangeNotifierProvider(create: (_) => DechargeCardProvider()),

      ChangeNotifierProvider(create: (_) => EpargneProvider()),
      ChangeNotifierProvider(create: (_) => TransportProvider()),
      ChangeNotifierProvider(create: (_) => SoinProvider()),
      ChangeNotifierProvider(create: (_) => EspecesProvider ()),
      ChangeNotifierProvider(create: (_) => FamilleProvider ()),
      ChangeNotifierProvider(create: (_) => EpargneProviderDTO()),
      ChangeNotifierProvider(create: (_) =>  EspecesProviderDTO()),
      ChangeNotifierProvider(create: (_) => FamilleProviderDTO()),
      ChangeNotifierProvider(create: (_) => ShoppingProviderDTO()),
      ChangeNotifierProvider(create: (_) => SoinProviderDTO()),
      ChangeNotifierProvider(create: (_) => TransportProviderDTO()),
      ChangeNotifierProvider(create: (_) => ChatProvider()),
      ChangeNotifierProvider(create: (_) => RechargeCardDTOProvider()),
      ChangeNotifierProvider(create: (_) => DechargeCardDTOProvider()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // Initialize FCM after the first frame to ensure MaterialApp is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFCM();
    });
  }

  Future<void> _initializeFCM() async {
    try {
      await FCMService.initialize(navigatorKey: navigatorKey);
      print("✅ FCM Service initialized successfully");
    } catch (e) {
      print("❌ FCM Service initialization failed: $e");
    }
  }
  void checkFCMToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("Current FCM Token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: MainScreen(email: "hichem.jemaiel02@gmail.com"),
    );
  }
}