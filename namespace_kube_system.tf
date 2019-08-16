# KUBE-SYSTEM

resource "null_resource" "kube_system" {

  provisioner "local-exec" {
    command = "kubectl label ns kube-system control-plane=kube-system --overwrite"
  }
}
