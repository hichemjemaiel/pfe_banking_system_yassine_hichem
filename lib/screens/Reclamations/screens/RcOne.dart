import 'package:flutter/material.dart';
import 'package:pfe_banking_system/screens/Reclamations/Model/ReclamationDTO.dart';
import 'package:pfe_banking_system/screens/Reclamations/provider/ReclamationDtoProvider.dart';
import 'package:pfe_banking_system/screens/Reclamations/screens/Rcthree.dart';
import 'package:pfe_banking_system/screens/Reclamations/screens/Rctwo.dart';
import 'package:provider/provider.dart';

import '../../Bar.dart';

class Rcone extends StatefulWidget {
  final int? id;

  const Rcone({super.key, this.id});

  @override
  State<Rcone> createState() => _RconeState();
}

class _RconeState extends State<Rcone> {
  int ind = 0;
  int myIndex = 0;

  @override
  void initState() {
    super.initState();
    print("Rcone initState - widget.id: ${widget.id}");
    int clientId = widget.id ?? 1;
    Provider.of<ReclamationDtoProvider>(context, listen: false)
        .getAllReclamtionForClient(clientId);
  }

  @override
  Widget build(BuildContext context) {
    List<ReclamationDTO> reclamations = Provider.of<ReclamationDtoProvider>(context).reclamations;

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
        title: Text("Réclamation"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              if (widget.id != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Rcthree(id: widget.id)),
                );
              } else {
                print("Warning: widget.id is null, using default client ID");
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Erreur: ID client manquant")),
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.only(right: 30),
              child: Icon(
                Icons.add_circle_outline_rounded,
                color: Colors.green,
                size: 30,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 0),
              child: Container(
                width: 400,
                height: 200,
                decoration: BoxDecoration(
                  color: Color(0xFF4A9E1F),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Réclamations\nen cours",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                "${RecEncours()}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Color(0xFF4A9E1F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Color(0xFF4A9E1F),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                "Réclamations\ncloturées",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 200,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Center(
                              child: Text(
                                "${RecColturee()}",
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height - 100,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
              ),
              child: ind == 1 ? Cloture(context) : Column(
                children: [
                  SizedBox(height: 20),
                  Container(
                    width: 300,
                    height: 70,
                    decoration: BoxDecoration(
                      color: Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              ind = 0;
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 70,
                            decoration: BoxDecoration(
                              color: ind == 0 ? Color(0xFF4A9E1F) : Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "En cours",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: ind == 0 ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              ind = 1;
                            });
                          },
                          child: Container(
                            width: 150,
                            height: 70,
                            decoration: BoxDecoration(
                              color: ind == 1 ? Color(0xFF4A9E1F) : Color(0xFFF2F2F2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Cloturé",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: ind == 1 ? Colors.white : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  SizedBox(
                    height: 600,
                    child: reclamations.isEmpty
                        ? Center(child: Text("Aucune réclamation en cours"))
                        : ListView.builder(
                      itemCount: reclamations.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (reclamations[index].status == "En cours") {
                          return Padding(
                            padding: EdgeInsets.all(20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Rctwo(
                                      type: reclamations[index].type,
                                      objet: reclamations[index].objet,
                                      description: reclamations[index].description,
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                width: 400,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Color(0xFFF2F2F2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(width: 20),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(top: 10, left: 10),
                                            child: Text(
                                              "${reclamations[index].type}",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              "${reclamations[index].date} à ${reclamations[index].time.split(":")[0]}:${reclamations[index].time.split(":")[1]}",
                                              style: TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right: 20),
                                      child: Icon(Icons.arrow_forward_ios),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Cloture(BuildContext context) {
    List<ReclamationDTO> reclamations = Provider.of<ReclamationDtoProvider>(context).reclamations;
    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          width: 300,
          height: 70,
          decoration: BoxDecoration(
            color: Color(0xFFF2F2F2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              InkWell(
                onTap: () {
                  setState(() {
                    ind = 0;
                  });
                },
                child: Container(
                  width: 150,
                  height: 70,
                  decoration: BoxDecoration(
                    color: ind == 0 ? Color(0xFF4A9E1F) : Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "En cours",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ind == 0 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    ind = 1;
                  });
                },
                child: Container(
                  width: 150,
                  height: 70,
                  decoration: BoxDecoration(
                    color: ind == 1 ? Color(0xFF4A9E1F) : Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Cloturé",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: ind == 1 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 40),
        SizedBox(
          height: 600,
          child: reclamations.isEmpty
              ? Center(child: Text("Aucune réclamation cloturée"))
              : ListView.builder(
            itemCount: reclamations.length,
            itemBuilder: (BuildContext context, int index) {
              if (reclamations[index].status != "En cours") {
                return Padding(
                  padding: EdgeInsets.all(20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Rctwo(
                            type: reclamations[index].type,
                            objet: reclamations[index].objet,
                            description: reclamations[index].description,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: 400,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Color(0xFFF2F2F2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 10, left: 10),
                                  child: Text(
                                    "${reclamations[index].type}",
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "${reclamations[index].date} à ${reclamations[index].time.split(":")[0]}:${reclamations[index].time.split(":")[1]}",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(right: 20),
                            child: Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else {
                return SizedBox.shrink();
              }
            },
          ),
        ),
      ],
    );
  }

  int RecEncours() {
    List<ReclamationDTO> reclamations = Provider.of<ReclamationDtoProvider>(context).reclamations;
    int num = 0;
    for (int i = 0; i < reclamations.length; i++) {
      if (reclamations[i].status == "En cours") {
        num++;
      }
    }
    return num;
  }

  int RecColturee() {
    List<ReclamationDTO> reclamations = Provider.of<ReclamationDtoProvider>(context).reclamations;
    int num = 0;
    for (int i = 0; i < reclamations.length; i++) {
      if (reclamations[i].status != "En cours") {
        num++;
      }
    }
    return num;
  }
}