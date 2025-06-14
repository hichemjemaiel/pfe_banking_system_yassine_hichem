import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/AddShopping.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/Especes.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/Famille.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/Soin.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/Transport.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/addEpargne.dart';
import 'package:provider/provider.dart';
import 'package:pfe_banking_system/screens/historique/provider/BankOpDTOProvider.dart';
// Add these imports for category providers
import 'package:pfe_banking_system/screens/statistiques/provider/ShoppingProviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/EpargneProviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/TransportProviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/SoinProviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/EspecesProviderDTO.dart';
import 'package:pfe_banking_system/screens/statistiques/provider/FamilleProviderDTO.dart';
import '../../Bar.dart';
import '../../Chart.dart';
import '../../CreationParticulier/model/BankingAccountDTOModel.dart';
import '../../CreationParticulier/provider/BankingAccountDTOProvider.dart';
import '../../GBudget.dart';
import 'Epargne.dart';
import 'Shopping.dart';

class Statistiques extends StatefulWidget {
  int? id;
  Statistiques({Key? key, this.id}) : super(key: key);

  @override
  State<Statistiques> createState() => _StatistiquesState();
}

class _StatistiquesState extends State<Statistiques> {
  int ind1 = -1;
  int _selectedMonthIndex = DateTime.now().month;
  bool _isLoading = false;
  double _totalExpenses = 250000;

  late int _selectedAccountId;
  String _selectedAccountRIB = "06008592476554399978";

  String _selectedTransactionType = 'deposit';
  final List<Map<String, dynamic>> _transactionTypes = [
    {'value': 'deposit', 'label': 'Dépôts', 'icon': Icons.arrow_downward, 'color': Color(0xFF4A9E1F)},
    {'value': 'withdrawl', 'label': 'Retraits', 'icon': Icons.arrow_upward, 'color': Color(0xFFE57373)},
    {'value': 'transfer', 'label': 'Transferts', 'icon': Icons.swap_horiz, 'color': Color(0xFF42A5F5)},
  ];

  final List<String> months = [
    'Janvier', 'Février', 'Mars', 'Avril', 'Mai', 'Juin',
    'Juillet', 'Août', 'Septembre', 'Octobre', 'Novembre', 'Décembre'
  ];

  // Category budget limits from database
  final Map<String, double> _categoryBudgets = {
    'shopping': 11000,
    'epargne': 7000,
    'transport': 9000,
    'soin': 8000,
    'especes': 9000,
    'famille': 8500,
  };

  @override
  void initState() {
    super.initState();
    _selectedAccountId = widget.id!;
    _fetchMonthData(_selectedMonthIndex);
    _loadCategoryData();
  }

  // Load data for all categories
  void _loadCategoryData() {
    if (!mounted) return;

    Provider.of<ShoppingProviderDTO>(context, listen: false).getAllShoppings(widget.id!);
    Provider.of<EpargneProviderDTO>(context, listen: false).getAllEpargens(widget.id!);
    Provider.of<TransportProviderDTO>(context, listen: false).getAllTransports(widget.id!);
    Provider.of<SoinProviderDTO>(context, listen: false).getAllSoins(widget.id!);
    Provider.of<EspecesProviderDTO>(context, listen: false).getAllEpargens(widget.id!);
    // Add FamilleProviderDTO if available
    // Provider.of<FamilleProviderDTO>(context, listen: false).getAllFamille(widget.id!);
  }

  // Calculate total amount for a category
  double _calculateCategoryTotal(String category) {
    double total = 0;

    switch (category) {
      case 'shopping':
        final shoppings = Provider.of<ShoppingProviderDTO>(context, listen: false).shoppings;
        total = shoppings.fold(0, (sum, item) => sum + item.amount);
        break;
      case 'epargne':
        final epargnes = Provider.of<EpargneProviderDTO>(context, listen: false).epargnes;
        total = epargnes.fold(0, (sum, item) => sum + item.amount);
        break;
      case 'transport':
        final transports = Provider.of<TransportProviderDTO>(context, listen: false).transports;
        total = transports.fold(0, (sum, item) => sum + item.amount);
        break;
      case 'soin':
        final soins = Provider.of<SoinProviderDTO>(context, listen: false).soins;
        total = soins.fold(0, (sum, item) => sum + item.amount);
        break;
      case 'especes':
        final especes = Provider.of<EspecesProviderDTO>(context, listen: false).especes;
        total = especes.fold(0, (sum, item) => sum + item.amount);
        break;
      case 'famille':
      // Add famille calculation if provider is available
        total = 100000; // Placeholder
        break;
    }

    return total;
  }

  // Calculate progress value (0.0 to 1.0)
  double _calculateProgress(String category) {
    double total = _calculateCategoryTotal(category);
    double budget = _categoryBudgets[category] ?? 100000;
    double progress = total / budget;
    return progress > 1.0 ? 1.0 : progress; // Cap at 100%
  }

