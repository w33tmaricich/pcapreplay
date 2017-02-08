#!/bin/bash
set -e
echo Usage: pcapreplay --iface \<ethn\> --pcap \<file path\> --ip \<address\> --port \<number\>
echo        Spoof pcap traffic from your machine to given address over http

PCAPOUT="final.pcap"

while [[ $# -gt 1 ]]
do
    key="$1"
    case $key in 
        --iface)
            IFACE="$2"
            shift
            ;;
        --pcap)
            PCAP="$2"
            shift
            ;;
        --ip)
            IP="$2"
            shift
            ;;
        --port)
            PORT="$2"
            shift
            ;;
        *)
            #Unknown option
            ;;
    esac
    shift
done

HOSTIP=$(ifconfig $IFACE | grep "inet addr" | cut -d ':' -f 2 | cut -d ' ' -f 1)

read HOSTMAC </sys/class/net/$IFACE/address

echo PCAP = "$PCAP"
echo REMOTE IP = "$IP"
echo PORT = "$PORT"
echo IFACE = "$IFACE"
echo HOST IP = "$HOSTIP"
echo HOST MAC = "$HOSTMAC"

echo
echo Rewriting pcap file with your ip and mac...
tcprewrite --infile=$PCAP --outfile=$PCAPOUT --srcipmap=0.0.0.0/0:$HOSTIP --enet-smac=$HOSTMAC --fixcsum
echo
echo Transmitting to $IP on port $PORT...
./gor --input-raw $PCAPOUT --input-raw-engine pcap_file --output-http "http://$IP:$PORT"
