import 'package:flutter/material.dart';
import 'ModelIkan.dart';
import 'APIServices.dart';

class FormIkanScreen extends StatefulWidget {
  final Ikan? ikan;

  FormIkanScreen({this.ikan});

  @override
  _FormIkanScreenState createState() => _FormIkanScreenState();
}

class _FormIkanScreenState extends State<FormIkanScreen> {
  final IkanService _ikanService = IkanService();
  late TextEditingController _namaController;
  late TextEditingController _jenisController;
  late TextEditingController _warnaController;
  late TextEditingController _habitatController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.ikan?.nama ?? '');
    _jenisController = TextEditingController(text: widget.ikan?.jenis ?? '');
    _warnaController = TextEditingController(text: widget.ikan?.warna ?? '');
    _habitatController =
        TextEditingController(text: widget.ikan?.habitat ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.ikan == null ? 'Iwak' : 'Iwak lagi'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _namaController,
              decoration: InputDecoration(labelText: 'Nama Iwak'),
            ),
            TextFormField(
              controller: _jenisController,
              decoration: InputDecoration(labelText: 'Tipe Iwak'),
            ),
            TextFormField(
              controller: _warnaController,
              decoration: InputDecoration(labelText: 'Warna Iwak'),
            ),
            TextFormField(
              controller: _habitatController,
              decoration: InputDecoration(labelText: 'Habitat Iwak'),
            ),
            Center(
              child: TextButton(
                onPressed: () {
                  final ikan = Ikan(
                    id: widget.ikan?.id ?? '',
                    nama: _namaController.text,
                    jenis: _jenisController.text,
                    warna: _warnaController.text,
                    habitat: _habitatController.text,
                  );

                  if (widget.ikan == null) {
                    _ikanService.addIkan(ikan).then((_) {
                      Navigator.of(context).pop();
                    });
                  } else {
                    _ikanService.updateIkan(ikan.id, ikan).then((_) {
                      Navigator.of(context).pop();
                    });
                  }
                },
                child: Icon(Icons.save),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
