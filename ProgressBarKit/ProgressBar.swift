//
//  ProgressBar.swift
//  ProgressBarKit
//
//  Created by Zaim Ramlan on 09/02/2019.
//  Copyright © 2019 Zaim Ramlan. All rights reserved.
//

import Foundation

/// An animatable and customizable progress bar.
public class ProgressBar: NSObject {

    // MARK: - Properties
    
    // MARK: Parent
    
    /// Container where the progress bar will be initialized in.
    var containerView: UIView!
    
    // MARK: Track and Bar Configurations
    
    /// The colour of the progress bar's track.
    var trackColour: UIColor
    
    /// The colour of the progress bar's bar.
    var barColour: UIColor
    
    /// The configurations for the progress bar's track.
    var trackConfigurations: [PBTrackConfiguration]
    
    /// The configurations for the progress bar's bar.
    var barConfiguration: PBBarConfiguration
    
    /// Current percentage of the width of the progress bar
    /// to be displayed.
    var currentPercentage: CGFloat = 0
    
    // MARK: Frames
    
    /// Gets the value of the starting frame where the `height` is initialized
    /// based on the containerView's `height`, and the `width` is based on the
    /// current percentage of the containerView's `width`.
    ///
    /// - Returns: A CGRect that represents the starting frame.
    func startFrame() -> CGRect {
        var frame = CGRect.zero
        frame.size.width = currentPercentage * containerView.frame.size.width
        frame.size.height = containerView.frame.height
        return frame
    }
    
    /// Gets the value of the ending frame where the height value is not zero and
    /// the width value is initialized based on the value given.
    ///
    /// - Parameter value: The percentage (in decimals) for the progress bar's width to expand to,
    ///                    within a minimum value of 0, and a maximum value of 1.
    /// - Returns: A CGRect that represents the ending frame.
    ///
    /// The `width` and `height` value is determined as follows:
    ///
    ///      let width = value * containerView.frame.width
    ///      let height = containerView.frame.height
    ///
    func endFrame(until value: CGFloat) -> CGRect {
        var frame = CGRect.zero
        frame.size.width = value * containerView.frame.width
        frame.size.height = containerView.frame.height
        return frame
    }
    
    // MARK: Paths
    
    /// The starting path for the progress bar's bar or track.
    func startPath(for config: Any? = nil) -> UIBezierPath {
        let config = parse(config: config)
        return UIBezierPath.init(roundedRect: startFrame(), byRoundingCorners: config.roundingCorners, cornerRadii: config.cornerRadii)
    }
    
    /// The end path for the progress bar's bar or track, based on the given percentage value (in decimals).
    func endPath(for config: Any? = nil, until value: CGFloat) -> UIBezierPath {
        let config = parse(config: config)
        return UIBezierPath.init(roundedRect: endFrame(until: value), byRoundingCorners: config.roundingCorners, cornerRadii: config.cornerRadii)
    }
    
    private func parse(config: Any?) -> (roundingCorners: UIRectCorner, cornerRadii: CGSize) {
        var roundingCorners: UIRectCorner = []
        var cornerRadii: CGSize = .zero
        
        if let config = config as? PBTrackConfiguration {
            roundingCorners = config.roundingCorners
            cornerRadii = config.cornerRadii
        }
        
        if let config = config as? PBBarConfiguration {
            roundingCorners = config.roundingCorners
            cornerRadii = config.cornerRadii
        }
        
        return (roundingCorners, cornerRadii)
    }
    
    // MARK: Layers
    
    private var trackLayer: CAShapeLayer!
    private var barLayer: CAShapeLayer!
    
    // MARK: - Initializers
    
    /// Initializes the progress bar instance and (optionally) based on the given
    /// progress bar's track configuration(s) and bar configuration.
    ///
    /// - Parameters:
    ///   - trackColour: The progress bar's track UIColor.
    ///   - barColour: The progress bar's bar UIColor.
    ///   - configurations: The `PBConfiguration` that takes in the configurations for
    ///                     the progress bar's track and bar. (optional)
    ///
    /// The `PBConfiguration` takes in 2 keys which are `.track` and `.bar`. Both represents the progress bar's
    /// track and bar elements, respectively.
    ///
    /// The `PBConfiguration.track` accepts an Array of `PBTrackConfiguration`s which will configure
    /// the progress bar's track display. Also, it determines the number of progress bar that
    /// will be displayed.
    ///
    /// The above, can be observed in the following examples:
    ///
    /// - Display 1 progress bar with default track configurations
    ///
    /// ```
    /// let bar = ProgressBar(trackColour: .black, barColour: .purple)
    /// ```
    ///
    /// - Display 1 progress bar with default track configurations
    ///
    /// ```
    /// let trackConfig = PBTrackConfiguration(
    ///     roundingCorners: [.allCorners],
    ///     cornerRadii: CGSize(width: 8, height: 8),
    ///     edgeInsets: UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
    /// )
    ///
    /// let bar = ProgressBar(trackColour: .black, barColour: .purple, configurations: [.track: [trackConfig]])
    /// ```
    ///
    /// - Display 2 or more progress bars with default or custom track configurations
    ///
    /// ```
    /// let firstTrackConfig = PBTrackConfiguration(
    ///     roundingCorners: [.topLeft, .bottomLeft],
    ///     cornerRadii: CGSize(width: 8, height: 8),
    ///     edgeInsets: UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
    /// )
    ///
    /// let lastTrackConfig = PBTrackConfiguration(
    ///     roundingCorners: [.topRight, .bottomRight],
    ///     cornerRadii: CGSize(width: 8, height: 8),
    ///     edgeInsets: UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
    /// )
    ///
    /// // use default values
    /// let otherTrackConfig = PBTrackConfiguration()
    ///
    /// // this will display 3 tracks
    /// let configs = [firstTrackConfig, otherTrackConfig, lastTrackConfig]
    /// let bar = ProgressBar(trackColour: .black, barColour: .purple, configurations: [.track: configs])
    /// ```
    ///
    /// The `PBConfiguration.bar` accepts an object of type `PBBarConfiguration` which will configure
    /// the progress bar's bar display.
    ///
    /// Similar with the progress bar's track configurations, the progress bar's bar configuration can also be
    /// customized, or used with default values.
    ///
    /// - Display the progress bar with default bar configuration
    ///
    /// ```
    /// let bar = ProgressBar(trackColour: .black, barColour: .purple)
    /// ```
    ///
    /// - Display the progress bar with default bar configuration
    ///
    /// ```
    /// let barConfig = PBBarConfiguration(
    ///     roundingCorners: [.allCorners],
    ///     cornerRadii: CGSize(width: 8, height: 8)
    /// )
    ///
    /// let bar = ProgressBar(trackColour: .black, barColour: .purple, configurations: [.bar: barConfig])
    /// ```
    public init(trackColour: UIColor, barColour: UIColor, configurations: [PBConfigurations: Any] = [:]) {
        self.trackColour = trackColour
        self.barColour = barColour
        
        self.trackConfigurations = configurations[.track] as? [PBTrackConfiguration] ?? []
        self.barConfiguration = configurations[.bar] as? PBBarConfiguration ?? PBBarConfiguration.init()
        
        super.init()
    }
    
