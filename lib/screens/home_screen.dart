import 'package:flutter/material.dart';
import '../widgets/feature_card.dart';
import '../widgets/product_card.dart';
import '../widgets/eco_impact_card.dart';
import '../models/product.dart';
import 'main_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late ScrollController _scrollController;
  final Map<String, Animation<double>> _animations = {};

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _animations['header'] = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    _animations['featureCards'] = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
    );

    _animations['products'] = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.4, 0.9, curve: Curves.easeOut),
    );

    _animations['ecoImpact'] = CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.6, 1.0, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  
  // Navigate to browse screen
  void _navigateToBrowse(BuildContext context) {
    MainScreen.navigateToTab(context, 1);
  }

  // Navigate to browse screen with specific category
  void _navigateToBrowseWithCategory(BuildContext context, String category) {
    MainScreen.navigateToTab(context, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 24),
              _buildFeatureCards(context),
              const SizedBox(height: 24),
              _buildUpcycledProducts(context),
              const SizedBox(height: 24),
              _buildEcoImpact(context),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return FadeTransition(
      opacity: _animations['header'] as Animation<double>,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
            .animate(_animations['header'] as Animation<double>),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "E-Waste Hub",
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications_outlined),
                    onPressed: () {},
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ],
              ),
              Text(
                "Make a difference today",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureCards(BuildContext context) {
    return FadeTransition(
      opacity: _animations['featureCards'] as Animation<double>,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero)
            .animate(_animations['featureCards'] as Animation<double>),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "How can we help?",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: FeatureCard(
                      icon: Icons.delete_outline_rounded,
                      title: "Submit E-Waste",
                      color: Theme.of(context).colorScheme.primary,
                      onTap: () {
                        MainScreen.navigateToTab(context, 2);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FeatureCard(
                      icon: Icons.support_agent_rounded,
                      title: "Browse Services",
                      color: Theme.of(context).colorScheme.secondary,
                      onTap: () {
                        MainScreen.navigateToTab(context, 3);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              FeatureCard(
                icon: Icons.store_rounded,
                title: "Explore Upcycled Marketplace",
                color: Theme.of(context).colorScheme.primary.withOpacity(0.8),
                onTap: () {
                  // Use the static method for consistent navigation
                  MainScreen.navigateToTab(context, 1);
                },
                isWide: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcycledProducts(BuildContext context) {
    final demoProducts = [
      Product(
        id: '1',
        name: 'Refurbished iPhone 12',
        image: 'assets/images/iphone12.jpg',
        originalPrice: 799.99,
        currentPrice: 499.99,
        rating: 4.5,
        condition: 'Excellent',
        category: 'Phones',
      ),
      Product(
        id: '2',
        name: 'Dell XPS 13 Renewed',
        image: 'assets/images/dell_xps.jpg',
        originalPrice: 1299.99,
        currentPrice: 849.99,
        rating: 4.8,
        condition: 'Like New',
        category: 'Laptops',
      ),
      Product(
        id: '3',
        name: 'Samsung Galaxy Tab S7',
        image: 'assets/images/tab_s7.jpg',
        originalPrice: 649.99,
        currentPrice: 429.99,
        rating: 4.3,
        condition: 'Good',
        category: 'Tablets',
      ),
      Product(
        id: '4',
        name: 'Wireless Earbuds',
        image: 'assets/images/earbuds.jpg',
        originalPrice: 129.99,
        currentPrice: 69.99,
        rating: 4.1,
        condition: 'Refurbished',
        category: 'Audio',
      ),
    ];

    return FadeTransition(
      opacity: _animations['products'] as Animation<double>,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Featured Upcycled Products",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                TextButton(
                  onPressed: () {
                    // Use the static method for consistent navigation
                    MainScreen.navigateToTab(context, 1);
                  },
                  child: const Text("See All"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 280,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: demoProducts.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: SlideTransition(
                    position: Tween<Offset>(begin: Offset(0.2 * (index + 1), 0), end: Offset.zero)
                        .animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: Interval(
                              0.4 + (index * 0.1),
                              0.7 + (index * 0.1),
                              curve: Curves.easeOut,
                            ),
                          ),
                        ),
                    child: ProductCard(
                      product: demoProducts[index],
                      onTap: () {
                        // Use the static method for consistent navigation
                        MainScreen.navigateToTab(context, 1);
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEcoImpact(BuildContext context) {
    return FadeTransition(
      opacity: _animations['ecoImpact'] as Animation<double>,
      child: SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(_animations['ecoImpact'] as Animation<double>),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Your Eco Impact",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 16),
              Row(
              children: [
                  Expanded(
                    child: EcoImpactCard(
                      title: "Eco Points",
                      value: 324,
                      icon: Icons.eco,
                      color: Theme.of(context).colorScheme.primary,
                      progress: 0.65,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: EcoImpactCard(
                      title: "Items Recycled",
                      value: 8,
                      icon: Icons.delete_outline,
                      color: Theme.of(context).colorScheme.secondary,
                      progress: 0.4,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              EcoImpactCard(
                title: "Carbon Impact",
                value: 120,
                icon: Icons.co2,
                color: const Color(0xFF4CAF50),
                progress: 0.8,
                unit: "kg saved",
                isWide: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
} 