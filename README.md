# ProgressBarKit
![pod-version](https://cocoapod-badges.herokuapp.com/v/ProgressBarKit/badge.png) ![pod-platform](https://cocoapod-badges.herokuapp.com/p/ProductivityKit/badge.png)  

An animatable progress bar that can easily be used to display progress.

## Requirements

- Swift 4.2
- iOS 10 or later

## Installation

### Cocoapods

Add the following to your `Podfile`:
```
pod 'ProgressBarKit'
```

## Documentation

For a full deep-dive, refer to the [full documentation](https://zaimramlan.github.io/ProgressBarKit/).

## Usage

It's very easy to start using the progress bar. Simply:

1. Import and initialize
1. Setup
1. Set progress value

But... i need more customization. Sure, go straight [here](#advanced-usage)!

### Import and Initialize

```swift
import ProgressBarKit

class ViewController: UIViewController {
    lazy var progressBar: ProgressBar = {
        ProgressBar(trackColour: [.black], barColour: [.purple])
    }()
}
```

### Intial Setup

Specify the `UIView` that will be the progress bar's container view and initializes the progress bar in it.

```swift
progressBar.setup(in: myContainerView)
```

<sub>Important:  
This method should only be called ONCE, and only in `viewDidLayoutSubviews` to ensure the `container` has already been laid out correctly by AutoLayout.</sub>

### Set Progress Value

Animates the progress bar from `0` until the given percentage value (in decimal number) of the total width of the progress bar container view.

ie. Given, `value = 0.75` and `containerView.frame.width` is `100`  
The progress bar will only be expanded until a width of `0.75 * 100` which is 75 points.

```swift
progressBar.setProgressBarValue(to: 0.75)
```

<sub>Note:  
This method should only be called after calling `setupProgressBar(in:)` to ensure the progress bar is already initialized.</sub>

## Advanced Usage

So your _designer_ put or _you_ wanted a little bit more challenge to your design. Fret not, ProgressBarKit _mostly_ got you covered!

### 1 progress bar with default BAR and TRACK configuration

 ```swift
 let bar = ProgressBar(trackColour: [.black], barColour: [.purple])
 ```

### 1 progress bar with custom BAR configuration

 ```swift
 let barConfig = PBBarConfiguration(
     roundingCorners: [.allCorners],
     cornerRadii: CGSize(width: 8, height: 8)
 )

 let bar = ProgressBar(trackColour: [.black], barColour: [.purple], configurations: [.bar: barConfig])
 ```

### 1 progress bar with custom TRACK configurations

 ```swift
 let trackConfig = PBTrackConfiguration(
     roundingCorners: [.allCorners],
     cornerRadii: CGSize(width: 8, height: 8),
     edgeInsets: UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
 )

 let bar = ProgressBar(trackColour: [.black], barColour: [.purple], configurations: [.track: [trackConfig]])
 ```

### 2 or more progress bars with default and custom TRACK configurations

 ```swift
 let firstTrackConfig = PBTrackConfiguration(
     roundingCorners: [.topLeft, .bottomLeft],
     cornerRadii: CGSize(width: 8, height: 8),
     edgeInsets: UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
 )

 let lastTrackConfig = PBTrackConfiguration(
     roundingCorners: [.topRight, .bottomRight],
     cornerRadii: CGSize(width: 8, height: 8),
     edgeInsets: UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
 )

 // use default values
 let otherTrackConfig = PBTrackConfiguration()

 // this will display 3 tracks with different configurations, and
 // you can have some fun here by adding more configs into the array, and
 // watch the magic happens!
 let configs = [firstTrackConfig, otherTrackConfig, lastTrackConfig]
 let bar = ProgressBar(trackColour: [.black], barColour: [.purple], configurations: [.track: configs])
 ```

 ### 2 or more progress bars with GRADIENT track and bars

 ```swift
 // use default values
 let defaultTrackConfig = PBTrackConfiguration()

 // this will display the track and bar in gradient colours
 // you can have some fun here by adding more colours into the array, and
 // watch the gradient colour changes!
 let gradientTrackColours: [UIColor] = [.black, .white]
 let gradientBarColours: [UIColor] = [.red, .purple]

 let configs = [defaultTrackConfig, defaultTrackConfig, defaultTrackConfig]
 let bar = ProgressBar(trackColour: gradientTrackColours, barColour: gradientBarColours, configurations: [.track: configs])
 ```

## License

Under the MIT license. See LICENSE file for details