    // MARK: - Main
    
    /// Sets up the progress bar within the given container view.
    ///
    /// - Parameters:
    ///   - container: The container `view` to initialize the progress bar in.
    ///
    /// This method should only be called ONCE, and only in `viewDidLayoutSubviews` to ensure the `container` has already been laid out
    /// correctly by AutoLayout.
    public func setupProgressBar(in container: UIView) {
        self.containerView = container
        
        layoutTrack()
        layoutBar()
        layoutMask()
    }
    
    /// Animates the progress bar from `0` until the given percentage value (in decimals)
    /// of the total width of the progress bar container view. Animation duration defaults to 0.75.
    ///
    /// - Parameters:
    ///   - value: The percentage (in decimals) for the progress bar's width to expand to,
    ///            within a minimum value of 0, and a maximum value of 1.
    ///   - duration: The animation duration to animate the progress bar. (optional)
    ///
    /// This method should only be called after calling `setupProgressBar(in:roundingCorners:cornerRadii:)` to ensure
    /// the progress bar is already initialized.
    public func setProgressBarValue(to value: CGFloat, with duration: CFTimeInterval = 0.75) {
        makeProgress(until: value, with: duration)
    }
}

// MARK: - Utilities

private extension ProgressBar {
    
    // MARK: - Track
    
    func layoutTrack() {
        trackLayer = CAShapeLayer.init()
        trackLayer.path = endPath(until: 1).cgPath
        trackLayer.fillColor = trackColour.cgColor
        
        containerView.layer.insertSublayer(trackLayer, at: 0)
    }
    
    // MARK: - Bar
    
    func layoutBar() {
        barLayer = CAShapeLayer.init()
        barLayer.path = startPath(for: barConfiguration).cgPath
        barLayer.fillColor = barColour.cgColor
        
        containerView.layer.insertSublayer(barLayer, at: 1)
    }
    
    // MARK: - Masking
    
    func layoutMask() {
        let mask = createMask()
        trackLayer.mask = mask.track
        barLayer.mask = mask.bar
    }
    
    func createMask() -> (track: CAShapeLayer, bar: CAShapeLayer) {
        let frame = endFrame(until: 1)
        let widthPerBar = frame.width / CGFloat(trackConfigurations.count)
        
        let finalPath = UIBezierPath()
        for i in 0...trackConfigurations.count - 1 {
            
            let config = trackConfigurations[i]
            let edgeInsets = config.edgeInsets
            
            let widthPerBarWithInsets = widthPerBar - edgeInsets.left - edgeInsets.right
            let heightWithInsets = frame.height - edgeInsets.top - edgeInsets.bottom
            
            var rect = CGRect.zero
            rect.origin.x = (CGFloat(i) * widthPerBar) + edgeInsets.left
            rect.origin.y = edgeInsets.top
            rect.size = CGSize.init(width: widthPerBarWithInsets, height: heightWithInsets)
            
            let path = UIBezierPath.init(roundedRect: rect, byRoundingCorners: config.roundingCorners, cornerRadii: config.cornerRadii)
            finalPath.append(path)
        }
        
        let trackMask = CAShapeLayer.init()
        trackMask.path = finalPath.cgPath
        trackMask.fillColor = UIColor.white.cgColor
        
        let barMask = CAShapeLayer.init()
        barMask.path = finalPath.cgPath
        barMask.fillColor = UIColor.white.cgColor
        
        return (trackMask, barMask)
    }
    
    // MARK: - Progress Bar Expansion
    
    func makeProgress(until rawValue: CGFloat, with duration: CFTimeInterval) {
        let value = sanitise(rawValue)
        
        let animation = CABasicAnimation.init(keyPath: "path")
        animation.fromValue = startPath(for: barConfiguration).cgPath
        animation.toValue = endPath(for: barConfiguration, until: value).cgPath
        animation.duration = duration
        animation.fillMode = .forwards
        animation.timingFunction = CAMediaTimingFunction.init(name: .default)
        animation.isRemovedOnCompletion = false
        barLayer.add(animation, forKey: nil)
        
        currentPercentage = value
    }
    
    func sanitise(_ value: CGFloat) -> CGFloat {
        switch value {
        case let x where x > 1:
            return 1
        case let x where x < 0:
            return 0
        default:
            return value
        }
    }
}
