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
            (crontab -l; echo "* * * * * cd $(pwd) && bash ./scripts/core_monitor.sh") | crontab - 
            echo "✅ CPU Monitoring telah ditambahkan ke crontab."
            ;;
        2) 
            crontab -l | grep -v "core_monitor.sh" | crontab - 
            echo "❌ CPU Monitoring telah dihapus dari crontab."
            ;;
        3) 
            (crontab -l; echo "* * * * * cd $(pwd) && bash ./scripts/frag_monitor.sh") | crontab - 
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
