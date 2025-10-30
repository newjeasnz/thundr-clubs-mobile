# THUNDR clubs
_Bring the Energy of Lightning to your Match_

Nama      : Jessica Tandra  
NPM       : 2406355445  
Kelas     : PBP B  

---

# Tugas 7 - PBP 2025/2026
## 1. Jelaskan apa itu widget tree pada Flutter dan bagaimana hubungan parent-child (induk-anak) bekerja antar widget.
Widget tree adalah struktur hierarki yang menunjukkan bagaimana widget-widget saling tersusun di dalam aplikasi flutter. Setiap tampilan di flutter dibagun dari kumpulan widget, mulai dari widget dengan level paling besar (seperti `MaterialApp` atau `Scaffold`) hingga widget terkecil (seperti `Text`, `Icon`, atau `Padding`).
Struktur ini disebut tree karena setiap widget bisa memiliki satu atau lebih child (anak), dan setiap child juga bisa memiliki child lagi, membentuk hubungan seperti cabang pohon.

Hubungan parent-child dalam hal ini berarti:
- Parent Widget berperan sebagai wadah atau pengatur tata letak (misalnya Column, Row, atau Container).
- Child Widget adalah elemen yang ditempatkan di dalam parent tersebut dan mengikuti aturan tampilan yang ditentukan oleh parent-nya.

Contoh:
```dart
Column(
  children: [
    Text('Hello'),
    Icon(Icons.star),
  ],
)
```
- Column berperan sebagai parent widget
- Text dan Icon adalah child widget
Column mengatur posisi kedua child tersebut agar vertikal di layar.


## 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.
Widget yang digunakan dalam proyek ini yaitu:
- **`MaterialApp`:** Widget utama yang menjadi pembungkus seluruh aplikasi flutter berbasis material design. MaterialApp ini menentukan tema aplikasi dan halaman awal (home).
- **`Scaffold`:** Memberikan struktur dasar dari halaman aplikasi dan menyediakan kerangka tampilan dengan bagian seperti `appBar`, `body`, dan `bottomNavigationBar`.
- **`AppBar`:** Menyediakan bar di bagian atas halaman yang biasanya digunakan untuk judul halaman atau aksi. Dalam proyek ini digunakan untuk menampilkan teks “Thundr Clubs”.
- **`Column`:** Menyusun widget-widget di dalamnya (child) secara **vertikal**. Dipakai untuk menampilkan info pengguna dan grid tombol di halaman utama.
- **`Row`:** Menyusun widget-widget di dalamnya (child) secara **horizontal**. Digunakan untuk menampilkan tiga InfoCard (NPM, Name, Class) sejajar dalam satu baris.
- **`Card`:** Widget dengan efek elevasi (bayangan) dan sudut melingkar, untuk menampilkan konten dalam kotak/kartu yang terpisah.
- **`Container`:** Widget yang bisa digunakan untuk mengatur ukuran, padding, margin, atau warna latar suatu elemen.
- **`Text`:** Digunakan untuk menampilkan tulisan statis dalam aplikasi, seperti judul, label tombol, atau informasi pengguna.
- **`Padding`:** Memberi jarak di sekitar widget agar tidak saling menempel.
- **`GridView`:** Menampilkan item dalam format grid atau tabel dengan jummlah kolom tertentu. Digunakan untuk menampilkan menu item produk dalam tata letak yang rapi (All Products, My Products, dan Create Products).
- **`Icon`:** Menampilkan ikon dari bawaan Flutter (Icons). Contohnya `Icons.shopping_bag_outlined`, `Icons.inventory_2_outlined`, dan `Icons.add_circle_outline`.
- **`Material`:** Memberi efek ink splash (gelombang air) saat widget ditekan. Digunakan di dalam ItemCard agar setiap tombol terlihat interaktif saat diklik.
- **`InkWell`:** Membuat area yang bisa ditekan (tappable) dengan animasi efek sentuhan.
Digunakan untuk menampilkan SnackBar ketika tombol diklik.
- **`SnackBar`:** Widget pesan sementara yang muncul di bagian bawah layar. Dalam proyek ini muncul ketika pengguna menekan salah satu tombol produk.
- **`Center`:** Memposisikan widget anaknya ke tengah.
- **`SizedBox`:** Memberikan jarak vertikal atau horizontal antar widget (misalnya `SizedBox(height: 16.0)`).


## 3. Apa fungsi dari widget `MaterialApp`? Jelaskan mengapa widget ini sering digunakan sebagai widget root.
Widget `MaterialApp` berfungsi sebagai pembungkus utama (root) dari aplikasi Flutter yang menggunakan **Material Design**, yaitu standar desain dari Google.
Widget ini menyediakan pengaturan dasar yang dibutuhkan oleh hampir semua aplikasi Flutter, seperti:
- title → judul aplikasi.
- theme → menentukan warna, gaya teks, dan tema keseluruhan aplikasi.
- home → menentukan halaman utama yang pertama kali ditampilkan.
- routes → mengatur navigasi antar halaman.

