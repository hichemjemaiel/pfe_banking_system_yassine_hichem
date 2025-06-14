import 'package:flutter/widgets.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/model/RendezVousModel.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/service/RendezVousService.dart';

class RendezVousProvider extends ChangeNotifier{
  String? date;
  String? time ;
  String? objet;
  String? commentaire;
  String? status;
  RendezVousModel? rendezVous ;
  RendezVousService service = RendezVousService();

  void setDate({required String date}){
    this.date = date;
    notifyListeners();
  }

  void setTime({required String time}){
    this.time = time;
    notifyListeners();
  }

  void setObject({required String objet}){
    this.objet = objet;
    notifyListeners();
  }

  void setCommentaire({required String commentaire}){
    this.commentaire = commentaire;
    notifyListeners(); // Added missing notifyListeners()
  }

  void setStatus(){
    this.status = "En attente";
    notifyListeners();
  }

  Future<void> saveRendezVous()async{
    if(date != null && time != null && objet != null && commentaire != null){
      try{
        RendezVousModel rendezVousModel = RendezVousModel(
          date: date!,
          time: time!,
          objet: objet!,
          commentaire: commentaire!,
          status: "En attente", // Set status here directly
          client: null,
          agency: null,
        );

        final result = await service.addRendezVous(rendezVousModel);
        if(result != null){
          rendezVous = result;
          print("Rendez vous added successfully with ID: ${result.id}");
          notifyListeners();
        } else {
          print("Failed to create rendez-vous: result is null");
        }
      }catch(e){
        print("Error in creating Rendez Vous: ${e}");
      }
    } else {
      print("Missing required fields for rendez-vous creation");
    }
  }

  Future<void> addRendezVousToClient(String Id, String CId)async{
    try {
      int rendezId = int.parse(Id);
      int clientId = int.parse(CId);

      print("Passing RendezVous ${rendezId} to Client ${clientId}");
      final result = await service.addRendezVousToClient(rendezId, clientId);
      if(result){
        print("RendezVous ${rendezId} added to Client ${clientId} successfully");
      } else {
        print("Failed to add RendezVous to Client");
      }
    } catch(e){
      print("Error in adding rdz to client in provider: ${e}");
    }
  }

  Future<void> addAgencyToRendezVous(String Id, String AId)async{
    try {
      int rendezId = int.parse(Id);
      int agencyId = int.parse(AId);

      print("Passing RendezVous ${rendezId} to Agency ${agencyId}");
      final result = await service.addRendezVousToAgency(rendezId, agencyId);
      if(result){
        print("RendezVous ${rendezId} added to Agency ${agencyId} successfully");
      } else {
        print("Failed to add RendezVous to Agency");
      }
    } catch(e){
      print("Error in adding rdz to agency in provider: ${e}");
    }
  }
}