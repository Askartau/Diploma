//
//  OurTextField.swift
//  Diploma
//
//  Created by Askar Serikkhanov on 4/25/20.
//  Copyright © 2020 Askar Serikkhanov. All rights reserved.
//

import Foundation
import UIKit
import InputMask
import RxSwift
import RxCocoa

class OurTextField : UIView, MaskedTextFieldDelegateListener {
    fileprivate var maskedDelegate : MaskedTextFieldDelegate?
    fileprivate let disposeBag = DisposeBag()
    fileprivate var isLoginField : Bool = false
    fileprivate var isPicker : Bool = false
    open var key: String?
    
    public var patternMask:String?
    
    public var textFieldDidEndEditing: ((OurTextField) -> ())?
    
    var observeError : ((Bool) -> Void)?
    public var onValueChange: ((OurTextField)->())?
    
    public var onTapRightView: (() -> Void)? {
        didSet {
            textField.rightView?.isUserInteractionEnabled = true
            let gr = UITapGestureRecognizer(target: self, action: #selector(onRightTap))
            gr.numberOfTapsRequired = 1
            gr.numberOfTouchesRequired = 1
            textField.rightView?.addGestureRecognizer(gr)
        }
    }
    
    open var text : String? {
        set(newValue) {
            if newValue != "" && text != nil {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [unowned self] in
                    self.titleLabel.font = .bold(size: 12)
                    self.titleLabel.snp.remakeConstraints({ (m) in
                        m.top.left.equalTo(self)
                    })
                    self.layoutIfNeeded()
                    }, completion: nil)
            }
            textField.text = newValue
        }
        get {
            return textField.text
        }
    }
    
    
    open var attributedText : NSAttributedString? {
        set(newValue) {
            guard let newValue = newValue else {
                return
            }
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [unowned self] in
                self.titleLabel.font = .bold(size: 12)
                self.titleLabel.snp.remakeConstraints({ (m) in
                    m.top.left.equalTo(self)
                })
                self.layoutIfNeeded()
                }, completion: nil)
            textField.attributedText = newValue
        }
        get {
            return textField.attributedText
        }
    }
    
    var input: UIView? {
        didSet {
            textField.inputView = input
        }
    }
    
    var placeholder : String? {
        didSet {
            titleLabel.text = placeholder
            if isPicker {
                codePickerButton.placeholder = placeholder
            }
        }
    }
    
    var isSecureEntry : Bool = false {
        didSet {
            textField.isSecureTextEntry = isSecureEntry
        }
    }
    
    var keyboardType : UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    var autoCapitalizationType : UITextAutocapitalizationType = .words {
        didSet {
            textField.autocapitalizationType = autoCapitalizationType
        }
    }
    
    var autoCorrectionType : UITextAutocorrectionType = .default {
        didSet {
            textField.autocorrectionType = autoCorrectionType
        }
    }
    
    var isEditingEnabled = true {
        didSet {
            textField.isEnabled = isEditingEnabled
        }
    }
    
    
    open var dateImage: Bool = false {
        didSet {
            if dateImage {
                let dateImageView = UIImageView(image: #imageLiteral(resourceName: "calendar_icn"))
                dateImageView.isUserInteractionEnabled = true
                dateImageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
                dateImageView.tintColor = UIColor.white
                dateImageView.contentMode = .scaleAspectFit
                textField.rightView = dateImageView
                textField.rightViewMode = .always
                textField.rightView?.isUserInteractionEnabled = true
                let gr = UITapGestureRecognizer(target: self, action: #selector(onRightTap))
                gr.numberOfTapsRequired = 1
                gr.numberOfTouchesRequired = 1
                textField.rightView?.addGestureRecognizer(gr)
            } else {
                textField.rightView = nil
                textField.rightViewMode = .never
            }
        }
    }
    
    open var rightImage: UIImage? {
        didSet {
            let rightImageView = UIImageView(image: rightImage)
            rightImageView.isUserInteractionEnabled = true
            rightImageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
            rightImageView.tintColor = UIColor.white
            rightImageView.contentMode = .scaleAspectFit
            textField.rightView = rightImageView
            textField.rightViewMode = .always
            textField.rightView?.isUserInteractionEnabled = true
            let gr = UITapGestureRecognizer(target: self, action: #selector(onRightTap))
            gr.numberOfTapsRequired = 1
            gr.numberOfTouchesRequired = 1
            textField.rightView?.addGestureRecognizer(gr)
        }
    }
    
    open var rightView: UIView = UIView() {
        didSet {
            rightView.tintColor = UIColor.white
            textField.rightView = rightView
            textField.rightViewMode = .always
        }
    }
    
    fileprivate lazy var titleLabel : UILabel = {
        let label = UILabel()
        
        label.alpha = 0.4
        label.font = .regular(size: 16)
        
        return label
    }()
    
    public lazy var codePickerButton : PickerButton = {
        let picker = PickerButton(type: .withImage)
        picker.placeholder = "code".localized
        return picker
    }()
    
    var onTopController: UIViewController?
    
    fileprivate lazy var horizontalLine : UIView = {
        let view = UIView()
        
        view.backgroundColor = .fromRgb(rgb: 0xEBEBEB)
        
        return view
    }()
    
    public fileprivate(set) lazy var textField : UITextField = {
        let textField = UITextField()
        
        textField.textColor = .black
        textField.font = UIFont.regular(size: 16)
        textField.delegate = self
        textField.isUserInteractionEnabled = true
        textField.addTarget(self, action: #selector(handleValueChange), for: .allEditingEvents)
        
        return textField
    }()
    
    fileprivate lazy var underline : UIView = {
        let view = UIView()
        
        view.backgroundColor = UIColor.fromRgb(rgb: 0xEBEBEB)
        
        return view
    }()
    
    fileprivate lazy var errorLabel : UILabel = {
        let label = UILabel()
        
        label.font = .regular(size: 12)
        label.textColor = .fromRgb(rgb: 0xE01515)
        label.alpha = 0
        label.numberOfLines = 0
        
        return label
    }()
    
    private init() {
        super.init(frame: .zero)
    }
    
    convenience init(isLoginField: Bool = false, isPicker: Bool = false) {
        self.init()
        self.isLoginField = isLoginField
        self.isPicker = isPicker
        
        configUI()
        configPicker()
        bindViews()
        
        if isLoginField {
            textField.keyboardType = .numberPad
        }
    }
    
    convenience init(isLoginField: Bool = false, topController: UIViewController) {
        self.init()
        self.isLoginField = isLoginField
        self.onTopController = topController
        
        configUI()
        configPicker()
        bindViews()
        
        if isLoginField {
            textField.keyboardType = .numberPad
            codePickerButton.onTopController = topController
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Actions
extension OurTextField {
    @objc fileprivate func onRightTap() {
        if let onTapRightView = onTapRightView {
            onTapRightView()
        }
    }
    
    @objc fileprivate func handleValueChange() {
        hideError()
        if let onValueChange = onValueChange {
            onValueChange(self)
        }
    }
}

// MARK: - Methods
extension OurTextField {
    
    func isEmpty() -> Bool {
        if let text = text, text.isEmpty {
            showError("empty_error".localized)
            return true
        }
        return false
    }
    
    
    func showError(_ message : String) {
        let errorColor = UIColor.fromRgb(rgb: 0xE01515)
        errorLabel.text = message
        errorLabel.textColor = errorColor
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.errorLabel.alpha = 1
            self?.underline.backgroundColor = errorColor
        }
    }
    
    func showWarning(_ warning: String) {
        if warning.count > 0 {
            let warningColor = UIColor.fromRgb(rgb: 0xF4B000)
            dateImage = true
            errorLabel.text = warning
            UIView.animate(withDuration: 0.5) { [weak self] in
                self?.errorLabel.alpha = 1
                self?.errorLabel.textColor = warningColor
                self?.underline.backgroundColor = warningColor
            }
        } else {
            hideError()
        }
    }
    
    func hideError() {
        errorLabel.text = nil
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.errorLabel.alpha = 0
            self?.underline.backgroundColor = .fromRgb(rgb: 0xEBEBEB)
        }
    }
    
    func disabled() {
        isUserInteractionEnabled = false
    }
}

//MARK: - Masks
extension OurTextField {
    func setPhoneMask() {
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: "([000]) [000]-[00]-[00]")
        maskedDelegate?.listener = self
        textField.delegate = maskedDelegate
        textField.keyboardType = .numberPad
    }
    
    func setPhoneKGSMask() {
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: "+[000] ([000]) [000]-[000]")
        maskedDelegate?.listener = self
        textField.delegate = maskedDelegate
        textField.keyboardType = .numberPad
    }
    
    func setCodeMask() {
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: "[0000]")
        maskedDelegate?.listener = self
        textField.delegate = maskedDelegate
        textField.keyboardType = .numberPad
    }
    
    func setIinMask(){
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: "[000000000000]")
        maskedDelegate?.listener = self
        textField.delegate = maskedDelegate
        textField.keyboardType = .numberPad
    }
    
    public func setIinKGSMask() {
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: "[00000000000000]")
        maskedDelegate?.listener = self
        textField.delegate = maskedDelegate
        textField.keyboardType = .numberPad
    }
    
    func setDocNumMask() {
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: "[000000000]")
        maskedDelegate?.listener = self
        textField.delegate = maskedDelegate
        textField.keyboardType = .numberPad
    }
    
    func setCardNumMask() {
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: "[000000]****[0000]")
        maskedDelegate?.listener = self
        textField.delegate = maskedDelegate
        textField.keyboardType = .numberPad
    }
    
    func setCardExpireMask() {
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: "[00]/[00]")
        maskedDelegate?.listener = self
        textField.delegate = maskedDelegate
        textField.keyboardType = .numberPad
    }
    
    func setCardMask() {
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: "[0000000000000000]")
        maskedDelegate?.listener = self
        textField.delegate = maskedDelegate
        textField.keyboardType = .numberPad
    }
    
    func setCardDigitMask() {
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: "[0000]")
        maskedDelegate?.listener = self
        textField.delegate = maskedDelegate
        textField.keyboardType = .numberPad
    }
    
    func setCustomMask(_ mask:String) {
        let expression = mask.replacingOccurrences(of: "#", with: "0")
        var exp = ""
        for i in 0..<expression.count {
            if i == 0 {
                if expression[i] == "0" {
                    exp = exp + "[" + String(expression[i])
                }else{
                    exp = exp + String(expression[i])
                }
            }else if i == expression.count - 1 {
                if expression[i] == "0" {
                    if expression[i - 1] == "0" {
                        exp = exp + String(expression[i]) + "]"
                    }else{
                        exp = exp + "[" + String(expression[i]) + "]"
                    }
                }else{
                    if expression[i - 1] == "0" {
                        exp = exp + "]" + String(expression[i])
                    }else{
                        exp = exp + String(expression[i])
                    }
                }
            }else{
                if expression[i] == "0" {
                    if expression[i - 1] == "0" {
                        exp = exp + String(expression[i])
                    }else{
                        exp = exp + "[" + String(expression[i])
                    }
                }else{
                    if expression[i - 1] == "0" {
                        exp = exp + "]" + String(expression[i])
                    }else{
                        exp = exp + String(expression[i])
                    }
                }
            }
        }
        
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: exp)
        maskedDelegate?.listener = self
        textField.delegate = maskedDelegate
        
    }
    
    func setCustomMaskWithPattern(_ pattern:String) {
        maskedDelegate = MaskedTextFieldDelegate(primaryFormat: pattern)
        maskedDelegate?.listener = self
        textField.delegate = maskedDelegate
    }
    
}


