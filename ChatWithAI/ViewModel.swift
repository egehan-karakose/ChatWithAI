//
//  ViewModel.swift
//  ChatWithAI
//
//  Created by Egehan Karaköse on 22.12.2022.
//

import Foundation
import OpenAISwift

enum Responder {
    case client
    case ai
    
    var title: String {
        switch self {
        case .client:
            return NSLocalizedString("ME_TEXT", comment: "Me")
        case .ai:
            return NSLocalizedString("CHATAI_TEXT", comment: "ChatAI")
        }
    }
}

enum MessageType {
    case success
    case error
}

struct MessageModel: Identifiable {
    var id: String = UUID().uuidString
    var responder: Responder = .client
    let message: String?
    var messageType: MessageType = .success
}

final class ViewModel: ObservableObject {
    init() {}
    
    @Published var messageModel: MessageModel?
    @Published var hudVisible = false
    private var client: OpenAISwift?
    
    func setup() {
        client = OpenAISwift(authToken: API.key)
    }
    
    func send(text: String) {
        hudVisible = true
        client?.sendCompletion(with: text,
                               maxTokens: 500,
                               completionHandler: { result in
            DispatchQueue.main.async {
                switch result{
                case .success(let model):
                    let output = model.choices.first?.text.slice(from: "\n\n", toward: "")
                    self.messageModel = MessageModel(responder: .ai, message: output)
                case .failure(let error):
                    self.messageModel = MessageModel(responder: .ai, message: error.localizedDescription, messageType: .error)
                }
                self.hudVisible = false
            }
        })
    }
}
