#!/bin/bash

wget "https://drive.usercontent.google.com/u/0/uc?id=1l8fsj5LZLwXBlHaqhfJVjz_T0p7EJjqV&export=download" -O reading_data.csv


echo "pilih jawaban untuk soal ini?"
echo "1. jumlah buku yang dibaca Chris Hemsworth"
echo "2. rata-rata durasi membaca dengan tablet"
echo "3. pembaca dengan rating tertinggi"
echo "4. genre paling populer"
echo -n "jawab: "
read jawaban

case "$jawaban" in
  "1")
    # Menghitung berapa banyak buku yang dibaca oleh Chris Hemsworth
    awk '/Chris Hemsworth/ { ++n }
    END { print "Chris Hemsworth membaca", n, "buku." }' reading_data.csv
    ;;
  "2")
    # Menghitung rata-rata durasi membaca dengan perangkat Tablet
    awk -F ',' '$8 ~ /Tablet/ {total += $6; count++ }
    END { 
      if (count > 0) {
        rata = total/count; 
        print "Rata-rata durasi membaca dengan Tablet adalah", rata, "menit."
      } else {
        print "Tidak ada data membaca dengan Tablet."
      }
    }' reading_data.csv
    ;;
  "3")
    # Menemukan pembaca dengan rating tertinggi
    sort -t ',' -k7 -nr reading_data.csv | awk -F ',' '
    NR == 1 {max = $7} 
    $7 == max {
      print "Pembaca dengan rating tertinggi: ", $2, "-", $3, "-", max
    }'
    ;;
  "4")
    # Menemukan genre paling populer di Asia setelah tahun 2023
    awk -F',' '
    $9 ~ /Asia/ && $5 > "2023-12-31" {count[$4]++}
    END {
      max=0; 
      genre=""; 
      for (g in count) {
        if (count[g] > max) {
          max = count[g]; 
          genre = g;
        }
      }
      if (genre != "") {
        print "Genre paling populer di Asia setelah 2023 adalah", genre, "dengan", max, "pembaca."
      } else {
        print "Tidak ada data genre di Asia setelah 2023."
      }
    }' reading_data.csv
    ;;
esac
