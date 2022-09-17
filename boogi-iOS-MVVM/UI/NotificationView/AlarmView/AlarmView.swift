//
//  AlarmView.swift
//  boogi-iOS-MVVM
//
//  Created by 김덕환 on 2022/09/17.
//

import Foundation
import SwiftUI

struct AlarmView: View {
    @ObservedObject private(set) var viewModel: ViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.alarms.alarms, id: \.self) { alarm in
                AlarmCell(alarm: alarm)
                //                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                //                        Button(role: .destructive) {
                //                            Task {
                //                                do {
                //                                    try await WebService.webService.deleteAlarm(alarmId: alarm.id)
                //                                    alarms.alarms.removeAll { $0.id == alarm.id }
                //                                } catch {
                //                                }
                //                            }
                //                        } label: {
                //                            Label("Delete", systemImage: "trash")
                //                        }
                //                    }
            }
            .onDelete { offsets in
                offsets.forEach { i in
                    let removed = viewModel.alarms.alarms.remove(at: i)
                    Task {
                        //TODO: removed alarm
                    }
                }
            }
        }
        .animation(.default, value: viewModel.alarms.alarms.count)
        .task {
            await viewModel.getAlarms()
        }
    }
    
}
