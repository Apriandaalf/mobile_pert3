import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tampilan Mahasiswa',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: LoginScreen(), // Menyeting LoginScreen sebagai halaman utama
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Membuat controller untuk TextField
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Inisialisasi GoogleSignIn
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Fungsi untuk login
  void _login() {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Username dan Password harus diisi!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login berhasil untuk $username!'),
        ),
      );
      // Arahkan pengguna ke halaman beranda atau halaman lain
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }

  // Fungsi untuk sign in menggunakan Google
  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign in sebagai ${account.displayName}'),
          ),
        );
        // Arahkan pengguna ke halaman beranda atau halaman lain
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal Sign In dengan Google: $error'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome Back"),
        backgroundColor: const Color.fromARGB(255, 250, 249, 249),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Enter your credentials to login",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              // Input Username
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person),
                  labelText: 'Username',
                  hintText: 'Masukkan username Anda',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Input Password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password',
                  hintText: 'Masukkan password Anda',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Tombol Login
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 16, 214, 152),
                  minimumSize: Size(double.infinity, 50), // Membuat tombol lebar penuh
                ),
              ),
              SizedBox(height: 20),

              // Tombol Sign In with Google
              ElevatedButton.icon(
                onPressed: _signInWithGoogle,
                icon: Icon(Icons.login, color: const Color.fromARGB(255, 4, 4, 4)),
                label: Text('Sign In with Google'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 181, 14, 176),
                  backgroundColor: const Color.fromARGB(255, 253, 252, 252),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        backgroundColor: const Color.fromARGB(255, 250, 249, 249),
      ),
      body: Center(
        child: Text(
          "Welcome to the Home Page!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
