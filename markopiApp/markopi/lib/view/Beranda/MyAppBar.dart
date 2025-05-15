import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:markopi/routes/route_name.dart';
import 'package:markopi/service/User_Storage.dart';
import 'package:markopi/service/User_Storage_Service.dart';
import 'package:markopi/service/token_storage.dart';

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(50);
}

class _MyAppBarState extends State<MyAppBar> {
  final userStorage = UserStorage();
  UserModel? _user;

  String? token;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    final result = await TokenStorage.getToken();
    await userStorage.openBox();
    final user = userStorage.getUser();
    setState(() {
      _user = user;
      token = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Jangan tampilkan apapun kalau masih loading
    if (isLoading) return const SizedBox.shrink();

    return AppBar(
      toolbarHeight: 40,
      titleSpacing: 10,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: const Icon(Icons.account_circle, size: 45),
          ),
          const SizedBox(width: 10),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _user?.namaLengkap ?? 'pengunjung',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (_user?.namaLengkap == null)
                  const Text(
                    'anda belum login',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
          const Spacer(),
          if (token == null)
            InkWell(
              onTap: () {
                Get.toNamed(RouteName.login);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF2696D6),
                  borderRadius: BorderRadius.circular(6),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
      backgroundColor: Colors.white,
      elevation: 1,
    );
  }
}
