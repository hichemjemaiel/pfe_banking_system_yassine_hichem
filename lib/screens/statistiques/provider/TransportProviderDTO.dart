import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EpargneDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/EspecesDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/FamilleDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/ShoppingDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/SoinDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/model/TransportDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EpargneServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/EspecesServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/FamilleServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/ShoppingServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/SoinServiceDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/service/TransportServiceDTO.dart';

class TransportProviderDTO extends ChangeNotifier{
  List<TransportDTO> transports= [];
  TransportServiceDTO service =  TransportServiceDTO();


  Future<List<TransportDTO>> getAllTransports(int bankId)async{
    try{
       transports = await service.findAllTransport(bankId);
      notifyListeners();
      return transports ;
    }catch(e){
      print("Error in fetching transports  in Provider");
      return [];
    }
  }
}