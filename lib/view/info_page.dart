import 'package:flutter/material.dart';
import 'package:bluetooth_printer/view/home_page.dart';
import 'package:bluetooth_printer/Models/Bilgiler.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  TextEditingController tfAdet = TextEditingController();
  TextEditingController tfUrun = TextEditingController();
  TextEditingController tfTutar = TextEditingController();

  List<Bilgiler> bilgiListesi = [];

  @override
  Widget build(BuildContext context) {
    double genislik=MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Yazdırmaya Gönder", style: TextStyle(fontSize: 25, color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            SizedBox(
              width: 100,
              child: TextField(
                controller: tfAdet,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "adet/kg",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextField(
                controller: tfUrun,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "ürün",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: TextField(
                controller: tfTutar,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "tutar",
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ]),
          SizedBox(height: 30),
          SizedBox(height: 50,width: genislik/2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                double adet = double.tryParse(tfAdet.text) ?? 0;
                String urun = tfUrun.text;
                double tutar = double.tryParse(tfTutar.text) ?? 0;
                double toplam = adet * tutar;

                Bilgiler bilgi = Bilgiler(
                  Adet: adet,
                  Urun: urun,
                  Tutar: tutar,
                  Toplam: toplam,
                  tumToplam: 0,
                );

                setState(() {
                  bilgiListesi.add(bilgi);
                });

                tfAdet.clear();
                tfUrun.clear();
                tfTutar.clear();
              },
              child: Text("Ekle", style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(height: 50,width: genislik/2,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                if (bilgiListesi.isNotEmpty) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(bilgiListesi: bilgiListesi),
                    ),
                  );
                }
              },
              child: Text("Gönder", style: TextStyle(fontSize: 20, color: Colors.white)),
            ),
          )
        ]),
      ),
    );
  }
}
