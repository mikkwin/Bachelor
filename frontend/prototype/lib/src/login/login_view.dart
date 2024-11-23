import 'package:flutter/material.dart';
import 'package:prototype/src/unit_search/unit_search_view.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

/// Displays a list of SampleItems.
class LoginView extends StatelessWidget {
  const LoginView({super.key});


  static const routeName = '/login';


  String hasher(String input) {
    input += "bachelorGE"; // salt
    List<int> bytes = utf8.encode(input);
    Digest hash = md5.convert(bytes);
    return hash.bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }




  @override
  Widget build(BuildContext context) {
    String username = "";
    String pass = "";

    return PopScope(
        canPop: false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Login'),
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Welcome! Please log in.'),
                    const SizedBox(height: 20),
                    TextField(
                      onChanged: (value) {username = value;},
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Username',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      obscureText: true,
                      onChanged: (value) {pass = value;},
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        pass = hasher(pass);
                        print(pass);
                        if (pass == "ede9ca0ba903a037f25f67b2cc24be3a" && username == "test"){
                          String url = "https://localhost:5001/Login/Login?username=${username}&password=${pass}";
                          print(url);
                          Future<Map<String, dynamic>> fetchData() async {
                            try {
                              final response = await http.get(Uri.parse(url));
                              if (response.statusCode == 200) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const UnitSearchView()));

                                return json.decode(response.body);
                              } else {
                                throw Exception("DATA_FEJL");
                              }
                            } catch (e) {
                              throw Exception("Error: $e");
                            }
                          }
                          fetchData();
                        }
                      },
                      child: const Text('Login'),
                    ),
                  ],
                )),
          ),
        ));
  }
}
