# THUNDR clubs
_Bring the Energy of Lightning to your Match_

Nama      : Jessica Tandra  
NPM       : 2406355445  
Kelas     : PBP B  

## Archive Tugas
- [Tugas 7 PBP 2025/2026](https://github.com/newjeasnz/thundr-clubs-mobile/wiki/Tugas-7-%E2%80%90-PBP-2025-2026)

---

# Tugas 8 - PBP 2025/2026
## 1.  Jelaskan perbedaan antara `Navigator.push()` dan `Navigator.pushReplacement()` pada Flutter. Dalam kasus apa sebaiknya masing-masing digunakan pada aplikasi Football Shop kamu?
`Navigator.push()` digunakan untuk menambahkan halaman baru ke atas stack navigasi.
Artinya, halaman sebelumnya tetap ada di bawah halaman baru, sehingga kita bisa kembali ke halaman sebelumnya dengan tombol back.
Contoh alurnya:
Home -> ProductForm -> (back) -> Home

Sedangkan `Navigator.pushReplacement()` akan mengganti halaman saat ini dengan halaman baru.
Halaman sebelumnya dihapus dari stack, sehingga tidak bisa kembali ke halaman sebelumnya dengan back.

Contoh alurnya:
Home -> ProductForm, dan tombol back tidak akan mengembalikan ke Home lagi.

`Navigator.push()` → Dipakai ketika user ingin kembali ke halaman sebelumnya
Contoh pengaplikasian:
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const ProductFormPage()),
);
```
Ini digunakan ketika user menekan button Create Products melalui menu utama pada halaman utama aplikasi. Halaman ProductFormPage berfungsi sebagai halaman tambahan sementara (sub-page), sehingga setelah user selesai membuat produk dan menekan back, user akan kembali ke halaman sebelumnya (main page).

`Navigator.pushReplacement()` → Dipakai ketika user berpindah halaman utama lewat Drawer
```dart
Navigator.pushReplacement(
  context,
  MaterialPageRoute(builder: (context) => MyHomePage()),
);
```
Pada Drawer, navigasi yang terjadi adalah perpindahan antar halaman utama seperti Home dan Add Product. Dalam konteks ini, halaman sebelumnya tidak perlu disimpan lagi dalam stack, karena user memang bermaksud berpindah halaman, bukan kembali.


## 2.  Bagaimana kamu memanfaatkan **hierarchy widget** seperti `Scaffold`, `AppBar`, dan `Drawer` untuk membangun struktur halaman yang konsisten di seluruh aplikasi?
1. **Scaffold** berfungsi sebagai kerangka dasar (layout structure) bagi setiap halaman.
Dengan `Scaffold`, tiap halaman memiliki tempat yang pasti untuk AppBar, body, Drawer, dan Floating Action Button bila diperlukan.
contoh:
```dart
Scaffold(
  appBar: AppBar(...),
  drawer: LeftDrawer(),
  body: ...
)
```
Dengan cara ini, setiap halaman selalu punya struktur yang sama, sehingga pengguna merasa navigasinya stabil dan mudah dipahami.

2. **AppBar** berperan sebagai penanda konteks halaman.
Setiap halaman memiliki judul yang konsisten di bagian atas, sehingga pengguna selalu tahu sedang berada di halaman apa.
Contoh:
```dart
appBar: AppBar(
  title: const Text("Thundr Clubs"),
  backgroundColor: theme.colorScheme.primary,
  foregroundColor: Colors.white,
),
```
Hal ini memperkuat brand identity sekaligus menjaga konsistensi visual.

3. **Drawer** digunakan untuk navigasi utama antar halaman penting (Home, Add Product, My Products, dst). Dengan memusatkan navigasi di Drawer, user tidak perlu menghafal tombol atau berpindah secara manual. Semua akses halaman utama ada di satu tempat.
```dart
drawer: LeftDrawer(),
```

Di dalam LeftDrawer, setiap item navigasi menggunakan Navigator.pushReplacement() supaya perpindahan halaman terasa sebagai perpindahan utama, bukan “membuka halaman tambahan”.

## 3. Dalam konteks desain antarmuka, apa kelebihan menggunakan layout widget seperti `Padding`, `SingleChildScrollView`, dan `ListView` saat menampilkan elemen-elemen form? Berikan contoh penggunaannya dari aplikasi kamu.
1. **Padding** digunakan untuk memberi jarak antar elemen UI supaya form tidak terlihat sempit atau terlalu mepet ke tepi layar. Dengan adanya ruang ini, teks lebih mudah dibaca dan input terasa lebih nyaman untuk diisi. Contoh:
```dart
Padding(
  padding: const EdgeInsets.all(8.0),
  child: TextFormField(
    decoration: InputDecoration(
      labelText: "Product Name",
      border: OutlineInputBorder(),
    ),
  ),
),
```

2. **SingleChildScrollView** mencegah tampilan form menjadi overflow ketika konten form tinggi atau ketika keyboard muncul. Widget ini memungkinkan pengguna meng-scroll halaman, sehingga seluruh elemen form tetap dapat diakses. Contoh pada halaman Product Form:
```dart
body: Form(
  key: _formKey,
  child: SingleChildScrollView(
    child: Column(
      children: [
        ...
      ],
    ),
  ),
),
```

3. **ListView** digunakan ketika elemen-elemen form atau list membutuhkan scrolling otomatis dan penataan vertikal yang dinamis. ListView cocok untuk layout yang panjang atau daftar produk, karena ia mengatur jarak antar elemen sekaligus mengaktifkan scroll tanpa perlu wrapper tambahan. ListView memastikan seluruh menu navigasi tetap bisa discroll meskipun layar kecil atau jumlah menu bertambah. Contoh Drawer Navigation:
```dart
Drawer(
  child: ListView(
    children: [
      DrawerHeader(...),
      ListTile(...),
      ListTile(...),
    ],
  ),
),
```


## 4.   Bagaimana kamu menyesuaikan warna tema agar aplikasi Football Shop memiliki identitas visual yang konsisten dengan brand toko?
Untuk menjaga konsistensi tampilan aplikasi, tema global ditentukan melalui `ThemeData` di dalam `MaterialApp`. Dengan cara ini, seluruh widget yang ada di aplikasi akan mengambil referensi warna, font, dan style langsung dari tema tersebut, tanpa harus diatur satu per satu secara manual.
```dart
return MaterialApp(
  theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blue,
    ),
    useMaterial3: true,
  ),
  home: const MyHomePage(),
);
```

Setelah tema ditetapkan, kita bisa menggunakan nilai-nilai warna tersebut secara konsisten di seluruh aplikasi melalui:
```dart
backgroundColor: Theme.of(context).colorScheme.primary,
```

Dengan mendefinisikan tema melalui ThemeData dan memanggilnya lewat `Theme.of(context).colorScheme.primary`, setiap aplikasi memiliki tampilan yang seragam, mudah dirawat, dan konsisten dengan identitas-nya tersendiri.