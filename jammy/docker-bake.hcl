// Shared common variables (if any)
target "_common" {
    args = {}
}

// Shared stack info variables (if any)
target "_stack_info" {
  args = {}
}

// Shared target info variables (if any)
target "_target_info" {
  args = {}
}

// Bake builds this by default
group "default" {
    targets = [
        "stack-based",
        "new-target-based",
    ]
}

// jammy build and run images with stack id label
group "stack-based" {
    targets = [
        "run-cnb-stack",
        "build-cnb-stack",
    ]
}

// jammy build and run images with [target] id label
group "new-target-based" {
    targets = [
        "run-cnb-target",
        "build-cnb-target",
    ]
}

target "run-cnb-stack" {
    inherits = ["_common", "_stack_info"]
    context = "./"
    dockerfile = "Dockerfile"
    target = "run-cnb-stack"
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
    tags = [
        "ghcr.io/jericop/run-jammy:stack",
    ]
}

target "build-cnb-stack" {
    inherits = ["_common", "_stack_info"]
    context = "./"
    dockerfile = "Dockerfile"
    target = "build-cnb-stack"
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
    tags = [
        "ghcr.io/jericop/build-jammy:stack",
    ]
}

target "run-cnb-target" {
    inherits = ["_common", "_target_info"]
    context = "./"
    dockerfile = "Dockerfile"
    target = "run-cnb-target"
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
    tags = [
        "ghcr.io/jericop/run-jammy:target",
        "ghcr.io/jericop/run-jammy:latest",
    ]
}

target "build-cnb-target" {
    inherits = ["_common", "_target_info"]
    context = "./"
    dockerfile = "Dockerfile"
    target = "build-cnb-target"
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
    tags = [
        "ghcr.io/jericop/build-jammy:target",
        "ghcr.io/jericop/build-jammy:latest",
    ]
}
