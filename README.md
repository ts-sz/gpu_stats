# GPU STATS
GPU Usage statistics (on Linux) for Nvidia Video Cards
## Push your stats from GPU(mining rig) to Influxdb with Grafana
![](https://i.imgur.com/jfX1980.png)

All stats grab with **nvidia-smi**

### List Cards
`nvidia-smi -L`

### Stats
`nvidia-smi --query- gpu=power.draw,clocks.sm,clocks.mem,clocks.gr,temperature.gpu,utilization.gpu --format=csv,noheader`

#### for online test
`-l 1` (sec)


#### fun speed
`nvidia-smi -i 0 --query-gpu=fan.speed --format=csv,noheader`

_Hash RATE is ONLY if you use HIVEOS [ https://hiveos.farm ]_

Add to your cron for push automatically every minute


---
souces:
* http://xcat-docs.readthedocs.io/en/stable/advanced/gpu/nvidia/management.html
* http://cryptomining-blog.com/tag/nvidia-smi/
