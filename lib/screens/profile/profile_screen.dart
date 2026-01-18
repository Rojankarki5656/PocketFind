import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocketfind/services/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:pocketfind/core/theme/app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<Map<String, dynamic>> _settingsOptions = [
    {'icon': Icons.notifications, 'title': 'Notifications', 'hasSwitch': true},
    {'icon': Icons.location_on, 'title': 'Location Settings'},
    {'icon': Icons.language, 'title': 'Language'},
    {'icon': Icons.dark_mode, 'title': 'Dark Mode', 'hasSwitch': true},
    {'icon': Icons.privacy_tip, 'title': 'Privacy Policy'},
    {'icon': Icons.help, 'title': 'Help & Support'},
    {'icon': Icons.info, 'title': 'About'},
    {'icon': Icons.logout, 'title': 'Logout', 'color': Colors.red},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      if (userProvider.user == null) {
        userProvider.loadUser();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;

    if (userProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (user == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_outline, size: 60, color: Colors.grey),
            const SizedBox(height: 16),
            const Text('No user data'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => userProvider.loadUser(),
              child: const Text('Load Profile'),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryColor.withOpacity(0.8),
                      AppTheme.secondaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: Text(
                          user.name.substring(0, 1),
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Member since ${DateFormat('MMM yyyy').format(user.joinedDate)}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Badge & Points
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.verified, size: 16, color: AppTheme.primaryColor),
                                    const SizedBox(width: 4),
                                    Text(
                                      user.badge,
                                      style: const TextStyle(
                                        color: AppTheme.primaryColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                '${user.points} Points',
                                style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Keep contributing to earn more!',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Column(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.amber,
                                child: Icon(
                                  Icons.emoji_events,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Quick Stats
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'My Activity',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 3,
                    childAspectRatio: 1.5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    children: [
                      _buildStatCard(
                        icon: Icons.store,
                        value: user.contributions
                            .where((c) => c.type == 'shop')
                            .length
                            .toString(),
                        label: 'Shops',
                        color: Colors.blue,
                      ),
                      _buildStatCard(
                        icon: Icons.shopping_bag,
                        value: user.contributions
                            .where((c) => c.type == 'product')
                            .length
                            .toString(),
                        label: 'Products',
                        color: Colors.green,
                      ),
                      _buildStatCard(
                        icon: Icons.edit,
                        value: user.contributions
                            .where((c) => c.type == 'price_update')
                            .length
                            .toString(),
                        label: 'Updates',
                        color: Colors.orange,
                      ),
                      _buildStatCard(
                        icon: Icons.bookmark,
                        value: user.savedProducts.length.toString(),
                        label: 'Saved',
                        color: Colors.purple,
                      ),
                      _buildStatCard(
                        icon: Icons.star,
                        value: '4.8',
                        label: 'Avg. Rating',
                        color: Colors.amber,
                      ),
                      _buildStatCard(
                        icon: Icons.visibility,
                        value: '1.2k',
                        label: 'Views',
                        color: Colors.red,
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Recent Contributions
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Recent Contributions',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: user.contributions.take(3).map((contribution) {
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getContributionColor(contribution.type)
                                  .withOpacity(0.1),
                              child: Icon(
                                _getContributionIcon(contribution.type),
                                color: _getContributionColor(contribution.type),
                              ),
                            ),
                            title: Text(contribution.name),
                            subtitle: Text(
                              DateFormat('MMM dd, yyyy').format(contribution.date),
                            ),
                            trailing: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                '+${contribution.pointsEarned}',
                                style: const TextStyle(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Settings
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Card(
                    child: Column(
                      children: _settingsOptions.map((option) {
                        return ListTile(
                          leading: Icon(
                            option['icon'] as IconData,
                            color: option['color'] ?? Colors.grey.shade700,
                          ),
                          title: Text(
                            option['title'],
                            style: TextStyle(
                              color: option['color'] ?? Colors.black,
                            ),
                          ),
                          trailing: option['hasSwitch'] == true
                              ? Switch(
                                  value: true,
                                  onChanged: (value) {},
                                  activeColor: AppTheme.primaryColor,
                                )
                              : const Icon(Icons.chevron_right),
                          onTap: () {
                            if (option['title'] == 'Logout') {
                              _showLogoutDialog(context);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
  }) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Color _getContributionColor(String type) {
    switch (type) {
      case 'shop':
        return Colors.blue;
      case 'product':
        return Colors.green;
      case 'price_update':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  IconData _getContributionIcon(String type) {
    switch (type) {
      case 'shop':
        return Icons.store;
      case 'product':
        return Icons.shopping_bag;
      case 'price_update':
        return Icons.edit;
      default:
        return Icons.help;
    }
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // Implement logout logic here
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully')),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}