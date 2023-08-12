//
//  UIView+Extension.swift
//  MarketPlace
//
//  Created by tanktank on 2022/4/20.
//

import Foundation
import UIKit
import RxSwift
 
extension UIView {
    
    @discardableResult
    func addGradient(colors: [UIColor],
                     point: (CGPoint, CGPoint) = (CGPoint(x: 0.5, y: 0), CGPoint(x: 0.5, y: 1)),
                     locations: [NSNumber] = [0, 1],
                     frame: CGRect = CGRect.zero,
                     radius: CGFloat = 0,
                     at: UInt32 = 0) -> CAGradientLayer {
        let bgLayer = CAGradientLayer()
        bgLayer.colors = colors.map { $0.cgColor }
        bgLayer.locations = locations
        if frame == .zero {
            bgLayer.frame = self.bounds
        } else {
            bgLayer.frame = frame
        }
        bgLayer.startPoint = point.0
        bgLayer.endPoint = point.1
        bgLayer.cornerRadius = radius
        self.layer.insertSublayer(bgLayer, at: at)
        return bgLayer
    }
    //将当前视图转为UIImage
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    func addRotatingAnimation(repeatCount:Float = HUGE)  {
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.toValue = Double.pi * 2.0
        rotationAnimation.duration = 1
        rotationAnimation.repeatCount = repeatCount
        self.layer.add(rotationAnimation, forKey: "transform.rotation.z")
    }
    func removeAnimation()  {
        
        self.layer.removeAllAnimations()
    }
    
    func addBottomLine(){
        
        let line = UIView()
        line.backgroundColor = kLineColor
        self.addSubview(line)
        line.snp.makeConstraints { make in

            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
    }
    
//    func controller(view:UIView)->UIViewController?{
//        var next:UIView? = view
//        repeat{
//            if let nextResponder = next?.next, nextResponder.isKindOfClass(UIViewController.self){
//                return (nextResponder as! UIViewController)
//            }
//            next = next?.superview
//        }while next != nil
//        return nil
//    }
    
    func viewCurrentVC(viewself:UIView)->UIViewController{

            var vc:UIResponder = viewself

            while vc.isKind(of: UIViewController.self) != true {

                vc = vc.next!

            }

            return vc as! UIViewController

        }
    
    /// xib快捷初始化
    class func fromNib() -> Self {
        return Bundle.main.loadNibNamed(self.className, owner: nil, options: nil)?.first as! Self
    }
    
    class func cellFromNib() -> UINib {
        return UINib.init(nibName: self.className, bundle: nil)
    }
    @IBInspectable
    var IB_cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable
    var IB_borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var IB_borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var IB_shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var IB_shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var IB_shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var IB_shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    /// 设置渐变色
    func configGradient(colors: [CGColor], startPoint: CGPoint, endPoint: CGPoint,bounds: CGRect) {
        let bgLayer = CAGradientLayer()
        bgLayer.colors = colors
        bgLayer.locations = [0, 1]
        bgLayer.frame = bounds
        bgLayer.startPoint = startPoint
        bgLayer.endPoint = endPoint
        bgLayer.cornerRadius = self.layer.cornerRadius
        self.layer.insertSublayer(bgLayer, at: 0)
    }
    
    //设置渐变色背景
    func setGradMainColor(size:CGSize = .zero){
        let leftColor = RGBCOLOR(r: 89, g: 160, b: 59)
        let rightColor =   RGBCOLOR(r: 18, g: 122, b: 40)
         
        var viewSize = size
        
        if viewSize.width == 0 {
            //默认不传递
            viewSize = self.bounds.size
        }
        print("====>\(viewSize.height)")
         
         self.configGradient(colors: [leftColor.cgColor,rightColor.cgColor], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 0), bounds: CGRect(x: 0, y: 0, width: viewSize.width, height:  viewSize.height ))
         
        
    }
}

// MARK: - 坐标
extension UIView {
    var x: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var y: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var centerX: CGFloat {
        set {
            var center = self.center
            center.x = newValue
            self.center = center
        }
        get {
            return self.center.x
        }
    }
    
    var centerY: CGFloat {
        set {
            var center = self.center
            center.y = newValue
            self.center = center
        }
        get {
            return self.center.y
        }
    }
    
