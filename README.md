Ansible Role: strongswan 
======================================

[![Build Status](https://travis-ci.org/entercloudsuite/ansible-strongswan.svg?branch=master)](https://travis-ci.org/entercloudsuite/ansible-strongswan)
[![Galaxy](https://img.shields.io/badge/galaxy-entercloudsuite.strongswan-blue.svg?style=flat-square)](https://galaxy.ansible.com/entercloudsuite/strongswan)  

Installs strongswan on Ubuntu 16.04 (Xenial)

## Requirements

This role requires Ansible 2.4 or higher.

## Role Variables

The role defines most of its variables in `defaults/main.yml`:

## Example Playbook

Run with default vars:

    - hosts: all
      roles:
        - role: entercloudsuite.strongswan
          mtu: 1374
          strongswan_conn:
            - name: example
              conn:
                auto: start
                type: tunnel
                authby: psk
                keyexchange: ikev2
              left:
                address: 0.0.0.0/0
                subnet: 10.3.0.0/16
                id: de
                updown: /usr/lib/ipsec/_updown_nat
              right:
                address: 88.88.88.88
                subnet: 10.2.0.0/16
                id: it
              secret: something_needs_to_go_here

## Deploy in HA
Strong swan use IP Cluster Kenel Module for HA deploy.
Is like a keepaliveD.

Deploy
1 create 1 VIP bind to PubblicIP

Wit terraform Modules

```
module "external_vip_VPN" {
  source = "github.com/entercloudsuite/terraform-modules//external_vip?ref=2.6"
  external_vips = ["10.10.255.1"]
  network_id = "${data.openstack_networking_network_v2.network.id}"
  subnet = "${data.openstack_networking_subnet_v2.subnet_net.id}"
  region = "${var.region}"
}

```
Deploy 2 VM

## Testing

Tests are performed using [Molecule](http://molecule.readthedocs.org/en/latest/).

Install Molecule or use `docker-compose run --rm molecule` to run a local Docker container, based on the [enterclousuite/molecule](https://hub.docker.com/r/fminzoni/molecule/) project, from where you can use `molecule`.

1. Run `molecule create` to start the target Docker container on your local engine.  
2. Use `molecule login` to log in to the running container.  
3. Edit the role files.  
4. Add other required roles (external) in the molecule/default/requirements.yml file.  
5. Edit the molecule/default/playbook.yml.  
6. Define infra tests under the molecule/default/tests folder using the goos verifier.  
7. When ready, use `molecule converge` to run the Ansible Playbook and `molecule verify` to execute the test suite.  
Note that the converge process starts performing a syntax check of the role.  
Destroy the Docker container with the command `molecule destroy`.   

To run all the steps with just one command, run `molecule test`. 

In order to run the role targeting a VM, use the playbook_deploy.yml file for example with the following command: `ansible-playbook ansible-strongswan/molecule/default/playbook_deploy.yml -i VM_IP_OR_FQDN, -u ubuntu --private-key private.pem`.  

## License

MIT
