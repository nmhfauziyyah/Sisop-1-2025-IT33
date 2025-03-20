# Sisop-1-2025-IT33

#### Nama Anggota
1. Ni'mah Fauziyyah Atok (5027241103)
2. Revalina Erica Permatasari (5027241007)
3. Kaisar Hanif Pratama (5027241029)

## Daftar Isi
1. [Soal 1](#soal-1)
2. [Soal 2](#soal-2)
3. [Soal 3](#soal-3)
4. [Soal 4](#soal-4)

## Soal 1 
### Oleh : Kaisar Hanif Pratama
#### a.) Pada soal 1 bagian a ini, Poppo ingin mencari tahu jumlah buku yang dibaca oleh Chris Hemsworth.

![1a](https://github.com/user-attachments/assets/7a5d085b-d521-4b44-a48a-0d88a4a5f4a2)

Lalu akan memberikan output seperti ini

![3  Hasil 1](https://github.com/user-attachments/assets/195c8d3e-0028-496b-ae26-32c9f9e5eaa3)

#### b.) Disini Poppo ingin tahu rata-rata durasi membaca menggunakan tablet.

![1b](https://github.com/user-attachments/assets/fd9990a4-40c7-4d63-a04e-69321d7a4479)

Dan outputnya seperti ini

![3  Hasil 2](https://github.com/user-attachments/assets/7d4c905a-8e72-46dc-9df0-46d2e32419d0)

#### c. Pada bagian c ini Siroyo ingin mencari rating tertinggi buku yang dibaca beserta Nama dan judul bukunya

![1c](https://github.com/user-attachments/assets/f0c9834f-8fe9-4b3e-9ca4-848ac15fc4e6)

Outputnya

![3  Hasil 3](https://github.com/user-attachments/assets/35cb1c3d-d8f8-4beb-8714-8ec5cc0aa824)

#### d. Siroyo ingin menganalisis data untuk menemukan genre yang paling sering dibaca di Asia setelah 31 Desember 2023 beserta jumlahnya

![1d](https://github.com/user-attachments/assets/a6f141ab-ad3a-4104-98a8-63a8930e6c8c)

Output

![3  Hasil 4](https://github.com/user-attachments/assets/724b1f8f-cbcb-4b98-bd61-efb7b64d54d7)

#### Kendala

Kendala saat menginstall file CSV

![2  Kendala Download](https://github.com/user-attachments/assets/be738921-69bf-4ed8-a154-e8045eb1b471)

## Soal 2
### Oleh : Ni'mah Fauziyyah A
### Soal
``
Anda merupakan seorang “Observer”, dari banyak dunia yang dibuat dari ingatan yang berbentuk “fragments” - yang berisi kemungkinan yang dapat terjadi di dunia lain. Namun, akhir-akhir ini terdapat anomali-anomali yang seharusnya tidak terjadi, perpindahan “fragments” di berbagai dunia, yang kemungkinan terjadi dikarenakan seorang “Seeker” yang berubah menjadi “Ascendant”, atau dalam kata lain, “God”. Tidak semua “Observer” menjadi “Player”, tetapi disini anda ditugaskan untuk ikut serta dalam menjaga equilibrium dari dunia-dunia yang terbuat dari “Arcaea”
``
### Jawaban
#### A. First Step in a New World
Tugas pertama, dikarenakan kejadian “Axiom of The End” yang semakin mendekat, diperlukan sistem untuk mencatat “Player” aktif agar terpisah dari “Observer”. Buatlah dua **shell script**, **login.sh dan register.sh**, yang dimana database **“Player” disimpan di /data/player.csv**. Untuk register, parameter yang dipakai yaitu email, username, dan password. Untuk login, parameter yang dipakai yaitu **email dan password.**
#### Penyelesaian
##### Membuat shell script ``register.sh``
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

##### Membuat shell script ``login.sh``
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

#### B. Radiant Genesis
Sistem login/register untuk para "Player" tentunya memiliki constraint, **yaitu validasi email dan password.** Email harus memiliki format yang benar dengan tanda @ dan titik, sementara password harus memiliki minimal 8 karakter, setidaknya satu huruf kecil, satu huruf besar, dan satu angka untuk menjaga keamanan data di dunia “Arcaea”.
#### Penyelesaian
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

#### C. Unceasing Spirit
Karena diperlukan pengecekan keaslian “Player” yang aktif, maka diperlukan sistem untuk pencegahan duplikasi “Player”. **Jadikan sistem login/register tidak bisa memakai email yang sama (email = unique), tetapi tidak ada pengecekan tambahan untuk username.**
#### Penyelesaian
Menambahkan command untuk check tidak boleh memiliki email yang sama pada ```register.sh```
```
grep -q ",$email," "$CSV_FILE" && { echo "❌ Email sudah terdaftar!"; exit 1; }
```
Menggunakan ```grep``` untuk mengambil data dari ```CSV_FILE```

#### D. The Eternal Realm of Light
Password adalah kunci akses ke dunia Arcaea. Untuk menjaga keamanan "Player", password perlu disimpan dalam bentuk yang tidak mudah diakses. Gunakan algoritma hashing **sha256sum** yang memakai static salt (bebas).
#### Penyelesaian
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
#### E. The Brutality of Glass
Setelah sukses login, "Player" perlu memiliki akses ke sistem pemantauan sumber daya. Sistem harus dapat melacak penggunaan **CPU (dalam persentase)** yang menjadi representasi “Core” di dunia “Arcaea”. Pastikan kalian juga bisa melacak “terminal” yang digunakan oleh “Player”, yaitu **CPU Model dari device mereka.** 
Lokasi shell script: ``./scripts/core_monitor.sh``
#### Penyelesaian
```
#!/bin/bash

mkdir -p ./logs

LOG_FILE="./logs/core.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')  # Menghitung CPU yang dipakai (100% - idle)
CPU_MODEL=$(lscpu | grep "Model name" | awk -F ':' '{print $2}' | sed 's/^[ \t]*//g' | tr -s ' ')

echo "[${TIMESTAMP}] - Core Usage [${CPU_USAGE}%] - Terminal Model [${CPU_MODEL}]" >> "$LOG_FILE" 2>/dev/null
```
### Penjelasan
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
4) Monitoring Penggunaan CPU
```
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
```
- Command ``top -bn1`` menampilkan snapshot sekali (non-interaktif) tentang penggunaan sumber daya.
- Lalu ``grep "Cpu(s)"`` akan mencari baris yang mengandung informasi CPU.
- Kolom ke-8 (idle / ``id``) menunjukkan CPU yang tidak dipakai.
- ``awk '{print 100 - $8}'`` akan menghitung CPU usage dengan mengurangkan 100 - idle.
- Misal : idle 85.0, berarti CPU usage: 100 - 85.0 = 15%.
5) Menampilkan Informasi Model Processor
```
CPU_MODEL=$(lscpu | grep "Model name" | awk -F ':' '{print $2}' | sed 's/^[ \t]*//g' | tr -s ' ')
```
- Perintah ``lscpu`` menampilkan informasi tentang CPU.
- ``grep "Model name"`` mengambil baris yang berisi model CPU.
- ``awk -F ':' '{print $2}'`` memisahkan teks dengan tanda ``:`` dan mengambil bagian kedua (isi modelnya).
- ``sed 's/^[ \t]*//g'`` menghapus spasi/tab di awal baris.
- ``tr -s ' '`` merapikan spasi agar tidak berlebihan.
- Hasil Akhir akan menampilkan hanya nama prosesor :
  ```Intel(R) Core(TM) i5-1035G1 CPU @ 1.00GHz```
6) Menampilkan Output dari core_monitor.sh
```
echo "[${TIMESTAMP}] - Core Usage [${CPU_USAGE}%] - Terminal Model [${CPU_MODEL}]" >> "$LOG_FILE" 2>/dev/null
```
- Menuliskan log ke file ``core.log`` dengan format:
```[2025-03-20 17:40:52] - Core Usage [15.0%] - Terminal Model [Intel(R) Core(TM) i5-1035G1 CPU @ 1.00GHz]```
- ``2>/dev/null`` membuang error output jika ada.
#### F. In Grief and Great Delight
Selain CPU, “fragments” juga perlu dipantau untuk memastikan equilibrium dunia “Arcaea”. **RAM** menjadi representasi dari “fragments” di dunia “Arcaea”, yang dimana dipantau **dalam persentase usage, dan juga penggunaan RAM sekarang.** 
Lokasi shell script: ``./scripts/frag_monitor.sh``
#### Penyelesaian
```
#!/bin/bash

mkdir -p ./logs

LOG_FILE="./logs/fragment.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

FRAG_USAGE=$(free -m | awk 'NR==2 {printf "%.2f", ($3/$2)*100}')  # Persentase penggunaan memori
FRAG_COUNT=$(df / | awk 'NR==2 {printf "%.2f", $3/1024}')  # Ukuran fragmentasi dalam MB
TOTAL_MEM=$(free -m | awk 'NR==2 {print $2}')  # Total memori dalam MB
AVAILABLE_MEM=$(free -m | awk 'NR==2 {print $7}')  # Memori yang tersedia dalam MB

echo "[${TIMESTAMP}] -- Fragment Usage [${FRAG_USAGE}%] -- Fragment Count [${FRAG_COUNT} MB] -- Details [Total: ${TOTAL_MEM} MB, Available: ${AVAILABLE_MEM} MB]" >> "$LOG_FILE"
```
#### Penjelasan
1) ``FRAG_USAGE`` Menghitung persentase memori yang digunakan
   ```
   free -m | awk 'NR==2 {printf "%.2f", ($3/$2)*100}
   ```
   - ``free -m`` Menampilkan penggunaan memori dalam MB
   - ``awk 'NR==2 {printf "%.2f", ($3/$2)*100}'``
     - ``NR==2`` Mengambil baris ke-2 (Karena berisikan data memori)
     - ``($3/$2)*100`` Menghitung persentase used/total
     - Ex : **50.63%**
2) ``FRAG_COUNT`` Menghitung ukuran fragmentasi
   ```
   df / | awk 'NR==2 {printf "%.2f", $3/1024}'
   ```
   - ``df /`` → Menampilkan disk usage untuk root (/).
   - ``awk 'NR==2 {printf "%.2f", $3/1024}'``
     - ``$3`` adalah kolom "Used" dalam satuan KB.
     - Dibagi ``1024`` untuk konversi ke MB.
     - Ex: **19531.25 MB**
3) ``TOTAL_MEM`` Total Memori
   ```
   free -m | awk 'NR==2 {print $2}'
   ```
   - Mengambil total memori dari ``free -m`` kolom ke-2.
   - Ex: **7900 MB**
4) ``AVAILABLE_MEM`` Memori Tersedia
   ```
   free -m | awk 'NR==2 {print $7}'
   ```
   - Mengambil jumlah memori yang tersedia dari ``free -m`` kolom ke-7.
   - Ex : **3700 MB**
#### G. On Fate's Approach
Pemantauan yang teratur dan terjadwal sangat penting untuk mendeteksi anomali. **Crontab manager (suatu menu)** memungkinkan "Player" untuk mengatur jadwal pemantauan sistem. 
Hal yang harus ada di fungsionalitas menu: <br>
**- Add/Remove CPU [Core] Usage** <br>
**- Add/Remove RAM [Fragment] Usage**<br>
**- View Active Jobs**<br>
Lokasi shell script: ``./scripts/manager.sh``
#### Penyelesaian
```
#!/bin/bash

LOG_DIR="./logs"

while true; do
    echo "================"
    echo " SELAMAT DATANG "
    echo "================"
    echo ""
    echo "1) Tambah CPU Monitoring"
    echo "2) Hapus CPU Monitoring"
    echo "3) Tambah RAM Monitoring"
    echo "4) Hapus RAM Monitoring"
    echo "5) Tampilkan Active Jobs"
    echo "6) Exit"
    read -p "Pilih opsi: " choice
    echo ""
    
    case $choice in
        1) 
            (crontab -l; echo "* * * * * bash $(pwd)/scripts/core_monitor.sh >> $LOG_DIR/core.log") | crontab - 
            echo "✅ CPU Monitoring telah ditambahkan ke crontab."
            ;;
        2) 
            crontab -l | grep -v "core_monitor.sh" | crontab - 
            echo "❌ CPU Monitoring telah dihapus dari crontab."
            ;;
        3) 
            (crontab -l; echo "* * * * * bash $(pwd)/scripts/frag_monitor.sh >> $LOG_DIR/fragment.log") | crontab - 
            echo "✅ RAM Monitoring telah ditambahkan ke crontab."
            ;;
        4) 
            crontab -l | grep -v "frag_monitor.sh" | crontab - 
            echo "❌ RAM Monitoring telah dihapus dari crontab."
            ;;
        5) 
            echo "📋 Menampilkan Active Jobs..."
            crontab -l 
            ;;
        6) 
            echo "🚪 Keluar dari program..."
            exit  # Keluar sepenuhnya
            ;;
        *) 
            echo "⚠️ Pilihan tidak valid, silakan pilih kembali."
            ;;
    esac
    echo ""
done
```
#### Penjelasan
``1)`` Menambahkan monitoring CPU ke ``crontab``, supaya script ``core_monitor.sh`` dijalankan setiap menit.
   ```
   (crontab -l; echo "* * * * * bash $(pwd)/scripts/core_monitor.sh >> $LOG_DIR/core.log") | crontab -
   ```
- ``crontab -l`` → Ambil daftar crontab yang ada.
- ``echo "* * * * * bash ..."`` → Tambahkan perintah baru yang berjalan setiap menit.
- ``| crontab -`` → Simpan kembali ke crontab.
- Output akan masuk ke ``logs/core.log.``

``2)`` Menghapus CPU monitoring dari ``crontab.``
```
crontab -l | grep -v "core_monitor.sh" | crontab -
```
Mengambil semua baris crontab, lalu menghilangkan (``grep -v``) dari baris yang mengandung ``core_monitor.sh`` dan menyimpan ulang.

``3)`` Menambahkan monitoring RAM (fragmentasi) ke crontab, juga setiap menit.
```
(crontab -l; echo "* * * * * bash $(pwd)/scripts/frag_monitor.sh >> $LOG_DIR/fragment.log") | crontab -
```
Sama halnya dengan pilihan 1), teteapi ini menggunakan ``frag_monitor.sh`` dan menyimpan output ke ``fragment.log.``

``4)`` Menghapus RAM monitoring dari crontab.
```
crontab -l | grep -v "frag_monitor.sh" | crontab -
```
Menghapus baris cron yang memanggil ``frag_monitor.sh``

``5)`` Menampilkan daftar ``active jobs`` yang sudah ada di crontab.
```
crontab -l
```
Menampilkan semua jadwal cron yang aktif.
``6)`` Keluar dari Program
```
exit
```
Menghentikan script
``*)`` Jika input tidak sesuai 1–6, maka:
```
echo "⚠️ Pilihan tidak valid, silakan pilih kembali."
```
Akan muncul peringatan bahwa input tidak valid.

