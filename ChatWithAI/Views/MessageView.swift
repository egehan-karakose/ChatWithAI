//
//  MessageView.swift
//  ChatWithAI
//
//  Created by Egehan Karaköse on 22.12.2022.
//

import SwiftUI

struct MessageView: View {
    
    var model: MessageModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(model.responder.title)
                .padding(.vertical, 8)
            
            if #available(iOS 15.0, *) {
                Text(model.message?.removingLeadingNewLines() ?? "")
                    .padding(.bottom, 8)
                    .textSelection(.enabled)
            } else {
                Text(model.message?.removingLeadingNewLines() ?? "")
                    .padding(.bottom, 8)
            }
        }
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView(model: MessageModel(message: "deneme"))
    }
}
