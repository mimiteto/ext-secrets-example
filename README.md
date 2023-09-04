# Example

Cluster is biult with the `run.sh` command in `os` directory.
It is aimed to reconfigure an RPI 4B, running Debian 11.

That script will fire `ansible-playbook` command that will:
* reconfigure the system
* install `k3s`
* add an AWS credentials and then bootstrap `fluxcd`

FluxCD is cconfigured to watch the `k8s` directory.

Note: To rotate credentials, simply execute the `run.sh` script with the updated ENV variables.
