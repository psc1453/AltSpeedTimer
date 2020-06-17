//
//  ContentView.swift
//  AltSpeedTimer
//
//  Created by 彭世辰 on 2020/6/14.
//  Copyright © 2020 Peng Shichen. All rights reserved.
//

import SwiftUI

let isPad = AppDelegate.isPad

struct ContentView: View {
    @ObservedObject var altSpeedTimer = AltSpeedTimer()
    @State var showSpeedConfig = false
    @State var speed = "1.0"
    @State var speedSetted = false
    @State var timeSettingHidden = false
    @State var minutesSetting = 1
    @State var secondsSetting = 0
    
    var body: some View {
        Group {
            // MARK: For iPad
            if isPad {
                ZStack {
                    ZStack {
                        if !timeSettingHidden {
                            ZStack {
                                Circle()
                                    .stroke(Color(.systemGray5), lineWidth: 12)
                                    .frame(width: 528, height: 528)
                                TimePickerView(minutes: $minutesSetting, seconds: $secondsSetting, pickerShouldHidden: $timeSettingHidden, altSpeedTimer: altSpeedTimer)
                            }
                        }
                        else {
                            TimerView(timeLeft: altSpeedTimer.timeLeft, timeSetting: altSpeedTimer.timeSetting)
                                .contextMenu{
                                    Button(action: {
                                        self.showSpeedConfig.toggle()
                                    }, label: {Text("Speed Setting")})
                                        .sheet(isPresented: $showSpeedConfig){
                                            VStack {
                                                TextField("Speed", text: self.$speed)
                                                    .frame(width: 220, height: 30)
                                                    .multilineTextAlignment(.center)
                                                    .font(.headline)
                                                Button(action: {
                                                    if let speedInput = Double(self.speed) {
                                                        self.altSpeedTimer.speed = speedInput
                                                        self.speedSetted.toggle()
                                                    }
                                                }){
                                                    Text("Set")
                                                }
                                                .alert(isPresented: self.$speedSetted) {
                                                    Alert(title: Text("Successful"),
                                                          message: Text("Swipe Down to Go Back"),
                                                          dismissButton: .default(Text("Got it!")))
                                                }
                                            }
                                    }
                            }
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    self.timeSettingHidden = false
                                }
                            }
                        }
                    }
                    ZStack {
                        if timeSettingHidden {
                            TwoButtonsView(altSpeedTimer: altSpeedTimer)
                        }
                        else {
                            OneButtonView(minutes: $minutesSetting, seconds: $secondsSetting, pickerShouldHidden: $timeSettingHidden, altSpeedTimer: altSpeedTimer)
                        }
                    }
                }
            }
            // MARK: For iPhone
            else {
                VStack {
                    ZStack {
                        if !timeSettingHidden {
                            TimePickerView(minutes: $minutesSetting, seconds: $secondsSetting, pickerShouldHidden: $timeSettingHidden, altSpeedTimer: altSpeedTimer)
                                .frame(width: 307, height: 307)
                        }
                        else {
                            TimerView(timeLeft: altSpeedTimer.timeLeft, timeSetting: altSpeedTimer.timeSetting)
                                .contextMenu{
                                    Button(action: {
                                        self.showSpeedConfig.toggle()
                                    }, label: {Text("Speed Setting")})
                                        .sheet(isPresented: $showSpeedConfig){
                                            VStack {
                                                TextField("Speed", text: self.$speed)
                                                    .frame(width: 220, height: 30)
                                                    .multilineTextAlignment(.center)
                                                    .font(.headline)
                                                Button(action: {
                                                    if let speedInput = Double(self.speed) {
                                                        self.altSpeedTimer.speed = speedInput
                                                        self.speedSetted.toggle()
                                                    }
                                                }){
                                                    Text("Set")
                                                }
                                                .alert(isPresented: self.$speedSetted) {
                                                    Alert(title: Text("Successful"),
                                                          message: Text("Swipe Down to Go Back"),
                                                          dismissButton: .default(Text("Got it!")))
                                                }
                                            }
                                    }
                            }
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    self.timeSettingHidden = false
                                }
                            }
                        }
                    }
                    .padding(.bottom, 74)
                    ZStack {
                        if timeSettingHidden {
                            TwoButtonsView(altSpeedTimer: altSpeedTimer)
                        }
                        else {
                            OneButtonView(minutes: $minutesSetting, seconds: $secondsSetting, pickerShouldHidden: $timeSettingHidden, altSpeedTimer: altSpeedTimer)
                        }
                    }
                }
            }
        }
        .statusBar(hidden: true)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TimerView: View {
    var timeLeft: Double
    var timeSetting: Double
    var body: some View {
        ZStack {
            Text(getMinutes(second: timeLeft) + ":" +
                 getSeconds(second: timeLeft) + ":" +
                 getMilliseconds(second: timeLeft))
                .font(.custom("SFMono-Medium", size: isPad ? 72 : 48))
            Circle()
                .stroke(Color(.systemGray5), lineWidth: isPad ? 12 : 8)
                .frame(width: isPad ? 528 : 307, height: isPad ? 528 : 307)
            Circle()
                .trim(from: 0, to: CGFloat(timeLeft) / CGFloat(timeSetting))
                .stroke(Color.orange, lineWidth: isPad ? 12 : 8)
                .frame(width: isPad ? 528 : 307, height: isPad ? 528 : 307)
                .rotationEffect(Angle(degrees: -90))
                .animation(Animation.default)
        }
    }
    
    
}

