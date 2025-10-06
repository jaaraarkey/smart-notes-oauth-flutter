// title: "Home Screen After Successful Login"
// filepath: /Users/hardcandy/rust_projects/flutter_smart_notes_oauth/lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/backend_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final BackendService _backendService = BackendService();
  List<Map<String, dynamic>>? _notes;
  bool _loadingNotes = false;

  @override
  void initState() {
    super.initState();
    _loadUserNotes();
  }

  Future<void> _loadUserNotes() async {
    setState(() => _loadingNotes = true);

    final authService = Provider.of<AuthService>(context, listen: false);

    if (authService.jwtToken != null) {
      final notes = await _backendService.getUserNotes(authService.jwtToken!);
      setState(() {
        _notes = notes;
        _loadingNotes = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('📝 Smart Notes'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          // User profile button
          Consumer<AuthService>(
            builder: (context, authService, child) {
              return PopupMenuButton<String>(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundImage: authService.currentUser?.avatar != null
                        ? NetworkImage(authService.currentUser!.avatar!)
                        : null,
                    child: authService.currentUser?.avatar == null
                        ? Text(
                            authService.currentUser?.fullName?[0]
                                    .toUpperCase() ??
                                'U',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )
                        : null,
                  ),
                ),
                itemBuilder: (context) => [
                  PopupMenuItem<String>(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          authService.currentUser?.fullName ?? 'User',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          authService.currentUser?.email ?? '',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  const PopupMenuItem<String>(
                    value: 'signout',
                    child: Row(
                      children: [
                        Icon(Icons.logout),
                        SizedBox(width: 8),
                        Text('Sign Out'),
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 'signout') {
                    _handleSignOut(authService);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new note
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add note feature coming soon!')),
          );
        },
        backgroundColor: Colors.blue[600],
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildBody() {
    if (_loadingNotes) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading your notes...'),
          ],
        ),
      );
    }

    if (_notes == null || _notes!.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.note_add_outlined,
              size: 80,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              'No notes yet',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Tap the + button to create your first note',
              style: TextStyle(
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadUserNotes,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _notes!.length,
        itemBuilder: (context, index) {
          final note = _notes![index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              title: Text(
                note['title'] ?? 'Untitled Note',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (note['content'] != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      note['content'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                  const SizedBox(height: 8),
                  Text(
                    'Created: ${note['createdAt']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              leading: CircleAvatar(
                backgroundColor: Colors.blue[100],
                child: Icon(
                  Icons.note_outlined,
                  color: Colors.blue[600],
                ),
              ),
              onTap: () {
                // TODO: Open note for editing
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Note editing coming soon!')),
                );
              },
            ),
          );
        },
      ),
    );
  }

  void _handleSignOut(AuthService authService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Sign Out'),
        content: const Text('Are you sure you want to sign out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              authService.signOut();
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }
}
