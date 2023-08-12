//
//  ButtonViews.swift
//  MarketPlace
//
//  Created by mac on 2023/3/6.
//

import UIKit

class LeftImgRightTitleButton : UIButton{
    
    var font : UIFont? {didSet{myTitleLabel.font = font!}}

    var title : String? {didSet{
        myTitleLabel.text = title
        updateContaints()
    }}
    /// 图片和title的间距
    var margin : Int = 10 {didSet {updateContaints()}}
    var textColor : UIColor = kBlackTextColor { didSet{  myTitleLabel.textColor = textColor}}
    var imageWidth : CGFloat = 20 { didSet{ updateContaints()}}
    var image : UIImage? { didSet{
        myImageView.image = image
        updateContaints()
    }}
    
    var imageUrl : String? { didSet{
        if let imageUrl{
            myImageView.kf.setImage(with: imageUrl)
            updateContaints()
    }}}
    func updateContaints() {
         if let _ = title  {
            if (image != nil || imageUrl != nil){
                myImageView.snp.remakeConstraints({ make in
                    make.left.equalToSuperview()
                    make.height.width.equalTo(self.imageWidth)
                    make.centerY.equalToSuperview()
                })
                myTitleLabel.snp.remakeConstraints({ make in
                    make.left.equalTo(myImageView.snp.right).offset(margin)
                    make.right.centerY.equalToSuperview()
                })
            }else{
                myTitleLabel.snp.remakeConstraints({ make in
                    make.left.equalToSuperview()
                    make.right.centerY.equalToSuperview()
                })
            }
        }
    }

