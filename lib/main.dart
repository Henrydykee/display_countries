import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter/services.dart';
import 'dart:convert';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var data = await parseCountriesJson("assets/Untitled.json");
  runApp(
    MaterialApp(
      home: CountryListView(data: data),
    ),
  );
}

Future<Map<String, dynamic>> parseCountriesJson(String filename) async {
  // Read the contents of the file as a string
  var jsonString = await rootBundle.loadString(filename);

  // Use the `jsonDecode` function from the `dart:convert` library to
  // convert the JSON string into a `Map<String, dynamic>` object
  return jsonDecode(jsonString);
}

class CountryListView extends StatelessWidget {
  final Map<String, dynamic> data;

  const CountryListView({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Country List'),
      ),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          var countryCode = data.keys.elementAt(index);
          return ListTile(
            title: GestureDetector(
              onTap: (){
                // Get the list of document types for the selected country
                var documentTypes = data[countryCode]["documentTypes"];
                // Show the document types in a new screen
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => DocumentTypeListView(documentTypes: documentTypes)));
              },
                child: Text(data[countryCode]["description"])),
          );
        },
      ),
    );
  }
}


class DocumentTypeListView extends StatelessWidget {
  final List<dynamic> documentTypes;

  const DocumentTypeListView({ required this.documentTypes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Document Types'),
      ),
      body: ListView.builder(
        itemCount: documentTypes.length,
        itemBuilder: (context, index) {
          var documentType = documentTypes[index];
          return ListTile(
            title: Text(documentType["type"]),
            subtitle: Text('Facial recognition: ${documentType["facialRecognition"]}'),
          );
        },
      ),
    );
  }
}




