import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  List<int> counter = [100, 200, 500, 1000];
  int number = 100;
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Setting"),
        centerTitle: true,
        elevation: 10,
        backgroundColor: Colors.grey[800],
        // leading: IconButton(
        //     onPressed: () => Navigator.of(context)
        //         .pushReplacement(MaterialPageRoute(builder: (context) => Home())),
        //     icon: const Icon(Icons.arrow_back_outlined)),
      ),
      backgroundColor: Colors.grey[700],
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text(
                  "Counter Number:",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
                DropdownButtonHideUnderline(
                  child: Container(
                    height: 50,
                    width: 150,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: DropdownButton(
                      items: counter
                          .map((e) => DropdownMenuItem(
                                child: Text("$e"),
                                value: e,
                              ))
                          .toList(),
                      //------------------
                      onChanged: (val) {
                        setState(() {
                          number = val as int;
                        });
                        setData();
                      },
                      //------------------
                      value: number,
                      //------------------
                      borderRadius: BorderRadius.circular(22),
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                      dropdownColor: Colors.grey[800],
                      iconEnabledColor: Colors.white,
                      //------------------
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //------------------------------
  setData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("counter", number);
  }

  //------------------------------
  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      number = prefs.getInt("counter") ?? 100;
    });
  }
  //------------------------------
}
