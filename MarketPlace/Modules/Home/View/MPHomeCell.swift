//
//  MPHomeCell.swift
//  MarketPlace
//
//  Created by mac on 2023/7/19.
//

import UIKit

class MPHomeCell: UITableViewCell,UICollectionViewDelegate,UICollectionViewDataSource {

    //某一区的图片广告 默认隐藏 高度 = 0
    @IBOutlet weak var topImageBanner: UIImageView!
    
    @IBOutlet weak var bannerHieght: NSLayoutConstraint!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let itemWidth : CGFloat = floor(SCREEN_WIDTH-20)/3
        let flow = UICollectionViewFlowLayout()
        flow.itemSize = CGSize(width: itemWidth, height: itemWidth)
        flow.minimumLineSpacing = 0
        flow.minimumInteritemSpacing = 0
        flow.scrollDirection = .vertical
        collectionView.isScrollEnabled = false
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.collectionViewLayout = flow
        collectionView.register(MPHomeSectionCell.self)
        
  
        
    }
    
 

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    var dataSource : [[String : String]] = [[:]]{
        
        didSet{
            collectionView.reloadData()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(dataSource.count)
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withType: MPHomeSectionCell.self, for: indexPath)
        cell.backgroundColor = UIColor.clear
        
        if  let dicarr = dataSource[indexPath.item] as? [String: Any],
            let text = dicarr["text"] as? String , let image = dicarr["img"] as? String {
            if let image = UIImage(named: image){
                cell.locaImage.image = image
            }
            
            cell.nameLable.text = text.localString()
        }
         
      
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        print("点击了\(indexPath.row)个")
    }
    
    
}
