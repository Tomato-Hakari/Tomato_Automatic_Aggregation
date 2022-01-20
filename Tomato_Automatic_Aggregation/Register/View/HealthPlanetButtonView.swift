//
//  HealthPlanetButtonView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by ミニトマト自動集計 on 2021/11/01.
//

import SwiftUI

struct HealthPlanetButtonView: View {
    var body: some View {
        VStack {
            Image("img_healthplanet")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            HStack {
                Spacer()
                Text("©2021 TANITA HEALTH LINK, INC. All Rights Reserved.")
                    .font(.system(size: 10))
                    .foregroundColor(.black)
            }
            
            Text("Health Planet アプリに遷移")
                .font(.title)
                .padding()
        }
        .border(Color.black)
    }
}

struct HealthPlanetButtonView_Previews: PreviewProvider {
    static var previews: some View {
        HealthPlanetButtonView()
            .previewLayout(.fixed(width: 400, height: 250))
    }
}
