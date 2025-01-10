import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'chat_screen.dart';

class ChatLoginScreen extends StatefulWidget {
  @override
  _ChatLoginScreenState createState() => _ChatLoginScreenState();
}

class _ChatLoginScreenState extends State<ChatLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  List<String> _savedUsernames = [];

  @override
  void initState() {
    super.initState();
    _loadSavedUsernames();
  }

  Future<void> _loadSavedUsernames() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedUsernames = prefs.getStringList('savedUsernames') ?? [];
    });
  }

  Future<void> _saveUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    if (!_savedUsernames.contains(username)) {
      setState(() {
        _savedUsernames.add(username);
      });
      await prefs.setStringList('savedUsernames', _savedUsernames);
    }
  }

  Future<void> _deleteUsername(String username) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedUsernames.remove(username);
    });
    await prefs.setStringList('savedUsernames', _savedUsernames);
  }

  void _proceedToChat() {
    final username = _usernameController.text.trim();
    if (username.isNotEmpty) {
      _saveUsername(username);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatScreen(username: username),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a username")),
      );
    }
  }

  void _useSavedUsername(String username) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(username: username),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enter Chat')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _proceedToChat,
              child: Text("Enter Chat"),
            ),
            SizedBox(height: 30),
            Text(
              "Previous Usernames:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _savedUsernames.length,
                itemBuilder: (context, index) {
                  final username = _savedUsernames[index];
                  return ListTile(
                    title: Text(username),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteUsername(username),
                    ),
                    onTap: () => _useSavedUsername(username),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
