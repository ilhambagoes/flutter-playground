import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:dio/dio.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  FToast fToast = FToast();
  final dio = Dio();

  final _textID = TextEditingController();
  final _textName = TextEditingController();
  final _textHobby = TextEditingController();
  final _textPassword = TextEditingController();
  final _textConfirmPassword = TextEditingController();
  bool _validate = false;

  @override
  Widget build(BuildContext context) {
    fToast.init(context);
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Staff Form'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _textID,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Staff ID',
                    errorText: _validate ? 'Staff ID Cant Be Empty' : null,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _textName,
                  decoration: InputDecoration(
                    labelText: 'Staff Name',
                    errorText: _validate ? 'Staff Name Cant Be Empty' : null,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _textHobby,
                  decoration: const InputDecoration(labelText: 'Hobby'),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _textPassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: _validate ? 'Password Cant Be Empty' : null,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: _textConfirmPassword,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    errorText:
                        _validate ? 'Confirm Password Cant Be Empty' : null,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _textID.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                      _textName.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                      _textPassword.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                      _textConfirmPassword.text.isEmpty
                          ? _validate = true
                          : _validate = false;
                      _textConfirmPassword.text != _textPassword.text
                          ? _showToast()
                          : _validate = false;
                    });
                    if (_validate == false) {
                      sendDataUser();
                    }
                  },
                  child: const Text('Submit'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void sendDataUser() async {
    final response = await dio.post('https://reqres.in/api/users', data: {
      'id': _textID.text,
      'name': _textName.text,
      'hobby': _textHobby.text.isNotEmpty ? _textHobby.text : "-",
      'password': _textPassword.text
    });
    print(response);
  }

  _showToast() {
    Fluttertoast.showToast(
        msg: "Confirm Password is not same with password",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
