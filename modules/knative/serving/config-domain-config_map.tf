resource "k8s_core_v1_config_map" "config-domain" {
  data = {
    "_example" = <<-EOF
      ################################
      #                              #
      #    EXAMPLE CONFIGURATION     #
      #                              #
      ################################
      
      # This block is not actually functional configuration,
      # but serves to illustrate the available configuration
      # options and document them in a way that is accessible
      # to users that `kubectl edit` this config map.
      #
      # These sample configuration options may be copied out of
      # this block and unindented to actually change the configuration.
      
      # Default value for domain.
      # Although it will match all routes, it is the least-specific rule so it
      # will only be used if no other domain matches.
      example.com: |
      
      # These are example settings of domain.
      # example.org will be used for routes having app=nonprofit.
      example.org: |
        selector:
          app: nonprofit
      
      # Routes having domain suffix of 'svc.cluster.local' will not be exposed
      # through Ingress. You can define your own label selector to assign that
      # domain suffix to your Route here, or you can set the label
      #    "serving.knative.dev/visibility=cluster-local"
      # to achieve the same effect.  This shows how to make routes having
      # the label app=secret only exposed to the local cluster.
      svc.cluster.local: |
        selector:
          app: secret
      
      EOF
  }
  metadata {
    labels = {
      "serving.knative.dev/release" = "devel"
    }
    name = "config-domain"
    namespace = "${var.namespace}"
  }
}