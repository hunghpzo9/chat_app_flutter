import 'dart:io';

import 'package:chat_app/widgets/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this._isLoading);
  final bool _isLoading;
  final void Function(
    String email,
    String password,
    String username,
    File imageFile,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';
  var _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState?.validate();
    FocusScope.of(context).unfocus();
    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text("Please pick an image"),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid == null) {
      return;
    } else {
      _formKey.currentState!.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _userImageFile ?? File(''),
        _isLogin,
        context,
      );
    }
  }

  Widget textFormEmail() {
    return TextFormField(
      key: ValueKey('email'),
      validator: (value) {
        if (value!.isEmpty || !value.contains('@')) {
          return "Please enter a valid email address.";
        }
        return null;
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        labelText: "Email address",
      ),
      onSaved: (value) {
        _userEmail = value!;
      },
    );
  }

  Widget textFormPassword() {
    return TextFormField(
      key: ValueKey('password'),
      onSaved: (value) {
        _userPassword = value!;
      },
      validator: (value) {
        if (value!.isEmpty || value.length < 7) {
          return "Password must be at least 7 characters long.";
        }
        return null;
      },
      decoration: InputDecoration(labelText: 'Password'),
      obscureText: true,
    );
  }

  Widget textFormUserName() {
    if (!_isLogin) {
      return TextFormField(
        key: ValueKey('username'),
        validator: (value) {
          if (value!.isEmpty || value.length < 4) {
            return "Username must be at least 4 characters long.";
          }
          return null;
        },
        decoration: InputDecoration(labelText: 'Username'),
        onSaved: (value) {
          _userName = value!;
        },
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  Widget textButton() {
    if (!widget._isLoading) {
      return TextButton(
        onPressed: () {
          setState(() {
            _isLogin = !_isLogin;
          });
        },
        child:
            Text(_isLogin ? 'Create new account' : 'I already have an account'),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  Widget submitButton() {
    if (!widget._isLoading) {
      return ElevatedButton(
        child: Text(_isLogin ? 'Login' : 'Signup'),
        onPressed: _trySubmit,
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) UserImagePicer(_pickedImage),
                  textFormEmail(),
                  textFormUserName(),
                  textFormPassword(),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget._isLoading) CircularProgressIndicator(),
                  submitButton(),
                  textButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