    var isRotaing = false {
        didSet{
            if isRotaing {
                myImageView.addRotatingAnimation()
            }else{
                myImageView.removeAnimation()
            }
        }
    }
    let myTitleLabel = UILabel()
    let myImageView = UIImageView()
    override init(frame: CGRect) {
        
        super.init(frame: frame)
                
        self.addSubview(myTitleLabel)
        self.addSubview(myImageView)
        myTitleLabel.textColor = textColor
        myTitleLabel.font = FONT_R(size: 12)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//segmentView
class SegmentView : UIView{
        
    var selectRow = 0 {
        didSet{
//            segmentedView.selectItemAt(index: selectRow)
//            segmentedView.reloadData()
            
            segmentedView.defaultSelectedIndex = selectRow
        }
    }
    
    var isShowRedPoint = false {
        didSet{
            dotDataSource.isTitleColorGradientEnabled = isShowRedPoint
            segmentedView.dataSource = dotDataSource
            dotDataSource.dotColor = .hexColor("#F75F52")
            dotDataSource.dotSize = CGSize(width: 6.0, height: 6.0)
            dotDataSource.dotOffset = CGPoint(x: 10, y: 9)
            segmentedView.reloadData()
        }
    }
    
    var clickAt : SelectBlock?
    lazy var lineView = JXSegmentedIndicatorLineView()
    lazy var segmentedViewDataSource =  JXSegmentedTitleDataSource() // JXSegmentedTitleImageDataSource()
    lazy var dotDataSource = JXSegmentedDotDataSource()
    lazy var segmentedView = JXSegmentedView()
    var isShowBottomLine = true {
        didSet{
            if !isShowBottomLine {
                bottonLineView.isHidden = true
            }
        }
    }
    var titles : [String] = [] {
        didSet{
            segmentedViewDataSource.titles = titles
            segmentedView.reloadData()
        }
    }
    let bottonLineView = UIView()

//    open var normalImageInfos: [String]? {
//        didSet{
//            if let normalImageInfos{
//
//                segmentedViewDataSource.normalImageInfos = normalImageInfos
//            }
//        }
//    }
//    open var selectedImageInfos: [String]?{
//        didSet{
//            if let selectedImageInfos{
//
//                segmentedViewDataSource.selectedImageInfos = selectedImageInfos
//            }
//        }
//    }
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        lineView.indicatorColor = kMainColor
        lineView.verticalOffset = 0.5
        lineView.indicatorWidth = 20
        lineView.indicatorHeight = 2

//        segmentedViewDataSource.titleImageType = .leftImage
//        segmentedViewDataSource.imageSize = CGSize(width: 14, height: 14)
        segmentedViewDataSource.titleNormalColor = .hexColor("#999999")
        segmentedViewDataSource.titleSelectedColor = .hexColor("#333333")
        segmentedViewDataSource.titleNormalFont = FONT_SB(size: 14)
        segmentedViewDataSource.titleSelectedFont = FONT_SB(size: 14)
//        segmentedViewDataSource.isTitleColorGradientEnabled = true
        segmentedViewDataSource.itemSpacing = 20
        segmentedViewDataSource.isItemSpacingAverageEnabled = false
        segmentedView.indicators = [lineView]
        segmentedView.defaultSelectedIndex = 0
        segmentedView.delegate = self
        segmentedView.dataSource = self.segmentedViewDataSource
        segmentedView.collectionView.contentOffset = CGPoint(x: 0, y: 10)
        segmentedView.contentScrollView?.isScrollEnabled = true
        
        
        self.addSubview(segmentedView)
        
        segmentedView.snp.makeConstraints { make in
            
            make.left.top.bottom.right.equalToSuperview()
        }
        
        bottonLineView.backgroundColor = kLineColor
        segmentedView.addSubview(bottonLineView)
        bottonLineView.snp.makeConstraints { make in

            make.left.right.bottom.equalToSuperview()
            make.bottom.equalToSuperview().offset(-0.5)
            make.height.equalTo(0.5)
        }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - JXSegmentedViewDelegate
extension SegmentView : JXSegmentedViewDelegate{

    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
        self.clickAt?(index)
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, scrollingFrom leftIndex: Int, to rightIndex: Int, percent: CGFloat) {
        
    }
    
    func segmentedView(_ segmentedView: JXSegmentedView, canClickItemAt index: Int) -> Bool {
        return true
    }
}

class TitleImgButton : ZQButton{
    let disposeBag = DisposeBag()

    var font : UIFont? {didSet{myTitleLabel.font = font!}}
    var isMarginEqual  = false { didSet{  updateContaints()}} // 在左右只有一张图时有效
    var title : String? {didSet{
        myTitleLabel.text = title
        updateContaints()
    }}
    /// 图片和title的间距
    var margin : CGFloat = 0 {didSet {updateContaints()}}
    var imageMargin : CGFloat = 0 {didSet {updateContaints()}}
    var textColor : UIColor = kBlackTextColor { didSet{  myTitleLabel.textColor = textColor}}
    var imageWidth : CGFloat = 0 { didSet{ updateContaints()}}
    var leftImageWidth : CGFloat = 0 { didSet{
        leftImageView.snp.updateConstraints({ make in
            make.height.width.equalTo(self.leftImageWidth)
        })
    }}
    var rightImageWidth : CGFloat = 0 { didSet{
        rightImageView.snp.updateConstraints({ make in
            make.height.width.equalTo(self.rightImageWidth)
        })
    }}
    var leftMageMargin : CGFloat = 0 {didSet {
        leftImageView.snp.updateConstraints({ make in
            make.left.equalTo(leftMageMargin)
        })
    }}

    var leftImage : UIImage? { didSet{
        leftImageView.image = leftImage
        updateContaints()
    }}
    var rightImage : UIImage? { didSet{
        rightImageView.image = rightImage
        updateContaints()
    }}
    
    func setRightImage(_ rightImage:UIImage? , withState state : UIControl.State){
        rightImageView.image = rightImage
        updateContaints()
    }

    var textAligment : NSTextAlignment = .center {
        didSet{
            myTitleLabel.textAlignment = textAligment
        }
    }
    var leftImageUrl : String? { didSet{
        if let leftImageUrl{
            leftImageView.kf.setImage(with: leftImageUrl, placeholder: UIImage(named: "USDT"))
            updateContaints()
    }}}
    var rightImageUrl : String? { didSet{
        if let rightImageUrl{
            rightImageView.kf.setImage(with: rightImageUrl)
            updateContaints()
    }}}
    
    var setCorner: CGFloat? {
        didSet{
            if let setCorner{
                leftImageView.corner(cornerRadius: setCorner)
            }
        }
    }
    
    enum ImageDirection {
        case up
        case down
    }
    var rightImageDirection : ImageDirection?{
        didSet{
            if let rightImageDirection{
                switch rightImageDirection {
                case .up:
                    self.rightImageView.transform = CGAffineTransformMakeRotation(-Double.pi)
                    print("")
                case .down:
                    print("")
                    self.rightImageView.transform = CGAffineTransformMakeRotation(0/180 * Double.pi)
                }
            }
        }
    }

    func updateContaints() {
         if let _ = title  {
             
             let isHaveLeftImage = leftImage != nil || leftImageUrl != nil
             let isHaveRightImage = rightImage != nil || rightImageUrl != nil
             
             if (isHaveLeftImage && isHaveRightImage){
                 leftImageView.snp.remakeConstraints({ make in
                     make.left.equalToSuperview().offset(self.imageMargin)
                     make.height.width.equalTo(self.imageWidth)
                     make.centerY.equalToSuperview()
                 })
                 rightImageView.snp.remakeConstraints({ make in
                     make.right.equalToSuperview().offset(-self.imageMargin)
                     make.height.width.equalTo(self.imageWidth)
                     make.centerY.equalToSuperview()
                 })
                 myTitleLabel.snp.remakeConstraints({ make in
                     make.left.equalTo(leftImageView.snp.right).offset(margin)
                     make.right.equalTo(rightImageView.snp.left).offset(-margin)
                     make.center.equalToSuperview()
                 })
             }else if (isHaveLeftImage){
                leftImageView.snp.remakeConstraints({ make in
                    make.left.equalToSuperview().offset(self.imageMargin)
                    make.height.width.equalTo(self.imageWidth)
                    make.centerY.equalToSuperview()
                })
                myTitleLabel.snp.remakeConstraints({ make in
                    make.left.equalTo(leftImageView.snp.right).offset(margin)
                    make.centerY.equalToSuperview()
                    if isMarginEqual {
                        make.right.equalToSuperview().offset(-(self.imageMargin + self.imageWidth + self.margin))
                    }else{
                        make.right.equalToSuperview().offset(-self.margin)
                    }
                })
            }else if (isHaveRightImage){
                rightImageView.snp.remakeConstraints({ make in
                    make.right.equalToSuperview().offset(-self.imageMargin)
                    make.height.width.equalTo(self.imageWidth)
                    make.centerY.equalToSuperview()
                })
                myTitleLabel.snp.remakeConstraints({ make in
                    make.right.equalTo(rightImageView.snp.left).offset(-margin)
                    make.centerY.equalToSuperview()
                    if isMarginEqual {
                        make.left.equalToSuperview().offset((self.imageMargin + self.imageWidth + self.margin))
                    }else{
                        make.left.equalToSuperview().offset(self.margin)
                    }
                })
            }else{
                myTitleLabel.snp.remakeConstraints({ make in
                    make.left.equalToSuperview().offset(margin)
                    make.right.equalToSuperview().offset(-margin)
                    make.center.equalToSuperview()
                })
            }
         }else{
             let isHaveLeftImage = leftImage != nil || leftImageUrl != nil
             let isHaveRightImage = rightImage != nil || rightImageUrl != nil
             
             if (isHaveLeftImage && isHaveRightImage){
                 leftImageView.snp.remakeConstraints({ make in
                     make.left.equalToSuperview().offset(self.imageMargin)
                     make.height.width.equalTo(self.imageWidth)
                     make.centerY.equalToSuperview()
                 })
                 rightImageView.snp.remakeConstraints({ make in
                     make.right.equalToSuperview().offset(-self.imageMargin)
                     make.height.width.equalTo(self.imageWidth)
                     make.centerY.equalToSuperview()
                 })
             }
         }
    }

    let myTitleLabel = UILabel()
    var leftImageView = UIImageView()
    let rightImageView = UIImageView()
    override init(frame: CGRect) {
        
        super.init(frame: frame)
              
        self.addSubview(myTitleLabel)
        self.addSubview(leftImageView)
        self.addSubview(rightImageView)
        myTitleLabel.textColor = textColor
        myTitleLabel.textAlignment = .center
        myTitleLabel.font = FONT_R(size: 12)
        leftImageView.contentMode = .scaleAspectFit
        rightImageView.contentMode = .scaleAspectFit

    }
    
    func setProperties( leftImage:UIImage? = nil ,
                        rightImage:UIImage? = UIImage(named: "wallet_down")?.withTintColor(kBlack3TextColor),
                        title:String ,
                        font:UIFont = FONT_R(size: 15),
                        textColor : UIColor = kBlack3TextColor,
                        backgroundColor: UIColor = kBtnGreyBackgrondColor,
                        margin: CGFloat = 5,
                        imageWidth: CGFloat = 10 ,
                        imageMargin: CGFloat = 5 ,
                        corner :CGFloat = 6,isEqualMargin : Bool = true)
    {
        
        self.backgroundColor = backgroundColor
        self.isMarginEqual = isEqualMargin
        self.leftImage = leftImage
        self.rightImage = rightImage
        self.title = title
        self.margin = margin
        self.imageWidth = imageWidth
        self.imageMargin = imageMargin
        self.textColor = textColor
        self.font = font
        self.corner(cornerRadius: corner)
    }
    
    var leftClick : NormalBlock?
    var isAddLeftCLick:Bool {
        set{if newValue{
            let leftBtn = ZQButton()
            leftBtn.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self else {return}
                self.leftClick?()
            }).disposed(by: disposeBag)
            self.addSubview(leftBtn)
            let width = self.margin + self.imageWidth + self.imageMargin
            leftBtn.snp.makeConstraints { make in
                make.width.equalTo(width)
                make.left.bottom.top.equalToSuperview()
            }
        }}get{
            return false
        }
    }
    
