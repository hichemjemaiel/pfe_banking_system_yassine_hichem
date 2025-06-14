import 'package:flutter/widgets.dart';
import 'package:pfe_banking_system/screens/Reclamations/Model/ReclamationModel.dart';
import 'package:pfe_banking_system/screens/Reclamations/service/ReclamationService.dart';

class ReclamationProvider extends ChangeNotifier{
  ReclamationService service = ReclamationService();
  String? type;
  String? objet;
  String? description;
  String? date;
  String? time;
  String? status;
  ReclamationModel? reclamation;

  void setType({
    required String type
  }){
    this.type = type;
    notifyListeners();
  }

  void setObjet({
    required String objet
  }){
    this.objet = objet;
    notifyListeners();
  }

  void setDescription({required String description}){
    this.description = description;
    notifyListeners();
  }

  void setDate({required String date}){
    this.date = date;
    notifyListeners();
  }

  void setTime({required String time}){
    this.time = time;
    notifyListeners();
  }

  void setStatus(){
    this.status ="En cours";
    notifyListeners();
  }

  Future<void> saveReclamation()async{
    // Fixed the condition: time != null instead of time != status
    if(type != null && objet != null &&  description!=null && date != null && time != null && status != null){
      try{
        ReclamationModel reclamationModel = ReclamationModel(
            type: type!,
            objet: objet!,
            description: description!,
            date: date!,
            time: time!,
            status: status!,
            client: null
        );
        final result = await service.addReclamation(reclamationModel);
        if(result != null){
          reclamation = result;
          print("Reclamation added successfully ${result.id}");
        }
      }catch(e){
        print("Error in adding reclamtion in Provider ${e}");
      }
    } else {
      print("Cannot save reclamation: missing required fields");
      print("type: $type, objet: $objet, description: $description, date: $date, time: $time, status: $status");
    }
  }

  Future<void> addReclamationToClient(String? reclamationId, String? clientId) async {
    // Add null checks before parsing
    if (reclamationId == null || reclamationId.isEmpty || reclamationId == "null") {
      print("Error: ReclamationId is null or empty");
      return;
    }

    if (clientId == null || clientId.isEmpty || clientId == "null") {
      print("Error: ClientId is null or empty");
      return;
    }

    try {
      int reclamationIdInt = int.parse(reclamationId);
      int clientIdInt = int.parse(clientId);

      print("Passing Reclamation $reclamationIdInt to Client $clientIdInt");
      final result = await service.addReclamationToClient(reclamationIdInt, clientIdInt);
      if(result){
        print("Reclamation $reclamationIdInt passed successfully To $clientIdInt");
      }
    } catch(e) {
      print("Error parsing IDs or adding Reclamation to client: $e");
      print("ReclamationId: '$reclamationId', ClientId: '$clientId'");
    }
  }
}