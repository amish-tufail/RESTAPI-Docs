//
//  PracticeApp.swift
//  Practice
//
//  Created by Amish on 02/07/2023.
//

import SwiftUI

@main
struct PracticeApp: App {
    var vm: ViewModel = ViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(vm)
        }
    }
}
