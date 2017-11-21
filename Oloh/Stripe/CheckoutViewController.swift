//
//  CheckoutViewController.swift
//  Oloh
//
//  Created by Baptiste Jacob on 11/19/17.
//  Copyright © 2017 oloh. All rights reserved.
//

import UIKit
import Stripe

class CheckoutViewController: UIViewController, STPPaymentContextDelegate {
    
    // 1) Setup the stripe publishable key
    let stripePublishableKey = "pk_test_QxNQHsJ0MaEiKDtVAlcj7Qk0"
    
    // 2) link of the backend for stripe
    let backendBaseURL: String? = "https://bjacobtestapp.herokuapp.com"
    
    // 3) Optionally, to enable Apple Pay, follow the instructions at https://stripe.com/docs/mobile/apple-pay
    // to create an Apple Merchant ID. Replace nil on the line below with it (it looks like merchant.com.yourappname).
    let appleMerchantID: String? = nil
    
    // These values will be shown to the user when they purchase with Apple Pay.
    let companyName = "Oloh"
    let paymentCurrency = "eur"
    
    let paymentContext: STPPaymentContext
    
    let theme: STPTheme
    let paymentRow: CheckoutRowView
    let shippingRow: CheckoutRowView
    let totalRow: CheckoutRowView
    let buyButton: BuyButton
    let rowHeight: CGFloat = 44
    let productImage = UILabel()
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    let numberFormatter: NumberFormatter
    let shippingString: String
    var product = ""
    var paymentInProgress: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
                if self.paymentInProgress {
                    self.activityIndicator.startAnimating()
                    self.activityIndicator.alpha = 1
                    self.buyButton.alpha = 0
                }
                else {
                    self.activityIndicator.stopAnimating()
                    self.activityIndicator.alpha = 0
                    self.buyButton.alpha = 1
                }
            }, completion: nil)
        }
    }
    
    init() {
        let product = "panier"
        let price = 42424242
        let settings = SettingsViewController().settings
        
        let stripePublishableKey = self.stripePublishableKey
        let backendBaseURL = self.backendBaseURL
        
        assert(stripePublishableKey.hasPrefix("pk_"), "You must set your Stripe publishable key at the top of CheckoutViewController.swift to run this app.")
        assert(backendBaseURL != nil, "You must set your backend base url")
        
        self.product = product
        self.productImage.text = product
        self.theme = settings.theme
        MyAPIClient.sharedClient.baseURLString = self.backendBaseURL
        
        // put in  App Delegate in the futur.
        let config = STPPaymentConfiguration.shared()
        config.publishableKey = self.stripePublishableKey
        config.appleMerchantIdentifier = self.appleMerchantID
        config.companyName = self.companyName
        config.requiredBillingAddressFields = settings.requiredBillingAddressFields
        config.requiredShippingAddressFields = settings.requiredShippingAddressFields
        config.additionalPaymentMethods = settings.additionalPaymentMethods
        
        let customerContext = STPCustomerContext(keyProvider: MyAPIClient.sharedClient)
        let paymentContext = STPPaymentContext(customerContext: customerContext,
                                               configuration: config,
                                               theme: settings.theme)
        let userInformation = STPUserInformation()
        paymentContext.prefilledInformation = userInformation
        paymentContext.paymentAmount = price
        paymentContext.paymentCurrency = self.paymentCurrency
        
        let paymentSelectionFooter = PaymentContextFooterView(text: "")
        paymentSelectionFooter.theme = settings.theme
        paymentContext.paymentMethodsViewControllerFooterView = paymentSelectionFooter
        
        let addCardFooter = PaymentContextFooterView(text: "")
        addCardFooter.theme = settings.theme
        paymentContext.addCardViewControllerFooterView = addCardFooter
        
        self.paymentContext = paymentContext
        
        self.paymentRow = CheckoutRowView(title: "Paiement", detail: "moyen de paiement",
                                          theme: settings.theme)
        var shippingString = "Contact"
        if config.requiredShippingAddressFields.contains(.postalAddress) {
            shippingString = "Adresse"
        }
        self.shippingString = shippingString
        self.shippingRow = CheckoutRowView(title: self.shippingString,
                                           detail: "Entrer une adresse",
            theme: settings.theme)
        self.totalRow = CheckoutRowView(title: "Total", detail: "", tappable: false,
                                        theme: settings.theme)
        self.buyButton = BuyButton(enabled: true, theme: settings.theme)
        var localeComponents: [String: String] = [
            NSLocale.Key.currencyCode.rawValue: self.paymentCurrency,
            ]
        localeComponents[NSLocale.Key.languageCode.rawValue] = NSLocale.preferredLanguages.first
        let localeID = NSLocale.localeIdentifier(fromComponents: localeComponents)
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: localeID)
        numberFormatter.numberStyle = .currency
        numberFormatter.usesGroupingSeparator = true
        self.numberFormatter = numberFormatter
        super.init(nibName: nil, bundle: nil)
        self.paymentContext.delegate = self
        paymentContext.hostViewController = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = self.theme.primaryBackgroundColor
        var red: CGFloat = 0
        self.theme.primaryBackgroundColor.getRed(&red, green: nil, blue: nil, alpha: nil)
        self.activityIndicator.activityIndicatorViewStyle = red < 0.5 ? .white : .gray
        self.navigationItem.title = "Panier"
        
        self.productImage.font = UIFont.systemFont(ofSize: 70)
        self.view.addSubview(self.totalRow)
        self.view.addSubview(self.paymentRow)
        self.view.addSubview(self.shippingRow)
        self.view.addSubview(self.productImage)
        self.view.addSubview(self.buyButton)
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.alpha = 0
        self.buyButton.addTarget(self, action: #selector(didTapBuy), for: .touchUpInside)
        self.totalRow.detail = self.numberFormatter.string(from: NSNumber(value: Float(self.paymentContext.paymentAmount)/100))!
        self.paymentRow.onTap = {
            self.paymentContext.pushPaymentMethodsViewController()
        }
        self.shippingRow.onTap = {
            self.paymentContext.pushShippingViewController()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let width = self.view.bounds.width
        self.productImage.sizeToFit()
        self.productImage.center = CGPoint(x: width/2.0,
                                           y: 85 + rowHeight)
        self.paymentRow.frame = CGRect(x: 0, y: self.productImage.frame.maxY + rowHeight,
                                       width: width, height: rowHeight)
        self.shippingRow.frame = CGRect(x: 0, y: self.paymentRow.frame.maxY,
                                        width: width, height: rowHeight)
        self.totalRow.frame = CGRect(x: 0, y: self.shippingRow.frame.maxY,
                                     width: width, height: rowHeight)
        self.buyButton.frame = CGRect(x: 0, y: 0, width: 120, height: 44)
        self.buyButton.center = CGPoint(x: width/2.0, y: self.totalRow.frame.maxY + rowHeight*1.5)
        self.activityIndicator.center = self.buyButton.center
    }
    
    @objc func didTapBuy() {
        self.paymentInProgress = true
        self.paymentContext.requestPayment()
    }
    
    // MARK: STPPaymentContextDelegate
    
    func paymentContext(_ paymentContext: STPPaymentContext, didCreatePaymentResult paymentResult: STPPaymentResult, completion: @escaping STPErrorBlock) {
        MyAPIClient.sharedClient.completeCharge(paymentResult,
                                                amount: self.paymentContext.paymentAmount,
                                                shippingAddress: self.paymentContext.shippingAddress,
                                                shippingMethod: self.paymentContext.selectedShippingMethod,
                                                completion: completion)
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFinishWith status: STPPaymentStatus, error: Error?) {
        self.paymentInProgress = false
        let title: String
        let message: String
        switch status {
        case .error:
            title = "Erreur"
            message = error?.localizedDescription ?? ""
        case .success:
            title = "Succès"
            message = "votre commande a bien été enregistrée"
        case .userCancellation:
            return
        }
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func paymentContextDidChange(_ paymentContext: STPPaymentContext) {
        self.paymentRow.loading = paymentContext.loading
        if let paymentMethod = paymentContext.selectedPaymentMethod {
            self.paymentRow.detail = paymentMethod.label
        }
        else {
            self.paymentRow.detail = "Moyen de paiement"
        }
        if let shippingMethod = paymentContext.selectedShippingMethod {
            self.shippingRow.detail = shippingMethod.label
        }
        else {
            self.shippingRow.detail = "Entrer une adresse"
        }
        self.totalRow.detail = self.numberFormatter.string(from: NSNumber(value: Float(self.paymentContext.paymentAmount)/100))!
    }
    
    func paymentContext(_ paymentContext: STPPaymentContext, didFailToLoadWithError error: Error) {
        let alertController = UIAlertController(
            title: "Erreur",
            message: error.localizedDescription,
            preferredStyle: .alert
        )
        let cancel = UIAlertAction(title: "Annuler", style: .cancel, handler: { action in
            // Need to assign to _ because optional binding loses @discardableResult value
            // https://bugs.swift.org/browse/SR-1681
            _ = self.navigationController?.popViewController(animated: true)
        })
        let retry = UIAlertAction(title: "Réessayer", style: .default, handler: { action in
            self.paymentContext.retryLoading()
        })
        alertController.addAction(cancel)
        alertController.addAction(retry)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
}
