resource "k8s_core_v1_config_map" "config-defaults" {
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
      
      # revision-timeout-seconds contains the default number of
      # seconds to use for the revision's per-request timeout, if
      # none is specified.
      revision-timeout-seconds: "300"  # 5 minutes
      
      # revision-cpu-request contains the cpu allocation to assign
      # to revisions by default.
      revision-cpu-request: "400m"  # 0.4 of a CPU (aka 400 milli-CPU)
      
      EOF
  }
  metadata {
    labels = {
      "serving.knative.dev/release" = "devel"
    }
    name = "config-defaults"
    namespace = "${var.namespace}"
  }
}