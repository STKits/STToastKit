//
//  StonkToastConfiguration.swift
//  StonkIOS
//
//  Created by admin on 2022/8/5.
//

import UIKit

/// toast装饰器
public struct StonkToastConfiguration: StonkToastBaseConfiguration {
  
    public var isTapToDissmiss: Bool = true
    public var type: StonkToastType = .toast
    // 图片
    public var image: UIImage?
    // 标题
    public var title: String = ""
    // 副标题
    public var subtitle: String?
    /// 被添加view(默认nil，添加到keywindow)
    public var superView: UIView?
    /// 动画进入时长
    public var showDuration: StonkToastDuration   = .short
    /// 延迟
    public var delay: TimeInterval     = 0
    /// 展示时长
    public var duration: StonkToastDuration       = .normal
    /// 动画消失时长
    public var hideDuration: StonkToastDuration   = .short
    /// 初始动画
    public var initialTransform        = CGAffineTransform(scaleX: 1.0, y: 1.0).translatedBy(x: 0, y: -200)
    /// 最小高度
    public var minHeight: CGFloat?     = nil
    /// 内容视图内间距
    public var contentMargin: UIEdgeInsets =  UIEdgeInsets.init(top: 15, left: 20, bottom: 15, right: 20)
    /// 图片尺寸
    public var imageSize: CGSize        = CGSize(width: 25, height: 25)
    /// 图片和文字间距
    public var imageSpacing: CGFloat    = 15
    /// label之间间距
    public var labelSpacing: CGFloat    = 0
    /// 标题色
    public var titleColor: UIColor      = .make(light: .rgba(255, 255, 255, 1), dark: .rgba(19, 19, 19, 1))
    /// 副标题色
    public var subtitletColor: UIColor  = .make(light: .rgba(153, 153, 153, 1), dark: .rgba(153, 153, 153, 1))
    /// 图片渲染色
    public var imageTintColor: UIColor?  = .make(light: .rgba(255, 255, 255, 1), dark: .rgba(19, 19, 19, 1))
    /// 标题字体
    public var titleFont: UIFont        = UIFont.boldSystemFont(ofSize: 14)
    /// 副标题字体
    public var subtitleFont: UIFont     = UIFont.systemFont(ofSize: 12)
    /// 背景颜色
    public var backgroundColor: UIColor = .make(light: .rgba(19, 19, 19, 1), dark: .rgba(255, 255, 255, 1))
    public var shadowColor              = UIColor.black.withAlphaComponent(0.15).cgColor
    public var shadowRadius: CGFloat    = 10
    public var shadowOffset: CGSize     = .zero
    /// 圆角类型
    public var cornerType: StonkToastCornerType   = .round
    
    public static func `default`() -> StonkToastConfiguration {
        return StonkToastConfiguration()
    }
    
    // MARK: - 快捷设置方式
    public mutating func setImageTintColor(_ color:UIColor?) -> Self {
        self.imageTintColor = color
        return self
    }
    
}
