//
//  JY_Collection_IndexView.swift
//  JYYQCustomController
//
//  Created by JYYQLin on 2025/4/15.
//

import UIKit

import UIKit

// 定义协议
protocol JY_Collection_IndexView_Delegate: AnyObject {
    func collectionViewIndex(_ collectionViewIndex: JY_Collection_IndexView, didselectionAtIndex indexPath: Int, withTitle title: String)
    func collectionViewIndexTouchesBegan(_ collectionViewIndex: JY_Collection_IndexView)
    func collectionViewIndexTouchesEnd(_ collectionViewIndex: JY_Collection_IndexView)
}

class JY_Collection_IndexView: UIView {

    private var isLayedOut: Bool = false
    private var shapeLayer: CAShapeLayer = CAShapeLayer()
    private var letterHeight: CGFloat = 0
    var titleIndexes: [String] = []
    weak var collectionDelegate: JY_Collection_IndexView_Delegate?
    private var isFrameLayer: Bool = true

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCollectionDelegate(_ delegate: JY_Collection_IndexView_Delegate) {
        collectionDelegate = delegate
        isLayedOut = false
        setNeedsLayout()
    }

    func setTitleIndexes(_ indexes: [String]) {
        titleIndexes = indexes
        setNeedsLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        setup()

        if titleIndexes.count <= 0 {
            return
        }

        if !isLayedOut {
            layer.sublayers?.forEach { $0.removeFromSuperlayer() }

            // 绘制边框线部分
            shapeLayer.frame = CGRect(x: 0, y: 0, width: layer.frame.size.width, height: layer.frame.size.height)
            let bezierPath = UIBezierPath()
            bezierPath.move(to: .zero)
            bezierPath.addLine(to: CGPoint(x: 0, y: frame.size.height))

            // 绘制文字部分
            letterHeight = 16
            let fontSize: CGFloat = 12
            for (idx, obj) in titleIndexes.enumerated() {
                let originY = CGFloat(idx) * letterHeight
                let ctl = textLayerWithSize(size: fontSize, string: obj, andFrame: CGRect(x: 0, y: originY, width: frame.size.width, height: letterHeight))
                layer.addSublayer(ctl)

                bezierPath.move(to: CGPoint(x: 0, y: originY))
                bezierPath.addLine(to: CGPoint(x: ctl.frame.size.width, y: originY))
            }

            shapeLayer.path = bezierPath.cgPath

            if isFrameLayer {
                layer.addSublayer(shapeLayer)
            }

            isLayedOut = true
        }
    }

    // 绘制边框线
    private func setup() {
        shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 1.0
        shapeLayer.fillColor = UIColor.black.cgColor
        shapeLayer.lineJoin = .round
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.strokeEnd = 1.0

        layer.masksToBounds = false
    }

    // 绘制字体
    private func textLayerWithSize(size: CGFloat, string: String, andFrame frame: CGRect) -> CATextLayer {
        let tl = CATextLayer()
        tl.font = CTFontCreateWithName("PingFangSC-Medium" as CFString, size, nil)
        tl.fontSize = size
        tl.frame = frame
        tl.alignmentMode = .center
        tl.contentsScale = UIScreen.main.scale
        tl.foregroundColor = UIColor(red: 66/255.0, green: 66/255.0, blue: 66/255.0, alpha: 1).cgColor
        tl.string = string
        return tl
    }

    // 根据触摸事件的触摸点来算出点击的是第几个section
    private func sendEventToDelegate(_ event: UIEvent) {
        guard let touch = event.allTouches?.first else { return }
        let point = touch.location(in: self)
        let indx = Int(floor(point.y / letterHeight))

        if indx < 0 || indx > titleIndexes.count - 1 {
            return
        }

        collectionDelegate?.collectionViewIndex(self, didselectionAtIndex: indx, withTitle: titleIndexes[indx])
    }

    // 开始触摸
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if let event = event {
            sendEventToDelegate(event)
            collectionDelegate?.collectionViewIndexTouchesBegan(self)
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let event = event {
            sendEventToDelegate(event)
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if event != nil {
            collectionDelegate?.collectionViewIndexTouchesEnd(self)
        }
    }
}
