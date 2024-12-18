import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:portfolio/features/users/providers/user_provider.dart';
import 'package:portfolio/features/users/screens/search_screen.dart';
import 'package:portfolio/models/user_model.dart';
import 'package:portfolio/widgets/user_card.dart';
import 'package:portfolio/widgets/user_form.dart';

class UserListScreen extends ConsumerStatefulWidget {
  const UserListScreen({super.key});

  @override
  ConsumerState<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends ConsumerState<UserListScreen> {
  bool cardList = true;
  String searched = "";
  Widget listView(UserModel? val) {
    return ListTile(
      contentPadding: EdgeInsets.only(left: 25, right: 25),
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: UserForm(
              true,
              id: val.id,
              name: val.name,
              email: val.email,
              address: val.address,
            ),
          ),
        );
      },
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => UserCard(userModel: val),
        );
      },
      title: Text(val!.name),
      subtitle: Text(val.email),
      trailing: IconButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              content: Text(
                "Delete data permanently?",
                style: TextStyle(fontSize: 20),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "No",
                      style: TextStyle(fontSize: 17),
                    )),
                TextButton(
                    onPressed: () {
                      ref.read(userProvider.notifier).removeUser(val.id!);
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Good to Go👍",
                      style: TextStyle(fontSize: 17),
                    ))
              ],
            ),
          );
        },
        icon: Icon(Icons.delete),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> userState = ref.watch(userProvider);
    final List<dynamic> userList = userState['users'];
    final isLoading = userState['isLoading'] as bool;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("PortFolio", style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              showSearch(
                  context: context,
                  delegate: SearchScreen(
                    listView: listView,
                    userList: userList as List<UserModel>,
                    onSearchQueryChanged: (value) {
                      setState(() {
                        searched = value;
                      });
                    },
                  ));
            },
          ),
        ],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                        onPressed: () {
                          setState(() {
                            cardList = !cardList;
                          });
                        },
                        icon: Icon(cardList ? Icons.grid_view : Icons.list))
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: userList.length,
                    itemBuilder: (context, index) {
                      if (userList.isEmpty) {
                        return Center(child: Text("No Data Found"));
                      }
                      UserModel val = userList[index];
                      return cardList
                          ? UserCard(userModel: val)
                          : listView(val);
                    },
                  ),
                ),
                Gap(10),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add User",
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) => UserForm(false),
          );
        },
      ),
    );
  }
}
