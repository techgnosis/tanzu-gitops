New app:
1. Push usable app code to its own repo
1. Create separate repo with K8s manifests, TBS setup scripts, pipeline, etc. The K8s manifests won't be usable yet because there are no OCI images for our app yet
1. Run TBS setup script to create an app namespace and a TBS Image (and needed Secrets) resource pointing at the commit you want
1. TBS builds that commit into an OCI image
1. TBS pushes that image to Harbor
1. Update the K8s manifest for your app to use the first OCI image
1. Run Flux setup script to install Flux into the previously created app namespace. Flux watches the repo with the app K8s manifests
1. Flux applies the app K8s manfists

Existing App:
1. Write commit
1. Push commit
1. Commit pulled down by Concourse
1. Concourse runs tests
1. Concourse runs static code analysis
1. Concourse uses 'kp' to edit the TBS Image resource to point to the validated commit
1. TBS builds commit into an OCI image
1. TBS deposits OCI image into Harbor
1. Flux is watching Harbor and notices the new image
1. Flux updates the previously applied k8s manifests to use the new image, applies the manifests, then pushes the updated manifests to Git to allow Git to stay the source of truth for the entire application
1. Create Wavefront Event so you can see when the deployment happened on charts and graphs