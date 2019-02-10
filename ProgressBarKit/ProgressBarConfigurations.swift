//
//  ProgressBarConfigurations.swift
//  ProgressBarKit
//
//  Created by Zaim Ramlan on 10/02/2019.
//  Copyright © 2019 Zaim Ramlan. All rights reserved.
//

import Foundation

/// The cases to represent available progress bar configurations.
///
/// - track: Represents the Progress Bar's track configurations.
/// - bar: Represents the Progress Bar's bar configurations.
public enum PBConfigurations {
    case track, bar
}

/// The available progress bar's track configurations.
public struct PBTrackConfiguration {
    
    /// The corners to be rounded. (optional)
    var roundingCorners: UIRectCorner = []
    
    /// The value to round each corners. (optional)
    var cornerRadii: CGSize = .zero
    
    /// The edge insets of the progress bar. (optional)
    var edgeInsets: UIEdgeInsets = .zero
}

/// The available progress bar's bar configurations.
public struct PBBarConfiguration {
    
    /// The corners to be rounded. (optional)
    var roundingCorners: UIRectCorner = []
    
    /// The value to round each corners. (optional)
    var cornerRadii: CGSize = .zero
}
