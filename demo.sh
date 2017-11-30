#!/bin/bash

clear
echo "In this demo we are going to show
      1. Heat stack with service chaining already deployed using vSRX VNF
      2. Upgrade of Contrail from version 4.0.2.0-34 4.0.2.0-35, while
          a. Ping is on from Right-vm to Left-vm"
read nextLine

echo "Currently we have a cluster with openstack-helm charts and OpenContrail charts up and running"
read nextline

echo "Lets see all the charts which are deployed in the system"
read nextline

cmd="helm ls | more"
echo "$" $cmd
$cmd
read nextline

echo "Now lets check the pods which have been deplyed by the helm charts"
read nextline

cmd="kubectl get pods -n openstack | more"
echo "$" $cmd
kubectl get pods -n openstack | more
read nextline

echo "Starting the ping from test-vm-1 to test-vm-2"
read nextline

#echo "Starting the video streaming"
#read nextline

echo "Check the nodes labelled as contrail-controllerv2"
read nextline

cmd="kubectl get nodes -l opencontrail.org/controllerv2=enabled"
echo "$" $cmd
$cmd
read nextline


echo "Going to deploy opencontrail controllerv2"
read nextline

cmd="helm install --name opencontrail-controllerv2 ~/openstack-helm/opencontrail-controller --namespace=openstack"
echo "$" $cmd
helm install --name opencontrail-controllerv2 ~/openstack-helm/opencontrail-controller --namespace=openstack
read nextline

echo "Now lets go back to the slides, while the upgrade is happening"
read nextline

echo "Clear the screen"
read nextline
clear
read nextline

echo "Check the opencontrail-controllerv2 status"
read nextline
cmd="kubectl exec -i $(kubectl get pods -n openstack | grep controllerv2 | awk '{print $1}') -n openstack \
	-- contrail-status"
echo "$" $cmd
$cmd
read nextline

echo "Check the opencontrail-vrouter status"
read nextline
cmd="kubectl exec -i $(kubectl get pods -n openstack | grep vrouter | awk '{print $1}') -n openstack \
	-- contrail-status"
echo "$" $cmd
$cmd
read nextline
