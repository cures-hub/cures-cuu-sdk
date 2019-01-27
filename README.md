<p align="center">
<img src=".github/cuu.jpeg" alt="CUU" width="250" />
</p>

# CUU

[![Build Status](https://travis-ci.org/cures-hub/cures-cuu-sdk.svg?branch=master)](https://travis-ci.org/cures-hub/cures-cuu-sdk)
[![Version](https://img.shields.io/cocoapods/v/CUU.svg?style=flat)](http://cocoapods.org/pods/CUU)
[![License](https://img.shields.io/cocoapods/l/CUU.svg?style=flat)](http://cocoapods.org/pods/CUU)
[![Platform](https://img.shields.io/cocoapods/p/CUU.svg?style=flat)](http://cocoapods.org/pods/CUU)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

CUU is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'CUU'
```


CUU requires a [`CUU.plist`](Example/CUU/CUU.plist) to be present at build time.
=======
CUU requires a [`CUU.plist`](Example/CUU/CUU.plist.example) to be present at build time.
You can rename and use the `CUU.plist.example` file as a starting point.
As the current commit hash needs to be written to this file, we recommend creating it with your CI/CD system.

## Setup

To be able to use all feature of CUU, you need to set up your project for it. 

In your AppDelegate, import CUU, let the AppDelegate conform to the IKAppDelegate protocol and start CUU.
You must also introduce a new var window in the AppDelegate.

```swift
class AppDelegate: UIResponder, UIApplicationDelegate, IKAppDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Start the CUU framework for tracking features and interactions within the app.
        CUU.start()
        
        // Do your own stuff.

        return true
    }
}
```

For every view controller which you want to be tracked, you need to inherit from one of the CUUViewController classes.
There is a subclass available for all types of View Controller, e.g. CUUPageViewController or CUUTabBarController.
For every event you want to track, call CUU's FeatureKit.seed(name: String) method.

```swift
class ViewController: CUUViewController {
    @IBAction func didTapTryFeatureKitButton(_ sender: UIButton) {
        // Notify the FeatureKit component of CUU that a step of a feature was triggered.
        CUU.seed(name: "TryFeatureKitButtonTapAction")
    }
}
```
## Author
- [Jan Ole Johanssen](http://github.com/janjohanssen)
- [Lara Marie Reimer](http://github.com/laramarie)
- [Jan Philip Bernius](http://github.com/jpbernius)

## Contributors
- [Michael Fröhlich](https://github.com/FroeMic)

## Contributors
- [Michael Fröhlich](https://github.com/FroeMic)

## License

CUU is available under the MIT license. See the [LICENSE file](LICENSE) for more info.

---

<img src="https://avatars1.githubusercontent.com/u/29952940?s=200&v=4" width="50" />
