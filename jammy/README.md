# jammy

This creates multi-arch (amd64 and arm64) build and run images based on jammy.

# Publishes the following images

* `ghcr.io/jericop/build-jammy`
* `ghcr.io/jericop/run-jammy`

# Image tags

* `stack`
  * Includes label `io.buildpacks.stack.id=io.buildpacks.stacks.jericop.jammy`
* `target`
  * Includes label `io.buildpacks.stack.id=io.buildpacks.stacks.jericop.jammy`
    * For backward compatibility
  * Includes label `io.buildpacks.id=jericop.jammy`
* `target`
  * Same as `target`
