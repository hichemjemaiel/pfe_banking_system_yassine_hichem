import 'package:flutter/widgets.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/model/RendezDTO.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/service/RendezDTOService.dart';

class RendezDtoProvider extends ChangeNotifier{
  List<RendezDTO> rendezVous = [];
  RendezDtoService service = RendezDtoService();
  Future<List<RendezDTO>> getAllRendezVous(int Id)async{
    try{
      rendezVous = await service.getAllRendezVousForClient(Id);
      notifyListeners();
      return rendezVous;
    }catch(e){
      print("Error in fecthing rendez vous Provider ${e}");
      return [];
    }
  }
}