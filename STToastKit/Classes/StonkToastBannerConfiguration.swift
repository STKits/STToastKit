//
//  StonkToastBannerConfiguration.swift
//  StonkCommonKit
//
//  Created by yuanbin on 1/15/25.
//

import Foundation

/// toast banner装饰器
public struct StonkToastBannerConfiguration: StonkToastBaseConfiguration {
    public var isTapToDissmiss: Bool = true
    public var type: StonkToastType = .banner
    // 图片
    public var image: UIImage?
    // 标题
    public var title: String = ""
    // 时间
    public var timeTitle: String = ""
    // 副标题
    public var subtitle: String?
    /// 被添加view(默认nil，添加到keywindow)
    public var superView: UIView?
    /// 动画进入时长
    public var showDuration: StonkToastDuration   = .short
    /// 延迟
    public var delay: TimeInterval     = 0
    /// 展示时长
    public var duration: StonkToastDuration       = .long
    /// 动画消失时长
    public var hideDuration: StonkToastDuration   = .short
    /// 初始动画
    public var initialTransform        = CGAffineTransform(scaleX: 1.0, y: 1.0).translatedBy(x: 0, y: -200)
    
    /// 最小高度
    public var minHeight: CGFloat?     = nil
    /// 内容视图内间距
    public var contentMargin: UIEdgeInsets =  UIEdgeInsets.init(top: 16, left: 16, bottom: 16, right: 16)
    /// 图片尺寸
    public var imageSize: CGSize        = CGSize(width: 40, height: 40)
    /// 图片和文字间距
    public var imageSpacing: CGFloat    = 16
    /// label之间间距
    public var labelSpacing: CGFloat    = 8
    /// 标题色
    public var titleColor: UIColor      = .make(light: .rgba(153, 153, 153, 1), dark: .rgba(153, 153, 153, 1))
    /// 时间标题色
    public var timeTitleColor: UIColor  = .make(light: .rgba(153, 153, 153, 1), dark: .rgba(153, 153, 153, 1))
    /// 副标题色
    public var subtitletColor: UIColor  = .make(light: .rgba(255, 255, 255, 1), dark: .rgba(19, 19, 19, 1))
    /// 图片渲染色
    public var imageTintColor: UIColor?  = .make(light: .rgba(153, 153, 153, 1), dark: .rgba(153, 153, 153, 1))
    /// 标题字体
    public var titleFont: UIFont        = UIFont.boldSystemFont(ofSize: 12)
    /// 时间标题字体
    public var timeTitleFont: UIFont    = UIFont.boldSystemFont(ofSize: 12)
    /// 副标题字体
    public var subtitleFont: UIFont     = UIFont.systemFont(ofSize: 14)
    /// 背景颜色
    
    public var backgroundColor: UIColor  = .make(light: .rgba(19, 19, 19, 1), dark: .rgba(255, 255, 255, 1))
    public var shadowColor: CGColor      = UIColor.clear.cgColor
    public var shadowRadius: CGFloat     = 0
    public var shadowOffset: CGSize      = .zero
    /// 圆角类型
    public var cornerType: StonkToastCornerType   = .custom(radius: 0)
    
    public static func `default`() -> StonkToastBannerConfiguration {
        return StonkToastBannerConfiguration()
    }
    
    // MARK: - 快捷设置方式
    public mutating func setImageTintColor(_ color:UIColor?) -> Self {
        self.imageTintColor = color
        return self
    }
    
}
