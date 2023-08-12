//
//  HPAlertControllerView.swift
//  Custom Alert
//
//  Created by Hugo Pivaral on 24/05/22.
//

import UIKit


public class HPAlertController: UIViewController {
    
    // MARK: - PROPERTIES
    
    private var padding: CGFloat = 12

    private var alertTintColor: UIColor!
    
    private var alertIcon: HPAlertIcon!
    private var textAligtment: NSTextAlignment!

    private var alertTitle: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    private var alertMessage: String? {
        get {
            messageLabel.text
        }
        set {
            messageLabel.attributedText = NSAttributedString(string: newValue ?? "", attributes: messageLabelAttributes)
        }
    }
    
    private var messageLabelAttributes: [NSAttributedString.Key : Any] = {
        var attributes: [NSAttributedString.Key : Any] = [:]
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 2
        paragraphStyle.alignment = .center
        
        attributes = [NSAttributedString.Key.foregroundColor : kBlackTextColor,
                      NSAttributedString.Key.paragraphStyle : paragraphStyle,
                      NSAttributedString.Key.font : FONT_SB(size: 16) ]
        
        return attributes
    }()
    
    

    // MARK: - INITIALIZERS
    
    public init(title: String, message: String, icon: HPAlertIcon = .none, alertTintColor: UIColor , textAligment :NSTextAlignment = .center ) {
        super.init(nibName: nil, bundle: nil)
        self.alertTintColor = alertTintColor
        self.alertMessage = message
        self.alertTitle = title
        self.alertIcon = icon
        self.textAligtment = textAligment
        setUp()
        titleLabel.textAlignment = self.textAligtment
        messageLabel.textAlignment = self.textAligtment
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    // MARK: - VIEWS
    
    var cardView: UIView = {
        let cardView = UIView()
        
        cardView.backgroundColor = kMainBackgroundColor
        cardView.layer.cornerRadius = 12
        cardView.translatesAutoresizingMaskIntoConstraints = false
        
        return cardView
    }()
    
    // Stack views
    
    private var mainStackView: UIStackView = {
        let mainStackView = UIStackView()
        
        mainStackView.spacing = 25
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        return mainStackView
    }()
    
    private var labelsStackView: UIStackView = {
        let labelsStackView = UIStackView()
        
        labelsStackView.axis = .vertical
        labelsStackView.spacing = 15
        labelsStackView.alignment = .fill
        
        return labelsStackView
    }()
    
    private var buttonsStackView: UIStackView = {
        let buttonsStackView = UIStackView()
        
        buttonsStackView.axis = .horizontal
        buttonsStackView.spacing = 10
        buttonsStackView.alignment = .fill
        buttonsStackView.distribution = .fillEqually
        
        return buttonsStackView
    }()
    
    // Labels
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        
        titleLabel.font = FONT_SB(size: 20)
        titleLabel.textColor = kBlackTextColor
        titleLabel.numberOfLines = 1
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    private var messageLabel: UILabel = {
        let messageLabel = UILabel()
        
        messageLabel.font = FONT_SB(size: 16)
        messageLabel.textColor = kBlackTextColor
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return messageLabel
    }()
    
    // Icon
    
    lazy var iconContainerView: UIView = {
        let iconContainerView = UIView()
        
        iconContainerView.isHidden = alertIcon == HPAlertIcon.none ? true : false
        iconContainerView.translatesAutoresizingMaskIntoConstraints = false
        
        return iconContainerView
    }()
    
    lazy var iconBackgroundView: UIView = {
        let iconBackgroundView = UIView()
        
//        iconBackgroundView.backgroundColor = alertTintColor
//        iconBackgroundView.layer.cornerRadius = 65
        iconBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        return iconBackgroundView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = alertIcon.rawValue
        iconImageView.tintColor = kMainColor
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        return iconImageView
    }()
    
    var iconImageWidth: CGFloat = 200 {
        
        didSet{
            setConstraints()
        }
    }
    
    var isDarkMode: Bool = false {
        
        didSet{
            
            if isDarkMode {
             
                titleLabel.textColor = .white
                messageLabel.textColor = .white
                mainStackView.backgroundColor = kArtGreyColor
                cardView.backgroundColor = kArtGreyColor
                for button in buttonsStackView.arrangedSubviews {
    //                let button = HPAlertActionButton(action: action, tintColor: alertTintColor)
                    if  button.isKind(of: HPAlertActionButton.self) {
                        
                        let bbb = button as! HPAlertActionButton
                        bbb.backgroundColor = .white
                        bbb.titleLabel?.textColor = .black
                    }
                }
            }
        }
    }

    
    // MARK: - PRIVATE HELPERS
    
    private func setUp() {
        modalPresentationStyle = .overFullScreen
        modalTransitionStyle = .crossDissolve
        view.backgroundColor = .black.withAlphaComponent(0.2)
        setConstraints()
    }
    
    private func setConstraints() {
        view.addSubview(cardView)
        cardView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        cardView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        cardView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        
        cardView.addSubview(mainStackView)
        mainStackView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: padding).isActive = true
        mainStackView.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -padding).isActive = true
        mainStackView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: padding).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -padding).isActive = true
        
        mainStackView.addArrangedSubview(iconContainerView)
        iconContainerView.heightAnchor.constraint(equalToConstant: iconImageWidth).isActive = true
        
        iconContainerView.addSubview(iconBackgroundView)
        iconBackgroundView.heightAnchor.constraint(equalToConstant: iconImageWidth).isActive = true
        iconBackgroundView.widthAnchor.constraint(equalToConstant: iconImageWidth).isActive = true
        iconBackgroundView.centerXAnchor.constraint(equalTo: iconContainerView.centerXAnchor).isActive = true
        iconBackgroundView.centerYAnchor.constraint(equalTo: iconContainerView.centerYAnchor).isActive = true
        
        iconBackgroundView.addSubview(iconImageView)
        iconImageView.widthAnchor.constraint(equalToConstant: iconImageWidth).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: iconImageWidth).isActive = true
        iconImageView.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor).isActive = true
        iconImageView.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor).isActive = true
        
        mainStackView.addArrangedSubview(labelsStackView)
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(messageLabel)
        
        mainStackView.addArrangedSubview(buttonsStackView)
        
