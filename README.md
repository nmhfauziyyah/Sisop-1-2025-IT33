# Sisop-1-2025-IT33

#### Nama Anggota
1. Ni'mah Fauziyyah Atok (5027241103)
2. Revalina Erica Permatasari (5027241007)
3. Kaisar Hanif Pratama (5027241029)

### Soal 1 
## Oleh : Kaisar Hanif Pratama
a.) Pada soal 1 bagian a ini, Poppo ingin mencari tahu jumlah buku yang dibaca oleh Chris Hemsworth.

![1a](https://github.com/user-attachments/assets/7a5d085b-d521-4b44-a48a-0d88a4a5f4a2)

Lalu akan memberikan output seperti ini

![3  Hasil 1](https://github.com/user-attachments/assets/195c8d3e-0028-496b-ae26-32c9f9e5eaa3)

b.) Disini Poppo ingin tahu rata-rata durasi membaca menggunakan tablet.

![1b](https://github.com/user-attachments/assets/fd9990a4-40c7-4d63-a04e-69321d7a4479)

Dan outputnya seperti ini

![3  Hasil 2](https://github.com/user-attachments/assets/7d4c905a-8e72-46dc-9df0-46d2e32419d0)

c. Pada bagian c ini Siroyo ingin mencari rating tertinggi buku yang dibaca beserta Nama dan judul bukunya

![1c](https://github.com/user-attachments/assets/f0c9834f-8fe9-4b3e-9ca4-848ac15fc4e6)

Outputnya

![3  Hasil 3](https://github.com/user-attachments/assets/35cb1c3d-d8f8-4beb-8714-8ec5cc0aa824)

d. Siroyo ingin menganalisis data untuk menemukan genre yang paling sering dibaca di Asia setelah 31 Desember 2023 beserta jumlahnya

![1d](https://github.com/user-attachments/assets/a6f141ab-ad3a-4104-98a8-63a8930e6c8c)

Output

![3  Hasil 4](https://github.com/user-attachments/assets/724b1f8f-cbcb-4b98-bd61-efb7b64d54d7)

### Soal 2
## Oleh : Ni'mah Fauziyyah A
## Soal
``
Anda merupakan seorang “Observer”, dari banyak dunia yang dibuat dari ingatan yang berbentuk “fragments” - yang berisi kemungkinan yang dapat terjadi di dunia lain. Namun, akhir-akhir ini terdapat anomali-anomali yang seharusnya tidak terjadi, perpindahan “fragments” di berbagai dunia, yang kemungkinan terjadi dikarenakan seorang “Seeker” yang berubah menjadi “Ascendant”, atau dalam kata lain, “God”. Tidak semua “Observer” menjadi “Player”, tetapi disini anda ditugaskan untuk ikut serta dalam menjaga equilibrium dari dunia-dunia yang terbuat dari “Arcaea”
``
## Jawaban
## A. First Step in a New World
Tugas pertama, dikarenakan kejadian “Axiom of The End” yang semakin mendekat, diperlukan sistem untuk mencatat “Player” aktif agar terpisah dari “Observer”. Buatlah dua **shell script**, **login.sh dan register.sh**, yang dimana database **“Player” disimpan di /data/player.csv**. Untuk register, parameter yang dipakai yaitu email, username, dan password. Untuk login, parameter yang dipakai yaitu **email dan password.**
## Penyelesaian
## Membuat shell script ``register.sh``
```
#!/bin/bash

CSV_FILE="data/player.csv"
echo "Name,Email,Password" > "$CSV_FILE"

echo "==================="
echo " SILAHKAN REGISTER "
echo "==================="
echo ""
echo "Masukkan nama:"
read -r name
echo "Masukkan email:"
read -r email
echo "Masukkan password:"
read -rs password
echo

# Hash password dan simpan
echo "$name,$email,$(echo -n "$password" | sha256sum | awk '{print $1}')" >> "$CSV_FILE"

echo "✅ Registrasi Berhasil!"
```
Program diatas diminta untuk input untuk email, username, dan password. Lalu, data akan disimpan ke dalam file data/player.csv dengan command ```echo "$name,$email,$(echo -n "$password" | sha256sum | awk '{print $1}')" >> "$CSV_FILE"```

## Membuat shell script ``login.sh``
```
#!/bin/bash

CSV_FILE="data/player.csv"

# Cek file ada atau tidak
[ ! -f "$CSV_FILE" ] && { echo "❌ Data tidak ditemukan!"; exit 1; }

echo "=================="
echo " SILAHKAN LOGIN! "
echo "=================="
echo ""
echo "Masukkan email:"
read -r email
echo "Masukkan password:"
read -rs password
echo

grep -q ",$email,$password_hash" "$CSV_FILE" && { echo "✅ Login Berhasil!"; exit 0; }

echo "❌ Invalid email or password!"
exit 1
clear
```
Membuat sistem login yang hanya menerima input email dan password, lalu email dan password tersebut diperiksa apakah cocok dengan data yang ada di file ```data/player.csv```

## B. Radiant Genesis
Sistem login/register untuk para "Player" tentunya memiliki constraint, **yaitu validasi email dan password.** Email harus memiliki format yang benar dengan tanda @ dan titik, sementara password harus memiliki minimal 8 karakter, setidaknya satu huruf kecil, satu huruf besar, dan satu angka untuk menjaga keamanan data di dunia “Arcaea”.
## Penyelesaian
Validasi email dan password sudah berada di ``register.sh`` :
```
# Validasi email
[[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]] || { echo "❌ Email salah, Coba lagi!"; exit 1; }

# Validasi password (minimal 8 karakter)
[[ ${#password} -ge 8 ]] || { echo "❌ Password minimal 8 karakter!"; exit 1; }
```
Dari kode tersebut terdapat 2 validasi, yaitu :
1) Validasi Email yang harus menggunakan format tanda @ dan titik dengan command :
   ```[[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]] || { echo "❌ Email salah, Coba lagi!"; exit 1; }```
2) Validasi password yang harus memiliki minimal 8 karakter
   ```[[ ${#password} -ge 8 ]] || { echo "❌ Password minimal 8 karakter!"; exit 1; }```
Kekurangan pada command password : tidak menambahkan syarat huruf besar, kecil, dan angka

## C. Unceasing Spirit
Karena diperlukan pengecekan keaslian “Player” yang aktif, maka diperlukan sistem untuk pencegahan duplikasi “Player”. **Jadikan sistem login/register tidak bisa memakai email yang sama (email = unique), tetapi tidak ada pengecekan tambahan untuk username.**
## Penyelesaian
Menambahkan command untuk check tidak boleh memiliki email yang sama pada ```register.sh```
```
grep -q ",$email," "$CSV_FILE" && { echo "❌ Email sudah terdaftar!"; exit 1; }
```
Menggunakan ```grep``` untuk mengambil data dari ```CSV_FILE```

## D. The Eternal Realm of Light
Password adalah kunci akses ke dunia Arcaea. Untuk menjaga keamanan "Player", password perlu disimpan dalam bentuk yang tidak mudah diakses. Gunakan algoritma hashing **sha256sum** yang memakai static salt (bebas).
## Penyelesaian
Menambahkan command untuk menyimpan password dalam bentuk yang tidak mudah diakses
``register.sh``
Ini langsung menyimpan ke ``CSV_FILE``
```
echo "$name,$email,$(echo -n "$password" | sha256sum | awk '{print $1}')" >> "$CSV_FILE"
```
``login.sh``
Ini untuk check lagi apakah sudah menggunakan **hashing sha256sum** untuk kerahasiaan password
```
password_hash=$(echo -n "$password" | sha256sum | awk '{print $1}')
```
## E. The Brutality of Glass
Setelah sukses login, "Player" perlu memiliki akses ke sistem pemantauan sumber daya. Sistem harus dapat melacak penggunaan **CPU (dalam persentase)** yang menjadi representasi “Core” di dunia “Arcaea”. Pastikan kalian juga bisa melacak “terminal” yang digunakan oleh “Player”, yaitu **CPU Model dari device mereka.** 
Lokasi shell script: ``./scripts/core_monitor.sh``
## Penyelesaian
```
#!/bin/bash

mkdir -p ./logs

LOG_FILE="./logs/core.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')  # Menghitung CPU yang dipakai (100% - idle)
CPU_MODEL=$(lscpu | grep "Model name" | awk -F ':' '{print $2}' | sed 's/^[ \t]*//g' | tr -s ' ')

echo "[${TIMESTAMP}] - Core Usage [${CPU_USAGE}%] - Terminal Model [${CPU_MODEL}]" >> "$LOG_FILE" 2>/dev/null
```
1) Membuat folder logs jika belum ada, untuk menyimpan file log.
```
mkdir -p ./logs
```
2) Menentukan lokasi file log, yaitu di folder logs dengan nama core.log.
```
LOG_FILE="./logs/core.log"
```
3) Menyimpan waktu saat ini dalam format YYYY-MM-DD HH:MM:SS ke dalam variabel TIMESTAMP.
```
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")
```
4) ```CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')```
- Command ``top -bn1`` menampilkan snapshot sekali (non-interaktif) tentang penggunaan sumber daya.
- Lalu ``grep "Cpu(s)"`` akan mencari baris yang mengandung informasi CPU.
- Kolom ke-8 (idle / ``id``) menunjukkan CPU yang tidak dipakai.
- ``awk '{print 100 - $8}'`` akan menghitung CPU usage dengan mengurangkan 100 - idle.
- Misal : idle 85.0, berarti CPU usage: 100 - 85.0 = 15%.
5) ```CPU_MODEL=$(lscpu | grep "Model name" | awk -F ':' '{print $2}' | sed 's/^[ \t]*//g' | tr -s ' ')```
- Perintah ``lscpu`` menampilkan informasi tentang CPU.
- ``grep "Model name"`` mengambil baris yang berisi model CPU.
- ``awk -F ':' '{print $2}'`` memisahkan teks dengan tanda ``:`` dan mengambil bagian kedua (isi modelnya).
- ``sed 's/^[ \t]*//g'`` menghapus spasi/tab di awal baris.
- ``tr -s ' '`` merapikan spasi agar tidak berlebihan.
- Hasil Akhir akan menampilkan hanya nama prosesor :
  ```Intel(R) Core(TM) i5-1035G1 CPU @ 1.00GHz```
