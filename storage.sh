IFS=$','
hostuuidlist=$(xe host-list params=uuid --minimal)
poolname=$(xe pool-list params=name-label --minimal)
storageuuidlist=$(xe sr-list type=lvmohba params=uuid --minimal)
echo Pool,Name,Type,SizeAvailable,SizeInUse > $poolname-storageinfo.csv
for storageuuid in $storageuuidlist
do
storagename=$(xe sr-list type=lvmohba params=name-label uuid=$storageuuid --minimal)
storagetype=$(xe sr-list type=lvmohba params=type uuid=$storageuuid --minimal)
storagesizeavailable=$(xe sr-list type=lvmohba params=physical-size uuid=$storageuuid --minimal)
storagesizeinuse=$(xe sr-list type=lvmohba params=physical-utilisation uuid=$storageuuid --minimal)
storagesizeinusegb=$((storagesizeinuse/1024/1024/1024))
storagesizeavailablegb=$((storagesizeavailable/1024/1024/1024))
echo $poolname,$storagename,$storagetype,$storagesizeavailablegb,$storagesizeinusegb
done >> $poolname-storageinfo.csv
storageuuidlist=$(xe sr-list type=lvmoiscsi params=uuid --minimal)
for storageuuid in $storageuuidlist
do
storagename=$(xe sr-list type=lvmoiscsi params=name-label uuid=$storageuuid --minimal)
storagetype=$(xe sr-list type=lvmoiscsi params=type uuid=$storageuuid --minimal)
storagesizeavailable=$(xe sr-list type=lvmoiscsi params=physical-size uuid=$storageuuid --minimal)
storagesizeinuse=$(xe sr-list type=lvmoiscsi params=physical-utilisation uuid=$storageuuid --minimal)
storagesizeinusegb=$((storagesizeinuse/1024/1024/1024))
storagesizeavailablegb=$((storagesizeavailable/1024/1024/1024))
echo $poolname,$storagename,$storagetype,$storagesizeavailablegb,$storagesizeinusegb
done >> $poolname-storageinfo.csv
storageuuidlist=$(xe sr-list type=nfs params=uuid --minimal)
for storageuuid in $storageuuidlist
do
storagename=$(xe sr-list type=nfs params=name-label uuid=$storageuuid --minimal)
storagetype=$(xe sr-list type=nfs params=type uuid=$storageuuid --minimal)
storagesizeavailable=$(xe sr-list type=nfs params=physical-size uuid=$storageuuid --minimal)
storagesizeinuse=$(xe sr-list type=nfs params=physical-utilisation uuid=$storageuuid --minimal)
storagesizeinusegb=$((storagesizeinuse/1024/1024/1024))
storagesizeavailablegb=$((storagesizeavailable/1024/1024/1024))
echo $poolname,$storagename,$storagetype,$storagesizeavailablegb,$storagesizeinusegb
done >> $poolname-storageinfo.csv
