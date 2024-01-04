//
//  AD_17_LocationAvailabilityTimesOverview.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 10.03.21.
//

import SwiftUI
import Alamofire
import SwiftyJSON

struct AD_17_LocationAvailabilityTimesOverview: View {
    
    @State private var modelText: String = ""
    @EnvironmentObject var navigationManager: NavigationManager
    @State var EditingInformation = UserDefaults.standard.bool(forKey: "ADExisting")
    
 //   @AppStorage("editTimeInfo") var updateInfo: String?

    @AppStorage("Monday") var MondaySelected: String?
    @AppStorage("Tuesday") var TuesdaySelected: String?
    @AppStorage("Wednesday") var WednesdaySelected: String?
    @AppStorage("Thursday") var ThursdaySelected: String?
    @AppStorage("Friday") var FridaySelected: String?
    @AppStorage("Saturday") var SaturdaySelected: String?
    @AppStorage("Sunday") var SundaySelected: String?
    
//    @Environment(\.presentationMode) var presentation

    var body: some View {
//        NavigationView {
        VStack(alignment: .leading){
            
            ZStack(alignment: .top) {
                Header(title: "AED Activation")

            }

                ZStack(alignment: .top){
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .backgroundCard()
                    
                    VStack(){
                        //                    Spacer()
                        VStack(){

                            Text("You have made the following selection.")
                                .font(.headline)
                                .foregroundColor(Color.Cardi_Text_Inf)
                                .multilineTextAlignment(.leading)
                                .frame(width:widthInnerText, height: 60)
                                .padding(.top, 30.0)
                                .padding(.bottom, 20.0)
                        }
                        
                        
                        if MondaySelected == "Yes"
                        {
                            Monday()
                            
                        }
                        
                        if TuesdaySelected == "Yes"
                        {
                            Tuesday()
                        }
                        
                        if WednesdaySelected == "Yes"
                        {
                            Wednesday()
                        }
                        
                        if ThursdaySelected == "Yes"
                        {
                            Thursday()
                        }
                        
                        
                        if FridaySelected == "Yes"
                        {
                            Friday()
                        }
                        
                        
                        if SaturdaySelected == "Yes"
                        {
                            Saturday()
                        }
                        
                        if SundaySelected == "Yes"
                        {
                            Sunday()
                        }
                        Spacer()
                        
                        HStack(alignment: .center){

                            Button(action: {
                                print("Done tapped!")
                                
                                
                                if EditingInformation == true {
                                    
                                    deleteTimeData()
                                   
                                    
                                    UserDefaults.standard.set(false, forKey: "is247Available")
                                    
                                    print("Floating Button Click")
                                    
//                                    ADAvailable247()  //moved
                                    navigationManager.push(.adendoverview)
                                    
                                }else {
                                    
                                    navigationManager.push(.adlocationimages)
                                }
                            }) {
                                HStack {
                                    Text("Done")
                                        .fontWeight(.semibold)
                                        .font(.title2)
                                }
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(20)
                                .padding(.bottom, 60)
                            }
                            .simultaneousGesture(TapGesture().onEnded{

                                if MondaySelected == "Yes" {
                                    DataAvailMonday()
                                }

                                if TuesdaySelected == "Yes" {
                                    DataAvailTuesday()
                                }

                                if WednesdaySelected == "Yes" {
                                    DataAvailWednesday()
                                }

                                if ThursdaySelected == "Yes" {
                                    DataAvailThursday()
                                }

                                if FridaySelected == "Yes" {
                                    DataAvailFriday()
                                }

                                if SaturdaySelected == "Yes" {
                                    DataAvailSaturday()
                                }

                                if SundaySelected == "Yes" {
                                    DataAvailSunday()
                                }
                            })

                            
                            
                            Spacer()
                            Button(action: {
                                navigationManager.pop()
                            }) {
                                Text("Add More")
                                    .fontWeight(.semibold)
                                    .font(.title3)
                                    .frame(minWidth: 0, maxWidth: .infinity)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(LinearGradient(gradient: Gradient(colors: [Color.colorCardiRed, Color.colorCardiRed]), startPoint: .leading, endPoint: .trailing))
                                    .cornerRadius(20)
                                    .padding(.bottom,  60)
                            }
                            
                        }.frame(width:widthInnerText, height: 120)
                            .offset(x: 0, y: 30)
                    }
                }.offset(x: 15, y: 0)
                Spacer()

            }.frame(width:width)
            .navigationBarHidden(true)
   }
}

