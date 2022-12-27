//
//  ContentView.swift
//  ChatWithAI
//
//  Created by Egehan Karaköse on 22.12.2022.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @ObservedObject var viewModel = ViewModel()
    @State var text = ""
    @State var models: [MessageModel] = [MessageModel]()
    @State private var muted = true
    @State var previousText = ""
    
    let synt = AVSpeechSynthesizer()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Button(action: {
                        muted.toggle()
                        if muted {
                            synt.pauseSpeaking(at: .immediate)
                        }
                    }) {
                        Image(systemName: muted ? "speaker.slash" : "speaker")
                            .font(.system(size: 32))
                            .foregroundColor(.orange)
                    }
                    
                    .accessibilityLabel("Mute")
                }
                ScrollView(showsIndicators: false) {
                    ScrollViewReader { value in
                        LazyVStack {
                            ForEach(models, id: \.id) { model in
                                switch model.messageType {
                                case .success:
                                    switch model.responder {
                                    case .client:
                                        VStack {
                                            MessageView(model: model)
                                                .padding(5)
                                                .background(Color.gray)
                                                .cornerRadius(8)
                                                .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .leading)
                                            
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .id(model.id)
                                        
                                        
                                    case .ai:
                                        VStack {
                                            MessageView(model: model)
                                                .padding(5)
                                                .background(Color.green.opacity(0.5))
                                                .cornerRadius(8)
                                                .multilineTextAlignment(.leading)
                                                .frame(maxWidth: UIScreen.main.bounds.width / 1.5, alignment: .trailing)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                        .id(model.id)
                                        
                                    }
                                case .error:
                                    Text(model.message ?? "")
                                        .foregroundColor(.red)
                                        .id(model.id)
                                }
                            }
                            .onChange(of: models.count) { _ in
                                withAnimation {
                                    value.scrollTo(models.last?.id)
                                }
                                
                            }
                        }
                        
                    }
                }
                
                Spacer()
                HStack {
                    Button(action: {
                        send(text: previousText)
                    }) {
                        Image(systemName: "arrow.counterclockwise")
                            .font(.system(size: 24))
                            .foregroundColor(previousText == "" ? .gray : .orange)
                    }
                    .disabled(previousText == "")
                    TextField("ENTRY_TEXT", text: $text)
                    Button("SEND_BTN_TEXT") {
                        hideKeyboard()
                        send(text: text)
                    }
                    .foregroundColor(.orange)
                    .disabled(viewModel.hudVisible)
                }
            }
            .onReceive(viewModel.$messageModel) { model in
                guard let message = model, !(message.message ?? "").isEmpty else { return }
                self.models.append(message)
                if !muted {
                    playSound(text: message.message ?? "")
                }
            }
            .onAppear {
                viewModel.setup()
            }
            
            if viewModel.hudVisible {
                ActivityIndicator()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.orange)
            }
            
            
        }
        .onTapGesture {
            hideKeyboard()
        }
        .padding()
        
    }
    
    func playSound(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.5
        synt.speak(utterance)
        
    }
    
    func send(text: String) {
        guard !text.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        models.append(MessageModel(responder: .client, message: text))
        viewModel.send(text: text)
        previousText = text
        self.text = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
