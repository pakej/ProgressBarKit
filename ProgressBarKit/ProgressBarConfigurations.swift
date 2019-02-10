//
//  ProgressBarConfigurations.swift
//  ProgressBarKit
//
//  Created by Zaim Ramlan on 10/02/2019.
//  Copyright © 2019 Zaim Ramlan. All rights reserved.
//

import Foundation

/// The cases to represent available progress bar configurations.
public enum PBConfigurations {
    /// Represents the Progress Bar's track configurations.
    case track
    
    /// Represents the Progress Bar's bar configurations.
    case bar
}

/// The available progress bar's track configurations.
public struct PBTrackConfiguration {
    
    /// The corners to be rounded. (optional)
    public var roundingCorners: UIRectCorner = []
    
    /// The value to round each corners. (optional)
    public var cornerRadii: CGSize = .zero
    
    /// The edge insets of the progress bar. (optional)
    public var edgeInsets: UIEdgeInsets = .zero

    /// Initialize `PBTrackConfiguration` with default values.
    public init() {}
    
    /// Initialize `PBTrackConfiguration` with the given values.
    ///
    /// - Parameters:
    ///   - roundingCorners: The corners to be rounded.
    ///   - cornerRadii: The value to round each corners.
    ///   - edgeInsets: The edge insets of the progress bar.
    public init(roundingCorners: UIRectCorner, cornerRadii: CGSize, edgeInsets: UIEdgeInsets) {
        self.roundingCorners = roundingCorners
        self.cornerRadii = cornerRadii
        self.edgeInsets = edgeInsets
    }
}

/// The available progress bar's bar configurations.
public struct PBBarConfiguration {
    
    /// The corners to be rounded. (optional)
    public var roundingCorners: UIRectCorner = []
    
    /// The value to round each corners. (optional)
    public var cornerRadii: CGSize = .zero

    /// Initialize `PBBarConfiguration` with default values.
    public init() {}
    
    /// Initialize `PBBarConfiguration` with the given values.
    ///
    /// - Parameters:
    ///   - roundingCorners: The corners to be rounded.
    ///   - cornerRadii: The value to round each corners.
    public init(roundingCorners: UIRectCorner, cornerRadii: CGSize) {
        self.roundingCorners = roundingCorners
        self.cornerRadii = cornerRadii
    }
}