#### H. The Disfigured Flow of Time
Karena tentunya script yang dimasukkan ke crontab tidak mengeluarkan output di terminal, buatlah 2 log file, core.log dan fragment.log di folder ./log/, yang dimana masing-masing terhubung ke program usage monitoring untuk usage tersebut. 
#### Format log :
- CPU 
```
[YYYY-MM-DD HH:MM:SS] - Core Usage [$CPU%] - Terminal Model [$CPU_Model]
```
- RAM
```
[YYYY-MM-DD HH:MM:SS] - Fragment Usage [$RAM%] - Fragment Count [$RAM MB] - Details [Total: $TOTAL MB, Available: $AVAILABLE MB]
```
#### Penyelesaian
#### CPU
Pada script ``core_monitor.sh``, baris :
```
LOG_FILE="./logs/core.log"

echo "[${TIMESTAMP}] - Core Usage [${CPU_USAGE}%] - Terminal Model [${CPU_MODEL}]" >> "$LOG_FILE" 2>/dev/null
```
Berfungsi untuk mencatat hasil monitoring CPU ke dalam file log.
- Output akan disimpan ke file ``core.log`` yang berada di direktori ``./logs/``.
- Setiap baris log berisi timestamp, persentase penggunaan CPU, dan model CPU yang digunakan.
- ``>>`` digunakan untuk menambahkan baris ke akhir file log tanpa menghapus isi sebelumnya.
- ``2>/dev/null`` digunakan untuk membuang pesan error jika ada.
#### RAM
Pada script ``frag_monitor.sh``, baris :
```
LOG_FILE="./logs/fragment.log"

echo "[${TIMESTAMP}] -- Fragment Usage [${FRAG_USAGE}%] -- Fragment Count [${FRAG_COUNT} MB] -- Details [Total: ${TOTAL_MEM} MB, Available: ${AVAILABLE_MEM} MB]" >> "$LOG_FILE"
```
Berfungsi untuk mencatat hasil monitoring memori (RAM) ke dalam file log.
- Output akan disimpan ke file ``fragment.log`` yang berada di direktori ``./logs/``.
- Setiap baris log berisi waktu pencatatan, persentase penggunaan memori (``FRAG_USAGE``), ukuran fragmentasi (``FRAG_COUNT`` dalam MB), total memori yang tersedia (``TOTAL_MEM``), dan memori yang masih bisa dipakai (``AVAILABLE_MEM``).
- ``>>`` digunakan untuk menambahkan baris log baru tanpa menghapus isi sebelumnya.
#### I. Irruption of New Color
Sistem harus memiliki antarmuka utama yang menggabungkan semua komponen. Ini akan menjadi titik masuk bagi "Player" untuk mengakses seluruh sistem. Buatlah shell script **terminal.sh**, yang berisi user flow berikut: <br> 
- Register
- Login
  - Crontab manager (add/rem core & fragment usage)
  - Exit
