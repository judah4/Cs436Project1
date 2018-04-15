#Create a simulator object
set ns [new Simulator]

#Tell the simulator to use dynamic routing
$ns rtproto DV

#Create a trace file
set tracefd [open project1.tr w]
$ns trace-all $tracefd


#Create eight nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]
set n10 [$ns node]
set n11 [$ns node]
set n12 [$ns node]
set n13 [$ns node]
set n14 [$ns node]
set n15 [$ns node]
set n16 [$ns node]
set n17 [$ns node]

#Create duplex links between the nodes
$ns duplex-link $n0 $n2 2Mb 40ms DropTail
$ns duplex-link $n1 $n2 2Mb 40ms DropTail
$ns duplex-link $n2 $n3 8Mb 100ms DropTail
$ns duplex-link $n2 $n4 8Mb 100ms DropTail
$ns duplex-link $n3 $n4 8Mb 100ms DropTail
$ns duplex-link $n3 $n5 2Mb 40ms DropTail
$ns duplex-link $n4 $n6 2Mb 40ms DropTail
$ns duplex-link $n4 $n7 2Mb 40ms DropTail
$ns duplex-link $n8 $n0 1Mb 20ms DropTail
$ns duplex-link $n9 $n1 1Mb 20ms DropTail
$ns duplex-link $n10 $n5 1Mb 20ms DropTail
$ns duplex-link $n11 $n5 1Mb 20ms DropTail
$ns duplex-link $n12 $n5 1Mb 20ms DropTail
$ns duplex-link $n13 $n5 1Mb 20ms DropTail
$ns duplex-link $n14 $n6 1Mb 20ms DropTail
$ns duplex-link $n15 $n6 1Mb 20ms DropTail
$ns duplex-link $n16 $n7 1Mb 20ms DropTail
$ns duplex-link $n17 $n7 1Mb 20ms DropTail

#Set Queue Size of links
$ns queue-limit $n0 $n2 25
$ns queue-limit $n1 $n2 25
$ns queue-limit $n2 $n3 30
$ns queue-limit $n2 $n4 30
$ns queue-limit $n3 $n4 30
$ns queue-limit $n3 $n5 25
$ns queue-limit $n4 $n6 25
$ns queue-limit $n4 $n7 25
$ns queue-limit $n9 $n1 20
$ns queue-limit $n10 $n5 20
$ns queue-limit $n11 $n5 20
$ns queue-limit $n12 $n5 20
$ns queue-limit $n13 $n5 20
$ns queue-limit $n14 $n6 20
$ns queue-limit $n15 $n6 20
$ns queue-limit $n16 $n7 20
$ns queue-limit $n17 $n7 20

#Create a UDP agent and attach it to node n0
set tcp8to10 [new Agent/TCP]
$ns attach-agent $n8 $tcp8to10
set tcp8to11 [new Agent/TCP]
$ns attach-agent $n8 $tcp8to11
set udp9to12 [new Agent/UDP]
$ns attach-agent $n9 $udp9to12
set udp9to13 [new Agent/UDP]
$ns attach-agent $n9 $udp9to13
set tcp8to14 [new Agent/TCP]
$ns attach-agent $n8 $tcp8to14
set udp9to15 [new Agent/UDP]
$ns attach-agent $n9 $udp9to15
set tcp8to16 [new Agent/TCP]
$ns attach-agent $n8 $tcp8to16
set udp9to17 [new Agent/UDP]
$ns attach-agent $n9 $udp9to17

#Set flow id for each traffic
$tcp8to10 set fid_ 0
$tcp8to11 set fid_ 1
$udp9to12 set fid_ 2
$udp9to13 set fid_ 3
$tcp8to14 set fid_ 4
$udp9to15 set fid_ 5
$tcp8to16 set fid_ 6
$udp9to17 set fid_ 7

# Create a CBR traffic source and attach it to tcp8
set cbr8To10 [new Application/Traffic/CBR]
$cbr8To10 set packetSize_ 1000
$cbr8To10 set interval_ 0.005
$cbr8To10 set random_ 1
$cbr8To10 attach-agent $tcp8to10

