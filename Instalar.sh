#!/bin/bash

echo "Vamos Instalar as Dependecias necessarias para o bom funcionamento do Script:"
echo "So espere o processo Finalizar"
echo ""
read -p "Aperte para continuar"

apt-get update && apt-get install xterm && apt-get install mdk3

clear
echo ""
echo "Pronto ja pode Iniciar o Script"
