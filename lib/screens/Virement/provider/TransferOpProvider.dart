import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Virement/model/TransferModel.dart';
import 'package:pfe_banking_system/screens/Virement/service/TransferOpService.dart';

class TransferOpProvider extends ChangeNotifier{
  TransferOpService service = TransferOpService();
  TransferModel? transferModel;
  int? montant;
  String? date;
  String? status;
  String? senderRIB;
  String? receiverRIB;
  String? namecreditnum;

  void setMontant({required int montant}){
    this.montant = montant;
    notifyListeners();
  }

  void setDate({required String date}){
    this.date = date;
    notifyListeners();
  }

  void setStatus(){
    this.status = "PENDING";
    notifyListeners();
  }

  void setSenderRIB({required String senderRIB}){
    this.senderRIB = senderRIB;
    notifyListeners();
  }

  void setReceiverRIB({required String receiverRIB}){
    this.receiverRIB = receiverRIB;
    notifyListeners();
  }

  void setNameCreditNum({required String namecreditnum}){
    this.namecreditnum = namecreditnum;
    notifyListeners();
  }

  Future<void> saveTransferOp() async {
    if(montant != null && date != null && status != null && senderRIB != null && receiverRIB != null){
      TransferModel transferOp = TransferModel(
          montant: montant!,
          date: date!,
          status: status!,
          senderRIB: senderRIB!,
          receiverRIB: receiverRIB!,
          namecreditnum: namecreditnum!
      );

      try{
        final result = await service.addTransferOp(transferOp);
        if(result != null) {
          transferModel = result;
          print("Transfer Op created with Id: ${result.id}");
          print("Transfer Op details: ${result.toJson()}");
        } else {
          print("Error: Service returned null result");
        }
        notifyListeners();
      } catch(e) {
        print("Error creating Transfer Op in Provider: $e");
        transferModel = null;
        notifyListeners();
      }
    } else {
      print("Error: Missing required fields for transfer operation");
      print("montant: $montant, date: $date, status: $status");
      print("senderRIB: $senderRIB, receiverRIB: $receiverRIB");
    }
  }

  Future<void> addTransferOpToBankingAccount(String TId, String BId) async {
    try{
      int TransferId = int.parse(TId);
      int BankId = int.parse(BId);
      print("Passing TransferOp $TransferId to BankingAccount $BankId");
      final result = await service.addTransferOpToBankingAccount(TransferId, BankId);
      if(result){
        print("TransferOp $TransferId linked successfully to Banking Account $BId");
      } else {
        print("Failed to link TransferOp to Banking Account");
      }
      notifyListeners();
    } catch(e){
      print("Error in linking TransferOp to BankingAccount in Provider: $e");
    }
  }
}