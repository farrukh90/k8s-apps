module "artemis-terraform-helm" {
  source               = "./modules/terraform-helm/"
  deployment_name      = "artemis"
  deployment_namespace = "artemis"
  deployment_path      = "charts/application/"
  values_yaml          = <<EOF
controller:
  image: "docker.projectconsulting.net/artemis"
  tag: "2.0.0"
  ingress:
    enabled: yes
    apiVersion: "extensions/v1beta1"
    annotations:
      kubernetes.io/ingress.class: nginx
      ingress.kubernetes.io/ssl-redirect: "false"
      cert-manager.io/cluster-issuer: letsencrypt-prod
      acme.cert-manager.io/http01-edit-in-place: "true"
    hostName: "artemis.${var.google_domain_name}"
    tls:
      - secretName: artemis
        hosts:
          - "artemis.${var.google_domain_name}"
EOF
}
