//
//  OpenDeezerComponent.swift
//  Matis
//
//  Created by Maxime Maheo on 04/05/2020.
//  Copyright © 2020 Matis. All rights reserved.
//

import SwiftUI

struct OpenDeezerComponent: View {
    var body: some View {
        HStack(alignment: .center) {
            Image("deezer_logo_white")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 16)
        }
        .foregroundColor(.white)
        .padding()
        .frame(minHeight: 44)
        .background(Color.pink)
        .cornerRadius(8)
    }
}

struct OpenDeezerComponent_Previews: PreviewProvider {
    static var previews: some View {
        OpenDeezerComponent()
    }
}