struct TwoButtonsView: View {
    @ObservedObject var altSpeedTimer: AltSpeedTimer
    var body: some View {
        HStack {
            Button(action: {
                if self.altSpeedTimer.timerState == .initial {
                    
                }
                else {
                    self.altSpeedTimer.reset()
                }
            }, label: {
                ZStack{
                    Circle()
                        .frame(width: isPad ? 91.2 : 76, height: isPad ? 91.2 : 76)
                        .foregroundColor(Color(.systemGray))
                    Circle()
                        .stroke(Color(.systemGray), lineWidth: isPad ? 2.4 : 2)
                        .frame(width: isPad ? 99.6 : 83, height: isPad ? 99.6 : 83)
                    Text(self.altSpeedTimer.timerState == TimerState.initial ? "Cancel" : "Reset")
                        .foregroundColor(.white)
                        .font(.custom("SFProDisplay-Regular", size: isPad ? 21.6 : 18))
                }
            })
                .padding(.leading, isPad ? 44 : 67)
            Spacer()
            Button(action: {
                if self.altSpeedTimer.timerState == .running {
                    self.altSpeedTimer.pause()
                }
                else {
                    self.altSpeedTimer.start()
                }
            }, label: {
                ZStack{
                    Circle()
                        .frame(width: isPad ? 91.2 : 76, height: isPad ? 91.2 : 76)
                        .foregroundColor(self.altSpeedTimer.timerState == TimerState.running ? Color(.systemOrange) : Color(.systemGreen))
                    Circle()
                        .stroke(self.altSpeedTimer.timerState == TimerState.running ? Color(.systemOrange) : Color(.systemGreen), lineWidth: isPad ? 2.4 : 2)
                        .frame(width: isPad ? 99.6 : 83, height: isPad ? 99.6 : 83)
                    Text(self.altSpeedTimer.timerState == TimerState.initial ? "Start" :
                         self.altSpeedTimer.timerState == TimerState.running ? "Pause" : "Continue")
                        .foregroundColor(.white)
                        .font(.custom("SFProDisplay-Regular", size: isPad ? 21.6 : 18))
                }
            })
                .padding(.trailing, isPad ? 44 : 67)
        }
    }
}

struct OneButtonView: View {
    @Binding var minutes: Int
    @Binding var seconds: Int
    @Binding var pickerShouldHidden: Bool
    @ObservedObject var altSpeedTimer: AltSpeedTimer
    var body: some View {
        HStack {
            if isPad {
                Spacer()
            }
            Button(action: {
                self.altSpeedTimer.setTime(minutes: self.minutes, seconds: self.seconds)
                withAnimation(.spring()) {
                    self.pickerShouldHidden = true
                }
            }, label: {
                ZStack{
                    Circle()
                        .frame(width: isPad ? 91.2 : 76, height: isPad ? 91.2 : 76)
                        .foregroundColor(Color(.systemGray))
                    Circle()
                        .stroke(Color(.systemGray), lineWidth: isPad ? 2.4 : 2)
                        .frame(width: isPad ? 99.6 : 83, height: isPad ? 99.6 : 83)
                    Text("Set")
                        .foregroundColor(.white)
                        .font(.custom("SFProDisplay-Regular", size: isPad ? 21.6 : 18))
                }
            })
        }
        .padding(.trailing, isPad ? 44 : 0)
    }
}

struct TimePickerView: View {
    @Binding var minutes: Int
    @Binding var seconds: Int
    @Binding var pickerShouldHidden: Bool
    var altSpeedTimer: AltSpeedTimer
    var body: some View {
        HStack {
            ZStack {
                Picker(selection: $minutes, label: Text("m")) {
                    ForEach((0..<60), content: { minutesSetting in
                        Text("\(minutesSetting)").tag(minutesSetting)
                    })
                }
                    .frame(width: 100)
                    .clipped()
                Text("M")
                    .font(.system(size: 17, weight: .regular, design: .default))
                    .offset(x: 30, y: 0)
            }
            ZStack {
                Picker(selection: $seconds, label: Text("s")) {
                    ForEach((0..<60), content: { secondsSetting in
                        Text("\(secondsSetting)").tag(secondsSetting)
                    })
                }
                    .frame(width: 100)
                    .clipped()
                Text("S")
                    .font(.system(size: 17, weight: .regular, design: .default))
                    .offset(x: 30, y: 0)
            }
        }
        .frame(width: 311, height: 311)
    }
}