struct AD_17_LocationAvailabilityTimesOverview_Previews: PreviewProvider {
    static var previews: some View {
        AD_17_LocationAvailabilityTimesOverview()
            .previewDevice("iPhone SE (2nd generation)")
        AD_17_LocationAvailabilityTimesOverview()
            .previewDevice("iPhone 14 Pro")
    }
}

struct Monday: View {
    
    @AppStorage("timeStartMon") var timeStartMon: String?
    @AppStorage("timeEndMon") var timeEndMon: String?
    
    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    
    var body: some View {
        VStack(){
            Button(action: {
                //                                    SectionOneFirstLine.toggle()
                //                            self.mondayCheck.toggle()
            }) {
                HStack(alignment: .center){
                    Image(systemName:"checkmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.colorCardiGray)
                        .font(.system(size: 20, weight: .bold, design: .default))
                    
                    Text("Monday")
                        .foregroundColor(Color.colorCardiGray)
                    Text("from")
                    
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    Spacer()
                    Text(timeStartMon ?? "00:00")
                        .foregroundColor(Color.colorCardiGray)
                    Text("till")
                        .foregroundColor(Color.colorCardiGray)
                    Text(timeEndMon ?? "00:00")
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    //                                    Spacer()
                }.frame(width:widthInnerText, height: 10)
            }
            .padding(.bottom)
            //                                }
        }
    }
}

struct Tuesday: View {
    
    @AppStorage("timeStartTue") var timeStartTue: String?
    @AppStorage("timeEndTue") var timeEndTue: String?
    
    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    
    var body: some View {
        VStack(){
            Button(action: {
                //                                    SectionOneFirstLine.toggle()
                //                            self.mondayCheck.toggle()
            }) {
                HStack(alignment: .center){
                    Image(systemName:"checkmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.colorCardiGray)
                        .font(.system(size: 20, weight: .bold, design: .default))
                    
                    Text("Tuesday")
                        .foregroundColor(Color.colorCardiGray)
                    Text("from")
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    Spacer()

                    Text(timeStartTue ?? "00:00")
                        .foregroundColor(Color.colorCardiGray)
                    Text("till")
                    
                        .foregroundColor(Color.colorCardiGray)
                    Text(timeEndTue ?? "00:00")
                    
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    //                                    Spacer()
                }.frame(width:widthInnerText, height: 10)
            }
            .padding(.bottom)
            //                                }
        }
    }
}

struct Wednesday: View {
    
    @AppStorage("timeStartWed") var timeStartWed: String?
    @AppStorage("timeEndWed") var timeEndWed: String?
    
    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    
    var body: some View {
        VStack(){
            Button(action: {
                //                                    SectionOneFirstLine.toggle()
                //                            self.mondayCheck.toggle()
            }) {
                HStack(alignment: .center){
                    Image(systemName:"checkmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.colorCardiGray)
                        .font(.system(size: 20, weight: .bold, design: .default))
                    
                    Text("Wednesday")
                        .foregroundColor(Color.colorCardiGray)
                    Text("from")
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    Spacer()
                    Text(timeStartWed ?? "00:00")
                        .foregroundColor(Color.colorCardiGray)
                    Text("till")
                        .foregroundColor(Color.colorCardiGray)
                    Text(timeEndWed ?? "00:00")
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    //                                    Spacer()
                }.frame(width:widthInnerText, height: 10)
            }
            .padding(.bottom)
            //                                }
        }
    }
}

struct Thursday: View {
    
