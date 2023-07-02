//
//  ContentView.swift
//  Practice
//
//  Created by Amish on 02/07/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(ViewModel.self) var vm
    var body: some View {
        ScrollView {
            ForEach(vm.modelData) { post in
                PostView(post: post)
            }
            .task {
                print("Downloading")
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 6.0) {
                    vm.createPost()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                    vm.patchPost()
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environment(ViewModel())
}
