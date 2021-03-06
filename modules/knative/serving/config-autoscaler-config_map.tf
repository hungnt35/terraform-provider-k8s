resource "k8s_core_v1_config_map" "config-autoscaler" {
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
      
      # The Revision ContainerConcurrency field specifies the maximum number
      # of requests the Container can handle at once. Container concurrency
      # target percentage is how much of that maximum to use in a stable
      # state. E.g. if a Revision specifies ContainerConcurrency of 10, then
      # the Autoscaler will try to maintain 7 concurrent connections per pod
      # on average. A value of 0.7 is chosen because the Autoscaler panics
      # when concurrency exceeds 2x the desired set point. So we will panic
      # before we reach the limit.
      container-concurrency-target-percentage: "1.0"
      
      # The container concurrency target default is what the Autoscaler will
      # try to maintain when the Revision specifies unlimited concurrency.
      # Even when specifying unlimited concurrency, the autoscaler will
      # horizontally scale the application based on this target concurrency.
      #
      # A value of 100 is chosen because it's enough to allow vertical pod
      # autoscaling to tune resource requests. E.g. maintaining 1 concurrent
      # "hello world" request doesn't consume enough resources to allow VPA
      # to achieve efficient resource usage (VPA CPU minimum is 300m).
      container-concurrency-target-default: "100"
      
      # When operating in a stable mode, the autoscaler operates on the
      # average concurrency over the stable window.
      stable-window: "60s"
      
      # When observed average concurrency during the panic window reaches 2x
      # the target concurrency, the autoscaler enters panic mode. When
      # operating in panic mode, the autoscaler operates on the average
      # concurrency over the panic window.
      panic-window: "6s"
      
      # Max scale up rate limits the rate at which the autoscaler will
      # increase pod count. It is the maximum ratio of desired pods versus
      # observed pods.
      max-scale-up-rate: "10"
      
      # Scale to zero feature flag
      enable-scale-to-zero: "true"
      
      # Tick interval is the time between autoscaling calculations.
      tick-interval: "2s"
      
      # Dynamic parameters (take effect when config map is updated):
      
      # Scale to zero grace period is the time an inactive revision is left
      # running before it is scaled to zero (min: 30s).
      scale-to-zero-grace-period: "30s"
      
      EOF
  }
  metadata {
    labels = {
      "serving.knative.dev/release" = "devel"
    }
    name = "config-autoscaler"
    namespace = "${var.namespace}"
  }
}