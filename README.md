# Netflow
Cybersecurity: Graph Processing using Gunrock.

## What is Netflow?
NetFlow is a traffic profile monitoring technology that describes the method for a router to export statistics about the routed socket pairs. When a network administrator enables the NetFlow export on a router interface, traffic statistics of packets received on that interface will be counted as "flow" and stored into a dynamic flow cache.

## What is flow?
Flow is defined as a unidirectional sequence of packets (which means there will be two flows for each connection session, one from the server to client, one from the client to server) between two endpoints. A flow can be identified by seven key fields: source IP address, destination IP address, source port number, destination port number, protocol type, type of services, and the router input interface. Any time after receiving a packet, a router will look for these seven fields and then make a decision: if the packet belongs to an existent flow, traffic statistics of the corresponding flow will be increased, otherwise a new flow entry will be created.

```
 Date flow start          Duration Proto   Src IP Addr:Port      Dst IP Addr:Port     Packets    Bytes Flows
 2010-09-01 00:00:00.459     0.000 UDP     127.0.0.1:24920   ->  192.168.0.1:22126        1       46     1
 2010-09-01 00:00:00.363     0.000 UDP     192.168.0.1:22126 ->  127.0.0.1:24920          1       80     1
```
 
## Analysis Methods
* Top N and Baseline
* Top N session
* Top N data
* Pattern Matching
  * Port matching
  * IP address matching
  
## Sources
* [Inter Projekt - NetFlow](https://pliki.ip-sa.pl/wiki/Wiki.jsp?page=NetFlow)
* [Detecting Worms and Abnormal Activities with NetFlow](https://www.symantec.com/connect/articles/detecting-worms-and-abnormal-activities-netflow-part-1)
