import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task2/controllers/admin_controller.dart';

class AdminPage extends StatelessWidget {
  final AdminController controller = Get.put(AdminController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin'),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.users.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: controller.users.length,
            itemBuilder: (context, index) {
              final userData =
                  controller.users[index].data() as Map<String, dynamic>;
              final username = userData['username'] ?? 'suraj';
              final emailOrPhone =
                  userData['email or phone no'] ?? '6280644889';
              final phone = userData['phone'] ?? '6280644889';

              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    title: Text(username),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(emailOrPhone),
                        Text(phone),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
