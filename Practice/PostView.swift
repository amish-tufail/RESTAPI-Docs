//
//  PostView.swift
//  Practice
//
//  Created by Amish on 02/07/2023.
//

import SwiftUI

struct PostView: View {
    let post: Model
    var body: some View {
        VStack(alignment: .leading, spacing: 10.0) {
            Text("\(post.userId)")
                .font(.system(size: 30.0, design: .monospaced))
                .bold()
            Text("\(post.id)")
                .font(.system(size: 30.0, design: .monospaced))
                .bold()
            Text(post.title)
                .font(.system(size: 24.0, design: .monospaced))
                .fontWeight(.semibold)
            Text(post.body)
                .font(.system(size: 14.0, design: .monospaced))
                .fontWeight(.medium)
        }
        .padding()
        .foregroundStyle(.black)
        .frame(maxWidth: .infinity, maxHeight: 200.0)
        .background(
            RoundedRectangle(cornerRadius: 12.0, style: .continuous)
                .fill(.orange)
        )
        .padding()
    }
}

#Preview {
    PostView(post: Model(userId: 1, id: 1, title: "Hello", body: "nfjekwnfjk finweifwe nfiwefn"))
}
