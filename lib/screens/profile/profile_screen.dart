import 'package:flutter/material.dart';
import 'package:cb011999/services/user_service.dart';
import 'package:cb011999/services/order_service.dart';
import 'package:cb011999/models/order.dart';
import 'package:cb011999/screens/registration/login_screen.dart';

// String extension to capitalize first letter
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserService _userService = UserService();
  final OrderService _orderService = OrderService();
  Map<String, dynamic>? _userData;
  List<Order>? _orders;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    try {
      final userData = await _userService.getUserProfile();
      final orders = await _orderService.getOrders();

      if (mounted) {
        setState(() {
          _userData = userData;
          _orders = orders;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading profile data: $e')),
        );
      }
    }
  }

  Future<void> _handleLogout() async {
    try {
      await _userService.logout();
      if (mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error logging out: $e')),
        );
      }
    }
  }

  Future<void> _showUpdateDialog(String type) async {
    final TextEditingController controller = TextEditingController();
    final result = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add ${type.capitalize()}'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Enter your ${type.toLowerCase()}',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, controller.text),
            child: const Text('Save'),
          ),
        ],
      ),
    );

    if (result != null && result.isNotEmpty) {
      try {
        // Get current values
        final currentPhone = _userData?['phone'];
        final currentAddress = _userData?['address'];

        final success = await _userService.updateUserProfile(
          // If updating phone, use new value, else keep current value
          phone: type == 'phone' ? result : currentPhone,
          // If updating address, use new value, else keep current value
          address: type == 'address' ? result : currentAddress,
        );

        if (success && mounted) {
          _loadUserData(); // Reload user data
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$type updated successfully')),
          );
        } else if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to update $type')),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating $type: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Header
                    Center(
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage:
                                AssetImage("assets/images/profile_icon.png"),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _userData?['name'] ?? 'User',
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          Text(
                            _userData?['email'] ?? '',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // User Information
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Personal Information',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 16),
                            ListTile(
                              leading: const Icon(Icons.phone),
                              title: Text(
                                  _userData?['phone'] ?? 'No phone number'),
                              trailing: _userData?['phone'] == null
                                  ? TextButton(
                                      onPressed: () =>
                                          _showUpdateDialog('phone'),
                                      child: const Text('+ Add'),
                                    )
                                  : null,
                            ),
                            ListTile(
                              leading: const Icon(Icons.location_on),
                              title:
                                  Text(_userData?['address'] ?? 'No address'),
                              trailing: _userData?['address'] == null
                                  ? TextButton(
                                      onPressed: () =>
                                          _showUpdateDialog('address'),
                                      child: const Text('+ Add'),
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Order History
                    Text(
                      'Order History',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    if (_orders?.isEmpty ?? true)
                      Center(
                        child: Text(
                          'No orders yet',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _orders?.length ?? 0,
                        itemBuilder: (context, index) {
                          final order = _orders![index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order #${index + 1}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      ),
                                      Text(
                                        order.status,
                                        style: TextStyle(
                                          color: order.status == 'delivered'
                                              ? Colors.green
                                              : Colors.orange,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                      'Total: \$${order.total_amount.toStringAsFixed(2)}'),
                                  Text(
                                      'Date: ${order.created_at.toString().split('.')[0]}'),
                                  if (order.delivered_at != null)
                                    Text(
                                        'Delivered: ${order.delivered_at.toString().split('.')[0]}'),
                                  const SizedBox(height: 8),
                                  const Divider(),
                                  const Text('Order Items:',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 8),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: order.order_items.length,
                                    itemBuilder: (context, itemIndex) {
                                      final item = order.order_items[itemIndex];
                                      return ListTile(
                                        leading: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          child: Image.network(
                                            item.imageUrl,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Container(
                                                width: 50,
                                                height: 50,
                                                color: Colors.grey[300],
                                                child: const Icon(Icons.error),
                                              );
                                            },
                                          ),
                                        ),
                                        title: Text(item.name),
                                        subtitle:
                                            Text('Quantity: ${item.quantity}'),
                                        trailing: Text(
                                            '\$${(item.price * item.quantity).toStringAsFixed(2)}'),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                    // Logout Button
                    Container(
                      margin: const EdgeInsets.only(bottom: 24),
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _handleLogout,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          backgroundColor:
                              isDarkMode ? Colors.red[700] : Colors.red,
                        ),
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
