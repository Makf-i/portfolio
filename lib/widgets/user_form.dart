import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:portfolio/features/users/providers/user_provider.dart';

class UserForm extends ConsumerStatefulWidget {
  const UserForm(
    this.updating, {
    super.key,
    this.id,
    this.name,
    this.email,
    this.address,
  });

  final bool updating;
  final String? id;
  final String? name;
  final String? email;
  final String? address;

  @override
  ConsumerState<UserForm> createState() => _UserFormState();
}

class _UserFormState extends ConsumerState<UserForm> {
  var enteredName = '';
  var enteredEmail = '';
  var enteredAddress = '';

  final _form = GlobalKey<FormState>();

  bool isAdding = false;

  void _submit() async {
    FocusScope.of(context).unfocus();

    final isValid = _form.currentState!.validate(); //validate reuturn a boolean

    if (!isValid) {
      return;
    }

    _form.currentState!.save();
    setState(() {
      isAdding = true;
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    if (widget.updating) {
      await ref
          .read(userProvider.notifier)
          .updateUser(widget.id!, enteredName, enteredEmail, enteredAddress);
      setState(() {
        isAdding = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Data updated")));
      Navigator.of(context).pop();

      return;
    }

    await ref
        .read(userProvider.notifier)
        .addUser(enteredName, enteredEmail, enteredAddress);

    setState(() {
      isAdding = false;
    });
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Data Added Successfully")));
    _form.currentState!.reset();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.updating
          ? const EdgeInsets.all(0)
          : const EdgeInsets.all(19.0),
      child: Form(
        key: _form,
        child: SizedBox(
          height:
              widget.updating ? null : MediaQuery.of(context).size.height * 0.7,
          child: Column(
            mainAxisSize: widget.updating ? MainAxisSize.min : MainAxisSize.max,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Name'),
                enableSuggestions: false,
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your full name';
                  }
                  return null;
                },
                initialValue: widget.name,
                onSaved: (value) {
                  enteredName = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty ||
                      !value.contains('@')) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
                initialValue: widget.email,
                onSaved: (value) {
                  enteredEmail = value!;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Address',
                ),
                keyboardType: TextInputType.text,
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your Address';
                  }
                  return null;
                },
                initialValue: widget.address,
                onSaved: (value) {
                  enteredAddress = value!;
                },
              ),
              Gap(13),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Cancel")),
                  isAdding
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          onPressed: _submit,
                          child: Text(widget.updating ? "Update" : "Add"),
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
