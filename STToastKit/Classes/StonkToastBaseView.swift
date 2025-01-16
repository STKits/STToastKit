//
//  StonkToastBaseView.swift
//  StonkIOS
//
//  Created by admin on 2022/8/5.
//

import Foundation

/// ToastView基协议
public protocol StonkToastBaseView: UIView {
    func bind(with config: StonkToastBaseConfiguration)
}
