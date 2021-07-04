//
//  Message.swift
//  cats
//
//  Created by michelle gergs on 03/07/2021.
//

import Foundation
import SwiftMessages

class AlertMessage {
    
    class func alertError(_ msg: String?) {

        guard let msg = msg else { return }

        var config = SwiftMessages.Config()

        // Slide up from the bottom.
        config.presentationStyle = .top
        config.presentationContext = .window(windowLevel: .statusBar)

        let messageView = MessageView.viewFromNib(layout: .cardView)

        messageView.configureTheme(.error, iconStyle: .default)
        messageView.configureDropShadow()
        messageView.bodyLabel?.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.light)
        messageView.configureContent(body: msg)
        messageView.titleLabel?.isHidden = true
        messageView.button?.isHidden = true
        messageView.tapHandler = {
            _ in
            SwiftMessages.hide()
        }

        SwiftMessages.show(config: config, view: messageView)
    }
}