    var width: CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.width
        }
    }
    
    var height: CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
    
    var size: CGSize {
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
        get {
            return self.frame.size
        }
    }
    
    var origin: CGPoint {
        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin
        }
    }
    
    var maxY: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
        get {
            return self.height + self.y
        }
    }
    
    var maxX: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get {
            return self.width + self.x
        }
    }
}

// MARK: - 圆角

extension UIView {
    func corner(cornerRadius : CGFloat, toBounds : Bool = true,borderColor : UIColor? = nil, borderWidth : CGFloat? = nil) {
        self.layer.masksToBounds = toBounds
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = borderColor?.cgColor
        if borderWidth != nil  {
            self.layer.borderWidth = borderWidth!
        }
    }
    
    /// 单独圆角
    /// - Parameters:
    ///   - conrners: 圆角枚举
    ///   - radius: 圆角大小
    /// - Returns: <#description#>
    @discardableResult
    func addCorner(conrners: UIRectCorner, radius: CGFloat) -> CAShapeLayer {
        let rect = self.bounds
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return maskLayer
    }
    
    func setShadow(width:CGFloat,bColor:UIColor,
                       sColor:UIColor,offset:CGSize,opacity:Float,radius:CGFloat) {
            //设置视图边框宽度
            self.layer.borderWidth = width
            //设置边框颜色
            self.layer.borderColor = bColor.cgColor
            //设置边框圆角
            self.layer.cornerRadius = radius
            //设置阴影颜色
            self.layer.shadowColor = sColor.cgColor
            //设置透明度
            self.layer.shadowOpacity = opacity
            //设置阴影半径
            self.layer.shadowRadius = radius
            //设置阴影偏移量
            self.layer.shadowOffset = offset
        }
    
    
}
// MARK: - 弹框消失动画
extension UIView {

    @discardableResult
    func removeTransition() -> CALayer {
        let transition = CATransition()
        let maskLayer = CALayer()
        transition.duration = 1.0
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom 
        maskLayer.add(transition, forKey: nil)
        return maskLayer
    }
    
}

extension UIView {

    @discardableResult
    func addCornerFrame(conrners: UIRectCorner, radius: CGFloat, frame: CGRect) -> CAShapeLayer {
        let rect = frame
        let maskPath = UIBezierPath(roundedRect: rect, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = rect
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
        return maskLayer
    }
    
}

extension UIView {
    //高斯模糊
    func blurEffect(){
        let blur = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        addSubview(effectView)
    }
    
    // 毛玻璃
    func effectViewWithAlpha(alpha:CGFloat) -> Void
    {
        let effect = UIBlurEffect.init(style: .light)
        let effectView = UIVisualEffectView.init(effect: effect)
        effectView.frame = self.bounds
        effectView.alpha = alpha
        
        self.addSubview(effectView)
    }

}

extension UIView {
    
    @discardableResult
    func addTapForView() ->(Observable<UITapGestureRecognizer>){
        
        return addTapForView(1)
    }
    @discardableResult
    func addTapForView(_ timeInterval : Int) ->(Observable<UITapGestureRecognizer>){
        let ges = UITapGestureRecognizer()
        self.addGestureRecognizer(ges)
        
        return ges.rx.event.throttle(RxTimeInterval.seconds(timeInterval), latest: true, scheduler: MainScheduler.instance)
    }
    
    func addLongPressForView() ->(Observable<UILongPressGestureRecognizer>){
        
        return addLongPressForView(1)
    }
    @discardableResult
    func addLongPressForView(_ timeInterval : Int) ->(Observable<UILongPressGestureRecognizer>){
        let ges = UILongPressGestureRecognizer()
        ges.minimumPressDuration = TimeInterval(timeInterval)
        self.addGestureRecognizer(ges)
        
        return ges.rx.event.throttle(RxTimeInterval.seconds(1), latest: true, scheduler: MainScheduler.instance)
    }

}

//extension UIView{
//    ///判断是否是邮箱
//    func checkEmail(email: String) -> Bool {
//        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//        
//        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
//        let isValid = predicate.evaluate(with: email)
//        print(isValid ? "正确的邮箱地址" : "错误的邮箱地址")
//        return isValid
//    }
//    
//    ///判断密码格式
//    func checkPwd(pwd: String) -> Bool {
//        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
//        
//        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
//        let isValid = predicate.evaluate(with: pwd)
//        print(isValid ? "正确的密码格式" : "错误的密码格式")
//        return isValid
//    }
//}

// MARK: - UIView extension
extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        var rect = bounds

