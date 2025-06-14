import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../FCMService.dart';
import '../screens/FcmApiService.dart';

class FCMDebugScreen extends StatefulWidget {
  @override
  _FCMDebugScreenState createState() => _FCMDebugScreenState();
}

class _FCMDebugScreenState extends State<FCMDebugScreen> {
  String? fcmToken;
  List<String> logs = [];
  List<Map<String, dynamic>> accounts = [];
  List<Map<String, dynamic>> clients = [];

  // Controllers for test operations
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController depositAmountController = TextEditingController();
  final TextEditingController withdrawAmountController = TextEditingController();
  final TextEditingController transferAmountController = TextEditingController();
  final TextEditingController senderRIBController = TextEditingController();
  final TextEditingController receiverRIBController = TextEditingController();

  int? selectedAccountId;
  int? selectedClientId;

  @override
  void initState() {
    super.initState();
    _initializeDebug();
  }

  void _initializeDebug() {
    _getCurrentToken();
    _loadAccounts();
    _loadClients();
    _addLog("FCM Debug Screen initialized");
  }

  void _addLog(String log) {
    setState(() {
      logs.insert(0, "${DateTime.now().toString().substring(11, 19)}: $log");
    });
    print("📱 FCM Debug: $log");
  }

  void _getCurrentToken() {
    fcmToken = FCMService.getCurrentToken();
    if (fcmToken != null) {
      _addLog("Current FCM Token: ${fcmToken!.substring(0, 20)}...");
    } else {
      _addLog("No FCM Token found");
    }
    setState(() {});
  }

  Future<void> _loadAccounts() async {
    try {
      final fcmApiService = FCMApiService();
      final accountsList = await fcmApiService.getBankingAccounts();
      if (accountsList != null) {
        setState(() {
          accounts = accountsList;
        });
        _addLog("Loaded ${accounts.length} banking accounts");
      }
    } catch (e) {
      _addLog("Error loading accounts: $e");
    }
  }

  Future<void> _loadClients() async {
    try {
      final fcmApiService = FCMApiService();
      final clientsList = await fcmApiService.getClients();
      if (clientsList != null) {
        setState(() {
          clients = clientsList;
        });
        _addLog("Loaded ${clients.length} clients");
      }
    } catch (e) {
      _addLog("Error loading clients: $e");
    }
  }

  Future<void> _refreshToken() async {
    _addLog("Refreshing FCM Token...");
    String? newToken = await FCMService.refreshToken();
    if (newToken != null) {
      setState(() {
        fcmToken = newToken;
      });
      _addLog("Token refreshed successfully");
    } else {
      _addLog("Failed to refresh token");
    }
  }

  Future<void> _showTestNotification() async {
    _addLog("Showing test notification...");
    try {
      await FCMService.showTestNotification();
      _addLog("Test notification sent successfully");
    } catch (e) {
      _addLog("Error showing test notification: $e");
    }
  }

  Future<void> _sendTestNotificationToBackend() async {
    if (fcmToken == null) {
      _addLog("No FCM token available");
      return;
    }

    _addLog("Sending test notification via backend...");
    try {
      final fcmApiService = FCMApiService();
      final result = await fcmApiService.testSendNotification(
        token: fcmToken!,
        title: titleController.text.isEmpty ? "Test Banking Notification" : titleController.text,
        body: bodyController.text.isEmpty ? "This is a test notification from the debug screen" : bodyController.text,
      );

      if (result != null) {
        _addLog("Backend notification sent successfully");
      } else {
        _addLog("Failed to send notification via backend");
      }
    } catch (e) {
      _addLog("Error sending backend notification: $e");
    }
  }

