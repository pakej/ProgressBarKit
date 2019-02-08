//
//  ProgressBar.swift
//  ProgressBarKit
//
//  Created by Zaim Ramlan on 09/02/2019.
//  Copyright © 2019 Zaim Ramlan. All rights reserved.
//

import Foundation

public class ProgressBar: NSObject {
    
    // MARK: - Properties
    
    // MARK: Internal
    
    /// Current percentage of the width of the progress bar
    /// to be displayed.
    var currentPercentage: CGFloat = 0
    
    /// Container where the progress bar will be initialized in.
    var containerView: UIView!
    
    /// Corners to be rounded.
    var cornersToRound: UIRectCorner
    
    /// Corner radius for each corners to be rounded.
    var cornerRadii: CGSize
    
    /// Gets the value of the starting frame where only the height value is initialized.
    ///
    /// - Returns: A CGRect that represents the starting frame.
    ///
    /// All frame values are 0, except for the `height`. This is to prepare
    /// the bar to animate forward by expanding only the `width.
    func startFrame() -> CGRect {
        var frame = CGRect.zero
        frame.size.height = containerView.frame.height
        return frame
    }
    
    /// Gets the value of the ending frame where the height value is not zero and
    /// the width value is initialized based on the value given.
    ///
    /// - Parameter value: The percentage (in decimal number) for the progress bar's width to expand to,
    ///                    within a minimum value of 0, and a maximum value of 1.
    /// - Returns: A CGRect that represents the ending frame.
    ///
    /// The `height` value is based on the progress bar container's height.
    ///
    /// The `width` value is determined based on the percentage value of the
    /// progress bar container's width.
    func endFrame(until value: CGFloat) -> CGRect {
        var frame = CGRect.zero
        frame.size.width = value * containerView.frame.size.width
        frame.size.height = containerView.frame.height
        return frame
    }
    
    /// The starting path for the progress bar.
    func startPath() -> UIBezierPath {
        let path = UIBezierPath.init(roundedRect: startFrame(), byRoundingCorners: cornersToRound, cornerRadii: cornerRadii)
        return path
    }
    
    /// The end path for the progress bar based on the given percentage value (in decimal number).
    func endPath(until value: CGFloat) -> UIBezierPath {
        let path = UIBezierPath.init(roundedRect: endFrame(until: value), byRoundingCorners: cornersToRound, cornerRadii: cornerRadii)
        return path
    }
    
    // MARK: Private
    
    private var trackLayer: CAShapeLayer!
    private var progressLayer: CAShapeLayer!
    
    // MARK: - Object Lifecycle
    
    /// Initializes the progress bar instance and (optionally) rounding the given corners,
    /// based on the given (optional) corner radii.
    ///
    /// - Parameters:
    ///   - roundingCorners: The corners to be rounded. (optional)
    ///   - cornerRadii: The value to round each corners. (optional)
    public init(roundedCorners: UIRectCorner = [], cornerRadii: CGSize = CGSize.zero) {
        self.cornersToRound = roundedCorners
        self.cornerRadii = cornerRadii
        super.init()
    }

    // MARK: - Main
    
    /// Sets up the progress bar within the given container view.
    ///
    /// - Parameters:
    ///   - container: The container `view` to initialize the progress bar in.
    ///
    /// This method should only be called this method in `viewDidLayoutSubviews` to ensure the container has already been laid out
    /// correctly by AutoLayout.
    public func setupProgressBar(in container: UIView) {
        self.containerView = container
        
        layoutTrack()
        layoutBar()
    }
    
    /// Animates the progress bar from `0` until the given percentage value (in decimal number)
    /// of the total width of the progress bar container view.
    ///
    /// - Parameter value: The percentage (in decimal number) for the progress bar's width to expand to,
    ///                    within a minimum value of 0, and a maximum value of 1.
    ///
    /// This method should only be called after calling `setupProgressBar(in:roundingCorners:cornerRadii:)` to ensure
    /// the progress bar is already initialized.
    public func setProgressBarValue(to value: CGFloat) {
        makeProgress(until: value)
    }
}

// MARK: - Utilities

private extension ProgressBar {
    
    // MARK: - Track
    
    func layoutTrack() {
        trackLayer = CAShapeLayer.init()
        trackLayer.path = endPath(until: 1).cgPath
        trackLayer.fillColor = UIColor.gray.cgColor
        
        containerView.layer.insertSublayer(trackLayer, at: 0)
    }
    
    // MARK: - Bar
    
    func layoutBar() {
        progressLayer = CAShapeLayer.init()
        progressLayer.path = startPath().cgPath
        progressLayer.fillColor = UIColor.blue.cgColor
        
        containerView.layer.insertSublayer(progressLayer, at: 1)
    }
    
    // MARK: - Progress Bar Expansion
    
    func makeProgress(until value: CGFloat) {
        let animation = CABasicAnimation.init(keyPath: "path")
        animation.fromValue = startPath().cgPath
        animation.toValue = endPath(until: value).cgPath
        animation.duration = 0.5
        animation.fillMode =  value >= currentPercentage ? .forwards : .backwards
        animation.timingFunction = CAMediaTimingFunction.init(name: .default)
        animation.isRemovedOnCompletion = false
        progressLayer.add(animation, forKey: nil)
        
        currentPercentage = value
    }
}
