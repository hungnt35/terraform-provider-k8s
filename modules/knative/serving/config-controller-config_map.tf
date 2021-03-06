resource "k8s_core_v1_config_map" "config-controller" {
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
      
      # List of repositories for which tag to digest resolving should be skipped
      registriesSkippingTagResolving: "ko.local,dev.local"
      
      EOF
    "queueSidecarImage" = "gcr.io/knative-releases/github.com/knative/serving/cmd/queue@sha256:b5c759e4ea6f36ae4498c1ec794653920345b9ad7492731fb1d6087e3b95dc43"
  }
  metadata {
    labels = {
      "serving.knative.dev/release" = "devel"
    }
    name = "config-controller"
    namespace = "${var.namespace}"
  }
}