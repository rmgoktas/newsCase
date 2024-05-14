//
//  RemoteImage.swift
//  newsCase
//
//  Created by R. Metehan GÖKTAŞ on 14.05.2024.
//

import SwiftUI

struct RemoteImage: View {
    private let url: String
    @State private var image: Image? = nil
    
    init(url: String) {
        self.url = url
    }
    
    var body: some View {
        if let image = image {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
        } else {
            Rectangle()
                .foregroundColor(.gray)
                .frame(width: 100, height: 100)
                .onAppear(perform: loadImage)
        }
    }
    
    private func loadImage() {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data, let uiImage = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = Image(uiImage: uiImage)
                }
            }
        }.resume()
    }
}