6) ```echo "[${TIMESTAMP}] - Core Usage [${CPU_USAGE}%] - Terminal Model [${CPU_MODEL}]" >> "$LOG_FILE" 2>/dev/null```
- Menuliskan log ke file ``core.log`` dengan format:
```[2025-03-20 17:40:52] - Core Usage [15.0%] - Terminal Model [Intel(R) Core(TM) i5-1035G1 CPU @ 1.00GHz]```
- ``2>/dev/null`` membuang error output jika ada.
## Soal 3
## Soal 4
a.) Melihat summary dari data

Fitur untuk menampilkan nama Pokemon dengan Usage% dan RawUsage paling tinggi.

<img width="596" alt="image" src="https://github.com/user-attachments/assets/f91ed2b2-5d2d-43fb-b8c6-22afc71df006" />

Output

<img width="494" alt="image" src="https://github.com/user-attachments/assets/10e1c80f-e23b-42ea-a294-2dfb389d73ce" />

b.) Mengurutkan Pokemon berdasarkan data kolom

Sort dilakukan dengan urutan descending untuk semua angka selain nama, yang diurutkan secara alphabetical. Output harus sesuai dengan format csv yang diberikan.

<img width="674" alt="image" src="https://github.com/user-attachments/assets/d08ae74c-a493-4574-a764-9f6cfb398af8" />

