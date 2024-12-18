import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:portfolio/models/user_model.dart';
import 'package:portfolio/widgets/user_form.dart';

class UserCard extends StatelessWidget {
  const UserCard({super.key, required this.userModel});

  final UserModel userModel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onLongPress: () {
          final RenderBox renderBox = context.findRenderObject() as RenderBox;
          final Offset offset = renderBox.localToGlobal(Offset.zero);
          showMenu(
            context: context,
            position: RelativeRect.fromLTRB(
              offset.dx + renderBox.size.width - 100, // Adjust X position
              offset.dy + renderBox.size.height, // Position it below the tile
              offset.dx + renderBox.size.width, // Right edge
              offset.dy, // Top edge
            ),
            items: [
              PopupMenuItem(
                child: Text("Edit"),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shadowColor: const Color.fromARGB(255, 170, 222, 190),
                      surfaceTintColor: Colors.green,
                      content: UserForm(
                        true,
                        name: userModel.name,
                        email: userModel.email,
                        address: userModel.address,
                      ),
                    ),
                  );
                },
              ),
              PopupMenuItem(
                child: Text("Delete"),
                onTap: () {
                  // Handle Delete action, show confirmation dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Delete User"),
                        content:
                            Text("Are you sure you want to delete this user?"),
                        actions: <Widget>[
                          TextButton(
                            child: Text("Cancel"),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text("Delete"),
                            onPressed: () {
                              // Call delete function, for example: deleteUser(val.id);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          );
        },
        child: SizedBox(
          width: 320,
          height: 200,
          child: Card(
            color: Color(0xFFA8D5BA),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(19.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(userModel.name),
                  Gap(15),
                  Text(userModel.email),
                  Gap(5),
                  Text(userModel.address),
                  Gap(5),
                  Text(userModel.id == null ? "" : userModel.id!),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
