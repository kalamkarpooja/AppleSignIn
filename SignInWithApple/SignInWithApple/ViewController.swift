//
//  ViewController.swift
//  SignInWithApple
//
//  Created by Mac on 23/06/23.
//
import AuthenticationServices
import UIKit

class ViewController: UIViewController {
private let signInButton = ASAuthorizationAppleIDButton()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(signInButton)
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)

    }
    override func viewDidLayoutSubviews() {
        signInButton.frame = CGRect(x: 0, y: 0, width: 250, height: 50)
        signInButton.center = view.center
    }
    @objc func signIn(){
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName,.email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
}
extension ViewController: ASAuthorizationControllerDelegate{
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("failed")
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        switch authorization.credential{
            case let credentials as ASAuthorizationAppleIDCredential:
            let firstName = credentials.fullName?.givenName
            let lastName = credentials.fullName?.familyName
            let email = credentials.email
             break
        default:
            break
        }
    }  //vyawahareakshay2002@gmail.com
       //Poojaakshay@1315
    
}
extension ViewController: ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return view.window!
    }
}
