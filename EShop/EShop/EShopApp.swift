//
//  EShopApp.swift
//  EShop
//
//  Created by Reynaldo Cristinus Hutahaean on 29/06/23.
//

import SwiftUI

@main
struct EShopApp: App {
    
    @StateObject private var shopModel = ShopModel()
    
    var body: some Scene {
        WindowGroup {
            CategoryView().environmentObject(shopModel)
        }
    }
}