  // Get progress color based on percentage
  Color _getProgressColor(double progress) {
    if (progress < 0.5) return Colors.green;
    if (progress < 0.8) return Colors.orange;
    return Colors.red;
  }

  // Format amount for display
  String _formatAmount(double amount) {
    return "${amount.toInt()} XAF";
  }

  Future<void> _fetchMonthData(int monthIndex) async {
    if (!mounted) return;

    setState(() {
      _isLoading = true;
    });

    try {
      final provider = Provider.of<BankOpDTOProvider>(context, listen: false);

      final monthTransactions = await provider.getAllTransactionsForBankAccountByMonth(
        _selectedAccountId,
        _selectedTransactionType,
        monthIndex.toString(),
      );

      Provider.of<BankOpDTOProvider>(context, listen: false).getAmountForBankAccountByMonth(
          _selectedAccountId,
          _selectedTransactionType,
          monthIndex.toString()
      );

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

  // Create category card widget
  Widget _buildCategoryCard({
    required String title,
    required String category,
    required Color iconColor,
    required String iconPath,
    required VoidCallback onTap,
  }) {
    double amount = _calculateCategoryTotal(category);
    double progress = _calculateProgress(category);
    Color progressColor = _getProgressColor(progress);

    return InkWell(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 198,
        decoration: BoxDecoration(
          color: Color(0xFFCCCCCC),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Container(
              height: 100,
              width: 70,
              decoration: BoxDecoration(
                color: iconColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Image.asset(iconPath, scale: 1.5),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 5, top: 5),
                      child: Column(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            _formatAmount(amount),
                            style: TextStyle(fontSize: 15),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Container(
                              width: 80,
                              height: 5,
                              child: ClipRRect(
                                child: LinearProgressIndicator(
                                  minHeight: 6,
                                  value: progress,
                                  backgroundColor: Colors.grey.shade300,
                                  valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.arrow_forward_ios),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Rest of your existing methods (showDialogstat, showTransactionTypeFilter, etc.)
  void showDialogstat(BuildContext context) {
    List<BankingAccountDTOModel> bankingAccounts = Provider.of<BankingAccountDTOProvider>(context, listen: false).accounts;
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 200, top: 40),
                child: Text(
                  "Mes comptes",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, right: 20),
                child: Text(
                  "Cliquez pour choisir le compte à afficher",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 400,
                child: ListView.builder(
                  itemCount: bankingAccounts.length,
                  itemBuilder: (BuildContext context, int index) {
                    final account = bankingAccounts[index];
                    bool isSelected = account.id == _selectedAccountId;

                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            ind1 = index;
                            _selectedAccountId = account.id!;
                            _selectedAccountRIB = account.RIB;
                            _isLoading = true;
                          });
                          _fetchMonthData(_selectedMonthIndex);
                          _loadCategoryData(); // Reload category data for new account
                        },
                        child: Container(
                          width: 400,
                          height: 70,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? Color(0xFF4A9E1F).withOpacity(0.3)
                                : Colors.grey[300],
                            borderRadius: BorderRadius.circular(20),
                            border: isSelected
                                ? Border.all(color: Color(0xFF4A9E1F), width: 2)
                                : null,
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    "${account.type} | ${account.RIB}",
                                    style: TextStyle(
                                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      color: isSelected ? Color(0xFF4A9E1F) : Colors.black,
                                    ),
                                  ),
                                ),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF4A9E1F),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        );
      },
    );
  }

  void showTransactionTypeFilter(BuildContext context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          return Container(
            height: 400,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 50,
                  height: 5,
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10),
                  child: Text(
                    "Type de transaction",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20),
                  child: Text(
                    "Sélectionnez le type de transaction à afficher",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _transactionTypes.length,
                    itemBuilder: (context, index) {
                      final transactionType = _transactionTypes[index];
                      final isSelected = transactionType['value'] == _selectedTransactionType;

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              _selectedTransactionType = transactionType['value'];
                              _isLoading = true;
                            });
                            _fetchMonthData(_selectedMonthIndex);
                          },
                          child: Container(
                            height: 70,
                            decoration: BoxDecoration(
                              color: isSelected ? transactionType['color'].withOpacity(0.1) : Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: isSelected ? transactionType['color'] : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(10),
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: transactionType['color'],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(
                                    transactionType['icon'],
                                    color: Colors.white,
                                    size: 24,
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        transactionType['label'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: isSelected ? transactionType['color'] : Colors.black,
                                        ),
                                      ),
                                      Text(
                                        _getTransactionDescription(transactionType['value']),
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (isSelected)
                                  Container(
                                    margin: EdgeInsets.only(right: 15),
                                    child: Icon(
                                      Icons.check_circle,
                                      color: transactionType['color'],
                                      size: 24,
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
              ],
            ),
          );
        }
    );
  }

  String _getTransactionDescription(String type) {
    switch (type) {
      case 'deposit':
        return 'Argent reçu sur le compte';
      case 'withdrawl':
        return 'Argent retiré du compte';
      case 'transfer':
        return 'Transferts entrants et sortants';
      default:
        return '';
    }
  }

  Map<String, dynamic> get _currentTransactionType {
    return _transactionTypes.firstWhere(
          (type) => type['value'] == _selectedTransactionType,
      orElse: () => _transactionTypes[0],
    );
  }

  Widget _buildMonthContainer(String monthName, int monthIndex) {
    bool isSelected = monthIndex == _selectedMonthIndex;

    return Container(
      margin: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedMonthIndex = monthIndex;
            _isLoading = true;
          });
          _fetchMonthData(monthIndex);
        },
        child: Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF4A9E1F) : Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              monthName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }

  int myIndex = 0;
  @override
  Widget build(BuildContext context) {
    int? amount = Provider.of<BankOpDTOProvider>(context).amount;
    return Scaffold(
      bottomNavigationBar: Bar(
          myIndex: myIndex,
          onTap: (index){
            setState(() {
              myIndex = index;
            });
          }),
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        title: Text("Statistiques"),
        centerTitle: true,
        backgroundColor: Color(0xFFF2F2F2),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: () {
                showTransactionTypeFilter(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _currentTransactionType['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _currentTransactionType['color'],
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _currentTransactionType['icon'],
                      color: _currentTransactionType['color'],
                      size: 16,
                    ),
                    SizedBox(width: 4),
                    Text(
                      _currentTransactionType['label'],
                      style: TextStyle(
                        color: _currentTransactionType['color'],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: InkWell(
              onTap: () {
                showDialogstat(context);
              },
              child: Icon(Icons.filter_list_alt),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Container(
            height: MediaQuery.of(context).size.height + 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFF2F6FC),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // Month selector
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.only(right: 250, top: 20),
                    child: Row(
                      children: List.generate(
                        months.length,
                            (index) => _buildMonthContainer(months[index], index + 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 100, left: 10),
                      child: Text(
                        "Total ${_currentTransactionType['label'].toLowerCase()}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Statistiques()));
                      },
                      child: Text(
                        "Voir plus",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator()
                    : Padding(
                  padding: EdgeInsets.only(right: 180),
                  child: Text(
                    "${amount ?? 0} XAF",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: _currentTransactionType['color'],
                    ),
                  ),
                ),
                // Daily chart for selected month with curved lines
                Padding(
                  padding: EdgeInsets.all(20),
                  child: DailyTransactionChart(
                    bankId: _selectedAccountId,
                    rib: _selectedAccountRIB,
                    selectedMonth: _selectedMonthIndex,
                    transactionType: _selectedTransactionType,
                    onTotalCalculated: (total) {
                      setState(() {
                        _totalExpenses = total > 0 ? total : 250000;
                      });
                    },
                  ),
                ),
                SizedBox(height: 20),
                // Budget management button

                SizedBox(height: 20),
                // Categorize transactions button

                Padding(
                  padding: EdgeInsets.only(right: 100, top: 40),
                  child: Text(
                    "Dépenses par catégoriser",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 20),
                Column(
                  children: [
                    Row(
                      children: [
                        _buildCategoryCard(
                          title: "Shopping",
                          category: "shopping",
                          iconColor: Color(0xFF0089FC),
                          iconPath: "assets/shop.png",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Shopping(id: widget.id!)));
                          },
                        ),
                        SizedBox(width: 10),
                        _buildCategoryCard(
                          title: "Epargne",
                          category: "epargne",
                          iconColor: Colors.orange,
                          iconPath: "assets/house.png",
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Epargne(id: widget.id!)));
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCategoryCard(
                            title: "Transport",
                            category: "transport",
                            iconColor: Colors.purpleAccent,
                            iconPath: "assets/car.png",
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Transport(id: widget.id!)));
                            },
                          ),
                          _buildCategoryCard(
                            title: "Soin",
                            category: "soin",
                            iconColor: Colors.red,
                            iconPath: "assets/plus.png",
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Soin(id: widget.id!)));
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildCategoryCard(
                            title: "Especes",
                            category: "especes",
                            iconColor: Colors.green[600]!,
                            iconPath: "assets/expense.png",
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Especes(id: widget.id!)));
                            },
                          ),
                          _buildCategoryCard(
                            title: "Famille",
                            category: "famille",
                            iconColor: Colors.brown,
                            iconPath: "assets/group.png",
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => Famille(id: widget.id!)));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}