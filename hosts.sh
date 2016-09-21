IFS=$','
hostuuidlist=$(xe host-list params=uuid --minimal)
poolname=$(xe pool-list params=name-label --minimal)
echo Pool,Host,Description,Version,Edition,Address,CPU,RAM > $poolname-hostinfo.csv
for hostuuid in $hostuuidlist
do
hostname=$(xe host-list params=name-label uuid=$hostuuid --minimal)
hostcpu=$(xe host-cpu-info uuid=$hostuuid --minimal)
hostdescription=$(xe host-list params=name-description uuid=$hostuuid --minimal)
hostedition=$(xe host-list params=edition uuid=$hostuuid --minimal)
hostaddress=$(xe host-list params=address uuid=$hostuuid --minimal)
hostmemory=$(xe host-list params=memory-total uuid=$hostuuid --minimal)
hostversion=$(uname -r)
hostram=$((hostmemory/1024/1024/1024+1))
echo $poolname,$hostname,$hostdescription,$hostversion,$hostedition,$hostaddress,$hostcpu,$hostram
done >> $poolname-hostinfo.csv
