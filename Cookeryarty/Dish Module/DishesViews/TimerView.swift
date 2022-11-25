//
//  TimerView.swift
//  Cookeryarty
//
//  Created by Mac on 18.11.2022.
//

import SwiftUI
import AVFoundation

struct TimerView: View {
    
    @StateObject private var timerVM = TimerViewModel()
    let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
    
    @State var showAlert: Bool = false
    
    @EnvironmentObject private var vm: DishesViewModel
    let dish: DishModel
    

    var body: some View {
        VStack {
            ZStack {
                Color("AccentColor")
                
                VStack {
                    
                    Text("\(dish.name)")
                    
                    Text("\(timerVM.convertIntToTime(timeInSeconds: timerVM.time))")
                        .font(.system(size: 50, weight: .heavy, design: .rounded))
                    
                    HStack {
                        Button {
                            timerVM.start()
                        } label: {
                            Text(timerVM.startButtonText)
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color("AccentColor"))
                                .frame(height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        .disabled(timerVM.isActive)
                        
                        Button {
                            timerVM.stop()
                        } label: {
                            Text("Stop")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color("AccentColor"))
                                .frame(height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        
                        Button {
                            if timerVM.time != timerVM.resetTime {
                                showAlert.toggle()
                            }
                        } label: {
                            Text("Reset")
                                .frame(maxWidth: .infinity)
                                .foregroundColor(Color("AccentColor"))
                                .frame(height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(title: Text("Alert"),
                                  message: Text("Really want to reset timer?"),
                                  primaryButton: .default(Text("yes").fontWeight(.bold), action: {
                                        timerVM.reset()
                                        timerVM.settingAdviceText()
                                    }) ,
                                  secondaryButton: .cancel())
                        }

                    }
                    .padding(.bottom)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                }
                Spacer()
                
            }
            .cornerRadius(20)
            .frame(width: UIScreen.main.bounds.size.width / 1.5, height: UIScreen.main.bounds.size.width / 2)
            
            Text("Advice")
                .font(.title2)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            
            Text(timerVM.adviceText)
                .font(.title3)
            
            Spacer()
                .frame(height: 20)
            
        }
        .onReceive(timer, perform: { _ in
            timerVM.updateCountdown()
            timerVM.checkingAdvice()
            timerVM.settingAdviceText()
        })
        .onAppear(perform: {
            timerVM.time = dish.time
            timerVM.resetTime = dish.time
            timerVM.dishName = dish.name
        
        })
        
        .frame(maxWidth: .infinity)
        .multilineTextAlignment(.center)
        
    }
}




struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(dish: DishDataService.dishes.first!)
            .preferredColorScheme(.light)
            .environmentObject(DishesViewModel())
    }
}







