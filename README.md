# Pcap Replay

This is a tool used to replay http traffic that has been captured. Once you have
a file with a ```.pcap``` extension, you can use this tool to replay the traffic
to another machine, as if it was originating from your computer.

## Installation
Get yourself a computer running ubuntu. After cloning this repository, simply run
the included installation script.

```bash
sudo apt-get update
sudo apt-get install git -y
git clone http://gitlab.skylinenet.net/amaricich/pcapreplay.git
cd pcapreplay
./install.sh
```

## Usage
First copy the pcap file to the machine with pcapreplay installed. Then simply
run the command below.

```bash
./pcapreplay.sh --iface <ethn> --pcap <file path> --ip <address> --port <number>
```

 - ethn
   - The network interface you would like to pull your ip address and mac address from.
 - file path
   - The relative or absolute path to the pcap file.
 - address
   - The ip address of the device you wish to send your captured traffic to.
 - number
   - The port number of the device you wish to send your captured traffic to.

Here is an example of a finalized command.
```bash
./pcapreplay.sh --iface eth0 --pcap /home/username/your.pcap --ip 172.28.148.155 --port 80
```
