import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';


class TextInput extends StatefulWidget {
  bool fullNameEnabled;
  BuildContext ctx;
  TextInput({super.key, this.fullNameEnabled = true, required this.ctx});

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  var _isLoading = false;
  final _auth = FirebaseAuth.instance;
  bool _isObscure = true;

  void _submitAuthForm(String email, String password, String username) async {
    UserCredential authResult;
    try {
      setState(() {
        _isLoading = true;
      });
      if (!widget.fullNameEnabled) {
        authResult = await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        //here we sign in because fullNameEnabled is only available in signup mode
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(authResult.user!.uid)
            .set({'username': username, 'email': email});
            
      }
    } on FirebaseAuthException catch (error) {
      var message = 'An error occured, please check your credentials!';
      if (error.message != null) {
        message = error.message.toString();
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).errorColor,
      ));
      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      //print(error);
    }
  }

  void trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState!.save();
      //We will use those values to send our auth request...
      _submitAuthForm(_userEmail.trim(), _userPassword.trim(), _username);
    }
  }

  String _userEmail = '';
  String _userPassword = '';
  String _username = '';
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (widget.fullNameEnabled)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: TextFormField(
                onSaved: (newValue) {
                  _username = newValue!;
                },
                validator: (value) {
                  if (value != null && value.length <= 4) {
                    return 'İstifadəçi adı minimum 4 simvol olmalıdır...';
                  }
                  return null;
                },
                key: const ValueKey('fullname'),
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    prefixIcon: Icon(
                      Icons.person,
                      color: Theme.of(context).primaryColor,
                    ),
                    labelText: 'Full name',
                    labelStyle:
                        TextStyle(color: Theme.of(context).primaryColor)),
              ),
            ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextFormField(
              onSaved: (newValue) {
                _userEmail = newValue!;
              },
              validator: (value) {
                if (value != null && !value.contains('@')) {
                  return 'Bu formada elektron poçt mümkün deyil...';
                }
                return null;
              },
              key: const ValueKey('email'),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.email,
                    color: Theme.of(context).primaryColor,
                  ),
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor)),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: TextFormField(
                onSaved: (newValue) {
                  _userPassword = newValue!;
                },
                validator: (value) {
                  if (value != null && value.length < 7) {
                    return 'Şifrə 7 simvoldan böyük olmalıdır...';
                  }
                },
                key: const ValueKey('password'),
                obscureText: _isObscure,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.lock_outline_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(
                      _isObscure ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                )),
          ),
          widget.fullNameEnabled
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    if (_isLoading)
                    const  Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (!_isLoading)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: ElevatedButton(
                          onPressed: trySubmit,
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                          ),
                          child: const Text('Qeydiyyatdan  Keç'),
                        ),
                      ),
                    if (!_isLoading)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Sizin hesabınız var?'),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(SignIn.route);
                            },
                            style: ButtonStyle(
                                foregroundColor: MaterialStateProperty.all(
                                    Theme.of(context).primaryColor)),
                            child: const Text('Daxil ol'),
                          )
                        ],
                      ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.06,
                    ),
                    if (_isLoading)
                    const  Center(
                        child: CircularProgressIndicator(),
                      ),
                    if (!_isLoading)
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: ElevatedButton(
                          onPressed: trySubmit,
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            backgroundColor: MaterialStateProperty.all(
                                Theme.of(context).primaryColor),
                          ),
                          child: const Text('Daxil  ol'),
                        ),
                      ),
                  ],
                ),
        ],
      ),
    );
  }
}
