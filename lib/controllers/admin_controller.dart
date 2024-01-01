import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final users = <QueryDocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  Future<void> getUsers() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await _firestore.collection('users').get();
      users.assignAll(snapshot.docs);
    } catch (e) {
      print('Error fetching users: $e');
    }
  }
}
