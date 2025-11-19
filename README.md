# THUNDR clubs
_Bring the Energy of Lightning to your Match_

Nama      : Jessica Tandra  
NPM       : 2406355445  
Kelas     : PBP B  

## Archive Tugas
- [Tugas 7 PBP 2025/2026](https://github.com/newjeasnz/thundr-clubs-mobile/wiki/Tugas-7-%E2%80%90-PBP-2025-2026)
- [Tugas 8 - PBP 2025/2026](https://github.com/newjeasnz/thundr-clubs-mobile/wiki/Tugas-8-%E2%80%90-PBP-2025-2026)

---

# Tugas 9 - PBP 2025/2026
## 1.  Jelaskan mengapa kita perlu membuat model Dart saat mengambil/mengirim data JSON? Apa konsekuensinya jika langsung memetakan `Map<String, dynamic>` tanpa model (terkait validasi tipe, null-safety, maintainability)?
Kita perlu membuat Model Dart (class) karena Dart adalah bahasa yang strongly-typed, sedangkan JSON bersifat tidak terstruktur (loose). Model berfungsi sebagai cetakan (skema) untuk mengubah data JSON menjadi objek Dart yang aman. Jika kita langsung memetakan `Map<String, dynamic>` tanpa model, maka:
- **Type Safety**: Rawan runtime error (aplikasi crash) karena tidak ada jaminan tipe data saat compile time.
- **Maintainability**: Sulit di-refactor. Jika nama field berubah di backend, kamu harus mencari dan mengganti string key manual di seluruh aplikasi.
- **Null-Safety**: Sulit menerapkan aturan null-safety secara ketat dan rawan runtime error akibat data null yang tidak terduga.
- **Developer Experience**: Tidak ada IntelliSense (autocomplete) untuk nama field data

## 2.   Apa fungsi package http dan CookieRequest dalam tugas ini? Jelaskan perbedaan peran http vs CookieRequest
1. Package **http** digunakan untuk:
- Melakukan HTTP Request: Mengirim request (GET, POST, PUT, DELETE) ke server. Fungsinya murni untuk mengirim dan menerima data lewat protokol HTTP. Secara default, http bersifat stateless, artinya ia tidak menyimpan informasi apa pun (seperti cookie) di antara request yang berbeda.
- Mengambil Data dari API: Mendapatkan respons dalam bentuk JSON atau format lain.

2. **CookieRequest** merupakan bagian dari package `pbp_django_auth`, ini merupakan wrapper atau lapisan tambahan di atas package http. Fungsinya khusus untuk menangani autentikasi berbasis session dengan Django.

## 3. Jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
Instance CookieRequest harus dibagikan (biasanya menggunakan Provider) karena ia menyimpan state login (cookie/session data) pengguna.

Jika kita membuat instance CookieRequest baru di setiap halaman (Page/Widget):
1. Instance baru tersebut masih "kosong" (belum punya cookie).
2. Server akan menganggap kamu adalah pengguna baru yang belum login.
3. Akibatnya, fitur yang butuh login (seperti logout atau tambah item) akan gagal karena dianggap unauthorized.

Dengan membagikan satu instance yang sama (_Single Source of Truth_) ke seluruh aplikasi, cookie yang didapat saat Login Page tersimpan di instance tersebut dan bisa dipakai ulang oleh Home Page, Detail Page, dan lain-lain, menjaga sesi login tetap aktif.

## 4.   Jelaskan konfigurasi konektivitas yang diperlukan agar Flutter dapat berkomunikasi dengan Django. Mengapa kita perlu menambahkan 10.0.2.2 pada ALLOWED_HOSTS, mengaktifkan CORS dan pengaturan SameSite/cookie, dan menambahkan izin akses internet di Android? Apa yang akan terjadi jika konfigurasi tersebut tidak dilakukan dengan benar?
### Konfigurasi di jaringan (Django)
1. 10.0.2.2 di ALLOWED_HOSTS
10.0.2.2 adalah alamat IP khusus yang digunakan oleh Android Emulator untuk merujuk ke mesin host (laptop) tempat server Django berjalan. Kita harus memasukkannya ke dalam ALLOWED_HOSTS di settings.py Django. Tanpa konfigurasi ini, Django akan menganggap permintaan dari emulator sebagai permintaan dari host yang tidak diizinkan dan akan menolak koneksi dengan error 400 Bad Request.

2. Mengaktifkan CORS
CORS (_Cross-Origin Resource Sharing_) harus diaktifkan (misalnya menggunakan package `django-cors-headers`). Flutter, saat berjalan, dianggap sebagai "Origin" yang berbeda dari server Django (berbeda port atau lingkungan). Secara default, Django akan memblokir permintaan lintas origin untuk alasan keamanan, sehingga menyebabkan CORS Policy Blocked.

3. Pengaturan Cookie (SameSite)
Pengaturan ini memastikan session cookie yang dikirim Django saat login dapat disimpan dan dikirim kembali oleh `CookieRequest` Flutter. Jika gagal, request terautentikasi berikutnya akan gagal dengan 403 Forbidden karena sesi tidak dipertahankan.

### Izin Aplikasi (Flutter/Android)
Di file AndroidManifest.xml (Flutter), harus ditambahkan permission untuk mengakses internet: `<uses-permission android:name="android.permission.INTERNET"/>`. Hal ini dilakukan karena sistem operasi Android memerlukan deklarasi eksplisit untuk izin akses jaringan. Tanpa izin ini, aplikasi Flutter tidak akan dapat melakukan request HTTP apa pun dan akan gagal total saat mencoba terhubung ke Django.

Jika konfigurasi yang sudah disebutkan di atas tidak dilakukan dengan benar, koneksi antara Flutter dan Django akan terputus, menyebabkan kegagalan otentikasi (403), kegagalan koneksi (Network Error), atau kegagalan host (400 Bad Request).

## 5. Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
1. **Input data & Serialisasi (Flutter)**: Pengguna mengisi data di Form. Saat tombol ditekan, data input dikonversi menjadi format JSON (String).
2. **Pengiriman (Network)**: CookieRequest (atau http) mengirimkan data JSON tersebut ke Server Django melalui HTTP POST Request.
3. **Proses Backend (Django)**: Server menerima request, memvalidasi data, menyimpannya ke database, dan mengembalikan respon status (biasanya JSON success/error).
4. **Pengambilan Data (Network)**: Untuk menampilkan data, Flutter melakukan HTTP GET Request ke endpoint JSON Django.
5. **Deserialisasi (Flutter)**: Respon JSON dari server diterima, lalu dikonversi ("di-parse") menjadi objek Dart menggunakan Model (method fromJson).
6. **Rendering (Flutter)**: Objek Dart tersebut dimasukkan ke dalam widget, dan flutter akan me-render tampilan list data ke layar pengguna.

## 6. Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
#### Proses Register
1. **Input**: Pengguna mengisi username dan password di Form Flutter.
2. **Request**: Flutter mengirim data via HTTP POST ke endpoint Django (misal: /register/).
3. **Backend**: Django memvalidasi data (menggunakan UserCreationForm) dan membuat objek User baru di database.
4. **Response**: Django mengembalikan status sukses (JSON). Flutter menerima respon dan mengarahkan pengguna ke halaman Login.

#### Proses Login
1. **Input**: Pengguna mengisi kredensial di Form Login Flutter.
2. **Request**: CookieRequest mengirim HTTP POST ke endpoint login Django.
3. **Backend**: Django memverifikasi kredensial (auth.authenticate). Jika valid, Django membuat Session di server dan mengirimkan Session ID lewat header cookie dalam response.
4. **Client State**: CookieRequest di Flutter menerima dan menyimpan cookie tersebut secara lokal.
5. **UI Update**: Status loggedIn berubah menjadi true, dan Flutter menavigasi (push) layar ke Menu Utama/Home.

#### Proses Logout
1. **Request**: Pengguna menekan tombol Logout. CookieRequest mengirim request ke endpoint logout Django.
2. **Backend**: Django menghapus data sesi pengguna tersebut (auth.logout) di server.
3. **Client State**: CookieRequest menghapus cookie/session yang tersimpan di memori lokal Flutter.
4. **UI Update**: Flutter mengembalikan pengguna ke halaman Login.

## 7. Jelaskan bagaimana cara mengimplementasikan checklist di atas secara step-by-step
### Mengimplementasikan fitur registrasi akun pada proyek tugas Flutter.
1. Membuat sebuah view baru di project django
2. Membuat stateful page pada umumnya
3. Membuat form yang berisi input username, password, dan konfirmasi password
4. Membuat logic button registrasi
```dart
 final response = await request.postJson(
  "http://https://jessica-tandra-thundrclubs.pbp.cs.ui.ac.id//auth/register/",
  jsonEncode({
    "username": username,
    "password1": password1,
    "password2": password2,
  }));
```
5. Jika registrasi berhasil maka pengguna akan diarahkan ke login page
```dart
     Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => const LoginPage()),
  );
```

### Membuat halaman login pada proyek tugas Flutter.
1. Membuat view baru di Project Django
``` dart
   @csrf_exempt
   def login(request):
       username = request.POST['username']
       password = request.POST['password']
       user = authenticate(username=username, password=password)
```
2. Membuat stateful page pada umumnya
3. Membuat form yang berisi username dan password
4. Membuat logic button login
```dart
   ElevatedButton(
     onPressed: () async {
       String username = _usernameController.text;
       String password = _passwordController.text;

       final response = await request
           .login("http://jessica-tandra-thundrclubs.pbp.cs.ui.ac.id/auth/login/", {
         'username': username,
         'password': password,
       });
     }
   )
...
// Mengarahkan user ke home page jika sudah login
if (context.mounted) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => const MyHomePage()),
  );
}
   
```

### Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.
1. Membuat view login, logout, dan registrasi
2. Memanggil endpoints melalui request di Flutter
3. Memproses output JSON

### Membuat model kustom sesuai dengan proyek aplikasi Django.
1. Mengecek konten dari localhost:8000/json
2. Menggenerate model dart dengan bantuan website Quicktype
3. Membuat file baru bernama product_entry.dart untuk meletakan model yang telah digenerate sebelumnya

### Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON
1. Membuat page stateful pada umumnya
2. Membuat function untuk melakukan fetching json
3. Menggunakan Future Builder pada body dari Scaffold

### Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.
1. Membuat sebuah stateful page pada umumnya
2. Menyatakan variabel-variabel yang menjadi atribut dari page detail (misalnya Uuid, price, description, dll)
3. Menghandle jika card product di klik di halaman list product


### Melakukan filter pada halaman daftar item dengan hanya menampilkan item yang terasosiasi dengan pengguna yang login.
Filter berdasarkan pengguna telah dihandle melalui view json di projek django yaitu:
```dart
   ...
    data = Product.objects.filter(user=request.user)
   ...
```