// MARK: - UITextField Delegate
extension OurTextField : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if patternMask != nil {
            var numberOfMatches = 0
            do {
                let regex = try NSRegularExpression(pattern: patternMask!, options: .caseInsensitive)
                numberOfMatches = regex.numberOfMatches(in: textField.text ?? "", options: [], range: NSRange(location: 0, length: textField.text?.count ?? 0))
            }catch{
                
            }
            
            if numberOfMatches == 0 {
                showError("invalid_format".localized)
            }else{
                hideError()
            }
            
            
            return false
        }
        
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        hideError()
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [unowned self] in
            self.titleLabel.font = .bold(size: 12)
            self.titleLabel.snp.remakeConstraints({ (m) in
                m.top.left.equalTo(self)
            })
            
            self.layoutIfNeeded()
            }, completion: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if !isLoginField {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [unowned self] in
                self.titleLabel.font = .bold(size: 12)
                self.titleLabel.snp.remakeConstraints({ (m) in
                    m.top.equalTo(10)
                    m.left.equalTo(self)
                })
                
                self.layoutIfNeeded()
                }, completion: nil)
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [unowned self] in
                self.titleLabel.font = .bold(size: 12)
                self.titleLabel.snp.remakeConstraints({ (m) in
                    m.top.left.equalTo(self)
                })
                
                self.layoutIfNeeded()
                }, completion: nil)
        }
        
        underline.backgroundColor = .fromRgb(rgb: 0xA3A5A9)
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let textFieldDidEndEditing = textFieldDidEndEditing {
            textFieldDidEndEditing(self)
        }
        
        
        if !isLoginField {
            if textField.text == nil || textField.text == "" {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [unowned self] in
                    self.titleLabel.font = .regular(size: 16)
                    self.titleLabel.snp.remakeConstraints({ (m) in
                        m.top.equalTo(15)
                        m.left.right.equalTo(self)
                        m.bottom.equalTo(-18)
                    })
                    
                    self.layoutIfNeeded()
                    }, completion: nil)
            } else {
            }
        } else {
            if textField.text == nil || textField.text == "" {
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [unowned self] in
                    self.titleLabel.font = .regular(size: 16)
                    self.titleLabel.snp.remakeConstraints { (m) in
                        m.top.bottom.equalTo(self.horizontalLine)
                        m.left.equalTo(self.horizontalLine.snp.right).offset(10)
                        m.right.equalTo(self)
                    }
                    
                    self.layoutIfNeeded()
                    }, completion: nil)
            } else {
            }
        }
        
        underline.backgroundColor = UIColor.fromRgb(rgb: 0xEBEBEB)
    }
}


