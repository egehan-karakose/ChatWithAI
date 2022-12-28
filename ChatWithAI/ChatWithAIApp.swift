//
//  ChatWithAIApp.swift
//  ChatWithAI
//
//  Created by Egehan Karaköse on 22.12.2022.
//

import SwiftUI
import GoogleMobileAds

@main
struct ChatWithAIApp: App {
    
    init() {
          GADMobileAds.sharedInstance().start(completionHandler: nil)
      }
    
    var body: some Scene {
        WindowGroup {
            SplashView()
        }
    }
}
