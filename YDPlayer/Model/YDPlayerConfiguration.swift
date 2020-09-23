//
//  YDPlayerConfiguration.swift
//  YDPlayer
//
//  Created by Douglas Hennrich on 28/08/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import UIKit

public class YDPlayerConfiguration {
    
    // MARK: Properties
    let width: CGFloat
    let height: CGFloat
    let videoId: String
    
    // MARK: Init
    public init(withWidth width: CGFloat = UIApplication.shared
        .windows.first?.bounds.width ?? 320,
                withHeight height: CGFloat = 300,
                withVideoId videoId: String) {
        self.width = width
        self.height = height
        self.videoId = videoId
    }
}
