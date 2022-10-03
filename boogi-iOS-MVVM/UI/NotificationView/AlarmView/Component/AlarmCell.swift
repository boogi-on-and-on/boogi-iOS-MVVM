//
//  AlarmCell.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/17.
//

import Foundation
import SwiftUI

struct AlarmCell: View {
    let alarm: Alarm.AlarmInfo.Content
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(alarm.head)
                Text(alarm.body ?? "")
                    .bold()
            }
            
            Spacer()
            
            VStack(alignment: .trailing) {
                Text(alarm.createdAt)
                    .font(.caption)
                Spacer()
            }
        }
        .listRowInsets(EdgeInsets())
        .padding()
    }
}