Ouput



c.) Mencari nama Pokemon tertentu

Membuat fitur search berdasarkan nama Pokemon. Pastikan agar search yang dimasukkan tidak memunculkan hasil yang tidak diinginkan (seperti memunculkan semua Grass type ketika mengetik search “Grass”), dan output harus sesuai dengan format csv yang diberikan dengan sort Usage%.

<img width="626" alt="image" src="https://github.com/user-attachments/assets/6437f24c-1c7d-4f62-8a9e-19792d7f1ef7" />

Output



d.) Mencari Pokemon berdasarkan filter nama type

Membuat fitur filter berdasarkan Type sebuah Pokemon. Output harus sesuai dengan format csv yang diberikan dengan sort Usage%

<img width="657" alt="image" src="https://github.com/user-attachments/assets/92f5f934-14cb-494b-b031-18a16c8273c4" />

Outputnya yaitu

<img width="580" alt="image" src="https://github.com/user-attachments/assets/ad5ad469-2808-4dbf-b30b-6f99b15eefc3" />

e.) Error handling

Pastikan program yang anda buat mengecek semua kesalahan pengguna agar dapat memberikan kejelasan kepada pengguna pada setiap kasus.

Error Handling saat user belum mengisi option atau menulis option yang tidak ada
<img width="611" alt="image" src="https://github.com/user-attachments/assets/0ae683fa-b9ef-4ccd-88b7-ff551cbc8954" />

Salah satu contoh output

<img width="557" alt="image" src="https://github.com/user-attachments/assets/b5323eba-9d8b-4d0d-a48d-f351b74c7cc7" />

f.) Help screen yang menarik
Untuk memberikan petunjuk yang baik pada pengguna program, anda berpikir untuk membuat sebuah help screen yang muncul ketika mengetik -h atau --help sebagai command yang dijalankan. Kriteria yang harus ada dalam help screen pada program ini adalah:
- ASCII Art yang menarik! Gunakan kreativitas anda untuk mencari/membuat art yang cocok untuk program yang sudah anda buat!
- Penjelasan setiap command dan sub-command

<img width="956" alt="image" src="https://github.com/user-attachments/assets/e3535b48-e8d5-49a2-857d-6883f4addb54" />

Output

<img width="800" alt="image" src="https://github.com/user-attachments/assets/a99e54fd-16c3-4260-9184-fea093f46382" />

## Kendala
### Soal 1
Kendala saat menginstall file CSV

![2  Kendala Download](https://github.com/user-attachments/assets/be738921-69bf-4ed8-a154-e8045eb1b471)

### Soal 4
