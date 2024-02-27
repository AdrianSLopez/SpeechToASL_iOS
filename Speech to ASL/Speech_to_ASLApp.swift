//
//  Speech_to_ASLApp.swift
//  Speech to ASL
//
//  Created by Adrian Salgado Lopez on 1/30/24.
//

import SwiftUI

@main
struct Speech_to_ASLApp: App {
    var recorder = RecordAudioViewController()
    var body: some Scene {
        WindowGroup {
            ContentView(recorder: recorder)
        }
    }
}
