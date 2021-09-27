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

    let Varieties: [VarietiesDataBase] = Bundle.main.decodeJSON("varieties.json")
    
    let listText: [String] = DataManagement.MakeVarietiesViewName()
    
    var body: some View {
        VStack{
            GroupBox(label: Text("一覧から品種を選択")) {
                List(selection: $selectedVariety) {
                    ForEach(0..<Varieties.count) { num in
                        Text("\(listText[num])")
                    }
                }.environment(\.editMode, .constant(.active))
                .onChange(of: selectedVariety){ value in
                    if (value != nil) {
                        DataManagement.EnterInputData(ID: Varieties[value!].id)
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
