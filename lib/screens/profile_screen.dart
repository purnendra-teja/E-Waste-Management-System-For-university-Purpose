import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Mock user data
  final Map<String, dynamic> _userData = {
    'name': 'Alex Green',
    'email': 'alex.green@example.com',
    'ecoPoints': 324,
    'level': 'Eco Enthusiast',
    'profileImage': 'assets/images/profile.jpg',
    'joinDate': 'May 2023',
  };

  // Mock activity data
  final List<Map<String, dynamic>> _activities = [
    {
      'type': 'recycle',
      'item': 'iPhone 11',
      'points': 50,
      'date': 'Mar 15, 2024',
      'icon': Icons.recycling_rounded,
      'color': Colors.green,
    },
    {
      'type': 'repair',
      'item': 'Laptop Battery',
      'points': 30,
      'date': 'Mar 8, 2024',
      'icon': Icons.build_rounded,
      'color': Colors.blue,
    },
    {
      'type': 'market',
      'item': 'Purchased Refurbished Headphones',
      'points': 20,
      'date': 'Feb 28, 2024',
      'icon': Icons.shopping_bag_outlined,
      'color': Colors.amber,
    },
    {
      'type': 'recycle',
      'item': 'Old Tablet',
      'points': 45,
      'date': 'Feb 12, 2024',
      'icon': Icons.recycling_rounded,
      'color': Colors.green,
    },
    {
      'type': 'market',
      'item': 'Sold Used Smartwatch',
      'points': 35,
      'date': 'Jan 25, 2024',
      'icon': Icons.sell_outlined,
      'color': Colors.purple,
    },
  ];

  // Monthly eco points data for chart
  final List<int> _monthlyPoints = [20, 45, 80, 65, 90, 120];

  // List of available rewards based on eco points
  final List<Map<String, dynamic>> _rewards = [
    {
      'title': 'TechHack Discount',
      'description': '20% off on registration for the upcoming hackathon',
      'pointsRequired': 100,
      'icon': Icons.code,
      'color': Colors.indigo,
      'expiry': 'May 30, 2024',
      'redeemed': false,
    },
    {
      'title': 'College Fest Entry Pass',
      'description': 'Free entry pass to the annual college festival',
      'pointsRequired': 150,
      'icon': Icons.festival,
      'color': Colors.deepPurple,
      'expiry': 'July 15, 2024',
      'redeemed': false,
    },
    {
      'title': 'Workshop Access',
      'description': 'Free access to the E-Waste Management workshop',
      'pointsRequired': 200,
      'icon': Icons.school,
      'color': Colors.teal,
      'expiry': 'June 10, 2024',
      'redeemed': true,
    },
    {
      'title': 'Project Showcase',
      'description': 'Priority slot in the innovation showcase event',
      'pointsRequired': 250,
      'icon': Icons.lightbulb,
      'color': Colors.amber,
      'expiry': 'August 5, 2024',
      'redeemed': false,
    },
    {
      'title': 'Sustainable Tech Conference',
      'description': '50% discount on registration for the conference',
      'pointsRequired': 300,
      'icon': Icons.devices,
      'color': Colors.green,
      'expiry': 'September 20, 2024',
      'redeemed': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildProfileHeader(),
              _buildStatsCards(),
              _buildDivider('Activity Timeline'),
              _buildActivityTimeline(),
              _buildDivider('Monthly Impact'),
              _buildMonthlyChart(),
              _buildDivider('Rewards'),
              _buildRewardsSection(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey[200],
                child: ClipOval(
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: const Icon(
                  Icons.edit,
                  color: Colors.white,
                  size: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            _userData['name'],
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            _userData['email'],
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.eco,
                  size: 16,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  '${_userData['level']} · ${_userData['ecoPoints']} Points',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCards() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        children: [
          _buildStatCard(
            title: 'Items Recycled',
            value: '8',
            icon: Icons.delete_outline_rounded,
            color: Colors.green,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: 'Carbon Saved',
            value: '120kg',
            icon: Icons.co2_outlined,
            color: Colors.blue,
          ),
          const SizedBox(width: 16),
          _buildStatCard(
            title: 'Badges',
            value: '4',
            icon: Icons.emoji_events_outlined,
            color: Colors.amber[700]!,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color.withOpacity(0.1),
              child: Icon(
                icon,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 1,
              color: Colors.grey[300],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTimeline() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _activities.length,
        itemBuilder: (context, index) {
          final activity = _activities[index];
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimelineIndicator(
                color: activity['color'],
                isFirst: index == 0,
                isLast: index == _activities.length - 1,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildActivityCard(activity, index),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTimelineIndicator({
    required Color color,
    required bool isFirst,
    required bool isLast,
  }) {
    return Column(
      children: [
        Container(
          width: 2,
          height: 20,
          color: isFirst ? Colors.transparent : Colors.grey[300],
        ),
        CircleAvatar(
          radius: 12,
          backgroundColor: color,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: color,
            ),
          ),
        ),
        Container(
          width: 2,
          height: 80,
          color: isLast ? Colors.transparent : Colors.grey[300],
        ),
      ],
    );
  }

  Widget _buildActivityCard(Map<String, dynamic> activity, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: index == _activities.length - 1 ? 0 : 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: activity['color'].withOpacity(0.1),
                    child: Icon(
                      activity['icon'],
                      size: 16,
                      color: activity['color'],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _getActivityTypeText(activity['type']),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.eco,
                      size: 14,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '+${activity['points']}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            activity['item'],
            style: const TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            activity['date'],
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  String _getActivityTypeText(String type) {
    switch (type) {
      case 'recycle':
        return 'Recycled Item';
      case 'repair':
        return 'Repaired Item';
      case 'market':
        return 'Marketplace Activity';
      default:
        return 'Activity';
    }
  }

  Widget _buildMonthlyChart() {
    // Calculate a scaling factor based on the highest value to prevent overflow
    final int maxPoint = _monthlyPoints.reduce((max, value) => max > value ? max : value);
    final double scaleFactor = maxPoint > 0 ? 100 / maxPoint : 1;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Eco Points Earned',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(_monthlyPoints.length, (index) {
                // Scale height proportionally to the max value
                final double barHeight = _monthlyPoints[index] * scaleFactor;
                
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: _buildChartBar(
                      height: barHeight,
                      value: _monthlyPoints[index].toString(),
                      label: _getMonthLabel(index),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChartBar({
    required double height,
    required String value,
    required String label,
    required Color color,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutQuart,
          height: height,
          width: 16,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildRewardsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Available with ${_userData['ecoPoints']} Points',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Show all rewards
                },
                child: const Text('View All'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _rewards.length,
            itemBuilder: (context, index) {
              final reward = _rewards[index];
              final bool isAvailable = _userData['ecoPoints'] >= reward['pointsRequired'];
              final bool isRedeemed = reward['redeemed'];
              
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundColor: reward['color'].withOpacity(0.1),
                        child: Icon(
                          reward['icon'],
                          color: reward['color'],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              reward['title'],
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              reward['description'],
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isAvailable 
                                        ? Colors.green.withOpacity(0.1) 
                                        : Colors.grey.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.eco,
                                        size: 12,
                                        color: isAvailable ? Colors.green : Colors.grey,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '${reward['pointsRequired']} Points',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: isAvailable ? Colors.green : Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Expires: ${reward['expiry']}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        children: [
                          if (isRedeemed)
                            Chip(
                              label: const Text(
                                'Redeemed',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              backgroundColor: Colors.grey,
                              padding: EdgeInsets.zero,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            )
                          else
                            ElevatedButton(
                              onPressed: isAvailable ? () {
                                // Redeem reward logic
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Redeemed ${reward['title']}!'),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).colorScheme.primary,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                              ),
                              child: const Text('Redeem'),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  String _getMonthLabel(int index) {
    final List<String> months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
    return months[index];
  }
} 