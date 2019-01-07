//
//  SwipableCollectionViewCell.swift
//  CollectionViewWithSwipeAction
//
//  Created by Migu on 2019/1/7.
//  Copyright © 2019 VIctorChee. All rights reserved.
//

import UIKit

class SwipableCollectionViewCell: UICollectionViewCell {
    private var origin = CGPoint.zero
    private let deleteButtonWidth: CGFloat = 60
    var deletePanGesture: UIPanGestureRecognizer?
    var deleteButton: UIButton?
    
    var deleteButtonTitle: String = "Delete" {
        didSet {
            self.deleteButton?.setTitle(deleteButtonTitle, for: .normal)
        }
    }
    var enableSwipeDelete = false {
        didSet {
            if enableSwipeDelete {
                let button = UIButton(type: .custom)
                button.backgroundColor = UIColor.red
                button.setTitle(deleteButtonTitle, for: .normal)
                button.setTitleColor(UIColor.white, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
                button.titleLabel?.numberOfLines = 0
//                button.setImage(UIImage(named: "user_collection_delete"), for: .normal)
                button.addTarget(self, action: #selector(deleteButtonTapped(_:)), for: .touchUpInside)
                insertSubview(button, belowSubview: contentView)
                button.translatesAutoresizingMaskIntoConstraints = false
                button.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
                button.topAnchor.constraint(equalTo: topAnchor).isActive = true
                button.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
                button.widthAnchor.constraint(equalToConstant: deleteButtonWidth).isActive = true
                self.deleteButton = button
                
                deletePanGesture = PanDirectionGestureRecognizer(direction: .horizontal, target: self, action: #selector(pan(_:)))
                addGestureRecognizer(deletePanGesture!)
            }
        }
    }
    
    var deleteButtonVisibleHandler:(() -> Void)?
    var deleteButtonTappedHandler:((UIButton) -> Void)?
    
    /// 从删除状态恢复
    func renew() {
        if contentView.frame.equalTo(bounds) { return }
        UIView.animate(withDuration: 0.25, animations: {
            self.contentView.frame = self.bounds
        })
    }
    
    @objc private func pan(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self)
        switch sender.state {
        case .began:
            origin = translation
            
        case .changed:
            let offsetX = translation.x - origin.x
            if abs(offsetX) > abs(translation.y - origin.y) { // 横向滑动
                let targetX = contentView.center.x + offsetX
                if targetX <= bounds.midX && targetX >= bounds.midX - deleteButtonWidth {
                    contentView.center = CGPoint(x: targetX, y: contentView.center.y)
                }
            }
            
        case .ended:
            let offsetX = translation.x - origin.x
            var targetX = contentView.center.x + offsetX
            if targetX > bounds.midX - deleteButtonWidth / 2 {
                targetX = bounds.midX
            } else {
                targetX = bounds.midX - deleteButtonWidth
            }
            UIView.animate(withDuration: 0.25, animations: {
                self.contentView.center = CGPoint(x: targetX, y: self.contentView.center.y)
            }) { _ in
                if self.contentView.center.x < self.bounds.midX {
                    self.deleteButtonVisibleHandler?()
                }
            }
            
        default: break
        }
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        deleteButtonTappedHandler?(sender)
    }
}
