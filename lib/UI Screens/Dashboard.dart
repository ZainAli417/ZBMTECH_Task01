import 'package:ZBM_TASK01/AUTH/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import '../api_client.dart';
import '../data_model.dart'; // Import DataModel

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    _loadDataWithDelay();
  }

  Future<void> _loadDataWithDelay() async {
    final dataProvider = Provider.of<DataProvider>(context, listen: false);
    // Simulate a delay
    await Future.delayed(const Duration(seconds: 3));
    dataProvider.fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          automaticallyImplyLeading: false, // Disables the default back button
          actions: [
            TextButton.icon(
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text('Logout', style: TextStyle(color: Colors.white)),
              onPressed: _logout,
              style: TextButton.styleFrom(
                backgroundColor: Colors.indigo, // Custom button color
              ),
            ),
          ],
        ),
        body: Consumer<DataProvider>(
          builder: (context, dataProvider, child) {
            if (dataProvider.isLoading) {
              return _buildSkeleton();
            } else {
              return _buildContent(dataProvider.items);
            }
          },
        ),
      ),
    );
  }

  Widget _buildSkeleton() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Skeleton(
          isLoading: true,
          skeleton: _buildSkeletonItem(),
          child: const SizedBox.shrink(),
        );
      },
    );
  }

  Widget _buildSkeletonItem() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        leading: Skeleton(
          isLoading: true,
          skeleton: CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            radius: 24,
          ),
          child: const SizedBox.shrink(),
        ),
        title: Skeleton(
          isLoading: true,
          skeleton: Container(
            color: Colors.grey.shade300,
            height: 16,
            width: double.infinity,
          ),
          child: const SizedBox.shrink(),
        ),
        subtitle: Skeleton(
          isLoading: true,
          skeleton: Container(
            color: Colors.grey.shade300,
            height: 14,
            width: double.infinity,
          ),
          child: const SizedBox.shrink(),
        ),
      ),
    );
  }

  Widget _buildContent(List<DataModel> dataList) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: dataList.length,
      itemBuilder: (context, index) {
        final item = dataList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16.0),
            leading: CircleAvatar(
              backgroundColor: Colors.indigo[900],
              foregroundColor: Colors.white,
              child: Text(item.id.toString()),
            ),
            title: Text(item.title), // Update to use 'title'
            subtitle: Text(item.body), // Update to use 'body'
          ),
        );
      },
    );
  }

  void _logout() async {
      await FirebaseAuth.instance.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }

}
