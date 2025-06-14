// Updated EndPoints.dart with new contact endpoints
class EndPoints {
  // Existing endpoints (keeping all the original ones)
  static final String addPerson = "/person/add";
  static final String getAllAgencies = "/dto/agency/find";
  static final String addDepositAccount = "/type/deposit/add";
  static final String addSavingAccount = "/type/add";
  static final String addMoralPerson = "/moral/add";
  static final String addLesDeuxAccount = "/type/deux/add";
  static final String addBankingAccount = "/bank/add";
  static final String addBankingAccountToClient = "/bank/addCl";
  static final String getBankingAccount = "/find";
  static final String addBankingAccountToType = "/bank/add";
  static final String addBankingAccountToAgency = "/bank/addA";
  static final String getAllBankingAccountToClient = "/dto/bank/find";
  static final String updatePackforBankingAccount = "/bank/pack";
  static final String addDepositOp = "/op/deposit/add";
  static final String addBankingOperationToAgency = "/op/add/agency";
  static final String addDepositOptoBankingAccount = "/op/deposit/add/dop";
  static final String addBankingOperationToBankingAccount = "/op/add";
  static final String getAllCards = "/card/dto/find";
  static final String addCardToDepositOp = "/op/deposit/add/card";
  static final String getAllOperateurs = "/opr/dto/find";
  static final String addOperateurToDepositOp = "/op/deposit/add/op";
  static final String addWithdrawlOp = "/op/withdraw/add";
  static final String addOperateurToWithdrawlOp = "/op/withdraw/add";
  static final String addWithdrawlOpToBankingAccount = "/op/withdraw/add/wop";
  static final String addTransferOp = "/op/transfer/add";
  static final String getAllBankingOpsforBankAccount = "/dto/op/find";
  static final String getAllBankingOpsforBankAccountByType = "/dto/op/find/type";
  static final String getAllBankingOpsforBankAccountByRIB = "/dto/op/find/rib";
  static final String getAllReceivedTransferForBankingAccount = "/dto/op/find/transfer";
  static final String getAllClientDtos = "/client/dto/find";
  static final String getClientAssignedToBankAccount = "/dto/bank/find/client";
  static final String getAllTransactionsForBankAccountByMonth = "/dto/op/find/date";
  static final String getAllAmountsForBankAccountByMonth = "/dto/op/find/amount";
  static final String addExpenseToBankingAccount = "/expense/add";
  static final String addShopping = "/shop/add";
  static final String addMaxBudget = "/max/add";
  static final String updateMaxBudget = "/max/update";
  static final String getMaxBudgetByType = "/max/find";
  static final String sendTokenToBackend = "/users/save-token";
  static final String sendMessage = "/notify/send";
  static final String getAllMessages = "/notify/messages/sender";
  static final String getAllMessagesforAreceiverClient = "/notify/messages/receiver";
  static final String getAllConversation = "/notify/messages/conversation";
  static final String addRendezVous = "/rdz/add";
  static final String addRendezVousToClient = "/rdz/client";
  static final String addRendezVousToAgency = "/rdz/agency";
  static final String findAllRendezVousForClient = "/rdz/dto/find";
  static final String addReclamation = "/rec/add";
  static final String addReclamationToClient = "/rec/client";
  static final String findAllReclamtionForClient = "/dto/rec/find";
  static final String register = "/v1/auth/register";
  static final String authenticate = "/v1/auth/authenticate";
  static final String sendSms = "/v1/sms/send";
  static final String generaOtpCode = "/v1/sms/send/otp";
  static final String sendMail = "/v1/mail/send";
  static final String resetPassword = "/v1/auth/reset";

  // Contact related endpoints
  static final String addContact = "/contact/add";
  static final String addContactToClient = "/contact/add";
  static final String getAllContactForClient = "/contact/dto/find";

  // NEW: Contact CRUD endpoints
  static final String deleteContact = "/contact/delete";
  static final String updateContact = "/contact/update";
  static final String getContactById = "/contact/find";

  // Card related endpoints
  static final String addCard = "/card/add";
  static final String addCardToClient = "/card/add/client";
  static final String addRechargeCard = "/recharge/add";
  static final String addRechargeToCard = "/recharge/add/card";
  static final String addDechargeCard = "/decharge/add";
  static final String addDechargeCardToCard = "/decharge/add/card";

  // Budget categories
  static final String addEpargne = "/epargne/add";
  static final String addTransport = "/transport/add";
  static final String addSoin = "/soin/add";
  static final String addEspeces = "/especes/add";
  static final String addFamille = "/famille/add";
  static final String findAllEpargneForBankingAccount = "/epargne/dto/find";
  static final String findAllEspecesForBankingAccount = "/especes/dto/find";
  static final String findAllFamilleForBankingAccount = "/famille/dto/find";
  static final String findAllShoppingForBankingAccount = "/shopping/dto/find";
  static final String findAllSoinForBankingAccount = "/soin/dto/find";
  static final String findAllTransportForBankingAccount = "/transport/dto/find";

  // Validation endpoints
  static final String verifyEmailExistence = "/person/validate/email";
  static final String verifyPhoneExitence = "/person/validate/phone";
  static final String verifyMoralEmailExistence = "/moral/validate/email";
  static final String verifyMoralPhoneExistence = "/moral/validate/phone";
  static final String setPassword = "/v1/auth/set-password";
  static final String userExistence = "/v1/mail/find";
  static final String findUser = "/v1/auth/find";
  static final String findClientDtoByEmail = "/client/dto/find/email";
  static final String chatbot = "/ai/chat";
  static final String addTransferOpToBankingAccount = "/op/transfer/add/top";
  static final String findAllDechargeDTo = "/card/decharge/dto/find";
  static final String setCardStatus = "/card/status";

  // FCM related endpoints
  static final String updateFCMToken = "/client/fcm-token";
  static final String removeFCMToken = "/client/fcm-token";
  static final String getClientProfile = "/client/profile";
  static final String getAllCardsDtoForClientActive = "/card/dto/find/active";

  // Test endpoints for FCM
  static final String testSendNotification = "/test/send-notification";
  static final String testSendToClient = "/test/send-to-client";
  static final String testGetClients = "/test/clients";
  static final String testGetClientInfo = "/test/client";
  static final String testSetFCMToken = "/test/set-fcm-token";
  static final String testCreateTransfer = "/test/create-transfer";
  static final String testCreateDeposit = "/test/create-deposit";
  static final String testCreateWithdrawal = "/test/create-withdrawal";
  static final String testGetAccounts = "/test/accounts";
  static final String testGetOperations = "/test/operations";
  static final String setFcmToken = "/test/set-fcm-token";

  // Additional endpoints
  static final String deleteCard = "/card/delete";
  static final String getCardById = "/card/find";
  static final String updatePersonByEmail = "/person/update/em";
  static final String getAllRechargesForCard = "/card/recharge/dto/find";
}