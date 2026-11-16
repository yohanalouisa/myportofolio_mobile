Name : Yohana Louisa Saragih  
NPM : 2506584205  
Class : PBP E  
  
### Assignment 7    
  
1. Widget tree adalah beberapa widget yang digabungkan membentuk pohon widget. widget tree dibangun ulang setiap kali status widget berubah atau ketika dihapus dan kemudian ditambahkan kembali. Untuk setiap widget, sebuah elemen dibuat secara bersamaan oleh kerangka kerja flutter. Hubungan parent-child terjadi ketika sebuah widget (parent) membungkus widget lain. Parent menentukan batasan ukuran dan posisi child, sedangkan tema dan data diturunkan dari parent ke child. Widget dengan satu anak memakai `child` (cth:padding), sedangkan yang banyak anak memakai `children` (cth: `Column`).  
    
2. Widget yang digunakan:  
    - `MaterialApp`: root menyediakan tema dan navigasi.  
    - `Scaffold`: kerangka dasar halaman (AppBar, body, SnackBar).  
    - `AppBar`: bar judul di bagian atas.  
    - `Text`: menampilkan text.  
    - `Padding`: jarak sekeliling child.  
    - `Column`: menyusun child secara vertikal.  
    - `Row`: menyusun child secara horizontal.  
    - `InfoCard`: menampilkan NPM, Name, dan Class.  
    - `ItemCard`: tombol aksi berwarna.  
    - `Icon`: icon tombol.  
    - `SnacBar`: pesan singkat saat button ditekan.  
  
3. MaterialApp berfungsi dalam manajemen tema, navigasi dan routing, lokalisasi, identitas aplikasi, dan mengatur konfigurasi global lainnya. Pada aplikasi flutter, MaterialApp sering digunakan sebagai root karena MaterialApp yang menentukan tampilan dan perilaku dasar seluruh aplikasi dengan prinsip Material design.
  
4. StatelessWidget adalah widget yang digunakan penguna untuk membuat aplikasi non-dinamis yang dibentuk dari kombinasi beberapa widget kecil. Sedangkan, StatefulWidget adalah widget yang digunakan penggna untuk membuat aplikasi dinamis. Pada StatefulWidget, ketika framework memanggil metode createElement, sebuah objek state akan dibuat. Saat ingin mengatur nilai data baru atau untuk memperbarui objek state gunakan `setState()`, yang membuat flutter memanggil ulang `build` sehingga tampilan diperbarui. Pilih StatelessWidget jika tampilan statis dan StatefulWidget jika tampilan berubah akibat interaksi atau data.  
  
5. BuildContext adalah objek yang merepresentasikan lokasi sebuah widget di dalam widget tree. BuildContext penting untuk dapat mengakses informasi dari widget induk, seperti tema, ukuran layar. BuildContext diterima sebagai paremeter `build(BuildContext context)`. Contoh : `Theme.of(context)`.     
  
6. Hot Reload adalah fitur di Flutter yang memungkinkan Anda untuk dengan cepat memasukkan perubahan kode ke dalam aplikasi yang sedang berjalan tanpa harus memulai ulang seluruh aplikasi. Hot Restart adalah fitur di Flutter yang memuat ulang aplikasi dari awal. Ini mirip dengan memulai ulang aplikasi sepenuhnya, tetapi melakukannya jauh lebih cepat daripada membangun ulang sepenuhnya. Tidak seperti Hot Reload, Hot Restart menghapus status aplikasi dan memulainya dari keadaan awal. Hot Reload saja tidak cukup dan harus hot restart/full restart ketika mengubah`main()` atau variabel global/static, dll.  
  
```AI Disclosure```  
Pada tugas 7 ini saya tidak menggunakan AI. Tutorial 8 sebagai panduan.  