- Exit
#### Penyelesaian
```
#!/bin/bash

while true; do
    echo "============================"
    echo " SELAMAT DATANG DI TERMINAL "
    echo "============================"
    echo ""
    echo "1) Register"
    echo "2) Login"
    echo "3) Exit"
    read -p "Pilih opsi: " main_choice
    echo ""

    clear

    case $main_choice in
        1) bash register.sh ;;
        2) 
            bash login.sh 
            if [[ $? -eq 0 ]]; then
                while true; do
                    bash scripts/manager.sh
                    read -p "Kembali ke Crontab Manager? (y/n): " choice
                    if [[ "$choice" != "y" ]]; then
                        break
                    fi
                done
            fi
        ;;
        3) exit
        sleep 1
        ;;
    esac
done
```
#### Penjelasan
``case $main_choice in`` digunakan untuk menangkap input user dari variabel main_choice (hasil dari ``read -p "Pilih opsi: "``). Kemudian dijalankan sesuai pilihan: <br>
``1)`` Jika user memilih 1, maka script akan menjalankan ``register.sh``.<br>
User akan diarahkan ke proses registrasi.<br>
``2)`` Jika user memilih 2, maka script akan menjalankan ``login.sh``.<br>
- Setelah ``login.sh`` selesai dijalankan, akan dicek ``if [[ $? -eq 0 ]];
  then``
