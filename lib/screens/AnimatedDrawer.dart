import 'package:flutter/material.dart';
import 'package:pfe_banking_system/chat/UserSelectionScreen.dart';
import 'package:pfe_banking_system/screens/Auth.dart';
import 'package:pfe_banking_system/screens/Contacts/screens/Cone.dart';
import 'package:pfe_banking_system/screens/Depot/screens/Done.dart';
import 'package:pfe_banking_system/screens/Mes%20Cartes/screens/McOne.dart';
import 'package:pfe_banking_system/screens/Profile/Prone.dart';
import 'package:pfe_banking_system/screens/Profile/Prtwo.dart';
import 'package:pfe_banking_system/screens/Recharger%20carte/screens/Rctone.dart';
import 'package:pfe_banking_system/screens/Reclamations/screens/RcOne.dart';
import 'package:pfe_banking_system/screens/Retrait/screens/Reone.dart';
import 'package:pfe_banking_system/screens/authentication/proivder/AuthProvider.dart';
import 'package:pfe_banking_system/screens/chatbot/screens/ChatScreenAi.dart';
import 'package:pfe_banking_system/screens/configuration/CnOne.dart';
import 'package:pfe_banking_system/screens/historique/screens/Hone.dart';
import 'package:pfe_banking_system/screens/rendez%20vous/screens/RnOne.dart';
import 'package:pfe_banking_system/screens/statistiques/screens/Statistiques.dart';
import 'package:provider/provider.dart';

import 'Virement/screens/ChoixVirement.dart';

class AnimatedDrawer extends StatefulWidget {
  String email;
  int? id ;
  AnimatedDrawer({super.key ,required this.email, required  this.id});

  @override
  _AnimatedDrawerState createState() => _AnimatedDrawerState();


}

