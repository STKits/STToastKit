//
//  StonkToastBannerView.swift
//  StonkCommonKit
//
//  Created by yuanbin on 1/15/25.
//

import UIKit
import SnapKit

/// ToastView
public class StonkToastBannerView: UIView, StonkToastBaseView {
    
    private lazy var contentStackView:UIStackView = {
        let v = UIStackView()
        v.axis          = .horizontal
        v.distribution  = .fill
        v.alignment     = .center
        return v
    }()
    
    private lazy var labelStackView:UIStackView = {
        let v = UIStackView()
        v.axis          = .vertical
        v.distribution  = .fill
        v.alignment     = .fill
        return v
    }()
    
    private lazy var imageView:UIImageView = {
        let lab = UIImageView()
        lab.contentMode = .scaleAspectFit
        return lab
    }()
    
    private lazy var titleStackView:UIStackView = {
        let v = UIStackView()
        v.axis          = .horizontal
        v.distribution  = .equalSpacing
        v.alignment     = .center
        return v
    }()
    
    private lazy var titleLabel:UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 1
        lab.textAlignment = .left
        return lab
    }()
    
    private lazy var timeLabel:UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 1
        lab.textAlignment = .right
        return lab
    }()
    
    private lazy var subtitleLabel:UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 4
        lab.textAlignment = .left
        return lab
    }()
    
    public init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - StonkToastBaseView
    public func bind(with config: StonkToastBaseConfiguration) {
        guard let config = config as? StonkToastBannerConfiguration else { return }
        self.setupViews(config)
    }
    
    /// 更新子视图配置
    private func setupViews(_ config: StonkToastBannerConfiguration) {
        guard let superView = superview else { return }
        addSubview(contentStackView)
        if config.image != nil {
            contentStackView.addArrangedSubview(imageView)
        }
        contentStackView.addArrangedSubview(labelStackView)
        
        labelStackView.addArrangedSubview(titleStackView)
        titleStackView.addArrangedSubview(titleLabel)
        titleStackView.addArrangedSubview(timeLabel)
        
        if config.subtitle != nil {
            labelStackView.addArrangedSubview(subtitleLabel)
        }
        // layout
        contentStackView.spacing = config.imageSpacing
        labelStackView.spacing   = config.labelSpacing
        self.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        contentStackView.snp.makeConstraints { make in
            make.top.equalTo(superView.safeAreaLayoutGuide.snp.top).offset(config.contentMargin.top)
            make.left.right.bottom.equalToSuperview().inset(config.contentMargin)
        }
        
        if let minHeight = config.minHeight {
            contentStackView.snp.makeConstraints { make in
                make.height.greaterThanOrEqualTo(minHeight)
            }
        }
        
        imageView.snp.makeConstraints { make in
            make.size.equalTo(config.imageSize)
        }
        
        // style
        backgroundColor         = config.backgroundColor
        layer.shadowOffset      = config.shadowOffset
        layer.shadowColor       = config.shadowColor
        layer.shadowOpacity     = 1
        layer.shadowRadius      = config.shadowRadius
        titleLabel.textColor    = config.titleColor
        timeLabel.textColor     = config.timeTitleColor
        subtitleLabel.textColor = config.subtitletColor
        titleLabel.font         = config.titleFont
        timeLabel.font          = config.timeTitleFont
        subtitleLabel.font      = config.subtitleFont
        
        if config.image != nil {
            if let imageTintColor = config.imageTintColor {
                imageView.tintColor = imageTintColor
                imageView.image = config.image?.withRenderingMode(.alwaysTemplate)
            } else {
                imageView.image = config.image?.withRenderingMode(.alwaysOriginal)
            }
        }
        self.titleLabel.text = config.title
        timeLabel.text = config.timeTitle
        if let subtitle = config.subtitle {
            subtitleLabel.text   = subtitle
        }
        
        self.layoutIfNeeded()
        switch config.cornerType {
        case .round:
            self.layer.cornerRadius = frame.height / 2
        case .custom(let radius):
            self.layer.cornerRadius = radius
        }
        
    }
    
}