//        mainStackView.backgroundColor = .red
//        labelsStackView.backgroundColor = .blue
//        titleLabel.backgroundColor = .yellow
//        messageLabel.backgroundColor = .green
//        buttonsStackView.backgroundColor = kMainColor
        
    }
    
    // MARK: - PUBLIC METHODS
    
    public func addAction(_ action: HPAlertAction) {
        let button = HPAlertActionButton(action: action, tintColor: alertTintColor)
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        if #available(iOS 14.0, *) {
            button.addAction(UIAction(handler: { [weak self] _ in
                self?.dismiss(animated: true) {
                    action.handler()
                }
            }), for: .touchUpInside)
        } else {
            // Fallback on earlier versions
        }
        
        buttonsStackView.addArrangedSubview(button)
    }
}

internal class HPAlertActionButton: UIButton {
    
    // MARK: - PROPERTIES
    
    private var action: HPAlertAction!
    
    private lazy var buttonBackgroundColor: UIColor = {
        var buttonBackgroundColor = UIColor()
        
        switch action.style {
        case .default:
            buttonBackgroundColor = kMainColor
        case .cancel:
            buttonBackgroundColor = kInputBGColor
        case .gotIt:
            buttonBackgroundColor = kInputBGColor
        case .destructive:
            buttonBackgroundColor = kRedColor
        case .none:
            break
        }
        
        return buttonBackgroundColor
    }()
    
    private lazy var buttonTextColor: UIColor = {
        var buttonTextColor = UIColor()
        
        switch action.style {
        case .default:
            buttonTextColor = .white
        case .cancel:
            buttonTextColor = kBlackTextColor
        case .gotIt:
            buttonTextColor = kMainColor
        case .destructive:
            buttonTextColor = .white
        case .none:
            break
        }
        
        return buttonTextColor
    }()
    
    
    // MARK: - INITIALIZERS
    
    convenience init(action: HPAlertAction, tintColor: UIColor) {
        self.init(type: .custom)
        self.action = action
        self.tintColor = tintColor
        self.configureButton()
    }
    
    
    // MARK: - HELPERS
    
    func configureButton() {
        setTitle(action.title, for: .normal)
        setTitleColor(buttonTextColor, for: .normal)
        setTitleColor(buttonTextColor.withAlphaComponent(0.6), for: .highlighted)
        titleLabel?.font = FONT_SB(size: 16)
        backgroundColor = buttonBackgroundColor
        layer.cornerRadius = 6
        
    }
}


public class HPAlertAction: NSObject {
    
    private(set) var title: String!
    private(set) var style: HPAlertAction.Style!
    private(set) var handler: () -> Void
    
    public init(title: String, style: HPAlertAction.Style = .default, handler: @escaping () -> Void = {}) {
        self.title = title
        self.style = style
        self.handler = handler
    }
}

extension HPAlertAction {
    public enum Style {
        case `default`
        case cancel
        case gotIt
        case destructive
    }
}

public enum HPAlertIcon: Equatable {
    case error
    case info
    case success
    case custom(UIImage)
    case none
    
    public var rawValue: UIImage? {
        switch self {
        case .error:
            return UIImage(named: "warning")
        case .info:
            return UIImage(named: "warning")
        case .success:
            return UIImage(named: "done")
        case .custom(let icon):
            return icon
        case .none:
            return nil
        }
    }
}