- ``$? -eq 0`` artinya login berhasil (exit code 0).
- Jika login berhasil, maka akan masuk ke ``manager.sh`` secara berulang.
- Setelah keluar dari ``manager.sh``, akan muncul pertanyaan:
```
Kembali ke Crontab Manager? (y/n):
```
Jika user mengetik ``y``, maka akan kembali lagi ke ``manager.sh``. Jika tidak, keluar dari loop. <br>
``3)``Jika user memilih 3, script akan menjalankan ``exit`` (keluar dari program).<br>

### Kendala
#### [1] Path file di dalam script tidak konsisten
Ingin menggunakan path simple ``./`` tetapi tidak bisa saat dijalankan cron karena cron tidak tahu direktori kerjanya. <br>
##### Solusi: Mengubah semua path menjadi path absolut. 
Contoh: ``/home/username/Sisop-1-2025-IT33/logs/fragment.log.``[Solve] <br>
#### [2] Membuat script monitoring log dengan cron
- Script tidak berjalan otomatis lewat crontab. <br>
- Log tidak masuk ke file karena path relatif ``./logs`` tidak dikenali
  saat crontab berjalan. <br> 
##### Solusi : 
Akhirnya saya mengganti path pada script menjadi path absolut (dari /home/...) seperti poin 1 supaya cron dapat mengeksekusi dengan benar. [Solve] <br>
#### [3] Menjadwalkan monitoring CPU dan RAM secara otomatis
- Crontab tidak menulis ke log karena kesalahan pada permission dan
  environment cron yang berbeda dari terminal biasa. <br>