  Future<void> _testDepositWithNotification() async {
    if (selectedAccountId == null) {
      _addLog("Please select an account first");
      return;
    }

    if (depositAmountController.text.isEmpty) {
      _addLog("Please enter deposit amount");
      return;
    }

    _addLog("Creating deposit with notification...");
    try {
      final fcmApiService = FCMApiService();
      final result = await fcmApiService.testDepositWithNotification(
        accountId: selectedAccountId!,
        amount: double.parse(depositAmountController.text),
      );

      if (result != null) {
        _addLog("Deposit created successfully - Check for notification!");
        _addLog("Deposit ID: ${result['depositId']}");
      } else {
        _addLog("Failed to create deposit");
      }
    } catch (e) {
      _addLog("Error creating deposit: $e");
    }
  }

  Future<void> _testWithdrawalWithNotification() async {
    if (selectedAccountId == null) {
      _addLog("Please select an account first");
      return;
    }

    if (withdrawAmountController.text.isEmpty) {
      _addLog("Please enter withdrawal amount");
      return;
    }

    _addLog("Creating withdrawal with notification...");
    try {
      final fcmApiService = FCMApiService();
      final result = await fcmApiService.testWithdrawalWithNotification(
        accountId: selectedAccountId!,
        amount: double.parse(withdrawAmountController.text),
      );

      if (result != null) {
        _addLog("Withdrawal created successfully - Check for notification!");
        _addLog("Withdrawal ID: ${result['withdrawalId']}");
      } else {
        _addLog("Failed to create withdrawal");
      }
    } catch (e) {
      _addLog("Error creating withdrawal: $e");
    }
  }

  Future<void> _testTransferWithNotification() async {
    if (senderRIBController.text.isEmpty || receiverRIBController.text.isEmpty) {
      _addLog("Please enter both sender and receiver RIB");
      return;
    }

    if (transferAmountController.text.isEmpty) {
      _addLog("Please enter transfer amount");
      return;
    }

    _addLog("Creating transfer with notification...");
    try {
      final fcmApiService = FCMApiService();
      final result = await fcmApiService.testTransferWithNotification(
        senderRIB: senderRIBController.text,
        receiverRIB: receiverRIBController.text,
        amount: double.parse(transferAmountController.text),
      );

      if (result != null) {
        _addLog("Transfer created successfully - Check for notification!");
        _addLog("Transfer ID: ${result['transferId']}");
      } else {
        _addLog("Failed to create transfer");
      }
    } catch (e) {
      _addLog("Error creating transfer: $e");
    }
  }

  Future<void> _setCurrentClientFCMToken() async {
    if (selectedClientId == null || fcmToken == null) {
      _addLog("Please select a client and ensure FCM token is available");
      return;
    }

    _addLog("Setting FCM token for selected client...");
    try {
      final fcmApiService = FCMApiService();
      final result = await fcmApiService.setClientFCMToken(
        clientId: selectedClientId!,
        token: fcmToken!,
      );

      if (result != null) {
        _addLog("FCM token set for client successfully");
        await _loadClients(); // Refresh client list
      } else {
        _addLog("Failed to set FCM token for client");
      }
    } catch (e) {
      _addLog("Error setting FCM token: $e");
    }
  }

