import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:myapp/api/controller.dart';
import 'package:myapp/home.dart';

ApiPrsns _apiPrsns = ApiPrsns();

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static final DateTime now = DateTime.now();
  static final DateFormat formatter = DateFormat('yyyy');
  final String formatted = formatter.format(now);

  final _formLoginKey = GlobalKey<FormState>();
  TextEditingController _controllerNomorKtp = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: Form(
                  key: _formLoginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold),
                      ),
                      // const Text(
                      //   'Anda harus login untuk menggunakan aplikasi',
                      // ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: _controllerNomorKtp,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kolom ini harus diisi!';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nomor KTP',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: _controllerPassword,
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kolom ini harus diisi!';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          child: const Text('Login'),
                          onPressed: () async {
                            if (_formLoginKey.currentState!.validate()) {
                              EasyLoading.show(status: 'Mohon Tunggu!');

                              dynamic data = await _apiPrsns.login(
                                _controllerNomorKtp.text,
                                _controllerPassword.text,
                              );

                              if (data['success'].toString() == 'true') {
                                const storage = FlutterSecureStorage();
                                await storage.write(
                                    key: 'login_id_user', value: data['id']);
                                await storage.write(
                                    key: 'login_no_ktp',
                                    value: _controllerNomorKtp.text);
                                await storage.write(
                                    key: 'login_pass',
                                    value: _controllerPassword.text);
                                EasyLoading.dismiss();
                                if (!mounted) return;
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Home(),
                                  ),
                                );
                              } else {
                                EasyLoading.dismiss();
                                EasyLoading.showError(
                                    'Periksa kembali nama pengguna / kata sandi Anda');
                              }
                            }
                          },
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                        //child: Text('Don\'t have an account? Create'),
                        child: Center(
                          child: Text(
                            'Aplikasi Presensi Online\nCopyright © $formatted Artmedia Apps\nAll rights reserved',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              // shadows: [
                              //   Shadow(
                              //     offset: Offset(1.0, 1.0),
                              //     blurRadius: 3.0,
                              //     color: Color.fromARGB(255, 0, 0, 0),
                              //   ),
                              // ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