##### Solusi:
- Ternyata saya belum memberikan permission, akhirnya saya memberikan
  permission ``chmod +x`` pada script. [Solve] <br>
- Menggunakan path absolut pada semua script dan file log. [Solve] <br>
#### [4] Bingung kenapa tidak muncul output log
Cron tidak menampilkan error apa pun, dan log tidak bertambah.<br>
##### Solusi:
- Mengecek log cron dengan ``grep CRON /var/log/syslog`` untuk melihat
  error. [Solve] <br>
- Memastikan script sudah ``chmod +x``. [Solve] <br>
#### [5] Cron job tidak jalan per menit
Cron hanya jalan sekali atau tidak jalan sama sekali. <br>
##### Solusi:
- Akhirnya saya check crontab dengan ``crontab -e`` dan memastikan syntax cron job benar: [Solve] <br>
```
* * * * * /bin/bash /home/username/Sisop-1-2025-IT33/scripts/frag_monitor.sh
```
- Lalu saya lanjut restart cron dengan ``sudo service cron restart`` [Solve] <br>
### Dokumentasi
### 1. Tampilan `terminal.sh`
![1  terminal](https://github.com/user-attachments/assets/554880f2-2fcb-4b25-b4a8-40deebf61553)
### 2) Tampilan jika memilih opsi 1 (register)
![2  register](https://github.com/user-attachments/assets/63dc9d02-bd12-4430-a294-55f22dcafbbd)
### 3) Data dari register akan tersimpan di data/player.csv
![2  data](https://github.com/user-attachments/assets/7a1e415e-2969-4fb5-bfc3-52b26b08c4e5)
### 4) Tampilan login
![3  login](https://github.com/user-attachments/assets/d17688e0-097f-4047-b55e-c55b2d1d386a)
### 5) Tampilan berhasil login lalu masuk ke crontab menu
![3  login berhasil crontab menu](https://github.com/user-attachments/assets/7176b9db-bcd7-40ee-b4d4-041849e41fd3)
### 6) Menambahkan CPU dan RAM
![4  menambahkan cpu dan ram](https://github.com/user-attachments/assets/72b260c2-d35d-4e45-91b9-d2792c3b2037)
### 7) View Active Jobs
![5  active jobs](https://github.com/user-attachments/assets/4130c3eb-23d9-46c0-b82a-96a62539f7f3)
### 8) Isi dari core.log (CPU)
![6  core log](https://github.com/user-attachments/assets/540abe07-fea3-45b0-a68c-c0d4f30dd7b9)
### 9) Isi dari fragment.log (RAM)
![6  frag log](https://github.com/user-attachments/assets/3792ceb3-8dcf-4b07-bb55-3bb337e00782)

## Soal 3
### Oleh: 

## Soal 4
### Oleh: Revalina Erica Permatasari
<img width="578" alt="image" src="https://github.com/user-attachments/assets/f5159058-e5e0-4776-a9bc-31f996685a1e" />

- ``$#`` adalah variabel khusus di Bash yang menyimpan jumlah argumen yang diberikan saat script dijalankan. Jika jumlah argumen kurang dari 2 (``-lt 2``), script akan menampilkan pesan error dan keluar (``exit 1``). Jadi dia memastikan user memberikan minimal 2 argumen: <file_name> (pokemon_usage.csv) dan <command> (seperti: ``-i``, ``-h``, dan lainnya).
- ``$0`` adalah nama script yang sedang dijalankan, yaitu pokemon_analysis.sh
- ``$1`` adalah nama file yang akan diproses, yaitu pokemon_usage.csv.
- ``$2`` adalah perintah yang akan dieksekusi (misal: ``-i``, ``--filter``).
- ``$3`` adalah opsi tambahan (misal: kolom untuk sorting atau nama Pokemon untuk searching).
  
### a.) Melihat summary dari data
Fitur untuk menampilkan nama Pokemon dengan Usage% dan RawUsage paling tinggi.

<img width="596" alt="image" src="https://github.com/user-attachments/assets/f91ed2b2-5d2d-43fb-b8c6-22afc71df006" />

- ``tail -n +2 "$file"`` Menghapus baris pertama (header) dari file CSV.
- ``sort -t, -k2 -nr``Mengurutkan data berdasarkan kolom ke-2 (Usage%) secara numerik (-n) dan terbalik (-r). Jadi dia akan menampilkan nilai tertinggi.
- ``head -1`` Mengambil baris pertama setelah diurutkan (nilai tertinggi).
- ``sort -t, -k3 -nr | head -1`` Sama halnya seperti sebelumnya, tetapi disini RawUsage ada di kolom 3

Output

<img width="494" alt="image" src="https://github.com/user-attachments/assets/10e1c80f-e23b-42ea-a294-2dfb389d73ce" />

#### b.) Mengurutkan Pokemon berdasarkan data kolom
Sort dilakukan dengan urutan descending untuk semua angka selain nama, yang diurutkan secara alphabetical. Output harus sesuai dengan format csv yang diberikan.

<img width="674" alt="image" src="https://github.com/user-attachments/assets/d08ae74c-a493-4574-a764-9f6cfb398af8" />

- ``grep -q -w "$option"`` Memeriksa apakah kolom yang diminta ada di header. Dan tidak ada output (hanya status ``true``/``false``) karena fokusnya pada error handling
- ``head -1 "$file"``Mengambil baris pertama (header) dari file untuk mendapatkan daftar nama kolom.
- ``tr ',' '\n'`` Mengubah koma (,) menjadi baris baru (\n).
- ``grep -n -w "$option"`` Mencari dan menampilkan nomor kolom berdasarkan nama kolom yang dipilih pengguna.
- ``cut -d: f1`` Mengambil nomor kolom dari hasil pencarian untuk sorting.
- ``head -1`` Jika ada lebih dari satu hasil (misalnya option muncul lebih dari sekali), kita hanya ambil yang pertama.
- ``sort -t, -k"$COLUMN" -nr`` Mengurutkan data berdasarkan kolom yang dipilih.
- ``sort -t, -k1,1`` Untuk kolom Pokemon yang disorting secara alphabetical (A-Z)
  
Salah satu contoh output sort (Usage%)

<img width="552" alt="image" src="https://github.com/user-attachments/assets/41d10cb1-5ae5-40cd-a8bb-cc1975eff7b2" />

#### c.) Mencari nama Pokemon tertentu

Membuat fitur search berdasarkan nama Pokemon. Pastikan agar search yang dimasukkan tidak memunculkan hasil yang tidak diinginkan (seperti memunculkan semua Grass type ketika mengetik search “Grass”), dan output harus sesuai dengan format csv yang diberikan dengan sort Usage%.

<img width="626" alt="image" src="https://github.com/user-attachments/assets/6437f24c-1c7d-4f62-8a9e-19792d7f1ef7" />

- ``grep -i "^$option"`` Mencari Pokémon yang namanya diawali dengan $option (case-insensitive) di kolom pertama saja (kolom nama-nama Pokemon).
- ``z "$search"`` Memeriksa apakah hasil pencarian kosong, jika kosong akan menampilkan error handling.

Output

<img width="512" alt="image" src="https://github.com/user-attachments/assets/e23e91e4-aab5-4a2a-bb12-a126769e3e06" />

#### d.) Mencari Pokemon berdasarkan filter nama type

Membuat fitur filter berdasarkan Type sebuah Pokemon. Output harus sesuai dengan format csv yang diberikan dengan sort Usage%

<img width="702" alt="image" src="https://github.com/user-attachments/assets/b3ab12e9-7547-4cde-9219-f143514d68bc" />

- ``awk -F, -v type="$option" '$4 == type || $5 == type'`` Memfilter data berdasarkan tipe Pokemon (kolom ke-4 atau ke-5).
- ``sort -t, -k2 -nr`` Mengurutkan hasil filter berdasarkan kolom Usage%.

Output

<img width="580" alt="image" src="https://github.com/user-attachments/assets/ad5ad469-2808-4dbf-b30b-6f99b15eefc3" />

#### e.) Error handling

Pastikan program yang anda buat mengecek semua kesalahan pengguna agar dapat memberikan kejelasan kepada pengguna pada setiap kasus.

- Error Handling saat user belum mengisi option atau menulis option yang tidak ada
![Screenshot 2025-03-19 154126](https://github.com/user-attachments/assets/9d10493e-0ea3-4c61-95ba-a70f14b9e99b)

- Error Handling untuk Sorting berdasarkan Kolom
![Screenshot 2025-03-19 153448](https://github.com/user-attachments/assets/978394b3-f696-4ceb-a627-4d866e6fea81)

- Error Handling untuk Searching Pokemon
![Screenshot 2025-03-19 154027](https://github.com/user-attachments/assets/8141f861-1072-44c3-bc1f-3a7a210da8ad)

- Error Handling untuk Filter type Pokemon dan disorting bedasarkan Usage%
<img width="682" alt="image" src="https://github.com/user-attachments/assets/7447e81c-bc01-493f-9438-18becade28ac" />

Salah satu contoh output

<img width="536" alt="image" src="https://github.com/user-attachments/assets/02f5e404-7588-435c-9d2f-fbf266984165" />

#### f.) Help screen yang menarik
Untuk memberikan petunjuk yang baik pada pengguna program, anda berpikir untuk membuat sebuah help screen yang muncul ketika mengetik -h atau --help sebagai command yang dijalankan. Kriteria yang harus ada dalam help screen pada program ini adalah:
- ASCII Art yang menarik! Gunakan kreativitas anda untuk mencari/membuat art yang cocok untuk program yang sudah anda buat!
- Penjelasan setiap command dan sub-command

<img width="956" alt="image" src="https://github.com/user-attachments/assets/e3535b48-e8d5-49a2-857d-6883f4addb54" />

Output

![Screenshot 2025-03-19 152912](https://github.com/user-attachments/assets/7436e59f-3f4a-4cae-9082-f55642725536)

#### Kendala
Kendala saat searching nama Pokemon, yaitu nama type pokemon sempat muncul

<img width="638" alt="image" src="https://github.com/user-attachments/assets/cbb9c6f7-afd8-4463-ab21-ad53f0076c84" />

Tetapi sudah kami temukan solusinya yaitu pada bagian ``grep -i "$option"``, jika seperti ini maka objek dari semua kolom dapat ditampilkan.
Maka ``grep -i "$^option"`` adalah solusinya agar program hanya fokus pada kolom pertama saja, yaitu kolom untuk nama-nama Pokemon.

<img width="502" alt="image" src="https://github.com/user-attachments/assets/d9bc0018-3441-4391-98c6-45027f8a9f90" />
