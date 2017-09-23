# Prorsum Provider

![Swift](http://img.shields.io/badge/swift-4.0-brightgreen.svg)
[![Build Status](https://travis-ci.org/rb-de0/prorsum-provider.svg?branch=master)](https://travis-ci.org/rb-de0/prorsum-provider)


The Prorsum provider for Vapor allows you to use Prorsum HTTP server in your Vapor application.


## Usage

1. Add the ``Prorsum Provider`` to your Package.swift


### Swift Package Manager V3

```Swift
// swift-tools-version:3.1
import PackageDescription

let package = Package(
    name: "your-package-name",
    dependencies: [
        .Package(url: "https://github.com/rb-de0/prorsum-provider.git", majorVersion: 0, minor: 1)
    ]
)
```

### Swift Package Manager V4

```Swift
// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "your-package-name",
    package: [
        .Package(url: "https://github.com/rb-de0/prorsum-provider.git", from: "0.1.0")
    ],
    targets: [
    	.target(name: "your-target-name")
    ]
)
```

2. Add the ``Prorsum Provider`` to Droplet config.

Config+Setup.swift

```Swift
import ProrsumProvider

extension Config {
	
    /// Configure providers
    private func setupProviders() throws {
        try addProvider(ProrsumProvider.Provider.self)
    }
}
```

3. To change the server used by Vapor to prorsum, please change Config / droplet.json.

```JSON
{
    "server": "prorsum"
}
```

## LICENSE

ProrsumProvider is released under the MIT License. See the license file for more info.

