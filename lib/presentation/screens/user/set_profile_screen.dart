import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frenly/presentation/cubit/auth/auth_cubit.dart';
import 'package:frenly/presentation/cubit/auth/auth_state.dart';
import 'package:ionicons/ionicons.dart';

class SetProfileScreen extends StatefulWidget {
  const SetProfileScreen({super.key});

  @override
  State<SetProfileScreen> createState() => _SetProfileScreenState();
}

class _SetProfileScreenState extends State<SetProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  String profileImage = '';

  @override
  void initState() {
    final auth = context.read<AuthCubit>().state as Authenticated;
    nameController.text = auth.user.name!;
    profileImage = auth.user.profileImage!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          children: [
            const Text(
              'Fill your profile',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              'Complete your profile',
              style: TextStyle(color: Theme.of(context).disabledColor),
            ),
            const SizedBox(
              height: 28,
            ),
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileImage),
                  radius: 48,
                ),
                InkWell(
                  child: Icon(
                    Ionicons.camera,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () {},
                ),
              ],
            ),
            const SizedBox(
              height: 28,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Name'),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                    filled: true,
                    fillColor: Theme.of(context).hoverColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text('Bio'),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  controller: bioController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 18),
                    filled: true,
                    fillColor: Theme.of(context).hoverColor,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
