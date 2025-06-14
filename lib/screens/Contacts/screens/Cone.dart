// Updated Cone.dart - Contact List Screen with Delete/Update handling
import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Contacts/model/ContactDtoModel.dart';
import 'package:pfe_banking_system/screens/Contacts/provider/ContactDtoProvider.dart';
import 'package:pfe_banking_system/screens/Contacts/screens/Cfour.dart';
import 'package:pfe_banking_system/screens/Contacts/screens/Ctwo.dart';
import 'package:provider/provider.dart';
import '../../Bar.dart';

class Cone extends StatefulWidget {
  int? id;
  Cone({super.key, this.id});

  @override
  State<Cone> createState() => _ConeState();
}

class _ConeState extends State<Cone> {
  int myIndex = 0;
  TextEditingController searchController = TextEditingController();
  String searchQuery = "";
  String? selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadContacts();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _loadContacts() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.id != null) {
        Provider.of<ContactDtoProvider>(context, listen: false)
            .getAllContactsForClient(widget.id!);
      }
    });
  }

  void _refreshContacts() {
    if (widget.id != null) {
      Provider.of<ContactDtoProvider>(context, listen: false)
          .refreshContacts(widget.id!);
    }
  }

  List<ContactDtoModel> _getFilteredContacts(List<ContactDtoModel> contacts) {
    if (searchQuery.isEmpty && selectedCategory == null) {
      return contacts;
    }

    return contacts.where((contact) {
      bool matchesSearch = searchQuery.isEmpty ||
          contact.nom.toLowerCase().contains(searchQuery.toLowerCase()) ||
          contact.type.toLowerCase().contains(searchQuery.toLowerCase());

      bool matchesCategory = selectedCategory == null ||
          contact.categorie == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Bar(
        myIndex: myIndex,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
      ),
      backgroundColor: Color(0xFFF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xFFF2F2F2),
        title: Text("Mes contacts"),
        centerTitle: true,
        elevation: 0,
        actions: [
          // Add contact button
          InkWell(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Ctwo(id: widget.id),
                ),
              );

              if (result == true) {
                _refreshContacts();
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.add_circle_outline_rounded,
                  color: Colors.green,
                  size: 25,
                ),
              ),
            ),
          ),
          // Refresh button
          InkWell(
            onTap: _refreshContacts,
            child: Padding(
              padding: EdgeInsets.only(right: 20),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.refresh,
                  color: Colors.blue,
                  size: 25,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ContactDtoProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Color(0xFF4A9E1F),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Chargement des contacts...",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            );
          }

          if (provider.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 60,
                    color: Colors.red,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Erreur",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    provider.errorMessage!,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _refreshContacts,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4A9E1F),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      "Réessayer",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }

          List<ContactDtoModel> contacts = provider.contacts ?? [];
          List<ContactDtoModel> filteredContacts = _getFilteredContacts(contacts);

          return SingleChildScrollView(
            child: Column(
              children: [
                // Search and Filter Section
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      // Search Bar
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: searchController,
                          onChanged: (value) {
                            setState(() {
                              searchQuery = value;
                            });
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(
                              Icons.search,
                              color: Color(0xFF4A9E1F),
                            ),
                            suffixIcon: searchQuery.isNotEmpty
                                ? InkWell(
                              onTap: () {
                                searchController.clear();
                                setState(() {
                                  searchQuery = "";
                                });
                              },
                              child: Icon(
                                Icons.clear,
                                color: Colors.grey,
                              ),
                            )
                                : null,
                            hintText: "Rechercher un contact...",
                            hintStyle: TextStyle(color: Colors.grey[500]),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 15),

                      // Category Filter
                      if (contacts.isNotEmpty) ...[
                        Container(
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              _buildCategoryChip("Tous", null),
                              ...provider.getAvailableCategories()
                                  .map((category) => _buildCategoryChip(category, category))
                                  .toList(),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Statistics Section
                if (contacts.isNotEmpty) ...[
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem("Total", contacts.length.toString(), Icons.people),
                        _buildStatItem(
                          "Professionnel",
                          provider.getContactStatistics()['professional'].toString(),
                          Icons.business,
                        ),
                        _buildStatItem(
                          "Particulier",
                          provider.getContactStatistics()['personal'].toString(),
                          Icons.person,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                ],

                // Contacts List Container
                Container(
                  width: double.infinity,
                  constraints: BoxConstraints(
                    minHeight: 300,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 20,
                        offset: Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(top: 30, bottom: 20),
                    child: filteredContacts.isEmpty
                        ? _buildEmptyState()
                        : Column(
                      children: [
                        // Results header
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Contacts (${filteredContacts.length})",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (searchQuery.isNotEmpty || selectedCategory != null)
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      searchQuery = "";
                                      selectedCategory = null;
                                      searchController.clear();
                                    });
                                  },
                                  child: Text(
                                    "Effacer filtres",
                                    style: TextStyle(
                                      color: Color(0xFF4A9E1F),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),

                        // Contacts list
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: filteredContacts.length,
                          itemBuilder: (BuildContext context, int index) {
                            final contact = filteredContacts[index];
                            return _buildContactItem(contact);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip(String label, String? category) {
    bool isSelected = selectedCategory == category;

    return Container(
      margin: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            selectedCategory = category;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF4A9E1F) : Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: Color(0xFF4A9E1F),
          size: 24,
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildContactItem(ContactDtoModel contact) {
    String accountInfo = "";
    if (contact.bankingAccounts.isNotEmpty) {
      final account = contact.bankingAccounts[0];
      final ribSuffix = account.RIB.length > 15
          ? account.RIB.substring(15)
          : account.RIB;
      accountInfo = "${account.type} •••${ribSuffix}";
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Cfour(
                contact: contact,
                clientId: widget.id,
              ),
            ),
          );

          if (result == true) {
            _refreshContacts();
          }
        },
        child: Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              // Avatar
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF4A9E1F),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Center(
                  child: Text(
                    contact.nom.isNotEmpty
                        ? contact.nom[0].toUpperCase()
                        : "?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(width: 15),

              // Contact Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.nom,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: contact.type == "Professionnel"
                                ? Colors.blue.withOpacity(0.1)
                                : Colors.purple.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            contact.type,
                            style: TextStyle(
                              fontSize: 12,
                              color: contact.type == "Professionnel"
                                  ? Colors.blue
                                  : Colors.purple,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        if (contact.categorie != null) ...[
                          SizedBox(width: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.orange.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              contact.categorie!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.orange,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    if (accountInfo.isNotEmpty) ...[
                      SizedBox(height: 4),
                      Text(
                        accountInfo,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Action Icons
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.arrow_circle_up_outlined,
                    size: 28,
                    color: Colors.grey[400],
                  ),
                  SizedBox(width: 8),
                  Icon(
                    Icons.arrow_circle_down,
                    size: 28,
                    color: Color(0xFF4A9E1F),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              searchQuery.isNotEmpty || selectedCategory != null
                  ? Icons.search_off
                  : Icons.contacts,
              size: 60,
              color: Colors.grey[400],
            ),
            SizedBox(height: 20),
            Text(
              searchQuery.isNotEmpty || selectedCategory != null
                  ? "Aucun contact trouvé"
                  : "Aucun contact",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 10),
            Text(
              searchQuery.isNotEmpty || selectedCategory != null
                  ? "Essayez de modifier vos critères de recherche"
                  : "Commencez par ajouter votre premier contact",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[500],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            if (searchQuery.isEmpty && selectedCategory == null)
              ElevatedButton.icon(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Ctwo(id: widget.id),
                    ),
                  );

                  if (result == true) {
                    _refreshContacts();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4A9E1F),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                ),
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  "Ajouter un contact",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}