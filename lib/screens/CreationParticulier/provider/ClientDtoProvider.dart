import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModelDTO.dart';
import 'package:pfe_banking_system/screens/CreationParticulier/service/ClientDTOService.dart';

class ClientDTOProvider extends ChangeNotifier{
  List<ClientModelDTO> clients = [];
  ClientModelDTO? client ;
  ClientDTOService service = ClientDTOService();

  Future<List<ClientModelDTO>> getAllClients()async{
    try{
       print("Fetching all Clients dto : ");
       clients = await service.getAllClients();
       notifyListeners();
       return clients;
    }catch(e){
      print("Error in Client Dto provider ${e}");
      return [];
    }
  }

  Future<ClientModelDTO?> getClient(int Id)async{
    try{
      print("fetching client : ");
      client = await service.getClient(Id);
      notifyListeners();
      return client;
    }catch(e){
      print("Error in Client dto provider");
      return null;
    }
  }


  Future<ClientModelDTO?> getClientByEmail(String email)async{
    try{
      client = await service.getClientByEmail(email);
      notifyListeners();
      return client;
    }catch(e){
      print("Error in fetching client in Provider ${e}");
    }
  }

}