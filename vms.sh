IFS=$','
vmuuidlist=$(xe vm-list params=uuid is-control-domain=false is-a-snapshot=false --minimal)
poolname=$(xe pool-list params=name-label --minimal)
echo VMName,OS,Pool,Host,IP,vCPUs,RAM,Storage,Description > $poolname-vminfo.csv
for vmuuid in $vmuuidlist
do
vmname=$(xe vm-list params=name-label uuid=$vmuuid --minimal)
OS=$(xe vm-list params=os-version uuid=$vmuuid --minimal)
hostuuid=$(xe vm-list params=resident-on uuid=$vmuuid --minimal)
VIP=$(xe vm-list params=networks uuid=$vmuuid --minimal)
vmdescription=$(xe vm-list params=name-description uuid=$vmuuid --minimal)
hostname=$(xe host-list params=name-label uuid=$hostuuid --minimal)
vcpus=$(xe vm-list params=VCPUs-number uuid=$vmuuid --minimal)
ram=$(xe vm-list params=memory-static-max uuid=$vmuuid --minimal)
vdiuuidlist=$(xe vbd-list vm-uuid=$vmuuid type=Disk params=vdi-uuid --minimal)
for vdiuuid in $vdiuuidlist
do
vdisize=$(xe vdi-list uuid=$vdiuuid params=virtual-size --minimal)
totalsize=$((totalsize+vdisize))
done
totalsize=$((totalsize/1024/1024/1024))
vmram=$((ram/1024/1024/1024))
echo $vmname,$OS,$poolname,$hostname,$VIP,$vcpus,$vmram,$totalsize,$vmdescription 
done >> $poolname-vminfo.csv