        // Increase height (only useful for the iPhone X for now)
        if #available(iOS 11.0, *) {
            if let window = UIApplication.shared.windows.first {
                rect.size.height += window.safeAreaInsets.bottom
            }
        }

        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UILabel{
    
    @discardableResult
    func labelFactor(font : UIFont , textColor : UIColor , text : String?) -> UILabel {
        
        self.font = font
        self.textColor = textColor
        self.text = text
        return self
    }
    
}


//@IBDesignable
extension UIView {
    @IBInspectable
    var borderColor: UIColor? {
        set {
            layer.borderColor = newValue?.cgColor
        }
        get {
            guard let color = layer.borderColor else {
                return nil
            }
            return UIColor(cgColor: color)
        }
    }
    @IBInspectable
    var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
            clipsToBounds = newValue > 0
        }
        get {
            return layer.cornerRadius
        }
    }
}

/// Extend UITextView and implemented UITextViewDelegate to listen for changes
extension UITextView: UITextViewDelegate {
    
    
    
    /// Resize the placeholder when the UITextView bounds change
    override open var bounds: CGRect {
        didSet {
            self.resizePlaceholder()
        }
    }
    
    /// The UITextView placeholder text
    public var placeholder: String? {
        get {
            var placeholderText: String?
            
            if let placeholderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeholderLabel.text
            }
            
            return placeholderText
        }
        set {
            if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
                placeholderLabel.text = newValue
                placeholderLabel.sizeToFit()
            } else {
//                self.addPlaceholder(newValue!)
            }
        }
    }
    
    /// When the UITextView did change, show or hide the label based on if the UITextView is empty or not
    ///
    /// - Parameter textView: The UITextView that got updated
    public func textViewDidChange(_ textView: UITextView) {
        if let placeholderLabel = self.viewWithTag(100) as? UILabel {
            placeholderLabel.isHidden = !self.text.isEmpty
        }
        
        if let holderLabel = self.viewWithTag(1001) as? UILabel {
            holderLabel.isHidden = !self.text.isEmpty
        }
        
    
    }
    
    public func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if text.hasPrefix("\n") {
            return false
        }
        return true
    }
    
    /// Resize the placeholder UILabel to make sure it's in the same position as the UITextView text
    private func resizePlaceholder() {
        if let placeholderLabel = self.viewWithTag(100) as! UILabel? {
            let labelX = self.textContainer.lineFragmentPadding
            let labelY = self.textContainerInset.top - 2
            let labelWidth = self.frame.width - (labelX * 2)
            let labelHeight = placeholderLabel.frame.height

            placeholderLabel.frame = CGRect(x: labelX, y: labelY, width: labelWidth, height: labelHeight)
        }
    }
    
    /// Adds a placeholder UILabel to this UITextView
//    private func addPlaceholder(_ placeholderText: String) {
//        let placeholderLabel = UILabel()
//
//        placeholderLabel.text = placeholderText
//        placeholderLabel.sizeToFit()
//
//        placeholderLabel.font = self.font
//        placeholderLabel.textColor = UIColor.lightGray
//        placeholderLabel.tag = 100
//
//        placeholderLabel.isHidden = !self.text.isEmpty
//
//        self.addSubview(placeholderLabel)
//        self.resizePlaceholder()
//        self.delegate = self
//    }
    
    func addPlaceholder(placeholder:String) {

        let holderLab = UILabel()
        holderLab.text = placeholder
        holderLab.font = FONT_R(size: 14)
        holderLab.textColor = .hexColor("#999999")
        holderLab.tag = 1001
        holderLab.isHidden = !self.text.isEmpty
        self.addSubview(holderLab)
        holderLab.snp.makeConstraints { make in
            make.top.equalTo(10)
            make.left.equalTo(12)
            make.right.equalTo(-10)
        }
        
        self.delegate = self
    }
 
}
