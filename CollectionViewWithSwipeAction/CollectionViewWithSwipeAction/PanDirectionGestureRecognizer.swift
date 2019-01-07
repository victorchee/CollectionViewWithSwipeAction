//
//  PanDirectionGestureRecognizer.swift
//  CollectionViewWithSwipeAction
//
//  Created by Migu on 2019/1/7.
//  Copyright © 2019 VIctorChee. All rights reserved.
//

import UIKit

enum PanDirection {
    case vertical
    case horizontal
}

class PanDirectionGestureRecognizer: UIPanGestureRecognizer {
    let direction: PanDirection
    
    init(direction: PanDirection, target: Any?, action: Selector?) {
        self.direction = direction
        super.init(target: target, action: action)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        
        if state == .began {
            let velo = velocity(in: view)
            switch direction {
            case .horizontal where abs(velo.y) > abs(velo.x):
                state = .cancelled
            case .vertical where abs(velo.x) > abs(velo.y):
                state = .cancelled
            default:
                break
            }
        }
    }
}