set cbr8To11 [new Application/Traffic/CBR]
$cbr8To11 set packetSize_ 3000
$cbr8To11 set interval_ 0.005
$cbr8To11 set random_ 1
$cbr8To11 attach-agent $tcp8to11

set cbr9To12 [new Application/Traffic/CBR]
$cbr9To12 set packetSize_ 1000
$cbr9To12 set interval_ 0.005
$cbr9To12 set random_ 1
$cbr9To12 attach-agent $udp9to12

set cbr9To13 [new Application/Traffic/CBR]
$cbr9To13 set packetSize_ 3000
$cbr9To13 set interval_ 0.005
$cbr9To13 set random_ 1
$cbr9To13 attach-agent $udp9to13

set cbr8To14 [new Application/Traffic/CBR]
$cbr8To14 set packetSize_ 2000
$cbr8To14 set interval_ 0.005
$cbr8To14 set random_ 1
$cbr8To14 attach-agent $tcp8to14

set cbr9To15 [new Application/Traffic/CBR]
$cbr9To15 set packetSize_ 2000
$cbr9To15 set interval_ 0.005
$cbr9To15 set random_ 1
$cbr9To15 attach-agent $udp9to15

set cbr8To16 [new Application/Traffic/CBR]
$cbr8To16 set packetSize_ 2000
$cbr8To16 set interval_ 0.005
$cbr8To16 set random_ 1
$cbr8To16 attach-agent $tcp8to16

set cbr9To17 [new Application/Traffic/CBR]
$cbr9To17 set packetSize_ 2000
$cbr9To17 set interval_ 0.005
$cbr9To17 set random_ 1
$cbr9To17 attach-agent $udp9to17

#Create a Null agent (a traffic sink) and attach it to node
set null10 [new Agent/LossMonitor]
$ns attach-agent $n10 $null10
set null11 [new Agent/LossMonitor]
$ns attach-agent $n11 $null11
set null12 [new Agent/LossMonitor]
$ns attach-agent $n12 $null12
set null13 [new Agent/LossMonitor]
$ns attach-agent $n13 $null13
set null14 [new Agent/LossMonitor]
$ns attach-agent $n14 $null14
set null15 [new Agent/LossMonitor]
$ns attach-agent $n15 $null15
set null16 [new Agent/LossMonitor]
$ns attach-agent $n16 $null16
set null17 [new Agent/Null]
$ns attach-agent $n17 $null17

#Connect the traffic source with the traffic sink
$ns connect $tcp8to10 $null10
$ns connect $tcp8to11 $null11
$ns connect $udp9to12 $null12
$ns connect $udp9to13 $null13
$ns connect $tcp8to14 $null14
$ns connect $udp9to15 $null15
$ns connect $tcp8to16 $null16
$ns connect $udp9to17 $null17

#Schedule events for the CBR agent
$ns at 1 "$cbr8To10 start"
$ns at 10 "$cbr8To10 stop"
$ns at 1 "$cbr8To11 start"
$ns at 10 "$cbr8To11 stop"
$ns at 2 "$cbr9To12 start"
$ns at 10 "$cbr9To12 stop"
$ns at 2 "$cbr9To13 start"
$ns at 10 "$cbr9To13 stop"
$ns at 1 "$cbr8To14 start"
$ns at 10 "$cbr8To14 stop"
$ns at 2 "$cbr9To15 start"
$ns at 10 "$cbr9To15 stop"
$ns at 1 "$cbr8To16 start"
$ns at 10 "$cbr8To16 stop"
$ns at 2 "$cbr9To17 start"
$ns at 10 "$cbr9To17 stop"

#Schedule events for the CBR agent and the network dynamics
$ns rtmodel-at 6.0 down $n2 $n3
$ns rtmodel-at 7.0 up $n2 $n3

$ns at 10 "exit 0"

#Run the simulation
$ns run
