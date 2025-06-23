import 'package:bluetooth_printer/Models/Bilgiler.dart';
import 'package:bluetooth_printer/view/info_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart';

class HomeScreen extends StatefulWidget {
  final List<Bilgiler> bilgiListesi;

  const HomeScreen({super.key, required this.bilgiListesi});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ReceiptController? controller;

  @override
  Widget build(BuildContext context) {
    double yukseklik = MediaQuery.of(context).size.height;
    double toplamTutar = widget.bilgiListesi.fold(0, (sum, b) => sum + b.Toplam);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const InfoPage()),
            );
          },
          icon: Icon(Icons.arrow_back,color: Colors.white,size: 25,),
        ),
        backgroundColor: Colors.red,
        title: Text("Bluetooth Yazıcı", style: TextStyle(color: Colors.white, fontSize: 25)),
      ),
      body: Receipt(
        backgroundColor: Colors.grey,
        builder: (context) => SizedBox(
          height: yukseklik / 1.5,
          width: 400,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FATURA', style: TextStyle(fontSize: 20)),
              Text("Şanlıurfa, Haliliye", style: TextStyle(fontSize: 15)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text("adet/kg", style: TextStyle(fontSize: 18)),
                  Text("ürün", style: TextStyle(fontSize: 18)),
                  Text("tutar", style: TextStyle(fontSize: 18)),
                  Text("toplam", style: TextStyle(fontSize: 18)),
                ],
              ),
              Text("---------------------"),
              ...widget.bilgiListesi.map((b) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${b.Adet}", style: TextStyle(fontSize: 18)),
                    Text("${b.Urun}", style: TextStyle(fontSize: 18)),
                    Text("${b.Tutar}", style: TextStyle(fontSize: 18)),
                    Text("${b.Toplam}", style: TextStyle(fontSize: 18)),
                  ],
                );
              }).toList(),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Toplam     :     ", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  Text("$toplamTutar TL", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        onInitialized: (controller) {
          this.controller = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final adres = await FlutterBluetoothPrinter.selectDevice(context);
          if (adres != null) {
            await controller?.print(address: adres.address, keepConnected: true, addFeeds: 4);
          } else {
            print("failed printing");
          }
        },
        child: Icon(Icons.print),
      ),
    );
  }
}
