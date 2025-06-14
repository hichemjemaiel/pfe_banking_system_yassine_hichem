import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/ChatProvider.dart';
import 'ChatInputWidget.dart';
import 'ChatMessageWidget.dart';
import 'TypingIndicator.dart';


class ChatScreenAi extends StatefulWidget {
  const ChatScreenAi({Key? key}) : super(key: key);

  @override
  State<ChatScreenAi> createState() => _ChatScreenAiState();
}

class _ChatScreenAiState extends State<ChatScreenAi> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFF4CAF50),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.smart_toy,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 12),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Chatbot AI',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'En ligne',
                  style: TextStyle(
                    color: Color(0xFF4CAF50),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              switch (value) {
                case 'clear':
                  context.read<ChatProvider>().clearMessages();
                  break;
                case 'user':
                  _showUserIdDialog(context);
                  break;
                case 'help':
                  _showHelpDialog(context);
                  break;
              }
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'clear',
                child: Row(
                  children: [
                    Icon(Icons.refresh, size: 20),
                    SizedBox(width: 8),
                    Text('Effacer la conversation'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'user',
                child: Row(
                  children: [
                    Icon(Icons.person, size: 20),
                    SizedBox(width: 8),
                    Text('Changer d\'utilisateur'),
                  ],
                ),
              ),
              const PopupMenuItem<String>(
                value: 'help',
                child: Row(
                  children: [
                    Icon(Icons.help, size: 20),
                    SizedBox(width: 8),
                    Text('Aide'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) {
                // Auto-scroll when new messages arrive
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _scrollToBottom();
                });

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: chatProvider.messages.length +
                      (chatProvider.isLoading ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == chatProvider.messages.length) {
                      // Show typing indicator when loading
                      return const TypingIndicator();
                    }

                    final message = chatProvider.messages[index];
                    return ChatMessageWidget(
                      message: message,
                      onRetry: () => chatProvider.retryMessage(message.id),
                    );
                  },
                );
              },
            ),
          ),
          Container(
            color: Colors.white,
            child: SafeArea(
              child: Consumer<ChatProvider>(
                builder: (context, chatProvider, child) {
                  return ChatInputWidget(
                    onSendMessage: (message) {
                      chatProvider.sendMessage(message);
                    },
                    isEnabled: !chatProvider.isLoading,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showUserIdDialog(BuildContext context) {
    final controller = TextEditingController();
    final currentUserId = context.read<ChatProvider>().userId;
    controller.text = currentUserId;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('ID Utilisateur'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Entrez votre ID utilisateur',
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () {
              final newUserId = controller.text.trim();
              if (newUserId.isNotEmpty) {
                context.read<ChatProvider>().setUserId(newUserId);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('ID utilisateur changé en: $newUserId')),
                );
              }
            },
            child: const Text('Confirmer'),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Aide - Chatbot Bancaire'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Je peux vous aider avec:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('• Vérifier votre solde'),
              Text('• Consulter vos transactions'),
              Text('• Informations sur vos comptes'),
              Text('• Analyse de vos dépenses'),
              Text('• Questions bancaires générales'),
              SizedBox(height: 15),
              Text(
                'Exemples de questions:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text('• "Quel est mon solde?"'),
              Text('• "Montrez-moi mes dernières transactions"'),
              Text('• "Quelles sont mes informations de compte?"'),
              Text('• "Comment fonctionne un virement?"'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fermer'),
          ),
        ],
      ),
    );
  }
}