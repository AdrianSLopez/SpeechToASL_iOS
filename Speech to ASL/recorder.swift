//
//  recorder.swift
//  Speech to ASL
//
//  Created by Adrian Salgado Lopez on 2/16/24.
//
import Foundation
import SwiftUI
import Combine
import AVFoundation

//import Found
class RecordAudioViewController: ObservableObject{
    
    let objectWillChange = PassthroughSubject<RecordAudioViewController, Never>()
    var audioRecorder: AVAudioRecorder!
    var recording = false {
        didSet{
            objectWillChange.send(self)
        }
    }
    
    func startRecording() {
        let recordingSession = AVAudioSession.sharedInstance()
        do{
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        }catch{
            print("Failed to set up recordin session")
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
//        let docPath = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)
        //https://developer.apple.com/documentation/foundation/filemanager/1407726-urls
        //https://www.swiftyplace.com/blog/file-manager-in-swift-reading-writing-and-deleting-files-and-directories
        let audioFileName = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("\(NSUUID().uuidString)_recording.m4a")
        print(audioFileName)
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 44000,
            AVNumberOfChannelsKey:  1,
            AVEncoderBitRateKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRecorder.record()
            
            recording = true
        } catch {
            print("Couldn't record session")
        }
        
        print(audioFileName)
    }
    
    func stopRecording() {
        audioRecorder?.stop()
        recording = false
    }
}