// MARK: - Binding Views
extension OurTextField {
    fileprivate func bindViews() {
        
        codePickerButton.index.asObservable().subscribe(onNext: { [unowned self] (index) in
            if self.isPicker {
                if index != nil {
                    self.titleLabel.isHidden = false
                } else {
                    self.titleLabel.isHidden = true
                }
            }
        }).disposed(by: disposeBag)
        
    }
}


// MARK: - ConfigUI
extension OurTextField {
    fileprivate func configPicker() {
        if isPicker {
            [horizontalLine, textField].forEach { $0.removeFromSuperview() }
            titleLabel.font = .bold(size: 12)
            titleLabel.snp.remakeConstraints { (m) in
                m.top.equalTo(10)
                m.left.equalTo(self)
            }
            
            titleLabel.isHidden = true
        }
    }
    
    fileprivate func configUI() {
        if isLoginField {
            [codePickerButton, horizontalLine, titleLabel, textField, underline, errorLabel].forEach { addSubview($0) }
            
            codePickerButton.snp.makeConstraints { (m) in
                m.top.equalToSuperview().offset(20)
                m.left.equalToSuperview()
                m.width.equalTo(80)
                m.bottom.equalToSuperview().offset(-30)
            }
            
            horizontalLine.snp.makeConstraints { (m) in
                m.top.equalTo(codePickerButton).offset(4)
                m.left.equalTo(codePickerButton.snp.right).offset(10)
                m.width.equalTo(1)
                m.bottom.equalTo(codePickerButton).offset(-4)
            }
            
            titleLabel.snp.makeConstraints { (m) in
                m.left.equalTo(horizontalLine.snp.right).offset(10)
                m.centerY.equalTo(codePickerButton)
                m.bottom.equalToSuperview().offset(-1)
            }
            
            textField.snp.makeConstraints { (m) in
                m.top.bottom.equalTo(codePickerButton)
                m.right.equalToSuperview()
                m.left.equalTo(horizontalLine.snp.right).offset(10)
            }
            
            underline.snp.makeConstraints { (m) in
                m.top.equalTo(codePickerButton.snp.bottom).offset(10)
                m.left.right.equalToSuperview()
                m.height.equalTo(1.0)
            }
            
            errorLabel.snp.makeConstraints { (m) in
                m.top.equalTo(underline.snp.bottom).offset(2)
                m.right.left.equalToSuperview()
                m.bottom.equalToSuperview()
            }
            
        } else {
            [titleLabel, textField, underline, errorLabel].forEach { addSubview($0) }
            
            titleLabel.snp.makeConstraints { (m) in
                m.top.equalTo(20)
                m.left.right.equalTo(self)
                m.bottom.equalTo(-25)
            }
            
            textField.snp.makeConstraints { (m) in
                m.top.equalTo(20)
                m.left.right.equalTo(self)
                m.bottom.equalTo(-25)
            }
            
            underline.snp.makeConstraints { (m) in
                m.left.right.equalTo(self)
                m.height.equalTo(1.2)
                m.bottom.equalTo(-18)
            }
            
            errorLabel.snp.makeConstraints { (m) in
                m.left.bottom.equalTo(self)
            }
        }
    }
}
