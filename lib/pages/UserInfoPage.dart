import 'package:flutter/material.dart';

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  // Replace with your real data
  final String userName = 'John Doe';
  final String email = 'john.doe@gmail.com';
  final String phone = '+1 807 567 8900';
  final String avatarUrl =
      'https://gravatar.com/avatar/7e1a482b835c2c703fd170b811583cde?s=400&d=robohash&r=x';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F7),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'User Info',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(avatarUrl),
                  ),
                  const SizedBox(height: 12),
                  Text(userName, style: Theme.of(context).textTheme.titleLarge),
                ],
              ),
            ),
            const SizedBox(height: 24),

            Text(
              'ACCOUNT',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 8),

            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _buildTile(
                    icon: Icons.email,
                    title: 'Email',
                    trailing:
                        Text(email, style: TextStyle(color: Colors.grey[700])),
                  ),
                  const Divider(height: 1),
                  _buildTile(
                    icon: Icons.phone,
                    title: 'Phone number',
                    trailing:
                        Text(phone, style: TextStyle(color: Colors.grey[700])),
                  ),
                  const Divider(height: 1),
                  _buildTile(
                    icon: Icons.add_box,
                    title: 'Subscription',
                    trailing: Text('Chat Bot Plus',
                        style: TextStyle(color: Colors.grey[700])),
                  ),
                  const Divider(height: 1),
                  _buildTile(
                    icon: Icons.workspace_premium,
                    title: 'Upgrade to Chat Bot Pro',
                    onTap: () {
                      // TODO: upgrade logic
                    },
                  ),
                  const Divider(height: 1),
                  _buildTile(
                    icon: Icons.restore,
                    title: 'Restore purchases',
                    onTap: () {
                      // TODO: restore logic
                    },
                  ),
                  const Divider(height: 1),
                  _buildTile(
                    icon: Icons.person,
                    title: 'Personalization',
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: personalization page
                    },
                  ),
                  const Divider(height: 1),
                  _buildTile(
                    icon: Icons.notifications,
                    title: 'Notifications',
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: notifications settings
                    },
                  ),
                  const Divider(height: 1),
                  _buildTile(
                    icon: Icons.storage,
                    title: 'Data Controls',
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: data controls
                    },
                  ),
                  const Divider(height: 1),
                  _buildTile(
                    icon: Icons.archive,
                    title: 'Archived Chats',
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: archived chats
                    },
                  ),
                  const Divider(height: 1),
                  _buildTile(
                    icon: Icons.security,
                    title: 'Security',
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // TODO: security settings
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTile({
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title),
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    );
  }
}
