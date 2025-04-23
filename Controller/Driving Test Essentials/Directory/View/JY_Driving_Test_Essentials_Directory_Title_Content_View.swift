//
//  JY_Driving_Test_Essentials_Directory_Title_Content_View.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/23.
//

import UIKit
import JY_Toolbox

class JY_Driving_Test_Essentials_Directory_Title_Content_View: JY_View {
    
    var yq_current_selected_index_change_block: ((_ currentIndex: Int, _ titleArray: [JY_Driving_Test_Essentials_Directory_Title_View_Model]) -> Void)?
    
    private lazy var yq_current_selected_index: Int = 0 {
        didSet {
            if yq_current_selected_index_change_block != nil {
                yq_current_selected_index_change_block!(yq_current_selected_index, yq_title_model_array)
            }
        }
    }
    
    private lazy var yq_collectionView_contentSize: CGSize = .zero
    private lazy var yq_edgeInsets: UIEdgeInsets = .zero
    
    private lazy var yq_title_model_array: [JY_Driving_Test_Essentials_Directory_Title_View_Model] = [JY_Driving_Test_Essentials_Directory_Title_View_Model]()
    
    private lazy var yq_calue_cell: JY_Driving_Test_Essentials_Directory_Title_Cell = JY_Driving_Test_Essentials_Directory_Title_Cell()
    private lazy var yq_collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        view.dataSource = self
        view.delegate = self
        
        view.contentInsetAdjustmentBehavior = .never
        view.automaticallyAdjustsScrollIndicatorInsets = false
        
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        
        view.register(JY_Driving_Test_Essentials_Directory_Title_Cell.self, forCellWithReuseIdentifier: JY_Driving_Test_Essentials_Directory_Title_Cell.yq_ID())
        
        return view
    }()
}

extension JY_Driving_Test_Essentials_Directory_Title_Content_View {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_collectionView)
    }
}

extension JY_Driving_Test_Essentials_Directory_Title_Content_View {
    func yq_set(titleArray: [JY_Driving_Test_Essentials_Directory_Title_View_Model]) {
        yq_title_model_array = titleArray
        yq_collectionView.reloadData()
    }
    
    func yq_set(currentIndex: Int) {
        yq_current_selected_index = currentIndex
        
        if currentIndex < yq_title_model_array.count && currentIndex > 0 {
            yq_collectionView.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
        
        yq_collectionView.reloadData()
    }
}

extension JY_Driving_Test_Essentials_Directory_Title_Content_View {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_collectionView.frame.origin = {
            yq_collectionView.frame.size = bounds.size
            yq_collectionView.reloadData()
            return CGPoint.zero
        }()
        
        DispatchQueue.main.async { [weak self] in
            self?.yq_calue_edgeInsets()
        }
    }
    
    private func yq_calue_edgeInsets() {
        let contentSize = yq_collectionView.contentSize
        
        if yq_collectionView_contentSize != contentSize {
            yq_collectionView_contentSize = contentSize
            let insetLeft = (yq_collectionView.frame.width - contentSize.width) * 0.5
            
            if insetLeft <= 15 * yq_scale {
                yq_edgeInsets = UIEdgeInsets(top: 0, left: 15 * yq_scale, bottom: 0, right: 15 * yq_scale)
            }else{
                yq_edgeInsets = UIEdgeInsets(top: 0, left: insetLeft, bottom: 0, right: insetLeft)
            }
            
            yq_collectionView.reloadData()
        }
    }
}

extension JY_Driving_Test_Essentials_Directory_Title_Content_View: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yq_title_model_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JY_Driving_Test_Essentials_Directory_Title_Cell.yq_ID(), for: indexPath) as? JY_Driving_Test_Essentials_Directory_Title_Cell else {
            return JY_Driving_Test_Essentials_Directory_Title_Cell()
        }
        
        let titleData = yq_title_model_array[indexPath.row]
        cell.yq_set(title: titleData.yq_title, isSelected: yq_current_selected_index == indexPath.row, scale: yq_scale)
        
        return cell
    }
}

extension JY_Driving_Test_Essentials_Directory_Title_Content_View: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        yq_set(currentIndex: indexPath.row)
    }
}

extension JY_Driving_Test_Essentials_Directory_Title_Content_View: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return yq_calue_cell.yq_size(title: yq_title_model_array[indexPath.row].yq_title, scale: yq_scale)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18 * yq_scale
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return yq_edgeInsets
    }
}
