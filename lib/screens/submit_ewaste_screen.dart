import 'package:flutter/material.dart';
import '../widgets/eco_button.dart';

class SubmitEWasteScreen extends StatefulWidget {
  const SubmitEWasteScreen({super.key});

  @override
  State<SubmitEWasteScreen> createState() => _SubmitEWasteScreenState();
}

class _SubmitEWasteScreenState extends State<SubmitEWasteScreen> with SingleTickerProviderStateMixin {
  int _currentStep = 0;
  final int _totalSteps = 3;
  
  // Form data
  String? _selectedItemType;
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  String _selectedCondition = 'Good';
  bool _isPickup = true;
  
  // Animation controller
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  
  final List<String> _itemTypes = [
    'Smartphone',
    'Laptop',
    'Tablet',
    'Desktop PC',
    'TV/Monitor',
    'Printer',
    'Camera',
    'Audio Equipment',
    'Gaming Console',
    'Other Electronics'
  ];
  
  final List<String> _conditions = [
    'Like New',
    'Good',
    'Fair',
    'Poor',
    'Not Working'
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );
    
    _slideAnimation = Tween<Offset>(begin: const Offset(0.2, 0.0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _brandController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _nextStep() {
    if (_currentStep < _totalSteps - 1) {
      setState(() {
        _currentStep++;
        _animationController.reset();
        _animationController.forward();
      });
    } else {
      _showSuccessDialog();
    }
  }

  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
        _animationController.reset();
        _animationController.forward();
      });
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text('Success!'),
          ],
        ),
        content: const Text(
          'Your e-waste submission has been received. You\'ll be notified once it\'s processed.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Reset form
              setState(() {
                _currentStep = 0;
                _selectedItemType = null;
                _itemNameController.clear();
                _brandController.clear();
                _selectedCondition = 'Good';
                _isPickup = true;
                _animationController.reset();
                _animationController.forward();
              });
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit E-Waste'),
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildStepper(),
          Expanded(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: _buildCurrentStep(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepper() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(_totalSteps, (index) {
          final isActive = index <= _currentStep;
          return Row(
            children: [
              _buildStepCircle(index, isActive),
              if (index < _totalSteps - 1) _buildStepLine(index <= _currentStep - 1),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildStepCircle(int index, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: isActive 
              ? Theme.of(context).colorScheme.primary 
              : Colors.grey[300],
          child: Text(
            (index + 1).toString(),
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey[600],
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          _getStepTitle(index),
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive 
                ? Theme.of(context).colorScheme.primary 
                : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(bool isActive) {
    return Container(
      width: 60,
      height: 3,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      color: isActive
          ? Theme.of(context).colorScheme.primary
          : Colors.grey[300],
    );
  }

  String _getStepTitle(int step) {
    switch (step) {
      case 0:
        return 'Item Info';
      case 1:
        return 'Condition';
      case 2:
        return 'Submission';
      default:
        return '';
    }
  }

  Widget _buildCurrentStep() {
    switch (_currentStep) {
      case 0:
        return _buildItemInfoStep();
      case 1:
        return _buildConditionStep();
      case 2:
        return _buildSubmissionTypeStep();
      default:
        return Container();
    }
  }

  Widget _buildItemInfoStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Information',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 24),
        DropdownButtonFormField<String>(
          decoration: const InputDecoration(
            labelText: 'Item Type',
            prefixIcon: Icon(Icons.devices),
          ),
          value: _selectedItemType,
          hint: const Text('Select item type'),
          items: _itemTypes.map((type) {
            return DropdownMenuItem<String>(
              value: type,
              child: Text(type),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedItemType = value;
            });
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _itemNameController,
          decoration: const InputDecoration(
            labelText: 'Item Name/Model',
            prefixIcon: Icon(Icons.label_outline),
          ),
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _brandController,
          decoration: const InputDecoration(
            labelText: 'Brand',
            prefixIcon: Icon(Icons.business),
          ),
        ),
        const Spacer(),
        EcoButton(
          text: 'Continue',
          icon: Icons.arrow_forward,
          onPressed: _nextStep,
        ),
      ],
    );
  }

  Widget _buildConditionStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Condition',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 16),
        Text(
          'Please select the condition of your item',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 24),
        ...List.generate(_conditions.length, (index) {
          final condition = _conditions[index];
          return RadioListTile<String>(
            title: Text(condition),
            value: condition,
            groupValue: _selectedCondition,
            activeColor: Theme.of(context).colorScheme.primary,
            onChanged: (value) {
              setState(() {
                _selectedCondition = value!;
              });
            },
          );
        }),
        const SizedBox(height: 16),
        Text(
          'Add Photos (Optional)',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 16),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Center(
            child: IconButton(
              icon: const Icon(Icons.add_a_photo, size: 36),
              color: Colors.grey[500],
              onPressed: () {
                // Implementation for adding photos would go here
              },
            ),
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: EcoButton(
                text: 'Back',
                icon: Icons.arrow_back,
                isOutlined: true,
                onPressed: _previousStep,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: EcoButton(
                text: 'Continue',
                icon: Icons.arrow_forward,
                onPressed: _nextStep,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubmissionTypeStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Submission Type',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 24),
        Text(
          'How would you like to recycle your item?',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 16),
        _buildSubmissionOptionCard(
          title: 'Schedule Pickup',
          description: 'We will come pick up your e-waste at your location',
          icon: Icons.local_shipping_outlined,
          isSelected: _isPickup,
          onTap: () {
            setState(() {
              _isPickup = true;
            });
          },
        ),
        const SizedBox(height: 16),
        _buildSubmissionOptionCard(
          title: 'Drop Off',
          description: 'You can drop off your e-waste at our recycling center',
          icon: Icons.location_on_outlined,
          isSelected: !_isPickup,
          onTap: () {
            setState(() {
              _isPickup = false;
            });
          },
        ),
        const SizedBox(height: 24),
        if (_isPickup)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pickup Details',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                  prefixIcon: Icon(Icons.home_outlined),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Preferred Date',
                  prefixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () {
                  // Show date picker
                },
              ),
            ],
          )
        else
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Drop-off Centers',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Main Recycling Center',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text('123 Green Street, Eco City'),
                    const Text('Open: Mon-Sat, 9AM - 6PM'),
                  ],
                ),
              ),
            ],
          ),
        const Spacer(),
        Row(
          children: [
            Expanded(
              child: EcoButton(
                text: 'Back',
                icon: Icons.arrow_back,
                isOutlined: true,
                onPressed: _previousStep,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: EcoButton(
                text: 'Submit',
                icon: Icons.check_circle_outline,
                onPressed: _nextStep,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSubmissionOptionCard({
    required String title,
    required String description,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: isSelected
                  ? Theme.of(context).colorScheme.primary.withOpacity(0.2)
                  : Colors.grey[100],
              child: Icon(
                icon,
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Colors.grey[500],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isSelected ? Icons.check_circle : Icons.circle_outlined,
              color: isSelected
                  ? Theme.of(context).colorScheme.primary
                  : Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
} 