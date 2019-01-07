//
//  ViewController.swift
//  CollectionViewWithSwipeAction
//
//  Created by Migu on 2019/1/7.
//  Copyright © 2019 VIctorChee. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    var willDeleteCellIndexPath: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
    
        // Configure the cell
//        cell.deletePanGesture?.delegate = self
        cell.titleLabel.backgroundColor = indexPath.section == 0 ? UIColor.cyan : UIColor.orange
        cell.titleLabel.text = "\(indexPath.item)"
        cell.deleteButtonVisibleHandler = {
            if let deletingIndexPath = self.willDeleteCellIndexPath, deletingIndexPath != indexPath, let deletingCell = collectionView.cellForItem(at: deletingIndexPath) as? SwipableCollectionViewCell {
                deletingCell.renew() // 保证只有一个正在删除
            }
            self.willDeleteCellIndexPath = indexPath
        }
        cell.deleteButtonTappedHandler = { sender in
            print("Delete button tapped")
        }
    
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let layout = collectionViewLayout as? UICollectionViewFlowLayout else { return CGSize.zero }
        let width = collectionView.frame.width - layout.sectionInset.left - layout.sectionInset.right
        let height = layout.itemSize.height
        return CGSize(width: width, height: height)
    }
}

extension ViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
