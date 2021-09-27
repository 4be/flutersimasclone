# Flutter Boilerplate

Flutter Boilerplate using BLoC state management

## How to run

0. [Fork](https://docs.gitlab.com/ee/user/project/repository/forking_workflow.html) repository ini dan [clone](https://learn.hibbittsdesign.org/gitlab-githubdesktop/cloning-a-gitlab-repo) ke mesin lokal Anda
1. Untuk menjalankan flutter, silakan membaca dokumentasi pada [laman ini](https://flutter.dev/docs/get-started/install) dari bagian Install sampai Set Up an Editor.
2. Jalankan command `flutter pub get` untuk menginstall semua dependensi yang dibutuhkan project ini
3. Untuk menjalankan project ini, silakan membaca dokumentasi pada [laman ini](https://flutter.dev/docs/get-started/test-drive) (lewati bagian Create the App)

## Menggunakan project ini sebagai starter codebase untuk project Anda

1. Untuk mengubah nama project sesuai dengan nama project Anda, gunakan [package](https://pub.dev/packages/rename) berikut.

## Dependencies 

Boilerplate ini menggunakan beberapa library sebagai berikut:
1. [bloc](https://pub.dev/packages/bloc) untuk state management
2. [flutter_bloc](https://pub.dev/packages/flutter_bloc) untuk helper widgets dalam menggunakan BLoC
3. [bloc_test](https://pub.dev/packages/bloc_test) untuk testing BLoC
4. [Hive](https://pub.dev/packages/hive) untuk local database
5. [json_serializable](https://pub.dev/packages/json_serializable) untuk parsing JSON to object.

Silakan merujuk pada dokumentasi tiap library di atas untuk memahami penggunaannya.

### Read More 

1. BLoC
- [Getting Started with the Flutter Bloc](https://bloclibrary.dev/#/gettingstarted)
- [Architect your Flutter project using BLOC pattern](https://medium.com/flutterpub/architecting-your-flutter-project-bd04e144a8f1) 
- [Keep it Simple, State: Architecture for Flutter Apps](https://www.youtube.com/watch?v=zKXz3pUkw9A) 
- [Flutter BLoC Pattern for Dummies Like Me](https://medium.com/flutter-community/flutter-bloc-pattern-for-dummies-like-me-c22d40f05a56)
- [Getting Started With Flutter BLoC](https://dev.to/netguru/getting-started-with-flutter-bloc-1pkm)
2. Hive
- [Hive Docs](https://docs.hivedb.dev/#/)

## Deployment / Distribusi aplikasi
Berikut adalah tahapan distribusi aplikasi menggunakan AppCenter
### Membuat akun dan organisasi di AppCenter
1. Masuk / Buat akun di [AppCenter](https://appcenter.ms)
2. Agar dapat berkolaborasi, buat Organization baru dengan memilih ***Add New -> Add New Organization***. Organisasi cukup dibuat satu orang saja untuk per group.
3. Invite seluruh anggota kelompok ke organisasi yang baru saja di buat dengan memilih ***Invite Collaborators*** pada halaman Organisasi yang dibuat pada point 2

### Membuat project baru di AppCenter
1. Pada halaman organization, pilih ***Add New App***. Masukkan nama aplikasi, dan sesuaikan konfigurasi seperti pada gambar berikut (Sesuaikan release type (staging/production)) ![](readme/add_new_app.PNG)

### Memisahkan environment staging dan production
Untuk memisahkan aplikasi pada tahap staging dan production, silakan lakukan tahap Membuat Project Baru di AppCenter 2 kali (Staging dan Production)

### Upload file .apk ke AppCenter
1. Pada halaman project, pilih menu ***Release*** dan pilih ***New Release***


