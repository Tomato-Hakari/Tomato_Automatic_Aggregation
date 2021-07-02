//
//  InputByKeyboardTabView.swift
//  Tomato_Automatic_Aggregation
//
//  Created by TeraJun on 2021/05/29.
//

import SwiftUI
import Combine



struct InputByListTabView: View {
    // Pickerで選択された品種
    @State var selectedVariety: Int? = nil
    // 品種IDと品種名の関連付け
    struct VarietiesDataBase: Codable {
        var id: String
        var scion_name: String
        var scion_short: String
        var rootstock_name: String
        var isYieldSurvey: Bool
        var remarks: String
    }
    let Varieties: [VarietiesDataBase] = Bundle.main.decodeJSON("varieties.json")
    
    var body: some View {
        VStack{
            GroupBox(label: Text("一覧から品種を選択")) {
                List(selection: $selectedVariety) {
                    ForEach(0..<Varieties.count) { num in
                        Text("\(Varieties[num].scion_name)")
                    }
                }.environment(\.editMode, .constant(.active))
                .onChange(of: selectedVariety){ value in
                    if (value != nil) {
                        EnterInputData.EnterData(Name: Varieties[value!].scion_name)
                    }
                }
                
            }
        }
    }
}

struct InputByListTabView_Previews: PreviewProvider {
    static var previews: some View {
        InputByListTabView()
    }
}
