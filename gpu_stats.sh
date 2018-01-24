#!/bin/bash
# by sz

nbGPU=($(nvidia-smi -L | cut -f 1 -d : | grep -Eo '[0-9]'))

# echo ${#nbGPU[@]}

for ((gpu=0;gpu<${#nbGPU[@]};gpu++));
do
	#gpu=$(( gpu - 1))
	myGPU=$(nvidia-smi -i "${gpu}" --query-gpu=power.draw,clocks.sm,clocks.mem,clocks.gr,temperature.gpu,utilization.gpu --format=csv,noheader )
	myPowerDraw=$(echo "${myGPU}" | cut -d ',' -f 1 | grep -Eo '[0-9.]+')
	myClockSm=$(echo "${myGPU}" | cut -d ',' -f 2 | grep -Eo '[0-9.]+')
	myClockMem=$(echo "${myGPU}" | cut -d ',' -f 3 | grep -Eo '[0-9.]+')
	myClockGr=$(echo "${myGPU}" | cut -d ',' -f 4 | grep -Eo '[0-9.]+')
	myTempGPU=$(echo "${myGPU}" | cut -d ',' -f 5 | grep -Eo '[0-9.]+')
	myUtilGPU=$(echo "${myGPU}" | cut -d ',' -f 6 | grep -Eo '[0-9.]+')
	#send to influxDB
	curl --silent -i -XPOST 'http://your.url.influx.db:8086/write?db=myDB' -u user:pass --data-binary "myFARM,GPU=${gpu} power.draw=${myPowerDraw},clocks.current.sm=${myClockSm},clocks.current.memory=${myClockMem},clocks.current.graphics=${myClockGr},utilization.gpu=${myUtilGPU},temperature.gpu=${myTempGPU}"
done

#ONLY for users use HIVEOS
# myHashRate=$(cat /run/hive/khs)
# curl --silent -i -XPOST 'http://your.url.influx.db:8086/write?db=myDB' -u user:pass --data-binary "myFARM hrate=${myHashRate}"

