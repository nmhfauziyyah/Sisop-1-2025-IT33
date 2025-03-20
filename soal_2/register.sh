#!/bin/bash

CSV_FILE="data/player.csv"
if [ ! -f "$CSV_FILE" ]; then
    echo "Name,Email,Password" > "$CSV_FILE"
fi

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

# Cek apakah email sudah ada
grep -q ",$email," "$CSV_FILE" && { echo "❌ Email sudah terdaftar!"; exit 1; }

# Validasi email
[[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]] || { echo "❌ Email salah, Coba lagi!"; exit 1; }

# Validasi password (minimal 8 karakter dan mengandung 1 Huruf Besar, Kecil, Angka)
[[ ${#password} -ge 8 && "$password" == *[[:lower:]]* && "$password" == *[[:upper:]]* && "$password" == *[0-9]* ]] || { echo "❌ Password minimal 8 karakter!"; exit 1; }

# Hash password dan simpan
echo "$name,$email,$(echo -n "$password" | sha256sum | awk '{print $1}')" >> "$CSV_FILE"

echo "✅ Registrasi Berhasil!"