`MaterialApp` sering digunakan sebagai widget root karena widget ini menyediakan _context Material_ yang dibutuhkan oleh widget lain seperti `Scaffold`, `AppBar`, `SnackBar`, `FloatingActionButton`, dan berbagai komponen Material lainnya.
Tanpa MaterialApp, banyak widget tersebut tidak dapat berfungsi dengan benar karena tidak memiliki akses ke konfigurasi Material Design (seperti warna tema, efek elevasi, dan gaya tombol).

```dart
return MaterialApp(
  title: 'Thundr Clubs',
  theme: lightningTheme,
  home: MyHomePage(),
);
```
Di sini, MaterialApp menjadi root yang membungkus seluruh aplikasi dan memastikan semua widget di bawahnya mengikuti gaya dan tema yang sama.


## 4.  Jelaskan perbedaan antara `StatelessWidget` dan `StatefulWidget`. Kapan kamu memilih salah satunya?
`StatelessWidget` merupakan jenis widget yang tidak memiliki keadaan (state) dan bersifat tetap selama aplikasi berjalan. Artinya, widget ini hanya dibangun satu kali saat pertama kali dibuat dan tampilannya tidak akan berubah meskipun ada interaksi pengguna. Contohnya, widget seperti Text, Icon, tombol atau Container, yang tidak memerlukan pembaruan data.
Contoh di proyek ini:
`MyHomePage`, `ItemCard`, dan `InfoCard` semuanya adalah StatelessWidget, karena isinya (seperti nama, NPM, dan label tombol) tidak berubah selama aplikasi berjalan.

Sedangkan, `StatefulWidget` adalah jenis widget yang memiliki keadaan (state) dan dapat berubah seiring waktu. Berbeda dengan `StatelessWidget`, widget ini bisa menampilkan data yang diperbarui selama aplikasi berjalan, misalnya karena adanya interaksi pengguna atau perubahan variabel di dalam program.
StatefulWidget terdiri dari dua bagian: kelas widget itu sendiri dan kelas state-nya yang menyimpan data dinamis. Setiap kali data diubah menggunakan setState(), Flutter akan membangun ulang tampilan agar sesuai dengan kondisi terbaru. Widget jenis ini umumnya digunakan untuk elemen yang interaktif, seperti form input, animasi, atau halaman yang menampilkan data yang selalu diperbarui.

Kapan kita memilih antara `StatelessWidget` dan `StatefulWidget`?
- Gunakan `StatelessWidget` jika tampilan hanya menampilkan data tetap.
- Gunakan `StatefulWidget` jika tampilan perlu berubah secara dinamis karena interaksi pengguna atau perubahan data.


## 5. Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana penggunaannya di metode `build`?
BuildContext adalah objek yang merepresentasikan lokasi sebuah widget dalam widget tree. Objek ini digunakan Flutter untuk mengetahui hubungan antarwidget, seperti siapa parent dan child-nya. BuildContext penting karena banyak fungsi Flutter (misalnya `Theme.of(context)`, `Navigator.of(context)`, atau `ScaffoldMessenger.of(context)`) memerlukan konteks ini untuk mengakses data atau widget lain yang berada di atasnya dalam tree.

Dalam metode build, BuildContext digunakan sebagai parameter utama untuk membangun tampilan widget. Melalui konteks tersebut, Flutter tahu di mana widget itu ditempatkan dan dapat mengambil informasi yang relevan, seperti tema, ukuran layar, atau rute navigasi yang aktif.
Dengan kata lain, BuildContext membantu Flutter menjaga agar setiap widget dapat “berkomunikasi” dengan struktur tampilan yang lebih besar secara efisien.


## 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".
**Hot reload** adalah fitur Flutter yang memungkinkan developer melihat perubahan kode secara langsung tanpa kehilangan state (keadaan) aplikasi yang sedang berjalan. Saat file Dart disimpan setelah mengalami perubahan, Flutter hanya memperbarui bagian kode yang berubah dan menyusun ulang widget tree tanpa menjalankan ulang seluruh aplikasi. Fitur ini sangat membantu dalam proses pengembangan interface karena hasil perubahan, seperti warna, teks, atau tata letak, dapat langsung terlihat tanpa menghapus data yang sedang ditampilkan.

Sementara itu, **hot restart** akan memulai ulang aplikasi dari awal, sehingga seluruh state atau variabel yang tersimpan akan hilang. Flutter akan memuat ulang seluruh kode dan membuat instance baru dari semua widget, seolah-olah aplikasi baru dijalankan pertama kali.