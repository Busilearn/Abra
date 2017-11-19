//
//  MyAPIClient.swift
//  stripeproto
//
//  Created by Baptiste Jacob on 11/18/17.
//  Copyright © 2017 oloh. All rights reserved.
//

import Foundation
import Stripe
import Alamofire

class MyAPIClient: NSObject, STPEphemeralKeyProvider {
    
    static let sharedClient = MyAPIClient()
    var baseURLString: String? = nil
    var baseURL: URL {
        if let urlString = self.baseURLString, let url = URL(string: urlString) {
            return url
        } else {
            fatalError()
        }
    }
    
    func completeCharge(_ result: STPPaymentResult,
                        amount: Int,
                        shippingAddress: STPAddress?,
                        shippingMethod: PKShippingMethod?,
                        completion: @escaping STPErrorBlock) {
        let url = "https://oloh.fr/wp-content/plugins/oloh/payment_api/charge.php"//self.baseURL.appendingPathComponent("charge")
        var params: [String: Any] = [
            "source": result.source.stripeID,
            "amount": amount,
//            @Field("name") String name, // Nom du customer
//            @Field("firstName") String firstName, // Prenom customer
//            @Field("phoneNumber") String phoneNumber, //Numéro de tel customer
//            @Field("mail") String mail, // Mail Customer
//            @Field("token") String token, // Le token de validation
//            @Field("amount") String amount, //Somme à prélever
//            @Field("currency") String currency, // Doit contenir "eur"
//            @Field("notes") String notes, //Les notes du customer
//            @Field("idProduct[]") ArrayList<String> idProduct, //L'enssemble des id des produits achetés
//            @Field("quantityProduct[]") ArrayList<String> quantityProduct, // La quantitée pour chaque produit
//            @Field("posGps") String posGps // La pos GPS n'est plus utilisé peut être remplacé par "0.00"
        ]
        params["shipping"] = STPAddress.shippingInfoForCharge(with: shippingAddress, shippingMethod: shippingMethod)
        Alamofire.request(url, method: .post, parameters: params)
            .validate(statusCode: 200..<300)
            .responseString { response in
                switch response.result {
                case .success:
                    completion(nil)
                case .failure(let error):
                    completion(error)
                }
        }
    }
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let url = self.baseURL.appendingPathComponent("ephemeral_keys")
        Alamofire.request(url, method: .post, parameters: [
            "api_version": apiVersion,
            "method": "ephemeral_keys"
            ])
            .validate(statusCode: 200..<300)
            .responseJSON { responseJSON in
                switch responseJSON.result {
                case .success(let json):
                    completion(json as? [String: AnyObject], nil)
                case .failure(let error):
                    completion(nil, error)
                }
        }
    }
    
}

