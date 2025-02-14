terraform {
  required_providers {
    virtualbox = {
      source = "terra-farm/virtualbox"
      version = "0.2.2-alpha.1"
    }
  }
}

# There are currently no configuration options for the provider itself.

resource "virtualbox_vm" "node" {
  name      = "test12"
  image     = "./ubuntu24-server.ova"
  cpus      = 2
  memory    = "2000 mib"

  network_adapter {
    type           = "bridged"
    host_interface = "Intel(R) Dual Band Wireless-AC 7260"
  }
}

resource "null_resource" "wait" {
  provisioner "local-exec" {
    command = "sleep 200"
  }
  depends_on = [virtualbox_vm.node]
}
