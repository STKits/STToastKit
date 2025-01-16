//
//  StonkToastView.swift
//  StonkIOS
//
//  Created by admin on 2022/8/5.
//

import UIKit
import SnapKit

/// ToastView
public class StonkToastView: UIView, StonkToastBaseView {
    
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
        v.alignment     = .center
        return v
    }()
    
    private lazy var imageView:UIImageView = {
        let lab = UIImageView()
        lab.contentMode = .scaleAspectFit
        return lab
    }()
    
    private lazy var titleLabel:UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 0
        lab.textAlignment = .center
        return lab
    }()
    
    private lazy var subtitleLabel:UILabel = {
        let lab = UILabel()
        lab.numberOfLines = 4
        lab.textAlignment = .center
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
        guard let config = config as? StonkToastConfiguration else { return }
        self.setupViews(config)
    }
    
    /// 更新子视图配置
    private func setupViews(_ config: StonkToastConfiguration) {
        guard let superView = superview else { return }
        addSubview(contentStackView)
        contentStackView.addArrangedSubview(titleLabel)
        if config.image != nil {
            contentStackView.addArrangedSubview(imageView)
        }
        contentStackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(titleLabel)
        if config.subtitle != nil {
            labelStackView.addArrangedSubview(subtitleLabel)
        }
        // layout
        contentStackView.spacing = config.imageSpacing
        labelStackView.spacing   = config.labelSpacing
        self.snp.makeConstraints { make in
            make.top.equalTo(superView.safeAreaLayoutGuide.snp.top) // 适用于从上往下的
            make.left.greaterThanOrEqualTo(10)
            make.right.lessThanOrEqualTo(-10)
            make.centerX.equalToSuperview()
        }
        
        if let minHeight = config.minHeight {
            self.snp.makeConstraints { make in
                make.height.greaterThanOrEqualTo(minHeight)
            }
        }
        
        contentStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.left.greaterThanOrEqualToSuperview().inset(config.contentMargin)
            make.right.bottom.lessThanOrEqualToSuperview().inset(config.contentMargin)
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
        subtitleLabel.textColor = config.subtitletColor
        titleLabel.font         = config.titleFont
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
