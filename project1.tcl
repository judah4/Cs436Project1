#Create a simulator object
set ns [new Simulator]

#Tell the simulator to use dynamic routing
$ns rtproto DV

#Create a trace file
set tracefd [open example1.tr w]
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

#Create duplex links between the nodes
$ns duplex-link $n0 $n2 2Mb 40ms DropTail
$ns duplex-link $n1 $n2 2Mb 40ms DropTail
$ns duplex-link $n2 $n3 8Mb 100ms DropTail
$ns duplex-link $n2 $n4 8Mb 100ms DropTail
$ns duplex-link $n3 $n4 8Mb 100ms DropTail
$ns duplex-link $n3 $n5 2Mb 40ms DropTail
$ns duplex-link $n4 $n6 2Mb 40ms DropTail
$ns duplex-link $n4 $n7 2Mb 40ms DropTail

#Set Queue Size of links
$ns queue-limit $n0 $n2 25
$ns queue-limit $n1 $n2 25
$ns queue-limit $n2 $n3 30
$ns queue-limit $n2 $n4 30
$ns queue-limit $n3 $n4 30
$ns queue-limit $n3 $n5 25
$ns queue-limit $n4 $n6 25
$ns queue-limit $n4 $n7 25

#Create a UDP agent and attach it to node n0
set tcp8to10 [new Agent/TCP]
$ns attach-agent $n0 $tcp8to10
set tcp8to11 [new Agent/TCP]
$ns attach-agent $n0 $tcp8to11
set udp9to12 [new Agent/UDP]
$ns attach-agent $n1 $udp9to12
set udp9to13 [new Agent/UDP]
$ns attach-agent $n1 $udp9to13
set tcp8to14 [new Agent/TCP]
$ns attach-agent $n0 $tcp8to14
set udp9to15 [new Agent/UDP]
$ns attach-agent $n1 $udp9to15
set tcp8to16 [new Agent/TCP]
$ns attach-agent $n0 $tcp8to16
set udp9to17 [new Agent/UDP]
$ns attach-agent $n1 $udp9to17

#Set flow id for each traffic
$tcp8to10 set fid_ 0
$tcp8to11 set fid_ 1
$udp9to12 set fid_ 2
$tcp8to11 set fid_ 3
$udp9to13 set fid_ 4
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
set null10 [new Agent/Null]
$ns attach-agent $n5 $null10
set null11 [new Agent/Null]
$ns attach-agent $n5 $null11
set null12 [new Agent/Null]
$ns attach-agent $n5 $null12
set null13 [new Agent/Null]
$ns attach-agent $n6 $null13
set null14 [new Agent/Null]
$ns attach-agent $n6 $null14
set null15 [new Agent/Null]
$ns attach-agent $n5 $null15
set null16 [new Agent/Null]
$ns attach-agent $n7 $null16
set null17 [new Agent/Null]
$ns attach-agent $n7 $null17
#Connect the traffic source with the traffic sink
$ns connect $tcp8to10 $null10
$ns connect $tcp8to11 $null11
$ns connect $udp9to12 $null12
$ns connect $udp9to13 $null13

#Schedule events for the CBR agent
$ns at 1 "$cbr8To10 start"
$ns at 10 "$cbr8To10 stop"

$ns at 10 "exit 0"

#Run the simulation
$ns run
