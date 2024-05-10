import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

Future<List<Map>> getRiwayatPompa() async {
  List<Map> listRiwayatPompa = [];

  List<String> tanggal = [];
  List<String> waktu = [];
  List<String> nilaiKelembaban = [];

  // Mendapatkan referensi ke koleksi "riwayat_kelembaban"
  CollectionReference data =
      FirebaseFirestore.instance.collection('riwayat_pompa');

  // Mendapatkan data dari koleksi "riwayat_kelembaban"
  QuerySnapshot querySnapshot =
      await data.orderBy('waktu', descending: true).get();

  // Looping untuk mendapatkan data setiap dokumen pada querySnapshot
  querySnapshot.docs.forEach((doc) {
    Map riwayatSatuPompa = {};
    var waktu = DateTime.fromMillisecondsSinceEpoch(
        doc['waktu'].millisecondsSinceEpoch);

    String formattedDate = DateFormat('dd-MM-yyyy').format(waktu);

    // Menggunakan DateFormat untuk memformat waktu
    String formattedTime = DateFormat('HH:mm').format(waktu);

    var banyakAir = '${doc['banyak_air']}';
    var keterangan = '${doc['keterangan']}';

    riwayatSatuPompa["tanggal"] = formattedDate;
    riwayatSatuPompa["jam"] = formattedTime;
    riwayatSatuPompa["banyak_air"] = banyakAir;
    riwayatSatuPompa["keterangan"] = keterangan;
    listRiwayatPompa.add(riwayatSatuPompa);
  });

  return listRiwayatPompa;
}
