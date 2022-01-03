import SwiftUI
import UIKit

public struct TranslateController: UIViewControllerRepresentable {
    @Binding public var text : String
    @Binding public var showing : Bool
    
    public typealias UIViewControllerType = UINavigationController
    
    public init(text:Binding<String>,showing:Binding<Bool>) {
        self.$text = text
        self.$showing = showing
    }
    
    public func makeUIViewController(context: Context) -> UINavigationController {
        let navController =  UINavigationController()
        navController.setNavigationBarHidden(true, animated: false)
        let viewController = UIViewController()
        navController.addChild(viewController)
        return navController
    }
    
    public func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        if showing {
            translate(uiViewController,text: text)
        }
    }
    
    func translate(_ navController:UINavigationController , text: String) {
        guard !text.isEmpty else {
            return
        }
        if #available(iOS 15.0, *) {
            let text = text.unicodeScalars.filter { !$0.properties.isEmojiPresentation}.reduce("") { $0 + String($1) }
            
            let textView = UITextView()
            textView.text = text
            textView.isEditable = false
            if let topController = navController.topViewController{
                topController.view.addSubview(textView)
                textView.selectAll(nil)
                textView.perform(NSSelectorFromString(["_", "trans", "late:"].joined(separator: "")), with: nil)
                
                DispatchQueue.main.async {
                    textView.removeFromSuperview()
                    showing = false
                }
            }
        }
    }
}

