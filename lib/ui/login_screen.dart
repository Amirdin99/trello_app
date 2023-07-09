import 'package:flutter/material.dart';
import 'package:trello_app/repository/user_repository.dart';
import 'package:trello_app/ui/task_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _nameController=TextEditingController();
  final TextEditingController _passwordController=TextEditingController();
  Future<void> login()async {
   await UserRepository.getInstance().login("jhonhanks@gmail.com", "aA1234567");
  }
  @override
  void initState() {
    login();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Login",style: TextStyle(
          color: Colors.black,
          fontSize: 16
        ),),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 20,right: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                
                decoration:  InputDecoration(
                  label: Text("Name"),
                  hintText: "Name",
                  border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(20.0),
            borderSide: new BorderSide(),
          ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _passwordController,

                decoration:  InputDecoration(
                  label: Text("Password"),
                  hintText: "Password",
                  border: new OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(20.0),
                    borderSide: new BorderSide(),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: (){

                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>TaskScreen()));

              }, child: Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}