    @AppStorage("timeStartThu") var timeStartThu: String?
    @AppStorage("timeEndThu") var timeEndThu: String?
    
    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    
    var body: some View {
        VStack(){
            Button(action: {
                //                                    SectionOneFirstLine.toggle()
                //                            self.mondayCheck.toggle()
            }) {
                HStack(alignment: .center){
                    Image(systemName:"checkmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.colorCardiGray)
                        .font(.system(size: 20, weight: .bold, design: .default))
                    
                    Text("Thursday")
                        .foregroundColor(Color.colorCardiGray)
                    Text("from")
                    
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    Spacer()
                    Text(timeStartThu ?? "00:00")
                        .foregroundColor(Color.colorCardiGray)
                    Text("till")
                        .foregroundColor(Color.colorCardiGray)
                    Text(timeEndThu ?? "00:00")
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    //                                    Spacer()
                }.frame(width:widthInnerText, height: 10)
            }
            .padding(.bottom)
            //                                }
        }
    }
}

struct Friday: View {
    
    @AppStorage("timeStartFri") var timeStartFri: String?
    @AppStorage("timeEndFri") var timeEndFri: String?
    
    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    
    var body: some View {
        VStack(){
            Button(action: {
                //                                    SectionOneFirstLine.toggle()
                //                            self.mondayCheck.toggle()
            }) {
                HStack(alignment: .center){
                    Image(systemName:"checkmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.colorCardiGray)
                        .font(.system(size: 20, weight: .bold, design: .default))
                    
                    Text("Friday")
                        .foregroundColor(Color.colorCardiGray)
                    Text("from")
                    
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    Spacer()
                    Text(timeStartFri ?? "00:00")
                        .foregroundColor(Color.colorCardiGray)
                    Text("till")
                        .foregroundColor(Color.colorCardiGray)
                    Text(timeEndFri ?? "00:00")
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    //                                    Spacer()
                }.frame(width:widthInnerText, height: 10)
            }
            .padding(.bottom)
            //                                }
        }
    }
}

struct Saturday: View {
    
    @AppStorage("timeStartSat") var timeStartSat: String?
    @AppStorage("timeEndSat") var timeEndSat: String?
    
    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    
    var body: some View {
        VStack(){
            Button(action: {
                //                                    SectionOneFirstLine.toggle()
                //                            self.mondayCheck.toggle()
            }) {
                HStack(alignment: .center){
                    Image(systemName:"checkmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.colorCardiGray)
                        .font(.system(size: 20, weight: .bold, design: .default))
                    
                    Text("Saturday")
                        .foregroundColor(Color.colorCardiGray)
                    Text("from")
                    
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    Spacer()
                    Text(timeStartSat ?? "00:00")
                        .foregroundColor(Color.colorCardiGray)
                    Text("till")
                        .foregroundColor(Color.colorCardiGray)
                    Text(timeEndSat ?? "00:00")
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    //                                    Spacer()
                }.frame(width:widthInnerText, height: 10)
            }
            .padding(.bottom)
            //                                }
        }
    }
}

struct Sunday: View {
    
    @AppStorage("timeStartSun") var timeStartSun: String?
    @AppStorage("timeEndSun") var timeEndSun: String?
    
    var widthInnerText = UIScreen.main.bounds.width - (10 + 80)
    
    var body: some View {
        VStack(){
            Button(action: {
                //                                    SectionOneFirstLine.toggle()
                //                            self.mondayCheck.toggle()
            }) {
                HStack(alignment: .center){
                    Image(systemName:"checkmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.colorCardiGray)
                        .font(.system(size: 20, weight: .bold, design: .default))
                    
                    Text("Sunday")
                        .foregroundColor(Color.colorCardiGray)
                    Text("from")
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    Spacer()
                    Text(timeStartSun ?? "00:00")
                        .foregroundColor(Color.colorCardiGray)
                    Text("till")
                        .foregroundColor(Color.colorCardiGray)
                    Text(timeEndSun ?? "00:00")
                    //                                                .padding(.leading, 15.0)
                        .foregroundColor(Color.colorCardiGray)
                    //                                    Spacer()
                }.frame(width:widthInnerText, height: 10)
            }
            .padding(.bottom)
            //                                }
        }
    }
}
