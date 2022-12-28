//
//  InterstitialView.swift
//  ChatWithAI
//
//  Created by Egehan Karaköse on 28.12.2022.
//

import GoogleMobileAds
import SwiftUI
import UIKit

final class Interstitial:NSObject, GADFullScreenContentDelegate {
  var interstitial:GADInterstitialAd?

  override init() {
    super.init()
    self.loadInterstitial()
  }

    func loadInterstitial(){
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID:"ca-app-pub-1184579499874373/9180396618",
                               request: request,
                               completionHandler: { [self] ad, error in
                                if let error = error {
                                    print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                    return
                                }
                                interstitial = ad
                                interstitial?.fullScreenContentDelegate = self
                               })
    }

    func showAd(){
        if self.interstitial != nil {
            let root = UIApplication.shared.windows.first?.rootViewController
            self.interstitial?.present(fromRootViewController: root!)
        }
        else{
            print("Not Ready")
        }
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
        self.loadInterstitial()
    }
    
}
