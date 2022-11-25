//
//  TimerViewModel.swift
//  Cookeryarty
//
//  Created by Mac on 18.11.2022.
//

import Foundation
import AVFoundation

class TimerViewModel: ObservableObject {
    
    @Published var isActive = false
    @Published var time: Int = 0
    @Published var resetTime: Int = 0
    @Published var startButtonText = "Start"
    @Published var adviceText = "advice"
    @Published var dishName = ""
    
    let systemSoundEnd: SystemSoundID = 1335
    let systemSoundAttention: SystemSoundID = 1331
    
    
    // Function for showint time in needed format
    func convertIntToTime(timeInSeconds: Int) -> String {
        
        let hours = timeInSeconds / 3600
        let afterHour = timeInSeconds % 3600
        let minutes = afterHour / 60
        let seconds = timeInSeconds % 60
        
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    
    
    // MARK: - Timer settings
    
    func start() {
        if self.time > 0 {
            self.isActive = true
        }
    }

    func stop() {
        self.isActive = false
        if self.time != 0 && self.time != self.resetTime {
            self.startButtonText = "Continue"
        }
    }
    
    
    func reset() {
        self.isActive = false
        self.time = self.resetTime
        self.startButtonText = "Start"
    }
    
    
    func updateCountdown() {
        guard isActive else { return }

        if self.time == 0 {
            self.isActive = false
            self.startButtonText = "End"
            AudioServicesPlaySystemSound(systemSoundEnd)
            return
        } else if self.time > 0 && self.isActive {
            self.time -= 1
        } 
    }
    
    
    // MARK: - Big tom of checking adviceText instructions
    
    func settingAdviceText() {
        switch self.dishName {
        case "Test":
            if self.isActive == false && self.time == self.resetTime {
                self.adviceText = "yeah test"
            }
        case "Dumplings":
            if self.isActive == false && self.time == self.resetTime {
                self.adviceText = "Salt the boiling water and put the dumplings \n Follow the instructions and good Luck!"
            }
        case "Pasta":
            if self.isActive == false && self.time == self.resetTime {
                self.adviceText = "Salt the boiling water and put the pasta \n Follow the instructions and good Luck!"
            }
        case "Borscht":
            if self.isActive == false && self.time == self.resetTime {
                self.adviceText = "Salt the boiling water \n Follow the instructions and good Luck!"
            }
        default:
            if self.isActive == false && self.time == self.resetTime {
                self.adviceText = "Follow the instructions and good Luck!"
            }
        }
    }
    
    
    func checkingAdvice() {
        switch self.dishName {
           
            
        
            // TEST
        case "Test":
            if self.time == 0 {
                self.adviceText = "Bon appetit!"
            } else if self.time == 10 {
                self.adviceText = "flip the test"
                AudioServicesPlaySystemSound(systemSoundAttention)
            }
            //
            
            
            
            
        case "Hot sandwiches":
            if self.time == 0 {
                self.adviceText = "Bon appetit!"
            } else if self.time == 75 {
                self.adviceText = "flip the sandwich"
                AudioServicesPlaySystemSound(systemSoundAttention)
            }
            
        case "Pasta":
            if self.time == 0 {
                self.adviceText = "Bon appetit!"
            } else if self.time == 540 {
                self.adviceText = "mash the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 450 {
                self.adviceText = "mash the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 360 {
                self.adviceText = "mash the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 270 {
                self.adviceText = "mash the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 180 {
                self.adviceText = "mash the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 90 {
                self.adviceText = "turn off fire and mash"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 30 {
                self.adviceText = "water out, butter in"
                AudioServicesPlaySystemSound(systemSoundAttention)
            }

        case "Pancakes":
            if self.time == 0 {
                self.adviceText = "Bon appetit!"
            } else if self.time == 60 {
                self.adviceText = "flip the pancake"
                AudioServicesPlaySystemSound(systemSoundAttention)
            }

        case "Buckwheat":
            if self.time == 0 {
                self.adviceText = "Bon appetit!"
            } else if self.time == 1020 {
                self.adviceText = "mash the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 720 {
                self.adviceText = "mash the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 360 {
                self.adviceText = "mash the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 30 {
                self.adviceText = "water out, butter in"
                AudioServicesPlaySystemSound(systemSoundAttention)
            }

        case "Chicken chops":
            if self.time == 0 {
                self.adviceText = "Bon appetit!"
            } else if self.time == 300 {
                self.adviceText = "flip the chop"
                AudioServicesPlaySystemSound(systemSoundAttention)
            }

        case "Syrniki":
            if self.time == 0 {
                self.adviceText = "Bon appetit!"
            } else if self.time == 180 {
                self.adviceText = "flip the syrnik"
                AudioServicesPlaySystemSound(systemSoundAttention)
            }

        case "Dumplings":
            if self.time == 0 {
                self.adviceText = "Bon appetit!"
            } else if self.time == 570 {
                self.adviceText = "mash the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 450 {
                self.adviceText = "mash the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 330 {
                self.adviceText = "mash the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 210 {
                self.adviceText = "mash the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 90 {
                self.adviceText = "mash the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 30 {
                self.adviceText = "water out, butter in"
                AudioServicesPlaySystemSound(systemSoundAttention)
            }

        case "Borscht":
            if self.time == 0 {
                self.adviceText = "Bon appetit!"
            } else if self.time == 3590 {
                self.adviceText = "meet to the water"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 3580 {
                self.adviceText = "peeled onion to the pot"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 3540 {
                self.adviceText = "start cutting the roast (onion, carrot, beetroot)"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 3480 {
                self.adviceText = "cut the roast (onion, carrot, beetroot)"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 3000 {
                self.adviceText = "put the pen on the fire add oil"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 2940 {
                self.adviceText = "put the onion to the pen"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 2880 {
                self.adviceText = "put the beetroot and carrot to the pen"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 2220 {
                self.adviceText = "add the tomato to the pen"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 1980 {
                self.adviceText = "stop fire on roast"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 1800 {
                self.adviceText = "add the potato and pepper to the pot"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 420 {
                self.adviceText = "add the roast to the pot"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 300 {
                self.adviceText = "add the cabbage to the pot"
                AudioServicesPlaySystemSound(systemSoundAttention)
            }


        case "Sarzuela fish and seafood":
            if self.time == 0 {
                self.adviceText = "Bon appetit!"
            } else if self.time == 5395 {
                self.adviceText = "point #1, #2, #3 in instruction"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 1800 {
                self.adviceText = "point #4, #5 in instruction"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 1500 {
                self.adviceText = "point #6, #7 in instruction"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 1200 {
                self.adviceText = "point #8 in instruction"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 300 {
                self.adviceText = "point #9, #10 in instruction"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 180 {
                self.adviceText = "point #11 in instruction"
                AudioServicesPlaySystemSound(systemSoundAttention)
            }


        case "Brownie":
            if self.time == 0 {
                self.adviceText = "Bon appetit!"
            } else if self.time == 1375 {
                self.adviceText = "put the water bath on the fire"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 1340 {
                self.adviceText = "add the butter and chocolate / mash"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 1280 {
                self.adviceText = "add other ingredients / mash"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 1230 {
                self.adviceText = "add shugar / mash"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 1200 {
                self.adviceText = "add the cocoa powder / mash"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 1140 {
                self.adviceText = "add eggs one by one / mash"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 1110 {
                self.adviceText = "add soda slaked in vinegar / mash"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 1050 {
                self.adviceText = "dough is ready / pour the dough into a greased mold"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 1020 {
                self.adviceText = "put the mold in a well-heated roaster"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 420 {
                self.adviceText = "check the cake if cake is ready stop and Bon Appetit!"
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 240 {
                AudioServicesPlaySystemSound(systemSoundAttention)
            } else if self.time == 60 {
                self.adviceText = "check the cake if cake is ready stop and Bon Appetit!"
                AudioServicesPlaySystemSound(systemSoundAttention)
            }
        
        default:
            self.adviceText = "Follow the instructions and good Luck!"
        }
    }
    
}
