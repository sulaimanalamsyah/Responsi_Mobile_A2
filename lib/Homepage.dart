import 'package:flutter/material.dart';
import 'ModelIkan.dart';
import 'APIServices.dart';
import 'FormIkan.dart';

class DaftarIkanScreen extends StatefulWidget {
  @override
  _DaftarIkanScreenState createState() => _DaftarIkanScreenState();
}

class _DaftarIkanScreenState extends State<DaftarIkanScreen> {
  final IkanService _ikanService = IkanService();
  late List<Ikan> _ikanList;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshIkanList();
  }

  void _refreshIkanList() {
    _ikanService.getIkanList().then((ikanList) {
      setState(() {
        _ikanList = ikanList;
      });
    });
  }

  void _searchIkanById(String id) {
    List<Ikan> searchResults = _ikanList
        .where((ikan) => ikan.id.toLowerCase().contains(id.toLowerCase()))
        .toList();

    setState(() {
      _ikanList = searchResults;
    });
  }

  void _resetSearch() {
    _searchController.clear();
    _refreshIkanList();
  }

  void _showDetailDialog(Ikan ikan) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          elevation: 0,
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  ikan.nama,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${ikan.jenis}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '${ikan.warna}',
                  style: TextStyle(fontSize: 14),
                ),
                Text(
                  '${ikan.habitat}',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit, size: 24),
                      onPressed: () {
                        Navigator.of(context).pop();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FormIkanScreen(ikan: ikan),
                          ),
                        ).then((_) {
                          _refreshIkanList();
                        });
                      },
                    ),
                    SizedBox(width: 20),
                    IconButton(
                      icon: Icon(Icons.delete, size: 24),
                      onPressed: () {
                        _showDeleteConfirmationDialog(ikan.id);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showDeleteConfirmationDialog(String id) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hapus Iwak'),
          content: Text('Yakin mau hapus iwak?'),
          actions: <Widget>[
            TextButton(
              child: Text('Tidak Jadi'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hapus'),
              onPressed: () {
                _ikanService.deleteIkan(id).then((result) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  _refreshIkanList();
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Iwak'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Cari Iwak Berdasar ID',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchIkanById(_searchController.text);
                  },
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.undo, size: 24),
                onPressed: _resetSearch,
              ),
              SizedBox(width: 16),
              IconButton(
                icon: Icon(Icons.refresh, size: 24),
                onPressed: _refreshIkanList,
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _ikanList.length,
              itemBuilder: (context, index) {
                Ikan ikan = _ikanList[index];
                return ListTile(
                  title: Text(ikan.nama),
                  subtitle: Text('ID: ${ikan.id}'),
                  onTap: () {
                    _showDetailDialog(ikan);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormIkanScreen(),
            ),
          ).then((_) {
            _refreshIkanList();
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
