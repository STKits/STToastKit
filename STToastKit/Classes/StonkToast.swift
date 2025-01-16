//
//  StonkToast.swift
//  StonkIOS
//
//  Created by admin on 2022/8/5.
//

import UIKit

/// 每个toast任务
public class StonkToast: Operation, @unchecked Sendable {
    
    private var _isExecuting: Bool = false {
        willSet {
            willChangeValue(forKey: "isExecuting")
        }
        didSet {
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    public override var isExecuting: Bool {
        return _isExecuting
    }
    
    private var _isFinished: Bool = false {
        willSet {
            willChangeValue(forKey: "isFinished")
        }
        didSet {
            didChangeValue(forKey: "isFinished")
        }
    }
    
    public override var isFinished: Bool {
        return _isFinished
    }
    
    private var _isCancelled: Bool = false {
        willSet {
            willChangeValue(forKey: "isCancelled")
        }
        didSet {
            didChangeValue(forKey: "isCancelled")
        }
    }
    
    public override var isCancelled: Bool {
        return _isCancelled
    }
    
    public let toastView: StonkToastBaseView
    public let config: StonkToastBaseConfiguration
    
    private var hideTimer:Timer?
    
    private var isTapToClose: Bool = false
    private var initialY: CGFloat = 0
    public var customCompletionBlock: ((_ isTap: Bool) -> Void)?
    
    public init(config: StonkToastBaseConfiguration) {
        var toastView: StonkToastBaseView
        switch config.type {
        case .toast:
            toastView = StonkToastView()
        case .banner:
            toastView = StonkToastBannerView()
        }
        self.toastView  = toastView
        self.config     = config
    }
    
    public func show() {
        StonkToastManager.shared.addToast(self)
    }
    
    public override func start() {
        if isCancelled {
            self.finish()
            return
        }
        _isExecuting = true
        self.executeOnMain {
            self.main()
        }
    }
    
    public override func main() {
        self.toastView.transform = config.initialTransform// 应根据方向和实际height动态处理
        let superV = config.superView  ?? keyWindow
        superV.addSubview(self.toastView)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.toastView.addGestureRecognizer(tapGesture)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        self.toastView.addGestureRecognizer(panGesture)
        toastView.bind(with: self.config)
        
        UIView.animate(withDuration: config.showDuration.value,
                       delay: config.delay,
                       options: [.curveEaseOut, .allowUserInteraction]) {
            self.toastView.transform = .identity
        } completion: { result in
            self.hideTimer = Timer.scheduledTimer(withTimeInterval: .init(self.config.duration.value),
                                                  repeats: false, block: { _ in
                self.hide()
            })
        }
    }
    
    public override func cancel() {
        super.cancel()
        _isCancelled = true
        // 标记结束，但是采用新的动画消失
        self.hide()
    }
    
    @objc private func handleTap() {
        isTapToClose = true
        self.hide()
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: toastView.superview)
        switch gesture.state {
        case .began:
            hideTimer?.fireDate = .distantFuture
            initialY = toastView.frame.origin.y
        case .changed:
            let newY = initialY + translation.y
            if newY <= initialY {
                toastView.transform = CGAffineTransform(translationX: 0, y: translation.y)
            }
        case .ended, .cancelled:
            self.hide()
        default:
            break
        }
    }
    
    private func hide(complete: (()->Void)? = nil) {
        if self.isFinished { return }
        UIView.animate(withDuration: config.hideDuration.value,
                       delay: 0,
                       options: [.curveEaseIn, .allowUserInteraction]) {
            self.toastView.transform = self.config.initialTransform
        } completion: { result in
            self.finish()
            complete?()
        }
    }
    
    private func finish() {
        executeOnMain {
            if self.isFinished { return }
            self.toastView.removeFromSuperview()
            self._isExecuting    = false
            self._isFinished     = true
            self.customCompletionBlock?(self.isTapToClose)
        }
    }
    
    private func executeOnMain(_ block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            OperationQueue.main.addOperation {
                block()
            }
        }
    }
}

private var keyWindow: UIWindow {
    var window: UIWindow?
    if #available(iOS 13.0, *) {
        window = UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive || $0.activationState == .foregroundInactive})
            .compactMap({ $0 as? UIWindowScene })
            .last?.windows
            .filter({ $0.isKeyWindow })
            .last
    } else {
        window = UIApplication.shared.keyWindow
    }
    return window ?? UIWindow(frame: CGRect.zero)
}
