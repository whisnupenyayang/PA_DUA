import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    // Untuk Android WebView modern
    // WebViewPlatform.instance = SurfaceAndroidWebView(); // uncomment kalau butuh
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 88,
        titleSpacing: 20,
        centerTitle: true,
        title: const Text("Masuk"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: "Email address",
                hintText: "Your email address",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: "Password",
                hintText: "Your password",
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      _obscurePassword ? "Show" : "Hide",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AdminWebViewPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2696D6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text("Masuk", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Aksi untuk tombol "Daftar"
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff2696D6),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: const Size(double.infinity, 48),
              ),
              child: const Text("Daftar", style: TextStyle(color: Colors.white)),
            ),
            const SizedBox(height: 16),
            const Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class AdminWebViewPage extends StatelessWidget {
  const AdminWebViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: 'http://192.168.52.244:8000/',
          javascriptMode: JavascriptMode.unrestricted,
        ),
      ),
    );
  }
}
