import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataFetcherWidget extends StatefulWidget {
  final String userEmail;

  DataFetcherWidget(this.userEmail);

  @override
  _DataFetcherWidgetState createState() => _DataFetcherWidgetState();
}

class _DataFetcherWidgetState extends State<DataFetcherWidget> {
  List<DocumentSnapshot> documents = [];
  List<DocumentSnapshot> filteredDocuments = [];
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: widget.userEmail)
        .get();

    setState(() {
      documents = querySnapshot.docs;
      filteredDocuments = documents;
    });
  }

  void searchList() {
    String query = searchController.text;
    setState(() {
      filteredDocuments = documents
          .where((doc) =>
      doc.get('title').toString().toLowerCase().contains(query.toLowerCase()) ||
          doc.get('description').toString().toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Future<void> deleteDocument(String documentId) async {
    await FirebaseFirestore.instance.collection('users').doc(documentId).delete();
    fetchData();
  }

  void navigateToEditScreen(DocumentSnapshot document) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(document: document),
      ),
    ).then((value) {
      if (value == true) {
        fetchData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previously saved tasks'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: searchList,
                  child: Text('Search'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDocuments.length,
              itemBuilder: (context, index) {
                var document = filteredDocuments[index];
                var documentId = document.id;
                var fieldValue1 = document.get('title');
                var fieldValue2 = document.get('description');
                return Column(
                  children: [
                    Text(
                      fieldValue1 ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      fieldValue2 ?? '',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            navigateToEditScreen(document);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete Entry'),
                                  content: Text('Are you sure you want to delete this entry?'),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Delete'),
                                      onPressed: () {
                                        deleteDocument(documentId);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    Divider(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class EditScreen extends StatefulWidget {
  final DocumentSnapshot document;

  EditScreen({required this.document});

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.document.get('title') ?? '';
    descriptionController.text = widget.document.get('description') ?? '';
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void updateDocument() async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.document.id)
        .update({
      'title': titleController.text,
      'description': descriptionController.text,
    });

    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: titleController,
            ),
            SizedBox(height: 16.0),
            Text(
              'Description:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: descriptionController,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: updateDocument,
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
