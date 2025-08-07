import 'package:flutter/material.dart';
import '../models/product.dart';
import '../widgets/product_card.dart';

class BrowseScreen extends StatefulWidget {
  final String initialCategory;
  
  const BrowseScreen({
    super.key, 
    this.initialCategory = 'All',
  });

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  late List<Product> _products;
  late TextEditingController _searchController;
  String _searchQuery = '';
  late String _selectedCategory;

  final List<String> _categories = [
    'All',
    'Phones',
    'Laptops',
    'Tablets',
    'Audio',
    'Accessories',
  ];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _selectedCategory = widget.initialCategory;
    _loadProducts();
    print('BrowseScreen initialized with category: ${widget.initialCategory}');
  }
  
  @override
  void didUpdateWidget(BrowseScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialCategory != widget.initialCategory) {
      setState(() {
        _selectedCategory = widget.initialCategory;
      });
      print('Updated category to: ${widget.initialCategory}');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void setCategory(String category) {
    if (_categories.contains(category)) {
      setState(() {
        _selectedCategory = category;
      });
    }
  }

  void _loadProducts() {
    // In a real app, this would come from an API or database
    _products = [
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
      Product(
        id: '5',
        name: 'MacBook Pro 2019',
        image: 'assets/images/macbook.jpg',
        originalPrice: 1499.99,
        currentPrice: 899.99,
        rating: 4.7,
        condition: 'Excellent',
        category: 'Laptops',
      ),
      Product(
        id: '6',
        name: 'Google Pixel 5',
        image: 'assets/images/pixel5.jpg',
        originalPrice: 699.99,
        currentPrice: 349.99,
        rating: 4.4,
        condition: 'Good',
        category: 'Phones',
      ),
      Product(
        id: '7',
        name: 'Bluetooth Speaker',
        image: 'assets/images/speaker.jpg',
        originalPrice: 199.99,
        currentPrice: 119.99,
        rating: 4.2,
        condition: 'Refurbished',
        category: 'Audio',
      ),
      Product(
        id: '8',
        name: 'iPad Pro 2020',
        image: 'assets/images/ipad.jpg',
        originalPrice: 899.99,
        currentPrice: 649.99,
        rating: 4.6,
        condition: 'Like New',
        category: 'Tablets',
      ),
    ];
  }

  List<Product> get _filteredProducts {
    return _products.where((product) {
      final matchesSearch = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory =
          _selectedCategory == 'All' || product.category == _selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Browse Upcycled Products'),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildCategoryFilter(),
          Expanded(
            child: _buildProductGrid(),
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
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
          contentPadding: const EdgeInsets.symmetric(vertical: 0),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = category == _selectedCategory;
          
          return GestureDetector(
            onTap: () {
              setCategory(category);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20),
              ),
              alignment: Alignment.center,
              child: Text(
                category,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProductGrid() {
    final products = _filteredProducts;
    
    if (products.isEmpty) {
      return const Center(
        child: Text('No products found'),
      );
    }
    
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(
          product: products[index],
          onTap: () {
            // Navigate to product details (can be implemented later)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Selected: ${products[index].name}')),
            );
          },
          isGridView: true,
        );
      },
    );
  }
} 