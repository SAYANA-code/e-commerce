import 'package:calculator/contact.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Contact> contacts = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  Future<void> add() async {
    final prefs = await SharedPreferences.getInstance();

    contacts.add(
      Contact(name: nameController.text, number: numberController.text),
    );
    setState(() {});
    prefs.setInt("index", contacts.length);
    for (int i = 0; i < contacts.length; i++) {
      prefs.setStringList("$i", [
        contacts[i].name.toString(),
        contacts[i].number.toString(),
      ]);
      print(contacts[i].name.toString());
      print(contacts[i].number.toString());
    }
  }

  Future<void> displayCache() async {
    final prefs = await SharedPreferences.getInstance();
    int? index = prefs.getInt("index");
    for (int i = 0; i < index!; i++) {
      List<String>? ls = prefs.getStringList("$i");
      contacts.add(Contact(name: ls![0], number: ls![1]));
      print(contacts[i].name.toString());
      print(contacts[i].number.toString());
    }
    setState(() {});
  }

  Future<void> delete(int index) async {
    //contacts.remove(index);

    contacts.removeAt(index);
    setState(() {});
    for (var element in contacts) {
      print(element.name);
      print(element.number);
    }
  }

  int newIndex = -1;

  void edit(int index) {
    newIndex = index;
    nameController.text = contacts[index].name.toString();
    numberController.text = contacts[index].number.toString();
    update(index);
  }

  void update(int index) {
    contacts[index].name = nameController.text;
    contacts[index].number = numberController.text;
    setState(() {});
  }

  void clearAll() {
    contacts.clear();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    displayCache();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Contact List",
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purple,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 2,
                      color: Colors.grey,
                    ),
                  ],
                ),
                child: TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Contact Name:",
                    label: Text("Enter name..."),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 2,
                      color: Colors.grey,
                    ),
                  ],
                ),
                child: TextField(
                  controller: numberController,
                  decoration: InputDecoration(
                    hintText: "Contact Number",
                    label: Text("Enter phone number..."),
                    border: InputBorder.none,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      add();
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Save",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => update(newIndex),
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 10,
                      ),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "Update",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 500,
                child: ListView.builder(
                  itemCount: contacts.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: Icon(Icons.person),
                        title: Text(contacts[index].name.toString()),
                        subtitle: Text(contacts[index].number.toString()),
                        trailing: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () => edit(index),
                              child: Icon(Icons.edit),
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              onTap: () => delete(index),
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => clearAll(),
                child: Icon(Icons.clear_rounded, color: Colors.red, size: 26),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