  void _copyToken() {
    if (fcmToken != null) {
      Clipboard.setData(ClipboardData(text: fcmToken!));
      _addLog("Token copied to clipboard");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('FCM Token copied to clipboard')),
      );
    }
  }

  void _clearLogs() {
    setState(() {
      logs.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FCM Banking Debug'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _refreshToken();
              _loadAccounts();
              _loadClients();
            },
          ),
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: _clearLogs,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // FCM Token Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.key, color: Colors.blue),
                        SizedBox(width: 8),
                        Text('FCM Token', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        fcmToken != null ? fcmToken! : "No token available",
                        style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        ElevatedButton.icon(
                          onPressed: _copyToken,
                          icon: Icon(Icons.copy),
                          label: Text('Copy'),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: _refreshToken,
                          icon: Icon(Icons.refresh),
                          label: Text('Refresh'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Client Selection Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person, color: Colors.green),
                        SizedBox(width: 8),
                        Text('Client Selection', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Select Client',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedClientId,
                      items: clients.map((client) {
                        return DropdownMenuItem<int>(
                          value: client['id'],
                          child: Text('${client['email']} ${client['hasFCMToken'] ? '✅' : '❌'}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedClientId = value;
                        });
                      },
                    ),
                    SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: _setCurrentClientFCMToken,
                      icon: Icon(Icons.notifications),
                      label: Text('Set FCM Token for Selected Client'),
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    ),
                  ],
                ),
              ),
            ),

            // Account Selection Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_balance, color: Colors.purple),
                        SizedBox(width: 8),
                        Text('Account Selection', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 12),
                    DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Select Banking Account',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedAccountId,
                      items: accounts.map((account) {
                        return DropdownMenuItem<int>(
                          value: account['id'],
                          child: Text('${account['rib']} (Balance: ${account['balance']})'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedAccountId = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Banking Operations Testing Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.account_balance_wallet, color: Colors.orange),
                        SizedBox(width: 8),
                        Text('Banking Operations', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 12),

                    // Deposit Test
                    Text('Test Deposit', style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: depositAmountController,
                            decoration: InputDecoration(
                              labelText: 'Deposit Amount',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: _testDepositWithNotification,
                          icon: Icon(Icons.add),
                          label: Text('Deposit'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    // Withdrawal Test
                    Text('Test Withdrawal', style: TextStyle(fontWeight: FontWeight.bold)),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: withdrawAmountController,
                            decoration: InputDecoration(
                              labelText: 'Withdrawal Amount',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: _testWithdrawalWithNotification,
                          icon: Icon(Icons.remove),
                          label: Text('Withdraw'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    // Transfer Test
                    Text('Test Transfer', style: TextStyle(fontWeight: FontWeight.bold)),
                    TextField(
                      controller: senderRIBController,
                      decoration: InputDecoration(
                        labelText: 'Sender RIB',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: receiverRIBController,
                      decoration: InputDecoration(
                        labelText: 'Receiver RIB',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: transferAmountController,
                            decoration: InputDecoration(
                              labelText: 'Transfer Amount',
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(width: 8),
                        ElevatedButton.icon(
                          onPressed: _testTransferWithNotification,
                          icon: Icon(Icons.send),
                          label: Text('Transfer'),
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Direct Notification Testing Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.notifications, color: Colors.orange),
                        SizedBox(width: 8),
                        Text('Direct Notifications', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Notification Title',
                        border: OutlineInputBorder(),
                        hintText: 'Test Banking Notification',
                      ),
                    ),
                    SizedBox(height: 8),
                    TextField(
                      controller: bodyController,
                      decoration: InputDecoration(
                        labelText: 'Notification Body',
                        border: OutlineInputBorder(),
                        hintText: 'This is a test notification',
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _showTestNotification,
                            icon: Icon(Icons.phone_android),
                            label: Text('Local Test'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _sendTestNotificationToBackend,
                            icon: Icon(Icons.cloud),
                            label: Text('Backend Test'),
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Logs Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.list, color: Colors.purple),
                        SizedBox(width: 8),
                        Text('Debug Logs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Spacer(),
                        TextButton(
                          onPressed: _clearLogs,
                          child: Text('Clear'),
                        ),
                      ],
                    ),
                    Divider(),
                    Container(
                      height: 200,
                      child: logs.isEmpty
                          ? Center(child: Text('No logs yet'))
                          : ListView.builder(
                        itemCount: logs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: Text(
                              logs[index],
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'monospace',
                                color: logs[index].contains('Error') || logs[index].contains('Failed')
                                    ? Colors.red
                                    : logs[index].contains('successfully') || logs[index].contains('✅')
                                    ? Colors.green
                                    : Colors.black87,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    depositAmountController.dispose();
    withdrawAmountController.dispose();
    transferAmountController.dispose();
    senderRIBController.dispose();
    receiverRIBController.dispose();
    super.dispose();
  }
}