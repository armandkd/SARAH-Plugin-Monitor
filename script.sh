#!/bin/bash
cpuTemp0=$(cat /sys/class/thermal/thermal_zone0/temp)
cpuTemp1=$(($cpuTemp0/1000))
cpuTemp2=$(($cpuTemp0/100))
cpuTempM=$(($cpuTemp2 % $cpuTemp1))

gpuTemp0=$(/opt/vc/bin/vcgencmd measure_temp)
gpuTemp0=${gpuTemp0//\'/°}
gpuTemp0=${gpuTemp0//temp=/}

cpuFreq=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
cpuFreqM=$(($cpuFreq/1000))

RXbytes=$(ifconfig eth0 | grep 'RX bytes'| cut -d':' -f2 | cut -d' ' -f1)
RXbytesM=$(($RXbytes/1048576))

TXbytes=$(ifconfig eth0 | grep 'TX bytes'| cut -d':' -f3 | cut -d' ' -f1)
TXbytesM=$(($TXbytes/1048576))

upTime=$(cat /proc/uptime | cut -d'.' -f1)
upTimeH=$(($upTime/3600))

memTotal=$(cat /proc/meminfo | grep 'MemTotal' | tr -d ' ' | cut -d':' -f2 | cut -d'k' -f1)
memTotalM=$(($memTotal/1000))

memFree=$(cat /proc/meminfo | grep 'MemFree' | tr -d ' ' | cut -d':' -f2 | cut -d'k' -f1)
memFreeM=$(($memFree/1000))

cpuIdle=$(top -bn1 | grep '%Cpu(s):' | cut -d' ' -f10 | cut -d',' -f1)
cpuUsage=$((100-$cpuIdle))

echo CPU Freq : $cpuFreqM"MHz"
echo CPU Usage : $cpuUsage"%"
echo RAM Total : $memTotalM"MB"
echo RAM Libre : $memFreeM"MB"
echo CPU Temp : $cpuTemp1"."$cpuTempM"°C"
echo GPU Temp : $gpuTemp0
echo RX : $RXbytesM"Mb"
echo TX : $TXbytesM"Mb"
echo Uptime : $upTimeH"h"