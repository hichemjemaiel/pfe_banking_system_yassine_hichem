import 'package:flutter/foundation.dart';
import 'package:pfe_banking_system/screens/Retrait/model/WithdrawlOp.dart';
import 'package:pfe_banking_system/screens/Retrait/service/WithdrawlOpService.dart';

class WithdrawlOpProvider extends ChangeNotifier{
     WithdrawlOpService service = WithdrawlOpService();
     WithdrawlOpModel? withdrawlOp;
     int? montant;
     String? date;
     String? status;
     String? creditnum;
     String? namecreditnum;

    void setMontant({required int montant}){
      this.montant = montant;
      notifyListeners();
}
   void setDate({
       required String date
}){
      this.date = date;
      notifyListeners();
   }

   void setStatus(){
      this.status = "PENDING";
      notifyListeners();
   }

   void setCreditNum({
       required String creditnum
}){
      this.creditnum = creditnum;
      notifyListeners();
   }

   void setNameCreditNum({required String namecreditnum}){
      this.namecreditnum = namecreditnum;
      notifyListeners();
   }

   Future<void> saveWithdrawlOp()async{
      if(montant != null && date != null && status !=null){
        WithdrawlOpModel withdrawl =WithdrawlOpModel(
        montant: montant!,
        date: date!,
        status: status!,
        creditnum: creditnum!,
            namecreditnum: namecreditnum!
        );
        try{
          final result = await service.addWithdrawlOp(withdrawl);
          if(result != null){
            withdrawlOp = result;
            print("WithrawlOp created with Id : ${result.id}");
          }
          notifyListeners();
     }catch(e){
          print("Error in creating Withdrawl op Provider");
        }
     }
   }

   Future<void> addOperateurToWithdarwlOp(String WithId , String OpId)async{
     int WId = int.parse(WithId);
     int OId = int.parse(OpId);
     try{
       final result = await service.addWithdarwlOptOperateur(WId, OId);
       if(result){
         print("Successfull linking");
         print("Withdrawl Op ${WId} linkined to Operateur ${OpId}");
       }
     }catch(e){
       print("Error in linking in provier ${e}");
     }
   }

   Future<void> addWithdarwlOpToBankingAccount(String WithId , String BankId)async{
      int WId = int.parse(WithId);
      int BId = int.parse(BankId);
      try{
        final result = await service.addWithdrawlOpToBankingAccount(WId, BId);
        if(result){
          print("Successful linking");
          print("Withdrawl Op ${WId} linked to BankingAccount ${BId}");
        }
      }catch(e){
        print("Error in linking in provider ${e}");
      }
   }
}