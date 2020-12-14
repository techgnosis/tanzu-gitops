Notes learned from real engagements:

1. kbld does not actually rely on Docker. At most it uses the credentials from Docker to reach your registries, but even those credentials can be provided by environment variables.
2. `kp import` does not rely on kpack to do the image importing. `kp` itself does the work. TBS installs that use internal Git repos and internal image registries do NOT need to set any proxy values.
3. You can put both the registry secret and the git secret in the same service account and it works fine. Make two lists, instead of adding to the existing list.
4. You need to provide the Java buildpack with a maven settings.xml in order for it to use the on-prem Nexus. 