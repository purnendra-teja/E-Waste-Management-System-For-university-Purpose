import 'package:flutter/material.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  
  // Animation controller for staggered list
  bool _isLoading = true;
  
  // Example repair center data
  final List<Map<String, dynamic>> _repairCenters = [
    {
      'name': 'Green Tech Repairs',
      'distance': 2.3,
      'rating': 4.8,
      'items': ['Phones', 'Laptops', 'Tablets'],
      'address': '123 Main St, Green City',
      'image': 'assets/images/repair1.jpg',
    },
    {
      'name': 'Circuit Fixers',
      'distance': 3.1,
      'rating': 4.6,
      'items': ['Computers', 'TVs', 'Game Consoles'],
      'address': '456 Tech Ave, Green City',
      'image': 'assets/images/repair2.jpg',
    },
    {
      'name': 'Mobile Medics',
      'distance': 4.5,
      'rating': 4.7,
      'items': ['Phones', 'Tablets', 'Wearables'],
      'address': '789 Digital Blvd, Green City',
      'image': 'assets/images/repair3.jpg',
    },
    {
      'name': 'PC Doctors',
      'distance': 5.2,
      'rating': 4.5,
      'items': ['Laptops', 'Desktops', 'Monitors'],
      'address': '101 Processor Ln, Green City',
      'image': 'assets/images/repair4.jpg',
    },
  ];
  
  // Example recycling center data
  final List<Map<String, dynamic>> _recyclingCenters = [
    {
      'name': 'EcoTech Recyclers',
      'distance': 1.8,
      'rating': 4.9,
      'items': ['All Electronics', 'Batteries', 'Appliances'],
      'address': '123 Green St, Eco City',
      'image': 'assets/images/recycle1.jpg',
    },
    {
      'name': 'Planet Savers',
      'distance': 3.4,
      'rating': 4.7,
      'items': ['Computers', 'Phones', 'Batteries'],
      'address': '456 Earth Ave, Eco City',
      'image': 'assets/images/recycle2.jpg',
    },
    {
      'name': 'e-Cyclers Facility',
      'distance': 5.1,
      'rating': 4.6,
      'items': ['Large Appliances', 'TVs', 'Office Equipment'],
      'address': '789 Recycle Rd, Eco City',
      'image': 'assets/images/recycle3.jpg',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).colorScheme.primary,
          labelColor: Theme.of(context).colorScheme.primary,
          unselectedLabelColor: Colors.grey[600],
          tabs: const [
            Tab(
              icon: Icon(Icons.build_rounded),
              text: 'Repair Centers',
            ),
            Tab(
              icon: Icon(Icons.recycling_rounded),
              text: 'Recycling Centers',
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildCentersList(_repairCenters, 'repair'),
                _buildCentersList(_recyclingCenters, 'recycle'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search nearby centers...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show filter options
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
      ),
    );
  }

  Widget _buildCentersList(List<Map<String, dynamic>> centers, String type) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    
    return centers.isEmpty
        ? _buildEmptyState(type)
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: centers.length,
            itemBuilder: (context, index) {
              final center = centers[index];
              return _buildCenterCard(
                center,
                type == 'repair' 
                    ? 'Schedule Repair' 
                    : 'Schedule Pickup',
                index,
              );
            },
          );
  }

  Widget _buildCenterCard(Map<String, dynamic> center, String buttonText, int index) {
    return AnimatedOpacity(
      opacity: _isLoading ? 0 : 1.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: AnimatedPadding(
        padding: EdgeInsets.only(
          top: _isLoading ? 20 : 0,
          bottom: 16,
        ),
        duration: Duration(milliseconds: 300 + (index * 100)),
        curve: Curves.easeOut,
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  height: 120,
                  width: double.infinity,
                  color: Colors.grey[300],
                  child: Center(
                    child: Icon(
                      buttonText.contains('Repair') 
                          ? Icons.build_circle_outlined
                          : Icons.recycling_outlined,
                      size: 40,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            center['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.star,
                                color: Colors.white,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                center['rating'].toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      center['address'],
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${center['distance']} miles away',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: List.generate(
                        center['items'].length,
                        (i) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            center['items'][i],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle scheduling
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                        ),
                        child: Text(buttonText),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String type) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            type == 'repair' ? Icons.build_circle_outlined : Icons.recycling_outlined,
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No ${type == 'repair' ? 'repair' : 'recycling'} centers found',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or location',
            style: TextStyle(
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
} 