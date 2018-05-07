//
//  PINView.swift
//
//  Burak Akkaş
//  2018

import Foundation
import UIKit

/**
 MARK: - PINView delegate protocol
 */
protocol PINViewDelegate: class {
    func PINChanged(to string: String)
    func PINFilled(with string: String)
}

/**
 MARK: - PINView component base class, private methods
 */
@IBDesignable class PINView: UIView {
    
    // Private configuration constants
    fileprivate let MARGIN_BETWEEN_VIEWS: CGFloat = 10
    
    // Private variables
    fileprivate var pinBlackDotImage: UIImage = UIImage()
    fileprivate var pinImageViewArray: [UIImageView] = [UIImageView]()
    fileprivate var txtInput: UITextField!
    
    // Inspectables
    @IBInspectable var pinBlackDotImageName: String = "pinview-black-dot" {
        didSet {
            self.setupView()
        }
    }
    @IBInspectable var emptyPinAlpha: CGFloat = 0.2 {
        didSet {
            self.setupView()
        }
    }
    @IBInspectable var filledPinAlpha: CGFloat = 1.0 {
        didSet {
            self.setupView()
        }
    }
    @IBInspectable var pinSize: Int = 5 {
        didSet {
            self.setupView()
        }
    }
    @IBInspectable var pinColor: UIColor = UIColor.green {
        didSet {
            self.setupView()
        }
    }
    
    // Delegate
    weak var delegate: PINViewDelegate?
    
    /**
     Constructor, default setup
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    /**
     Setup view
     */
    private func setupView() {
        self.cleanUp()
        self.setTextField()
        self.setImages()
        self.setupDots()
        self.drawDots()
    }
    
    /**
     Set images on image views
     */
    private func setImages() {
        self.pinBlackDotImage = UIImage(named: pinBlackDotImageName)!.withRenderingMode(.alwaysTemplate)
        for _ in 0..<pinSize {
            let imageView = UIImageView(image: pinBlackDotImage)
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = pinColor
            self.pinImageViewArray.append(imageView)
        }
    }
    
    /**
     Configures initial dot position and alphas
     */
    private func setupDots() {
        let width = self.frame.width
        let height = self.frame.height
        let dotHeight = height
        let dotWidth = CGFloat(width - CGFloat(MARGIN_BETWEEN_VIEWS * CGFloat(pinSize - 1))) / CGFloat(pinSize)
        
        var xIndex: CGFloat = 0
        let yIndex: CGFloat = 0
        for pinIndex in 0..<pinSize {
            let frame = CGRect(x: xIndex, y: yIndex, width: dotWidth, height: dotHeight)
            xIndex += MARGIN_BETWEEN_VIEWS + dotWidth
            pinImageViewArray[pinIndex].alpha = emptyPinAlpha
            pinImageViewArray[pinIndex].frame = frame
        }
    }
    
    /**
     Draws dots to the view
     */
    private func drawDots() {
        for pinIndex in 0..<pinSize {
            self.addSubview(pinImageViewArray[pinIndex])
        }
    }
    
    /**
     Set hidden text field for pin input
     */
    private func setTextField() {
        
        self.txtInput = UITextField(frame: CGRect.zero)
        self.txtInput.delegate = self
        self.txtInput.isHidden = false
        self.txtInput.keyboardType = .numberPad
        self.addSubview(self.txtInput)
    }
    
    /**
     Cleans up component before re-render
     */
    func cleanUp() {
        for pinIndex in 0..<pinImageViewArray.count {
            pinImageViewArray[pinIndex].removeFromSuperview()
        }
        
        pinImageViewArray.removeAll()
        
        if self.txtInput != nil {
            self.txtInput.removeFromSuperview()
        }
    }
}

/**
 MARK: - Public methods
 */
extension PINView {
    /**
     Keyboard focus
     */
    public func focus() {
        self.txtInput.becomeFirstResponder()
    }
}

/**
 MARK: - TextView delegate
 */
extension PINView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var willReplace = false
        if let text = textField.text {
            let count = text.count
            
            if string.isEmpty && count > 0 {
                pinImageViewArray[count - 1].alpha = emptyPinAlpha
                willReplace = true
            } else if count != pinSize {
                pinImageViewArray[count].alpha = filledPinAlpha
                willReplace = true
            }
            
            if willReplace {
                if string.isEmpty {
                    delegate?.PINChanged(to: String(text.dropLast()))
                } else {
                    delegate?.PINChanged(to: text + string)
                }
                
                if !string.isEmpty && count + 1 == pinSize {
                    delegate?.PINFilled(with: text + string)
                }
            }
        }
        
        return willReplace
    }
}

