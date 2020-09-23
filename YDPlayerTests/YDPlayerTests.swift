//
//  YDPlayerTests.swift
//  YDPlayerTests
//
//  Created by Douglas Hennrich on 28/08/20.
//  Copyright © 2020 YourDev. All rights reserved.
//

import XCTest
@testable import YDPlayer

class YDPlayerTests: XCTestCase {
    
    var config: YDPlayerConfiguration!

    override func setUpWithError() throws {
        config = YDPlayerConfiguration(withVideoId: "dTtshy4KzSY")
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func test_should_be_added_to_parent() {
        let vc = YDPlayerTestsViewController()
        vc.config = config
        
        vc.viewDidLoad()
        
        var hasAddedPlayer = false
        
        for view in vc.view.subviews {
            if view is YDPlayerView {
                hasAddedPlayer = true
            }
        }
        
        XCTAssertTrue(hasAddedPlayer, "Deve ter adicionado o player a parent view")
    }

}
