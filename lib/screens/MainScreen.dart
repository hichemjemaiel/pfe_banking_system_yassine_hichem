  import 'package:flutter/material.dart';
  import 'package:pfe_banking_system/screens/Bar.dart';
  import 'package:pfe_banking_system/screens/Chart.dart';
  import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountDTOModel.dart';
  import 'package:pfe_banking_system/screens/CreationParticulier/model/BankingAccountModel.dart';
  import 'package:pfe_banking_system/screens/CreationParticulier/model/ClientModelDTO.dart';
  import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountDTOProvider.dart';
  import 'package:pfe_banking_system/screens/CreationParticulier/provider/BankingAccountProvider.dart';
  import 'package:pfe_banking_system/screens/CreationParticulier/provider/ClientDtoProvider.dart';
  import 'package:pfe_banking_system/screens/Depot/screens/Done.dart';
  import 'package:pfe_banking_system/screens/Profile/Prone.dart';
  import 'package:pfe_banking_system/screens/Profile/Prtwo.dart';
  import 'package:pfe_banking_system/screens/Retrait/screens/Reone.dart';
  import 'package:pfe_banking_system/screens/Virement/screens/ChoixVirement.dart';
  import 'package:pfe_banking_system/screens/authentication/model/User.dart';
  import 'package:pfe_banking_system/screens/statistiques/screens/Statistiques.dart';
  import 'package:pfe_banking_system/screens/TransactionAcat.dart';
  import 'package:pfe_banking_system/screens/historique/provider/BankOpDTOProvider.dart';
  import 'package:provider/provider.dart';
  import 'AnimatedDrawer.dart';
  import 'MesComptes.dart';
  import 'Notifications.dart';


  class MainScreen extends StatefulWidget {
    String email;

     MainScreen({super.key, required this.email});

    @override
    State<MainScreen> createState() => _MainScreenState();
  }

  class _MainScreenState extends State<MainScreen> {

    int myIndex =0;
    int ind=0;
    bool clicked = false;
    ClientModelDTO? client;
    int? id ;
    // Add chart-related variables
    int _selectedAccountId = 73; // Default account ID
    String _selectedAccountRIB = "06008592476554399978"; // Default RIB
    int _selectedMonthIndex = DateTime.now().month; // Current month
    double _totalExpenses = 250000; // Default value
    bool _isLoading = false;

    Widget _buildCleanMenuItem({
      required IconData icon,
      required String title,
      required VoidCallback onTap,
      required bool hasArrow,
    }) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 22,
                  color: Colors.black87,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ),
                if (hasArrow)
                  Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: Colors.grey.shade600,
                  ),
              ],
            ),
          ),
        ),
      );
    }
    Future<void> loadClient()async{
      try{
        final fetchedClient = await Provider.of<ClientDTOProvider>(context,listen: false).getClientByEmail(widget.email);
        if(fetchedClient != null){
          setState(() {
            client = fetchedClient;
            id = fetchedClient.id;
          });
          if(id != null){
            Provider.of<BankingAccountDTOProvider>(context,listen: false).getAllBankingAccountForClient(id!);
          }
        }
      }catch(e){
        print("Error fetching Client");
      }
    }

    @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      if (client == null) {
        loadClient();
      }
    }
    @override
    void initState() {
      loadClient();
      _fetchMonthData(_selectedMonthIndex);


      super.initState();
    }

    // Add method to fetch month data for chart
    Future<void> _fetchMonthData(int monthIndex) async {
      if (!mounted) return;

      setState(() {
        _isLoading = true;
      });

      try {
        final provider = Provider.of<BankOpDTOProvider>(context, listen: false);

        // Get transactions for the selected month
        final monthTransactions = await provider.getAllTransactionsForBankAccountByMonth(
          _selectedAccountId,
          'deposit',
          monthIndex.toString(),
        );

        Provider.of<BankOpDTOProvider>(context,listen: false).getAmountForBankAccountByMonth(73, "deposit", monthIndex.toString());

        // Calculate total expenses for the month
        double total = 0;
        for (var transaction in monthTransactions) {
          total += transaction.montant;
        }

        if (mounted) {
          setState(() {
            _totalExpenses = total > 0 ? total : 250000;
            _isLoading = false;
          });
        }
      } catch (e) {
        print('Error fetching month data: $e');
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }

    @override
    Widget build(BuildContext context) {
      List<BankingAccountDTOModel> accountsList = Provider.of<BankingAccountDTOProvider>(context).accounts;
      int? amount = Provider.of<BankOpDTOProvider>(context).amount;
      return Scaffold(
        bottomNavigationBar: Bar(
          id: id,
            email: widget.email,
            myIndex: myIndex,
            onTap: (index){
              setState(() {
                myIndex = index;
              });
            }),
        backgroundColor: Color(0xFFF2F2F2),
        drawer:AnimatedDrawer(email : widget.email,id : id),
        appBar: AppBar(
          backgroundColor: Color(0xFFF2F2F2),
          actions: [
            Row(
              children: [
                InkWell(
                  onTap: () async{
                    if (id != null){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MesComptes(id : id!,email : widget.email)));
                    }

                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.qr_code, size: 35),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Notifications()));
                  },
                  child: Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: Icon(Icons.notifications, size: 35),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(right: 20),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Prtwo(email: widget.email)));
                      },
                      child: Icon(Icons.person_pin, size: 35),
                    )
                ),
              ],
            ),


          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Text(
                    "${client?.lastName}",
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    "${client?.firstName}",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 270,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: accountsList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 30, top: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${accountsList[index].type}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              "N° ${accountsList[index].RIB}",
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 40),
                            Padding(
                              padding: EdgeInsets.only(right: 20),
                              child: Text(
                                clicked ? "${accountsList[index].balance}" : "************",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4A9E1F),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 90),
                              child: Text(
                                "XAF",
                                style: TextStyle(
                                  fontSize: 25,
                                  color: Color(0xFF4A9E1F),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 180, top: 5),
                              child: InkWell(
                                onTap: (){
                                  setState(() {
                                    clicked == true ? clicked = false : clicked = true;
                                  });
                                },
                                child: clicked == false ? Icon(Icons.remove_red_eye) : Icon(Icons.remove_red_eye_outlined),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            Expanded(child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height+200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(right: 200,top: 20),
                      child: Text("Vos raccourcis",style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold
                      ),),),
                    Padding(padding: EdgeInsets.all(16),child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        SizedBox(width: 5,),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Choixvirement(id:  id!,)));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 90,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFF4A9E1F),

                                ),
                                child: FractionallySizedBox(
                                  widthFactor: 0.5,
                                  heightFactor: 0.5,
                                  child: Image.asset("assets/arrow.png", fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text("Transférer",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                        SizedBox(width: 5,),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Done()));
                          },
                          child:  Column(
                            children: [
                              Container(
                                height: 90,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFF4A9E1F),

                                ),
                                child: FractionallySizedBox(
                                  widthFactor: 0.5,
                                  heightFactor: 0.5,
                                  child: Image.asset("assets/down.png", fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text("Déposer",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)
                            ],
                          ),
                        ),
                        SizedBox(width: 5,),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Reone()));
                          },
                          child: Column(
                            children: [
                              Container(
                                height: 90,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Color(0xFF4A9E1F),

                                ),
                                child: FractionallySizedBox(
                                  widthFactor: 0.5,
                                  heightFactor: 0.5,
                                  child: Image.asset("assets/up.png", fit: BoxFit.contain),
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text("Retirer",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),

                            ],
                          ),
                        )

                      ],
                    ),),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(padding: EdgeInsets.all(20),child: Row(

                        children: [
                          Container(
                            height: 130,
                            width: 430,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child:  FractionallySizedBox(
                              widthFactor: 1,
                              heightFactor: 0.8,
                              child:Padding(padding: EdgeInsets.only(left: 20,top: 10),child: Row(

                                children: [
                                  Image.asset("assets/sta.png"),

                                  Column(
                                    children: [
                                      Padding(padding: EdgeInsets.only(right: 80,left: 20),child: Text("New update",style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),),),
                                      Padding(padding: EdgeInsets.only(left: 15),child:  Text("A new update is available.\nClick here to update"),)
                                    ],
                                  )


                                ],
                              ),),
                            ),

                          ),
                          SizedBox(width: 20,),
                          Container(
                            height: 130,
                            width: 430,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child:  FractionallySizedBox(
                              widthFactor: 1,
                              heightFactor: 0.8,
                              child:Padding(padding: EdgeInsets.only(left: 20,top:10),child: Row(

                                children: [
                                  Image.asset("assets/sta.png"),

                                  Column(
                                    children: [
                                      Padding(padding: EdgeInsets.only(right: 170),child: Text("Bienvenue",style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),),),
                                      Padding(padding: EdgeInsets.only(left: 15),child:  Text("Bienvenue dans l'ère de l'inclusion\nfinancière, un ére ou vous avez accès aux \nservices financiers 100% digitale ."),)
                                    ],
                                  )


                                ],
                              ),),
                            ),

                          ),
                          SizedBox(width: 20,),
                          Container(
                            height: 130,
                            width: 430,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child:  FractionallySizedBox(
                              widthFactor: 1,
                              heightFactor: 0.8,
                              child:Padding(padding: EdgeInsets.only(left: 20,top: 10),child: Row(

                                children: [
                                  Image.asset("assets/sta.png"),

                                  Column(
                                    children: [
                                      Padding(padding: EdgeInsets.only(left:10),child: Text("Une nouvelle Agence proche de vous.",style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),),),
                                      Padding(padding: EdgeInsets.only(right: 5 ),child:  Text("Nous vous informons qu'il y a une nouvelle\nagence est ouvert à Port Gentille pour vous \noffrir une meilleure expérience financière."),)
                                    ],
                                  )


                                ],
                              ),),
                            ),

                          ),
                          SizedBox(width: 20,),
                          Container(
                            height: 130,
                            width: 430,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child:  FractionallySizedBox(
                              widthFactor: 1,
                              heightFactor: 0.8,
                              child:Padding(padding: EdgeInsets.only(left: 20,top: 10),child: Row(

                                children: [
                                  Image.asset("assets/sta.png"),

                                  Column(
                                    children: [
                                      Padding(padding: EdgeInsets.only(left: 20,top: 10),child: Text("Retrait Mobile indisponible",style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),),),
                                      Padding(padding: EdgeInsets.only(left: 15),child:  Text("Les retraits mobile money sont \nindisponible pour le moment"),)
                                    ],
                                  )


                                ],
                              ),),
                            ),

                          ),
                          SizedBox(width: 20,),
                          Container(
                            height: 130,
                            width: 430,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child:  FractionallySizedBox(
                              widthFactor: 1,
                              heightFactor: 0.8,
                              child:Padding(padding: EdgeInsets.only(left: 20,top: 10),child: Row(

                                children: [
                                  Image.asset("assets/sta.png"),

                                  Column(
                                    children: [
                                      Padding(padding: EdgeInsets.only(left: 20,top: 10,right: 110),child: Text("Scannez et payez",style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold
                                      ),),),
                                      Padding(padding: EdgeInsets.only(left: 25),child:  Text("Réglez tous vos achats en toute \nsimplicité chez les commercants avec \nle Qr code."),)
                                    ],
                                  )


                                ],
                              ),),
                            ),

                          ),

                        ],
                      ),),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 550, // Reduced height to make chart smaller
                      width: 400,
                      decoration: BoxDecoration(
                          color: Color(0xFFF2F6FC),
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 20,),
                          Row(
                            children: [
                              Padding(padding: EdgeInsets.only(right: 140,left: 10),child: Text("Total dépenses",style: TextStyle(
                                  fontSize: 20
                              ),),),
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => Statistiques(id:  id,)));
                                },
                                child: Text("Voir plus",style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25,
                                ),),
                              )
                            ],
                          ),
                          SizedBox(height: 20,),
                          _isLoading
                              ? CircularProgressIndicator()
                              : Padding(
                            padding: EdgeInsets.only(right: 180),
                            child: Text(
                              "${amount ?? _totalExpenses.toInt()} XAF",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                          // Smaller chart container
                          Container(
                            height: 250, // Reduced height for smaller chart
                            width: 350,  // Reduced width for smaller chart
                            padding: EdgeInsets.all(10),
                            child: DailyTransactionChart(
                              bankId: _selectedAccountId,
                              rib: _selectedAccountRIB,
                              selectedMonth: _selectedMonthIndex,
                              transactionType: 'withdrawl',
                              onTotalCalculated: (total) {
                                setState(() {
                                  _totalExpenses = total > 0 ? total : 250000;
                                });
                              },
                            ),
                          ),
                          SizedBox(height: 20,),


                        ],
                      ),
                    ),
                  ],
                ),
              ),),)
          ],
        ),
      );
    }
  }