    var rightClick : NormalBlock?
    var isAddRightCLick:Bool {
        set{if newValue{
            let rightBtn = ZQButton()
            rightBtn.rx.tap.subscribe(onNext: { [weak self] in
                guard let self = self else {return}
                self.rightClick?()
            }).disposed(by: disposeBag)
            self.addSubview(rightBtn)
            let width = self.margin + self.imageWidth + self.imageMargin
            rightBtn.snp.makeConstraints { make in
                make.width.equalTo(width)
                make.right.bottom.top.equalToSuperview()
            }
        }}get{
            return false
        }
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        self.addSubview(myTitleLabel)
        self.addSubview(leftImageView)
        self.addSubview(rightImageView)
        myTitleLabel.textColor = textColor
        myTitleLabel.textAlignment = .center
        myTitleLabel.font = FONT_R(size: 12)
        leftImageView.contentMode = .scaleAspectFit
        rightImageView.contentMode = .scaleAspectFit
    }
}

class ImageButton : UIButton{
 
    override func setTitle(_ title: String?, for state: UIControl.State) {
        super.setTitle(title, for: state)
        self.titleLabel?.isHidden = true
        content.title = title
    }
    override func setTitleColor(_ color: UIColor?, for state: UIControl.State) {
        super.setTitleColor(color, for: state)
        content.textColor = color ?? kBlackTextColor
    }
    override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        self.imageView?.isHidden = true
        content.image = image
    }
    var content = LeftImgRightTitleButton()
    let contentImageView = UIImageView()
    var imgUrl : String?{
        didSet{
            if let imgUrl{
                contentImageView.kf.setImage(with: imgUrl , completionHandler: {[weak self] _ in
                    guard let self = self else {return}
                    
                    self.isShowImage = true
                    self.closeBtn.isHidden = false
                    self.content.isHidden = true
                })
            }
        }
    }
    
    var contentImg = UIImage(named:"") {
        didSet{
            contentImageView.image = contentImg
            closeBtn.isHidden = false
            playBtn.isHidden = false
        }
    }
    
    var isShowImage = false{
        didSet{
            contentImageView.isHidden = !isShowImage
        }
    }
    
    let disposebag = DisposeBag()
    var playBlock:NormalBlock?
    var contentClick:NormalBlock?
    var closeBtn = ZQButton()
    var playBtn = ZQButton()
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setUI()
//        contentImageView.addSubview(closeBtn)
//        closeBtn.setImage(UIImage(named: "c2c_close"), for: .normal)
//        closeBtn.snp.makeConstraints { make in
//            make.top.right.equalToSuperview()
//        }
        
        
    }
    
    func setUI(){
        self.titleLabel?.isHidden = true
        self.imageView?.isHidden = true
        self.addSubview(contentImageView)
        contentImageView.isHidden = isShowImage
        contentImageView.snp.makeConstraints { make in
            
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
        self.addSubview(content)
        content.snp.makeConstraints { make in
            
            make.center.equalToSuperview()
        }
        content.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else{return}
            self.contentClick?()
        }).disposed(by: disposebag)
        
        
        self.addSubview(closeBtn)
        closeBtn.isHidden = true
        closeBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else{return}
            self.contentImageView.image = nil