class _AnimatedDrawerState extends State<AnimatedDrawer> with TickerProviderStateMixin {
  int? _selectedIndex;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _colorAnimation = ColorTween(
      begin: Colors.transparent,
      end: Color(0xFF4A9E1F).withOpacity(0.1),
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onItemTap(int index, VoidCallback onTap) async {
    setState(() {
      _selectedIndex = index;
    });

    await _animationController.forward();
    await Future.delayed(Duration(milliseconds: 100));
    await _animationController.reverse();

    setState(() {
      _selectedIndex = null;
    });

    onTap();
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Déconnexion'),
          content: Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog first
                _performLogout();
              },
              child: Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                _performLogout();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: Text('Déconnecter'),
            ),
          ],
        );
      },
    );
  }

  void _performLogout() {
    // Clear the authentication state and navigate to Auth screen
    Provider.of<AuthProvider>(context, listen: false).logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Auth()),
          (route) => false, // This removes all previous routes from the stack
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          // Clean Header with logo and close button
          Container(
            height: 120,
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Logo section - you can replace with Image.asset("assets/logo.png")
                Container(
                    child: Image.asset("assets/bambo.png")
                ),
                // Close button
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.close,
                        size: 24,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Menu Items
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              children: [
                // Dashboard
                _buildAnimatedMenuItem(
                  index: 0,
                  icon: Icons.home_outlined,
                  title: "Tableau de bord",
                  onTap: () {
                    Navigator.pop(context);
                  },
                  hasArrow: false,
                ),

                // Account Section - Expandable
                _buildAnimatedExpansionTile(
                  index: 1,
                  icon: Icons.account_balance_wallet_outlined,
                  title: "Compte",
                  children: [
                    _buildSubMenuItem(
                      icon: Icons.person_outlined,
                      title: "Mon profil",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Prtwo(email : widget.email)));
                      },
                    ),
                    _buildSubMenuItem(
                      icon: Icons.credit_card_outlined,
                      title: "Mes cartes",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Mcone(id : widget.id)));
                      },
                    ),
                    _buildSubMenuItem(
                      icon: Icons.contacts_outlined,
                      title: "Contact",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Cone(id : widget.id)));
                      },
                    ),
                  ],
                ),

                // Transactions Section - Expandable
                _buildAnimatedExpansionTile(
                  index: 2,
                  icon: Icons.swap_horiz_outlined,
                  title: "Transactions",
                  children: [
                    _buildSubMenuItem(
                      icon: Icons.currency_exchange_outlined,
                      title: "Virements",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Choixvirement(id :widget.id!)));
                      },
                    ),
                    _buildSubMenuItem(
                      icon: Icons.attach_money_outlined,
                      title: "Dépôt / Retrait",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Reone(id : widget.id)));
                      },
                    ),
                    _buildSubMenuItem(
                      icon: Icons.payment_outlined,
                      title: "Recharge de carte",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Rctone(id : widget.id)));
                      },
                    ),
                  ],
                ),

                // History Section - Expandable
                _buildAnimatedExpansionTile(
                  index: 5,
                  icon: Icons.history_outlined,
                  title: "Historique",
                  children: [
                    _buildSubMenuItem(
                      icon: Icons.analytics_outlined,
                      title: "Statistiques",
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Statistiques(id: widget.id!)));
                      },
                    ),
                    _buildSubMenuItem(
                      icon: Icons.receipt_outlined,
                      title: "Opérations",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Hone(id : widget.id!)));
                      },
                    ),
                  ],
                ),

                // Spacer to push bottom items down
                SizedBox(height: 40),

                // Service client - Expandable
                _buildAnimatedExpansionTile(
                  index: 7,
                  icon: Icons.support_agent_outlined,
                  title: "Service client",
                  children: [
                    _buildSubMenuItem(
                      icon: Icons.event_outlined,
                      title: "Rendez-vous",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Rnone(id : widget.id,email :widget.email)));
                      },
                    ),
                    _buildSubMenuItem(
                      icon: Icons.message_outlined,
                      title: "Messagerie",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserSelectionScreen()));
                      },
                    ),
                    _buildSubMenuItem(
                      icon: Icons.report_problem_outlined,
                      title: "Réclamations",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Rcone(id: widget.id)));
                      },
                    ),
                    _buildSubMenuItem(
                      icon: Icons.smart_toy,
                      title: "assistant bancaire",
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreenAi()));
                      },
                    ),
                  ],
                ),

                _buildAnimatedMenuItem(
                  index: 8,
                  icon: Icons.settings_outlined,
                  title: "Configuration",
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Cnone()));
                  },
                  hasArrow: false,
                ),
              ],
            ),
          ),

          // Logout Button at the bottom
          Container(
            padding: EdgeInsets.all(16),
            child: _buildLogoutButton(),
          ),
        ],
      ),
    );
  }

  // Logout Button Builder
  Widget _buildLogoutButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: _showLogoutDialog,
        splashColor: Colors.red.withOpacity(0.2),
        highlightColor: Colors.red.withOpacity(0.1),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.red.shade300, width: 1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.logout_outlined,
                size: 22,
                color: Colors.red.shade600,
              ),
              SizedBox(width: 12),
              Text(
                "Déconnexion",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.red.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Animated Menu Item Builder
  Widget _buildAnimatedMenuItem({
    required int index,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool hasArrow,
  }) {
    bool isSelected = _selectedIndex == index;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: isSelected ? _scaleAnimation.value : 1.0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: isSelected ? _colorAnimation.value : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () => _onItemTap(index, onTap),
                splashColor: Color(0xFF4A9E1F).withOpacity(0.2),
                highlightColor: Color(0xFF4A9E1F).withOpacity(0.1),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: Duration(milliseconds: 200),
                        child: Icon(
                          icon,
                          size: 22,
                          color: isSelected ? Color(0xFF4A9E1F) : Colors.black87,
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: AnimatedDefaultTextStyle(
                          duration: Duration(milliseconds: 200),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                            color: isSelected ? Color(0xFF4A9E1F) : Colors.black87,
                          ),
                          child: Text(title),
                        ),
                      ),
                      if (hasArrow)
                        AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          child: Icon(
                            Icons.chevron_right,
                            size: 20,
                            color: isSelected ? Color(0xFF4A9E1F) : Colors.grey.shade600,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  // Animated Expansion Tile Builder
  Widget _buildAnimatedExpansionTile({
    required int index,
    required IconData icon,
    required String title,
    required List<Widget> children,
  }) {
    bool isSelected = _selectedIndex == index;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.scale(
          scale: isSelected ? _scaleAnimation.value : 1.0,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: isSelected ? _colorAnimation.value : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
                expansionTileTheme: ExpansionTileThemeData(
                  tilePadding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  childrenPadding: EdgeInsets.only(left: 16, bottom: 8),
                ),
              ),
              child: ExpansionTile(
                leading: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  child: Icon(
                    icon,
                    size: 22,
                    color: isSelected ? Color(0xFF4A9E1F) : Colors.black87,
                  ),
                ),
                title: AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 200),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Color(0xFF4A9E1F) : Colors.black87,
                  ),
                  child: Text(title),
                ),
                iconColor: Color(0xFF4A9E1F),
                collapsedIconColor: Colors.grey.shade600,
                onExpansionChanged: (expanded) {
                  if (expanded) {
                    _onItemTap(index, () {});
                  }
                },
                children: children,
              ),
            ),
          ),
        );
      },
    );
  }

  // Sub Menu Item Builder
  Widget _buildSubMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: Color(0xFF4A9E1F).withOpacity(0.1),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Row(
            children: [
              SizedBox(width: 16), // Indent for sub-items
              Icon(
                icon,
                size: 18,
                color: Colors.grey.shade700,
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}