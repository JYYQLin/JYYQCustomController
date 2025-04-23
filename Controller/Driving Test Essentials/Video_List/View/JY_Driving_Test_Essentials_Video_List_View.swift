//
//  JY_Driving_Test_Essentials_Video_List_View.swift
//  JY_Project_Library
//
//  Created by One Lang on 2025/4/23.
//

import UIKit
import JY_Toolbox

class JY_Driving_Test_Essentials_Video_List_View: JY_View {

    var yq_current_selected_index_change_block: ((_ currentIndex: Int, _ viewModelArray: [JY_Driving_Test_Essentials_Video_View_Model]) -> Void)?
    
    private lazy var yq_current_selected_index: Int = 0 {
        didSet {
            if yq_current_selected_index_change_block != nil {
                yq_current_selected_index_change_block!(yq_current_selected_index, yq_video_array)
            }
        }
    }
    
    private lazy var yq_current_play_index: Int = 0
    private lazy var yq_video_array: [JY_Driving_Test_Essentials_Video_View_Model] = [JY_Driving_Test_Essentials_Video_View_Model]()
    
    private lazy var yq_collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        view.dataSource = self
        view.delegate = self
        
        view.contentInsetAdjustmentBehavior = .never
        view.automaticallyAdjustsScrollIndicatorInsets = false
        
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        
        view.register(JY_Driving_Test_Essentials_Video_List_Cell.self, forCellWithReuseIdentifier: JY_Driving_Test_Essentials_Video_List_Cell.yq_ID())
        
        return view
    }()

}

extension JY_Driving_Test_Essentials_Video_List_View {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_collectionView)
    }
}

extension JY_Driving_Test_Essentials_Video_List_View {
    func yq_set(videoArray: [JY_Driving_Test_Essentials_Video_View_Model]) {
        yq_video_array = videoArray
        yq_collectionView.reloadData()
    }
    
    func yq_set(currentIndex: Int) {
        yq_current_selected_index = currentIndex
        
        if currentIndex < yq_video_array.count && currentIndex > 0 {
            yq_collectionView.scrollToItem(at: IndexPath(row: currentIndex, section: 0), at: .top, animated: true)
        }
        
        yq_collectionView.reloadData()
    }
}

extension JY_Driving_Test_Essentials_Video_List_View {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_collectionView.frame.origin = {
            yq_collectionView.frame.size = bounds.size
            yq_collectionView.reloadData()
            return CGPoint.zero
        }()
    }
}

extension JY_Driving_Test_Essentials_Video_List_View: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return yq_video_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: JY_Driving_Test_Essentials_Video_List_Cell.yq_ID(), for: indexPath) as? JY_Driving_Test_Essentials_Video_List_Cell else {
            return JY_Driving_Test_Essentials_Video_List_Cell()
        }
        
        let video = yq_video_array[indexPath.row]
        cell.yq_set(viewModel: video, isPlay: indexPath.row == yq_current_play_index, scale: yq_scale)
        
        return cell
    }
}

extension JY_Driving_Test_Essentials_Video_List_View: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        yq_set(currentIndex: indexPath.row)
    }
}

extension JY_Driving_Test_Essentials_Video_List_View: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size = JY_Driving_Test_Essentials_Video_List_Cell.yq_size()
        
        let row = Int(collectionView.frame.width / size.width)
        
        if row <= 1 {
            return CGSize(width: collectionView.frame.width, height: size.height)
        }else {
            return CGSize(width: collectionView.frame.width / CGFloat(row), height: size.height)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 18 * yq_scale
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}