//            self.content.isHidden = false
            self.closeBtn.isHidden = true
            self.playBtn.isHidden = true
        }).disposed(by: disposebag)
        closeBtn.setImage(UIImage(named: "c2c_video_close"), for: .normal)
        closeBtn.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        self.addSubview(playBtn)
        playBtn.isHidden = true
        playBtn.setImage(UIImage(named: "c2c_play"), for: .normal)
        playBtn.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.width.height.equalTo(24)
        }
        playBtn.rx.tap.subscribe(onNext: { [weak self] _ in
            guard let self = self else{return}
            
            self.playBlock?()
        }).disposed(by: disposebag)
    }

    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUI()
    }
}
//@IBDesignable extension UIView {
//    @IBInspectable var borderColor: UIColor? {
//        set {
//            layer.borderColor = newValue?.cgColor
//        }
//        get {
//            guard let color = layer.borderColor else {
//                return nil
//            }
//            return UIColor(cgColor: color)
//        }
//    }
//    @IBInspectable var borderWidth: CGFloat {
//        set {
//            layer.borderWidth = newValue
//        }
//        get {
//            return layer.borderWidth
//        }
//    }
//    @IBInspectable var cornerRadius: CGFloat {
//        set {
//            layer.cornerRadius = newValue
//            clipsToBounds = newValue > 0
//        }
//        get {
//            return layer.cornerRadius
//        }
//    }
//}
