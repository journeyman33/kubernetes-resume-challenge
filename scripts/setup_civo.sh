#!/bin/bash
# Set up new civo cluster and substite the old cluster settings

civo kubernetes create ecom --remove-applications=traefik2-nodeport --applications traefik2-loadbalancer,cert-manager --cni-plugin cilium  -n 1 -s g4s.kube.medium create-firewall  --wait --save --merge --switch

kubectl create namespace ecom

cd ~/k8s-resume-challenge/kubernetes/civo
kubectl apply -f clusterissuer.yaml

# Get the vaule of 'DNS A record' from civo
dns_a_record=$(civo k3s show ecom | grep "DNS A record" | awk '{print $NF}')

# Replace the old DNS value with the new value in certificate.yaml
# First check if dns_a_record is not empty
if [ -n "$dns_a_record" ]; then
    # Update certificate.yaml with the new DNS A record value
    sed -i "s/commonName: .*/commonName: $dns_a_record/" ../kubernetes/civo/certificate.yaml
    sed -i "s/- .*.lb.civo.com/- $dns_a_record/" ../kubernetes/civo/certificate.yaml
    echo "Updated certificate.yaml with DNS A record: $dns_a_record"
else
    echo "Failed to retrieve DNS A record from 'civo k3s show ecom' command"
    exit 1
fi
# Replace the old DNS value with the new value in ingress.yaml
sed -i "s/host: .*/host: $dns_a_record/" ../kubernetes/civo/ingress.yaml
sed -i "s/- .*.lb.civo.com/- $dns_a_record/" ../kubernetes/civo/ingress.yaml

kubectl  apply -f ../kubernetes/civo/ingress.yaml




