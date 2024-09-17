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
      home: SignUpScreen(), // Menyeting SignUpScreen sebagai halaman utama
    );
  }
}

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // Membuat controller untuk TextField
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Inisialisasi GoogleSignIn
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Fungsi untuk validasi dan membuat akun
  void _createAccount() {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;
    String confirmPassword = _confirmPasswordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Semua field harus diisi!'),
        ),
      );
    } else if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Password dan Confirm Password tidak cocok!'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Akun berhasil dibuat untuk $username!'),
        ),
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
        title: Text("Sign Up"),
        backgroundColor: const Color.fromARGB(255, 250, 249, 249),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Create your account",
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

              // Input Email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  labelText: 'Email',
                  hintText: 'Masukkan email Anda',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Input Password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  labelText: 'Password',
                  hintText: 'Masukkan password Anda',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Input Confirm Password
              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.password),
                  labelText: 'Confirm Password',
                  hintText: 'Konfirmasi password Anda',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Tombol Create Account
              ElevatedButton(
                onPressed: _createAccount,
                child: Text('Sign up'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 16, 214, 152),
                  minimumSize: Size(double.infinity, 50), // Membuat tombol lebar penuh
                ),
              ),
              SizedBox(height: 20),

              // Tombol Sign In with Google
              ElevatedButton.icon(
                onPressed: _signInWithGoogle,
                icon: Icon(Icons.login, color: const Color.fromARGB(255, 12, 12, 12)),
                label: Text('Sign In with Google'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 181, 14, 176), backgroundColor: const Color.fromARGB(255, 253, 252, 252),
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
