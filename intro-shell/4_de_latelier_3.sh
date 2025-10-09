# Aider par Grok un peu après le début


echo "#SYSTEM"
echo "OS: $(lsb_release -d | tail | awk '{print $2}') $(uname -s) $(uname -i)"
echo " "
echo "#HARDWARE"
echo "CPU : $(grep 'model name' /proc/cpuinfo | head -1 | cut -d ':' -f2 | sed 's/^[ \t]*//')"
echo "CPU(s): $(nproc --all)"
echo "Cores: $(lscpu | grep 'Core(s) per socket' | awk '{print $4}')"
echo "Total Memory: $(free -h | grep '^Mem:' | awk '{print $2}')"
echo "Total Disk Space: $(df -h / | tail -1 | awk '{print $2}')"
echo " "
echo "# CURRENT STATE"
MEM_TOTAL=$(free | grep '^Mem:' | awk '{print $2}')
MEM_USED=$(free | grep '^Mem:' | awk '{print $3}')
MEM_PERC=$(( MEM_USED * 100 / MEM_TOTAL ))
MEM_USED_H=$(free -h | grep '^Mem:' | awk '{print $3}')
echo "Used Memory: ${MEM_PERC}% (${MEM_USED_H})"
SWAP_TOTAL=$(free | grep '^Swap:' | awk '{print $2}')
SWAP_USED=$(free | grep '^Swap:' | awk '{print $3}')
if [ ${SWAP_TOTAL} -eq 0 ]; then
    SWAP_PERC=0
    SWAP_USED_H="0 MB"
else
    SWAP_PERC=$(( SWAP_USED * 100 / SWAP_TOTAL ))
    SWAP_USED_H=$(free -h | grep '^Swap:' | awk '{print $3}')
fi
echo "Swap: ${SWAP_PERC}% (${SWAP_USED_H})"
DISK_PERC=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
DISK_USED_KB=$(df / | tail -1 | awk '{print $3}')
DISK_USED_MB=$(( DISK_USED_KB / 1024 ))
echo "Used Disk Space: ${DISK_PERC}% (${DISK_USED_MB} MB)" 
