1. Use the `collector` folder to install the Wavefront Collector with custom HTTP proxy settings
2. Use the `prometheus` folder to install Prometheus and the Wavefront Prometheus storage adapter

The `collector` folder is configured OOTB to gather K8s metrics from the hosts, while the `prometheus` folder is only setup for Pods, but you can more easily query those metrics before they reach Wavefront using the `promtheus` folder