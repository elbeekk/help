//
//  Untitled.swift
//  
//
//  Created by Arseny Prostakov on 04/12/25.
//

import SwiftUI

struct FeatureRow: View {
    let icon: String
    let text: String

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 30)
            Text(text)
                .font(.body)
        }
    }
}
