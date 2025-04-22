//
//  SC_Driving_Test_Essentials_Introduction_View.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/22.
//

import UIKit
import JY_Toolbox

class SC_Driving_Test_Essentials_Introduction_View: JY_View {
    
    private lazy var yq_image_array: [(imageName: String, imageSize: CGSize)] = {
        
        return  [
            (imageName: "8d00b457db48f35cfafbbda397cacdc2", imageSize: CGSize(width: 345, height: 507)),
            (imageName: "fb065874a8fa6a3c24f908404b6fdd0a", imageSize: CGSize(width: 345, height: 792)),
            (imageName: "9a030013fa2a6324c5e312148b49e71b", imageSize: CGSize(width: 345, height: 353)),
        ]
        
    }()
    
    private lazy var yq_edgeInsets_left: CGFloat = 15

    private lazy var yq_collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        view.dataSource = self
        view.delegate = self
        
        view.register(SC_Driving_Test_Essentials_Introduction_Style1_Cell.self, forCellWithReuseIdentifier: SC_Driving_Test_Essentials_Introduction_Style1_Cell.yq_ID())
        view.register(SC_Driving_Test_Essentials_Introduction_Style2_Cell.self, forCellWithReuseIdentifier: SC_Driving_Test_Essentials_Introduction_Style2_Cell.yq_ID())
        
        return view
    }()

}

extension SC_Driving_Test_Essentials_Introduction_View {
    override func yq_add_subviews() {
        super.yq_add_subviews()
        
        addSubview(yq_collectionView)
    }
}

extension SC_Driving_Test_Essentials_Introduction_View {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        yq_collectionView.frame.origin = {
            yq_collectionView.frame.size = bounds.size
            
            yq_collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: safeAreaInsets.bottom, right: 0)
            yq_collectionView.reloadData()
            
            return bounds.origin
        }()
    }
}

extension SC_Driving_Test_Essentials_Introduction_View: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 1 : yq_image_array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SC_Driving_Test_Essentials_Introduction_Style1_Cell.yq_ID(), for: indexPath) as? SC_Driving_Test_Essentials_Introduction_Style1_Cell else {
                return SC_Driving_Test_Essentials_Introduction_Style1_Cell()
            }
            
            cell.yq_set(scale: yq_scale)
            
            return cell
        }
        else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SC_Driving_Test_Essentials_Introduction_Style2_Cell.yq_ID(), for: indexPath) as? SC_Driving_Test_Essentials_Introduction_Style2_Cell else {
                return SC_Driving_Test_Essentials_Introduction_Style2_Cell()
            }
            
            cell.yq_imageName = yq_image_array[indexPath.row].imageName
            
            return cell
        }
        
    }
}

extension SC_Driving_Test_Essentials_Introduction_View: UICollectionViewDelegate {
    
}

extension SC_Driving_Test_Essentials_Introduction_View: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 0 {
            return CGSize(width: collectionView.frame.width, height: 93 * yq_scale)
        }
        else {
            let imageData = yq_image_array[indexPath.row]
            
            let width = collectionView.frame.width - yq_edgeInsets_left * yq_scale * 2
            let height = width * (imageData.imageSize.height / imageData.imageSize.width)
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        if section == 0 {
            return UIEdgeInsets(top: 20 * yq_scale, left: 0, bottom: 15 * yq_scale, right: 0)
        }
        else {
            return UIEdgeInsets(top: 0, left: yq_edgeInsets_left * yq_scale, bottom: 0, right: yq_edgeInsets_left * yq_scale)
        }
        
    }
}
