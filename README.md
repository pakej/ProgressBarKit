# ProgressBarKit

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



## Usage

You can use the progress bar in 3 simple steps.

### Import and Initialize

```swift
import ProgressBarKit

class ViewController: UIViewController {
    lazy var progressBar: ProgressBar = {
        ProgressBar(roundedCorners: [.allCorners], cornerRadii: CGSize(width: 8, height: 8))
    }()
}
```

### Intial Setup

Specify the `UIView` that will be the progress bar's container view and initializes the progress bar in it.

```swift
progressBar.setup(in: myContainerView)
```

<sub>Important:  
This method should only be called in `viewDidLayoutSubviews` to ensure the container view has already been laid out correctly by AutoLayout.</sub>

### Set Progress Value

Animates the progress bar from `0` until the given percentage value (in decimal number) of the total width of the progress bar container view.

ie. Given, `value = 0.75` and `containerView.frame.width` is `100`  
The progress bar will only be expanded until a width of `0.75 * 100` which is 75 points.

```swift
progressBar.setProgressBarValue(to: 0.75)
```

<sub>Note:  
This method should only be called after calling `setupProgressBar(in:roundingCorners:cornerRadii:)` to ensure the progress bar is already initialized.</sub>

## License

Under the MIT license. See LICENSE file for details
