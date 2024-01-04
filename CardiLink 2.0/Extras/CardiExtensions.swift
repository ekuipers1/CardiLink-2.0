//
//  CardiExtensions.swift
//  CardiLink 2.0
//
//  Created by Erik Kuipers on 07.07.22.
//

import SwiftUI
import SystemConfiguration
import UIKit

extension String {
    var localized: String {
        return NSLocalizedString(self, comment:"")
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}

extension Bundle {
    
    public var appVersionShort: String? {
        if let result = infoDictionary?["CFBundleShortVersionString"] as? String {
            return result
        } else {
            return "⚠️"
        }
    }
    public var appVersionLong: String? {
        if let result = infoDictionary?["CFBundleVersion"] as? String {
            return result
        } else {
            return "⚠️"
        }
    }
    public var appName: String? {
        if let result = infoDictionary?["CFBundleName"] as? String {
            return result
        } else {
            return "⚠️"
        }
    }
}

public extension UIDevice {
  static let modelName: String = {
    var systemInfo = utsname()
    uname(&systemInfo)
    let machineMirror = Mirror(reflecting: systemInfo.machine)
    let identifier = machineMirror.children.reduce("") { identifier, element in
      guard let value = element.value as? Int8, value != 0 else { return identifier }
      return identifier + String(UnicodeScalar(UInt8(value)))
    }
    
    func mapToDevice(identifier: String) -> String {
      switch identifier {
      case "iPod5,1":                                 return "iPod Touch 5"
      case "iPod7,1":                                 return "iPod Touch 6"
      case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
      case "iPhone4,1":                               return "iPhone 4s"
      case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
      case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
      case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
      case "iPhone7,2":                               return "iPhone 6"
      case "iPhone7,1":                               return "iPhone 6 Plus"
      case "iPhone8,1":                               return "iPhone 6s"
      case "iPhone8,2":                               return "iPhone 6s Plus"
      case "iPhone9,1", "iPhone9,3":                  return "iPhone 7"
      case "iPhone9,2", "iPhone9,4":                  return "iPhone 7 Plus"
      case "iPhone8,4":                               return "iPhone SE"
      case "iPhone10,1", "iPhone10,4":                return "iPhone 8"
      case "iPhone10,2", "iPhone10,5":                return "iPhone 8 Plus"
      case "iPhone10,3", "iPhone10,6":                return "iPhone X"
      case "iPhone11,2":                              return "iPhone XS"
      case "iPhone11,4", "iPhone11,6":                return "iPhone XS Max"
      case "iPhone11,8":                              return "iPhone XR"
      case "iPhone12,1":                              return "iPhone 12"
      case "i386", "x86_64":                          return "Simulator \(mapToDevice(identifier: ProcessInfo().environment["SIMULATOR_MODEL_IDENTIFIER"] ?? "iOS"))"
      default:                                        return identifier
      }
    }
    
    return mapToDevice(identifier: identifier)
  }()
}

extension Image {
    
    func leftArrow() -> some View {
        self
            .padding(.leading, 15.0)
            .font(.title)
            .frame(width: 40.0, height: 40.0)
            .foregroundColor(Color.Cardi_Text_Inf)
            .cornerRadius(50)
    }
    
    func hamburgerMenu() -> some View {
        self
            .padding(.trailing, 15.0)
            .font(.title)
            .frame(width: 40.0, height: 40.0)
            .foregroundColor(Color.colorCardiRed)
    }
}

extension Text {
    
    func addDevice() -> some View {
        self
        
            .font(.headline)
            .foregroundColor(Color.Cardi_Text_Inf)
            .fontWeight(.semibold)
            .multilineTextAlignment(.leading)
    }
}

extension Shape {

    func backgroundCard() -> some View {
 
        self
        
            .fill(Color.Cardi_Text)
            .padding(.horizontal, 5.0)
            .padding(.top, 20)
            .shadow(color: .gray, radius: 3, y: 1)
            .frame(width: UIScreen.main.bounds.width - (10 + 40), height: UIScreen.main.bounds.height / 1.2)
    }
        
    func backgroundCardWaiting() -> some View {
 
        self
            .fill(Color.Cardi_Text)
            .opacity(0.8)
            .padding(.horizontal, 5.0)
            .padding(.top, 20)
            .shadow(color: .gray, radius: 3, y: 1)
            .frame(width: UIScreen.main.bounds.width - (10 + 60), height: UIScreen.main.bounds.height / 2.5)
            .offset(x: 0, y: -155)

    }
    
    func backgroundCardSmall() -> some View {
 
        self
        
            .fill(Color.Cardi_Text)
            .padding(.horizontal, 5.0)
            .padding(.top, 20)
            .shadow(color: .gray, radius: 3, y: 1)
            .frame(width: UIScreen.main.bounds.width - (10 + 40), height: UIScreen.main.bounds.height / 1.8)
    }
    
    func backgroundCardMedium() -> some View {
 
        self
        
            .fill(Color.Cardi_Text)
            .padding(.horizontal, 5.0)
            .padding(.top, 20)
            .shadow(color: .gray, radius: 3, y: 1)
            .frame(width: UIScreen.main.bounds.width - (10 + 40), height: UIScreen.main.bounds.height / 1.3)
    }
    
    
    func backgroundCardMini() -> some View {
 
        self
        
            .fill(Color.Cardi_Text)
            .padding(.horizontal, 5.0)
            .padding(.top, 20)
            .shadow(color: .gray, radius: 3, y: 1)
            .frame(width: UIScreen.main.bounds.width - (10 + 60), height: UIScreen.main.bounds.height / 2.5)
    }
}

func greeting() -> String {
    @State var date = Date()
    
    var greet = ""
    
    let midNight0 = Calendar.current.date(bySettingHour: 0, minute: 00, second: 00, of: date)!
    let nightEnd = Calendar.current.date(bySettingHour: 3, minute: 59, second: 59, of: date)!
    let morningStart = Calendar.current.date(bySettingHour: 4, minute: 00, second: 0, of: date)!
    let morningEnd = Calendar.current.date(bySettingHour: 11, minute: 59, second: 59, of: date)!
    let noonStart = Calendar.current.date(bySettingHour: 12, minute: 00, second: 00, of: date)!
    let noonEnd = Calendar.current.date(bySettingHour: 16, minute: 59, second: 59, of: date)!
    let eveStart = Calendar.current.date(bySettingHour: 17, minute: 00, second: 00, of: date)!
    let eveEnd = Calendar.current.date(bySettingHour: 20, minute: 59, second: 59, of: date)!
    let nightStart = Calendar.current.date(bySettingHour: 21, minute: 00, second: 00, of: date)!
    let midNight24 = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: date)!
    
    if ((date >= midNight0) && (nightEnd >= date)) {
            greet = NSLocalizedString("Good Night.", comment: "")
        } else if ((date >= morningStart) && (morningEnd >= date)) {
            greet = NSLocalizedString("Good Morning.", comment: "")
        } else if ((date >= noonStart) && (noonEnd >= date)) {
            greet = NSLocalizedString("Good Afternoon.", comment: "")
        } else if ((date >= eveStart) && (eveEnd >= date)) {
            greet = NSLocalizedString("Good Evening.", comment: "")
        } else if ((date >= nightStart) && (midNight24 >= date)) {
            greet = NSLocalizedString("Good Night.", comment: "")
        }
        return greet
}

let heightFull = UIScreen.main.bounds.height
let widthFull = UIScreen.main.bounds.width
let height = UIScreen.main.bounds.height / 1.5
let height3rd = UIScreen.main.bounds.height / 2
let height35rd = UIScreen.main.bounds.height / 2.3
let width = UIScreen.main.bounds.width - (10 + 10)
let widthInner = UIScreen.main.bounds.width - (10 + 40)
let widthInnerTextList = UIScreen.main.bounds.width - (10 + 50)
let widthInnerText = UIScreen.main.bounds.width - (10 + 80)
let widthInnerTextButton = UIScreen.main.bounds.width - (10 + 80)
var widthList = UIScreen.main.bounds.width
let widthInnerTextMini = UIScreen.main.bounds.width - (10 + 100)
let widthInnerTextMiniSearch = UIScreen.main.bounds.width - (10 + 120)
let widthSlider = UIScreen.main.bounds.width - (10 + 160)
var widthInnerTextBorder = UIScreen.main.bounds.width - (10 + 100)
var widthInnerTextBorderText = UIScreen.main.bounds.width - (10 + 140)
var heightInner = UIScreen.main.bounds.height / 1.5 - (40 - 20)
var heightInner2 = UIScreen.main.bounds.height / 1.6 - (40 - 20)

class AuthWindow: ObservableObject {
    @Published var isAuthenticated = false
}

extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

public struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: LocalizedStringKey
    
    public func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                Text(placeholder)
                    .padding(.horizontal, 5)
            }
            content
                .foregroundColor(.black)
                .padding(5.0)
        }
    }
}

func LoadMyData() {

    DefiGetsingleData()
    DefiGetsingleDataOverView()
    gethardwaredata()
    getNKMessagesData()
    getNKMessagesDataOverview()
    getmovementData()
    getGeoLocationdata()
    CommGetsingleDataOverview()
    getSIMcardDataOverview()
    
}

struct TextFieldLimitModifer: ViewModifier {
    @Binding var value: String
    var length: Int
    
    func body(content: Content) -> some View {
        content
            .onReceive(value.publisher.collect()) {
                value = String($0.prefix(length))
            }
    }
}

extension View {
    func limitInputLength(value: Binding<String>, length: Int) -> some View {
        self.modifier(TextFieldLimitModifer(value: value, length: length))
    }
}

extension View {
    func underlineTextField() -> some View {
        self
            .padding(.vertical, 1)
            .overlay(Rectangle().frame(height: 3).padding(.top, 35))
            .foregroundColor(.Calming_Green)
            .padding(1)
    }
}

extension Data {
    struct HexEncodingOptions: OptionSet {
        let rawValue: Int
        static let upperCase = HexEncodingOptions(rawValue: 1 << 0)
    }
    
    func hexEncodedString(options: HexEncodingOptions = []) -> String {
        let format = options.contains(.upperCase) ? "%02hhX" : "%02hhx"
        return self.map { String(format: format, $0) }.joined()
    }
}

extension String {
    func toHexEncodedString(uppercase: Bool = true, prefix: String = "", separator: String = "") -> String {
        return unicodeScalars.map { prefix + .init($0.value, radix: 16, uppercase: uppercase) } .joined(separator: separator)
    }
}

struct Header: View {
    @EnvironmentObject var navigationManager: NavigationManager
    var title: String
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack() {
                HStack() {
                    Button(action: {
                        TimerManager.shared.stopAllTimers()
                        navigationManager.pop()
                    }) {
                        Image(systemName: "arrow.left")
                            .leftArrow()
                    }
                    Spacer()
                    Text(title)
                        .addDevice()
                    Spacer()
                    Button(action: {
                        
                        navigationManager.navigateTo(.dashboard)
                    }) {
                        Image(systemName: "x.square.fill")
                            .hamburgerMenu()
                    }
                }
                .padding(.top, 0.0)
            }
            .frame(height: 50)
            .navigationBarHidden(true)
        }
    }
}

struct HeaderAlert: View {
    @EnvironmentObject var navigationManager: NavigationManager
    var title: String
    @State private var showingAlert = false
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack() {
                HStack() {
                    Button(action: {
                        TimerManager.shared.stopAllTimers()
                        navigationManager.pop()
                    }) {
                        Image(systemName: "arrow.left")
                            .leftArrow()
                    }
                    Spacer()
                    Text(title)
                        .addDevice()
                    Spacer()
                    Button(action: {
                        self.showingAlert = true
                    }) {
                        Image(systemName: "x.square.fill")
                            .hamburgerMenu()
                    }
                }
                .padding(.top, 0.0)
            }
            .frame(height: 50)
            .navigationBarHidden(true)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(NSLocalizedString("UnsavedChangesTitle", comment: "")),
                      message: Text(NSLocalizedString("UnsavedChangesMessage", comment: "")),
                      primaryButton: .default(Text(NSLocalizedString("YesButton", comment: "")), action: {
                          navigationManager.navigateTo(.dashboard)
                      }),
                      secondaryButton: .cancel(Text(NSLocalizedString("NoButton", comment: "")))
                )
            }
        }
    }
}

struct HeaderAddress: View {
    @EnvironmentObject var navigationManager: NavigationManager
    var title: String
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack() {
                HStack() {
                    Button(action: {
                        TimerManager.shared.stopAllTimers()
                        navigationManager.pop()

                    }) {
                        Image(systemName: "arrow.left")
                            .leftArrow()
                    }
                    Spacer()
                    Text(title)
                        .addDevice()
                    Spacer()
                    Button(action: {
                        
                        navigationManager.navigateTo(.dashboard)
                    }) {
                        Image(systemName: "x.square.fill")
                            .hamburgerMenu()
                    }
                }
                .padding(.top, 0.0)
            }
            .frame(height: 50)
            .navigationBarHidden(true)
        }
    }
}

struct HeaderTime: View {
    @EnvironmentObject var navigationManager: NavigationManager
    var title: String
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack() {
                HStack() {
                    Button(action: {
                        TimerManager.shared.stopAllTimers()
                        navigationManager.pop()
                    }) {
                        Image(systemName: "arrow.left")
                            .leftArrow()
                    }
                    Spacer()
                    Text(title)
                        .addDevice()
                    Spacer()
                    Button(action: {
                        
                        navigationManager.navigateTo(.dashboard)
                    }) {
                        Image(systemName: "x.square.fill")
                            .hamburgerMenu()
                    }
                }
                .padding(.top, 0.0)
            }
            .frame(height: 50)
            .navigationBarHidden(true)
        }
    }
}

struct HeaderStart: View {
    @EnvironmentObject var navigationManager: NavigationManager
    var widthInnerText = UIScreen.main.bounds.width - (10 + 20)
    
    @Environment(\.presentationMode) var presentationMode
    var title: String
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack() {
                HStack() {
                    Button(action:{
                        self.presentationMode.wrappedValue.dismiss()
                        TimerManager.shared.stopAllTimers()
                    }) {
                        Image(systemName: "arrow.left")
                            .leftArrow()
                            .opacity(0.0)
                    }
                    Spacer()
                    Text(title)
                        .addDevice()
                    Spacer()
                    Button(action: {
                        navigationManager.navigateTo(.dashboard)
                    }) {
                        Image(systemName: "x.square.fill")
                            .hamburgerMenu()
                    }
                }
                .padding(.top, 0.0)
            }
            .frame(width: widthInnerText, height: 50.0)
            .navigationBarHidden(true)
        }
    }
}

struct HeaderStartSuMenu: View {
    @EnvironmentObject var navigationManager: NavigationManager
    var widthInnerText = UIScreen.main.bounds.width - (10 + 20)
    
    @Environment(\.presentationMode) var presentationMode
    var title: String
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack() {
                HStack() {
                    Button(action:{
                        self.presentationMode.wrappedValue.dismiss()
                        TimerManager.shared.stopAllTimers()
                    }) {
                        Image(systemName: "arrow.left")
                            .leftArrow()
                            .opacity(0.0)
                    }
                    Spacer()
                    Text(title)
                        .addDevice()
                    Spacer()
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "x.square.fill")
                            .hamburgerMenu()
                    }
                }
                .padding(.top, 0.0)
            }
            .frame(width: widthInnerText, height: 50.0)
            .navigationBarHidden(true)
        }
    }
}

struct ForwardButtonStyle: ButtonStyle {
    var isLoading: Bool

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .disabled(isLoading)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.Calming_Green, Color.Map_Calming_Green]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .cornerRadius(20)
            .padding(.bottom, 20)
             .frame(width: widthInnerText)
    }
}

struct RadioGroupStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
                .font(.title2)
                .foregroundColor(Color.Cardi_Text_Inf)
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
                .foregroundColor(configuration.isOn ? .Calming_Green : .colorCardiGray)
                .font(.title2)
        }
        .onTapGesture {
            configuration.isOn.toggle()
        }
    }
}

extension String {
    
    func UTCToLocal(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = outGoingFormat
        return dateFormatter.string(from: dt ?? Date())
    }

    func localToUTC(incomingFormat: String, outGoingFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = incomingFormat
        dateFormatter.calendar = NSCalendar.current
        dateFormatter.timeZone = TimeZone.current
        let dt = dateFormatter.date(from: self)
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.dateFormat = outGoingFormat
        return dateFormatter.string(from: dt ?? Date())
    }
}

func clearCache(){
    let cacheURL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    let fileManager = FileManager.default
    do {
        let directoryContents = try FileManager.default.contentsOfDirectory( at: cacheURL, includingPropertiesForKeys: nil, options: [])
        for file in directoryContents {
            do {
                try fileManager.removeItem(at: file)
                debugPrint("ALL GOOD")
            }
            catch let error as NSError {
                debugPrint("Ooops! Something went wrong: \(error)")
            }
            
        }
    } catch let error as NSError {
        debugPrint("Ooops! Something went wrong: \(error)")
        print(error.localizedDescription)
    }
}

func clearGeo() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("latlon.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearGreen()
    } catch {
        clearGreen()
        return
    }
}

func clearGreen() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("greenData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearRed()
    } catch {
        clearRed()
        return
    }
}

func clearRed() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("redData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearYellow()
    } catch {
        clearYellow()
        return
    }
}

func clearYellow() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("yellowData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearBlue()
    } catch {
        clearBlue()
        return
    }
}

func clearBlue() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("blueData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        NKclearGreenAcvailable()
    } catch {
        NKclearGreenAcvailable()
        return
    }
}

func NKclearGreenAcvailable() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKgreenAvailableData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        NKclearYellowOverdue()
    } catch {
        NKclearYellowOverdue()
        return
    }
}

func NKclearYellowOverdue() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKyellowOverdueData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        NKclearYellowWarning()
    } catch {
        NKclearYellowWarning()
        return
    }
}

func NKclearYellowWarning() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKyellowWarningData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        NKclearRedTimeout()
    } catch {
        NKclearRedTimeout()
        return
    }
}

func NKclearRedTimeout() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKredTimeOutData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        NKclearRedError()
    } catch {
        NKclearRedError()
        return
    }
}

func NKclearRedError() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKredErrorData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        NKclearGrayNonMonitored()
    } catch {
        NKclearGrayNonMonitored()
        return
    }
}

func NKclearGrayNonMonitored() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKgrayNonMonitoredData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        DataDefiNK()
    } catch {
        DataDefiNK()
        return
    }
}

func DataDefiNK() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKMessagesData.json")
    do {
        try fileManager.removeItem(at: filenameLatLon)
        DataDefiNKOver()
    } catch {
        DataDefiNKOver()
        return
    }
}

func DataDefiNKOver() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKMessagesDataOverView.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        DataCommNK()
    } catch {
        DataCommNK()
        return
    }
}

func DataCommNK() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKMessagesDataComm.json")
    do {
        try fileManager.removeItem(at: filenameLatLon)
        NKclearCommData()
    } catch {
        NKclearCommData()
        return
    }
}

func NKclearCommData() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKCommData.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        NKclearServiceData()
    } catch {
        NKclearServiceData()
        return
    }
}

func NKclearServiceData() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("ServiceTicketsNK.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearService()
    } catch {
        clearService()
        return
    }
}

func clearService() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("service.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearSearchGreen()
    } catch {
        clearSearchGreen()
        return
    }
}

func clearSearchGreen() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKSearchDataGreen.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearSearchYellow()
    } catch {
        clearSearchYellow()
        return
    }
}

func clearSearchYellow() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKSearchDataYellow.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearSearchRed()
    } catch {
        clearSearchRed()
        return
    }
}

func clearSearchRed() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKSearchDataRed.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearSearchBlue()
    } catch {
        clearSearchBlue()
        return
    }
}

func clearSearchBlue() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKSearchDataBlue.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearSearchGray()
    } catch {
        clearSearchGray()
        return
    }
}

func clearSearchGray() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("NKSearchDataGray.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearSelfTest()
    } catch {
        clearSelfTest()
        return
    }
}

func clearSelfTest() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("SelfTest.json")
    
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearCache()
    } catch {
        return
    }
}

func clearAllFile() {
    let defaults = UserDefaults.standard
    
    defaults.set("NO", forKey: "callServiceTickets")
    defaults.set("", forKey: "Backend")
    defaults.set("", forKey: "BackendAdd")
    defaults.set("Nop", forKey: "ShowForgotPassword")
    defaults.set("", forKey: "searchText")
    defaults.set("0", forKey: "GreenCount")
    defaults.set("0", forKey: "YellowOverdue")
    defaults.set("0", forKey: "YellowCount")
    defaults.set("0", forKey: "RedCount")
    defaults.set("0", forKey: "RedTimeout")
    defaults.set("0", forKey: "BlueCount")
    defaults.set("0", forKey: "YellowCountOverdue")
    defaults.set("0", forKey: "CommunicatorCount")
    defaults.set("0", forKey: "green")
    defaults.set("0", forKey: "yellow")
    defaults.set("0", forKey: "red")
    defaults.set("0", forKey: "gray")
    defaults.set("0", forKey: "blue")
    defaults.set("0", forKey: "withGps")
    defaults.set("NO", forKey: "WaitForItOverview")
    defaults.set("NO", forKey: "WaitForIt")
    defaults.set("false", forKey: "ADExcisting")
    defaults.set("No", forKey: "NONIOT")
    defaults.set(false, forKey: "OnePortal")
    defaults.set("", forKey: "postalCodeKey")
    
    let fileManager = FileManager.default
    
    let filenameService = getDocumentsDiretory().appendingPathComponent("service.json")
    let filenameRedTimeout = getDocumentsDiretory().appendingPathComponent("NKredTimeOutData.json")
    let filenameRedError = getDocumentsDiretory().appendingPathComponent("NKredErrorData.json")
    let filenameYellow = getDocumentsDiretory().appendingPathComponent("yellowData.json")
    let filenameGreen = getDocumentsDiretory().appendingPathComponent("greenData.json")
    let filenameBlue = getDocumentsDiretory().appendingPathComponent("blueData.json")
    let filenameGreenNK = getDocumentsDiretory().appendingPathComponent("NKgreenAvailableData.json")
    let filenameGeo = getDocumentsDiretory().appendingPathComponent("latlon.json")
    let filenameCommNK = getDocumentsDiretory().appendingPathComponent("NKCommData.json")
    let filenameSelfTestNK = getDocumentsDiretory().appendingPathComponent("SelfTest.json")
    let filenameYellowOverdue = getDocumentsDiretory().appendingPathComponent("NKyellowOverdueData.json")
    let filenameYellowWarning = getDocumentsDiretory().appendingPathComponent("NKyellowWarningData.json")
    let filenameRedNK = getDocumentsDiretory().appendingPathComponent("NKredData.json")
    let filenameGrayNonMonitoredNK = getDocumentsDiretory().appendingPathComponent("NKgrayNonMonitoredData.json")
    let filenameDataDefiNK = getDocumentsDiretory().appendingPathComponent("NKMessagesData.json")
    let filenameDataDefiNKOver = getDocumentsDiretory().appendingPathComponent("NKMessagesDataOverView.json")
    let filenameDataCommNK = getDocumentsDiretory().appendingPathComponent("NKMessagesDataComm.json")
    let filenameSearchGreen = getDocumentsDiretory().appendingPathComponent("NKSearchDataGreen.json")
    let filenameSearchYellow = getDocumentsDiretory().appendingPathComponent("NKSearchDataYellow.json")
    let filenameSearchRed = getDocumentsDiretory().appendingPathComponent("NKSearchDataRed.json")
    let filenameSearchBlue = getDocumentsDiretory().appendingPathComponent("NKSearchDataBlue.json")
    let filenameSearchGray = getDocumentsDiretory().appendingPathComponent("NKSearchDataGray.json")
    let filenameServiceDataNK = getDocumentsDiretory().appendingPathComponent("ServiceTicketsNK.json")
    
    do {
        try fileManager.removeItem(at: filenameService)
        try fileManager.removeItem(at: filenameGrayNonMonitoredNK)
        try fileManager.removeItem(at: filenameRedTimeout)
        try fileManager.removeItem(at: filenameRedError)
        try fileManager.removeItem(at: filenameRedNK)
        try fileManager.removeItem(at: filenameYellow)
        try fileManager.removeItem(at: filenameYellowOverdue)
        try fileManager.removeItem(at: filenameYellowWarning)
        try fileManager.removeItem(at: filenameGreen)
        try fileManager.removeItem(at: filenameGreenNK)
        try fileManager.removeItem(at: filenameBlue)
        try fileManager.removeItem(at: filenameCommNK)
        try fileManager.removeItem(at: filenameGeo)
        try fileManager.removeItem(at: filenameSelfTestNK)
        try fileManager.removeItem(at: filenameDataDefiNK)
        try fileManager.removeItem(at: filenameDataDefiNKOver)
        try fileManager.removeItem(at: filenameDataCommNK)
        try fileManager.removeItem(at: filenameSearchGreen)
        try fileManager.removeItem(at: filenameSearchYellow)
        try fileManager.removeItem(at: filenameSearchRed)
        try fileManager.removeItem(at: filenameSearchBlue)
        try fileManager.removeItem(at: filenameSearchGray)
        try fileManager.removeItem(at: filenameServiceDataNK)
        
    } catch {
        clearGeo()
        return
    }
}

func clearAllFileOverview() {
    
    let fileManager = FileManager.default
    let filenameDataDefiNK = getDocumentsDiretory().appendingPathComponent("NKMessagesData.json")
    let filenameDataDefiNKOver = getDocumentsDiretory().appendingPathComponent("NKMessagesDataOverView.json")
    let filenameSelfTestNK = getDocumentsDiretory().appendingPathComponent("SelfTest.json")
    
    do {
        try fileManager.removeItem(at: filenameDataDefiNK)
        try fileManager.removeItem(at: filenameDataDefiNKOver)
        try fileManager.removeItem(at: filenameSelfTestNK)
    } catch {
        return
    }
}

func clearGeoOverview() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("latlon.json")
    do {
        try fileManager.removeItem(at: filenameLatLon)
        clearSelfTestOverview()
    } catch {
        clearSelfTestOverview()
        return
    }
}

func clearSelfTestOverview() {
    let fileManager = FileManager.default
    let filenameLatLon = getDocumentsDiretory().appendingPathComponent("SelfTest.json")
    do {
        try fileManager.removeItem(at: filenameLatLon)
    } catch {
        return
    }
}

struct BottomMenu: View {
    
    @State var selection: Int? = nil
    @EnvironmentObject var base:BaseDataFetch
    @EnvironmentObject var def:DefriDataFetch
    @EnvironmentObject var navigationManager: NavigationManager
    let defaults = UserDefaults.standard
    @AppStorage("NoPortal") var NoPortal: Bool?

    var body: some View {
        
        ZStack(){
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(radius: 5, y: 5)
                .frame(width: 400, height: 65)
            VStack(){
                HStack(spacing: 0){
                    Button(action: {
                        if NoPortal == true {
                            navigationManager.navigateTo(.login)
                            clearAllFile()
                            defaults.set("NO", forKey: "callServiceTickets")
                            defaults.set("", forKey: "Backend")
                            defaults.set("", forKey: "BackendAdd")
                            defaults.set("Nop", forKey: "ShowForgotPassword")
                            defaults.set("", forKey: "searchText")
                            defaults.set("0", forKey: "GreenCount")
                            defaults.set("0", forKey: "YellowOverdue")
                            defaults.set("0", forKey: "YellowCount")
                            defaults.set("0", forKey: "RedCount")
                            defaults.set("0", forKey: "RedTimeout")
                            defaults.set("0", forKey: "BlueCount")
                            defaults.set("0", forKey: "YellowCountOverdue")
                            defaults.set("0", forKey: "CommunicatorCount")
                            defaults.set("0", forKey: "green")
                            defaults.set("0", forKey: "yellow")
                            defaults.set("0", forKey: "red")
                            defaults.set("0", forKey: "gray")
                            defaults.set("0", forKey: "blue")
                            defaults.set("0", forKey: "withGps")
                            defaults.set("NO", forKey: "WaitForItOverview")
                            defaults.set("NO", forKey: "WaitForIt")
                            defaults.set("false", forKey: "ADExcisting")
                            defaults.set("No", forKey: "NONIOT")
                        } else {
                            navigationManager.navigateTo(.portalSelect)
                            clearAllFile()
                            defaults.set("NO", forKey: "callServiceTickets")
                            defaults.set("", forKey: "Backend")
                            defaults.set("", forKey: "BackendAdd")
                            defaults.set("Nop", forKey: "ShowForgotPassword")
                            defaults.set("", forKey: "searchText")
                            defaults.set("0", forKey: "GreenCount")
                            defaults.set("0", forKey: "YellowOverdue")
                            defaults.set("0", forKey: "YellowCount")
                            defaults.set("0", forKey: "RedCount")
                            defaults.set("0", forKey: "RedTimeout")
                            defaults.set("0", forKey: "BlueCount")
                            defaults.set("0", forKey: "YellowCountOverdue")
                            defaults.set("0", forKey: "CommunicatorCount")
                            defaults.set("0", forKey: "green")
                            defaults.set("0", forKey: "yellow")
                            defaults.set("0", forKey: "red")
                            defaults.set("0", forKey: "gray")
                            defaults.set("0", forKey: "blue")
                            defaults.set("0", forKey: "withGps")
                            defaults.set("NO", forKey: "WaitForItOverview")
                            defaults.set("NO", forKey: "WaitForIt")
                            defaults.set("false", forKey: "ADExcisting")
                            defaults.set("No", forKey: "NONIOT")
                        }
                    }) {
                        if NoPortal == true {
                            HStack {
                                Image(systemName: "escape")
                                    .font(.title2)
                                Text("Logout")
                                    .font(.system(size: 18))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.black)
                            }
                            .padding()
                            .foregroundColor(Color.colorCardiRed)
                    } else {
                        HStack {
                            Image(systemName: "escape")
                                .font(.title2)
                            Text("Portal select")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .foregroundColor(Color.colorCardiRed)
                    }
                    }
                    .padding(.trailing, 45.0)
                    Button(action: {
                        navigationManager.navigateTo(.about)
                        getUserData()
                    }, label: {
                        HStack {
                            Image(systemName: "wallet.pass")
                                .font(.title2)
                            Text("About")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                        }
                        .padding()
                        .foregroundColor(Color.colorCardiOrange)
                    })
                    .padding(.trailing, 55.0)
                    
                }
            }
        } .offset(x: 0, y: 20)
    }
}

struct comMainInfo: View {
    
    @AppStorage("commdetailID") var commdetailID: String?
    @AppStorage("commdetailOwner") var commdetailOwner: String?
    @AppStorage("commdetailDescription") var commdetailDescription: String?
    @AppStorage("commdetailSerial") var commdetailSerial: String?
    @AppStorage("commdetailOwnername") var commdetailOwnername: String?
    
    var body: some View {
        ZStack(){
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 170)
            VStack(alignment: .leading){
                if #available(iOS 15.0, *) {
                    Text("\(commdetailSerial ?? "Unknown Heart Connect")")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .textSelection(.enabled)
                } else {
                    Text("\(commdetailSerial ?? "Unknown Heart Connect")")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                }
                Text("\(commdetailOwnername ?? "Please try again")")
                    .fontWeight(.medium)
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                Text("\(commdetailDescription ?? "")")
                    .fontWeight(.light)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
            }.frame(width: 300, height: 150)
                .padding(.horizontal)
        }.padding(.horizontal, 25.0)
    }
}

struct comStatusSingle: View {
    
    @AppStorage("commdetailStatusValue") var commdetailStatusValue: String?
    @AppStorage("commstatusImage") var commstatusColor: String?
    
    var body: some View {
        ZStack(){
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 70)
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    Text("Status")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(25.0)
                    Spacer().opacity(0)
                    Text("\(commdetailStatusValue ?? "N/A")")
                        .fontWeight(.regular)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    Image(commstatusColor ?? "..")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40,
                               height: 40)
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}

struct comPairedSingleNK: View {
    
    @AppStorage("commdetailStatusValue") var commdetailStatusValue: String?
    
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 70)
            
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    Text("Status")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(25.0)
                    Spacer().opacity(0)
                    Text("\(commdetailStatusValue ?? "N/A")")
                        .fontWeight(.regular)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    let whatStatusImage = commdetailStatusValue
                    switch whatStatusImage {
                    case "Operational":
                        Image("comms_green")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40,
                                   height: 40)
                    case "Defective":
                        Image("comms_orange")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40,
                                   height: 40)
                    case "Disabled":
                        Image("comms_red")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40,
                                   height: 40)
                    default:
                        Image("Comms")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 40,
                                   height: 40)
                    }
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}

struct comPairedSingle: View {
    
    @AppStorage("commdetailStatusValue") var commdetailStatusValue: String?
    @AppStorage("commstatusImage") var commstatusColor: String?
    
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 70)
            
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    Text("Status")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(25.0)
                    Spacer().opacity(0)
                    Text("\(commdetailStatusValue ?? "available")")
                        .fontWeight(.regular)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    
                    Image(commstatusColor ?? "..")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40,
                               height: 40)
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}

struct comadminStatusSingle: View {
    
    @AppStorage("commdetailAdminStatusValue") var commdetailAdminStatusValue: String?
    
    var body: some View {
        ZStack(){
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 70)
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    Text("Administration Status")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 15.0)
                    Spacer().opacity(0)
                    
                    let newoneText = commdetailAdminStatusValue
                    switch newoneText {
                    case "Operational":
                        Text("\(commdetailAdminStatusValue ?? "..")")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color.Calming_Green)
                            .multilineTextAlignment(.trailing)
                    case "Defective":
                        Text("\(commdetailAdminStatusValue ?? "..")")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color.colorCardiRed)
                            .multilineTextAlignment(.trailing)
                    case "Monitored":
                        Text("\(commdetailAdminStatusValue ?? "..")")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color.Calming_Green)
                            .multilineTextAlignment(.trailing)
                    case "Disabled":
                        Text("\(commdetailAdminStatusValue ?? "..")")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color.colorCardiRed)
                            .multilineTextAlignment(.trailing)
                    default:
                        Text("\(commdetailAdminStatusValue ?? "..")")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}

struct comInitalBootDate: View {
    
    @AppStorage("initialBootupDate") var initialBootupDate: String?
    
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 70)
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    Text("Initial Bootup Date:")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 15.0)
                    Spacer().opacity(0)
                    if initialBootupDate == "N/A" ||  initialBootupDate == "Jan 1, 1970" {
                        SwiftUI.Text("N/A")
                            .fontWeight(.regular)
                            .font(.body)
                            .multilineTextAlignment(.trailing)
                            .padding(.leading, 15.0)
                    } else {
                        Text("\(initialBootupDate ?? "..")")
                            .fontWeight(.regular)
                            .font(.body)
                            .foregroundColor(Color.Calming_Green)
                            .multilineTextAlignment(.trailing)
                    }
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}

struct comownerSingle: View {
    
    @AppStorage("commdetailOwner") var commdetailOwner: String?
    @AppStorage("commdetailOwnername") var commdetailOwnername: String?
    
    var body: some View {
        ZStack(){
            
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(radius: 5, y: 5)
                .frame(width: 350, height: 70)
            
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    Text("Owner")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 15.0)
                    Spacer().opacity(0)
                    
                    let defaults = UserDefaults.standard
                    Text("\(commdetailOwnername ?? "..")")
                        .fontWeight(.regular)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}

struct comdescriptionSingle: View {
    
    @AppStorage("commdetailDescription") var commdetailDescription: String?
    
    var body: some View {
        GroupBox() {
            DisclosureGroup("Description") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            HStack(){
                                SwiftUI.Text("\(commdetailDescription ?? "..")")
                                    .fontWeight(.regular)
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
                .frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
        }
        .padding(.top)
        .frame(width: 350)
        .groupBoxStyle(TransparentGroupBox())
        
    }
}

struct compairedWithSingle: View {
    
    @AppStorage("commdetailpairingDate") var commdetailpairingDate: String?
    @AppStorage("commdetailpairingID") var commdetailpairingID: String?
    @AppStorage("commdetailpairingSerial") var commdetailpairingSerial: String?
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Paired with") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            HStack(){
                                Image(systemName: "antenna.radiowaves.left.and.right")
                                SwiftUI.Text("AED")
                                let defaults = UserDefaults.standard
                                if commdetailpairingID == "" || commdetailpairingID == "null" || commdetailpairingID == nil {
                                    SwiftUI.Text("N/A")
                                        .fontWeight(.regular)
                                        .font(.body)
                                        .multilineTextAlignment(.trailing)
                                        .padding(.leading, 15.0)
                                } else {
                                    NavigationLink(destination: AED_Detailed()) {
                                        SwiftUI.Text("\(commdetailpairingSerial ?? "..")")
                                            .fontWeight(.regular)
                                            .font(.body)
                                            .multilineTextAlignment(.trailing)
                                            .padding(.leading, 15.0)
                                    }
                                }
                            }.simultaneousGesture(TapGesture().onEnded{
                                UserDefaults.standard.set(commdetailpairingID, forKey: "SelectedDefi")
                                getNKMessagesData()
                                DefiGetsingleData()
                            })
                        }
                    }
                    
                    VStack(alignment: .leading){
                        Divider().opacity(0)
                        HStack(){
                            Image(systemName: "calendar.badge.clock")
                            if commdetailpairingDate == "N/A" ||  commdetailpairingDate == "Jan 1, 1970 2:00 AM" {
                                SwiftUI.Text("since")
                                SwiftUI.Text("N/A")
                                    .fontWeight(.regular)
                                    .font(.body)
                                    .multilineTextAlignment(.trailing)
                                    .padding(.leading, 15.0)
                            } else {
                                SwiftUI.Text("since")
                                SwiftUI.Text("\(commdetailpairingDate ?? "..")")
                                    .fontWeight(.regular)
                                    .font(.body)
                                    .multilineTextAlignment(.trailing)
                                    .padding(.leading, 15.0)
                            }
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.padding(.top, 20.0)
            .frame(width: 350)
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct CommunicatorMenu: View {
    @State private var showButtons = false
    @Environment(\.presentationMode) var presentationMode
    
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        
        ZStack() {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(
                        LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                    .opacity(showButtons ? 0.9 : 0)
                    .shadow(color: Color.Cardi_Text, radius: 5, y: 5)
                
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
            
        }
        
        HStack(spacing: 40){
            Button(action:{ self.presentationMode.wrappedValue.dismiss()
                
                UserDefaults.standard.set("Unknown Heart Connect", forKey: "commdetailOwner")
                UserDefaults.standard.set("Please try again", forKey: "commdetailID")
                UserDefaults.standard.set("Make sure you have Internet connection" ,forKey: "commdetailDescription")
                UserDefaults.standard.set("", forKey: "commdetailStatusValue")
                UserDefaults.standard.set("", forKey: "commdetailAdminStatusValue")
                UserDefaults.standard.set("", forKey: "commdetailpairingDate")
                UserDefaults.standard.set("", forKey: "commdetailpairingID")
                UserDefaults.standard.set("", forKey: "SelectedComm")
            }){
                
                Image(systemName: "arrow.left")
                    .font(.title)
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(Color.black)
                    .background(Color.white)
                    .cornerRadius(50)
                    .opacity(showButtons ? 0 : 1)
                
            }
            Text("Heart Connects")
                .fontWeight(.bold)
                .font(.title2)
                .foregroundColor(Color.black)
                .padding(10)
                .background(Capsule(style: .circular).fill(Color.white).opacity(0.9))
                .frame(width: 190, height: 30)
                .padding(.trailing, -30)
                .opacity(showButtons ? 0 : 1)
                .minimumScaleFactor(0.8)
            
            HStack(){
                ZStack(alignment: .topTrailing) {
                    
                    Group {
                        Button(action:
                                { self.showButtons.toggle() }) {
                            NavigationLink(destination: CommHardware()) {
                                VStack(){
                                    Image(systemName: "server.rack")
                                        .foregroundColor(Color.colorCardiOrange)
                                        .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
                                    Text("Hardware")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                }.padding(showButtons ? 30.0 : 0)
                            }.simultaneousGesture(TapGesture().onEnded{
                                getCommhardwaredata()
                            })
                        }
                                .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                                .offset(x: showButtons ? -130 : 0, y: 10)
                                .opacity(showButtons ? 1 : 0)
                        Button(action:
                                { self.showButtons.toggle() }) {
                            
                            NavigationLink(destination: CommSimCard()) {
                                VStack(){
                                    Image(systemName: "simcard")
                                        .foregroundColor(Color.colorCardiOrange)
                                        .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
                                    Text("SIM Card")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                }.padding(showButtons ? 30.0 : 0)
                            }.simultaneousGesture(TapGesture().onEnded{
                                getSIMcardData()
                                
                            })
                        }
                                .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                                .font(.headline)
                                .opacity(showButtons ? 1 : 0)
                                .offset(x: showButtons ? -240 : 0, y: showButtons ? 130 : 0)
                        Button(action:
                                { self.showButtons.toggle() }) {
                            let defaults = UserDefaults.standard
                            let backend = defaults.string(forKey: "Backend")
                            if backend == "NEW" {
                            } else {
                            }
                        }
                                .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                                .font(.headline)
                                .opacity(showButtons ? 1 : 0)
                                .offset(x: showButtons ? -140 : 0, y: showButtons ? 240 : 0)
                        Button(action:
                                { self.showButtons.toggle() }) {
                            let defaults = UserDefaults.standard
                            let backend = defaults.string(forKey: "Backend")
                            NavigationLink(destination: MessagesMainMenuCommNK()) {
                                VStack(){
                                    Image(systemName: "message")
                                        .foregroundColor(Color.colorCardiOrange)
                                        .rotationEffect(Angle.degrees(showButtons ? 0 : -90))
                                    Text("Messages")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                    
                                }.padding(showButtons ? 30.0 : 0)
                            }
                        }
                                .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                                .offset(x: -30, y: showButtons ? 100 : 0) // No
                                .opacity(showButtons ? 1 : 0)
                        Button(action: { self.showButtons.toggle() }) {
                            Image(systemName: "plus.circle")
                                .font(.title)
                                .foregroundColor(Color.black)
                                .padding(showButtons ? 15.0 : 15.0)
                                .rotationEffect(Angle.degrees(showButtons ? 45 : 0))
                        }
                        .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                        .offset(x: showButtons ? -50 : 0, y: showButtons ? 15 : 0)
                    }
                    .accentColor(.white)
                    .animation(.default)
                }
            }
        }
        .padding(.top, 40.0)
        .padding(.bottom, 30)
    }
}

struct commhardwareBaseDataNK: View {
    
    @AppStorage("commharwareModel") var commharwareModel: String?
    @AppStorage("commHardwarefirmwareVersion") var commHardwarefirmwareVersion: String?
    @AppStorage("commHardwarebatteryPercentage") var commHardwarebatteryPercentage: String?
    @AppStorage("commHardwarelot") var commHardwarelot: String?
    
    @State private var presentingSheet = false
    
    var body: some View {
        GroupBox() {
            DisclosureGroup("Base Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            SwiftUI.Text("Model")
                            HStack(){
                                Image(systemName: "greetingcard")
                                SwiftUI.Text(commharwareModel ?? "N/A")
                            }
                            Divider().opacity(0)
                        }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Firmware Version")
                        HStack(){
                            Image(systemName: "cube.transparent")
                            SwiftUI.Text(commHardwarefirmwareVersion ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Battery Percentage")
                        HStack(){
                            Image(systemName: "minus.plus.batteryblock")
                            SwiftUI.Text(commHardwarebatteryPercentage ?? "N/A")
                            SwiftUI.Text("%")
                        }
                        Divider().opacity(0)
                    }
                    
                        VStack(alignment: .leading){
                            SwiftUI.Text("LOT")
                            HStack(){
                                Image(systemName: "number.square")
                                SwiftUI.Text(commHardwarelot ?? "N/A")
                            }
                            Divider().opacity(0)
                        }
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
        }.frame(width: 350)
        .groupBoxStyle(TransparentGroupBox())
    }
}

struct commhardwareBaseData: View {
    
    @AppStorage("commharwareModel") var commharwareModel: String?
    @AppStorage("commassemblyDate") var commassemblyDate: String?
    @AppStorage("commactiveSince") var commactiveSince: String?
    @AppStorage("GPSAntennasAttached") var GPSAntennasAttached: Bool?
    
    @State private var presentingSheet = false
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Base Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Model:")
                            HStack(){
                                Image(systemName: "greetingcard")
                                let longtext = commharwareModel
                                let newone = longtext?.replacingOccurrences(of: "cloud.cardilink.communicator.models.", with: "")
                                SwiftUI.Text(newone ?? "N/A")
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Assembly Date:")
                        HStack(){
                            Image(systemName: "calendar")
                            SwiftUI.Text(commassemblyDate ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Active since:")
                        HStack(){
                            Image(systemName: "calendar")
                            SwiftUI.Text(commactiveSince ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        HStack(){
                            Image(systemName: "antenna.radiowaves.left.and.right")
                        if GPSAntennasAttached ?? true {
                            SwiftUI.Text("GPS antennas: attached")
                        } else {
                            SwiftUI.Text("GPS antennas: not attached")
                        }
                        }
                        Divider()
                            .opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
        }.frame(width: 350)
        .groupBoxStyle(TransparentGroupBox())
    }
}

struct commInternalChecks: View {
    
    @AppStorage("commbootupStatus") var commbootupStatus: String?
    @AppStorage("commbluetoothChipset") var commbluetoothChipset: String?
    @AppStorage("commbluetoothMacAddress") var commbluetoothMacAddress: String?
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        GroupBox() {
            DisclosureGroup("Internal Checks") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            SwiftUI.Text("Bootup Status:")
                            if commbootupStatus == "true" {
                            HStack(){
                                Image(systemName: "captions.bubble")
                                SwiftUI.Text("Success")
                                    .foregroundColor(Color.Calming_Green)
                            }
                            Divider().opacity(0)
                            }else {
                                Divider().opacity(0)
                                HStack(){
                                    Image(systemName: "captions.bubble")
                                    SwiftUI.Text("Failed")
                                        .foregroundColor(Color.colorCardiRed)
                                }
                                Divider().opacity(0)
                            }
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Bluetooth chipset:")
                        if commbluetoothChipset == "true" {
                        HStack(){
                            Image(systemName: "memorychip")
                            SwiftUI.Text("Success")
                                .foregroundColor(Color.Calming_Green)
                        }
                        Divider().opacity(0)
                        } else {
                            HStack(){
                                Image(systemName: "memorychip")
                                SwiftUI.Text("Failed")
                                    .foregroundColor(Color.colorCardiRed)
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Bluetooth MAC address:")
                        HStack(){
                            Image(systemName: "waveform")
                            SwiftUI.Text(commbluetoothMacAddress ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
        }.frame(width: 350)
        .groupBoxStyle(TransparentGroupBox())
    }
}

struct commhardwarePCBData: View {
    
    @AppStorage("commserialPCB") var commserialPCB: String?
    @AppStorage("commfinaldeliveryDatePCB") var commfinaldeliveryDatePCB: String?
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("PCB Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            SwiftUI.Text("Serial Number:")
                            HStack(){
                                Image(systemName: "greetingcard")
                                SwiftUI.Text(commserialPCB ?? "N/A")
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Delivery Date:")
                        HStack(){
                            Image(systemName: "calendar")
                            SwiftUI.Text(commfinaldeliveryDatePCB ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
        }.frame(width: 350)
        .groupBoxStyle(TransparentGroupBox())
    }
}

struct commhardwareBatteryData: View {
    
    @AppStorage("commBatteryBatch") var commBatteryBatch: String?
    @AppStorage("commBatteryVoltage") var commBatteryVoltage: String?
    @AppStorage("commactivationsDateBattery") var commactivationsDateBattery: String?
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Battery Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Batch:")
                            HStack(){
                                Image(systemName: "cube.transparent")
                                SwiftUI.Text(commBatteryBatch ?? "N/A")
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Voltage:")
                        HStack(){
                            Image(systemName: "minus.plus.batteryblock")
                            SwiftUI.Text(commBatteryVoltage ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Activation Date:")
                        HStack(){
                            Image(systemName: "calendar")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(commactivationsDateBattery ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
            .font(.headline)
        }.frame(width: 350)
        .groupBoxStyle(TransparentGroupBox())
    }
}

struct commhardwareSIMDataNK: View {
    
    @AppStorage("SIMserial") var SIMserial: String?
    @AppStorage("SIMoperator") var SIMoperator: String?
    @AppStorage("SIMcountryCode") var SIMcountryCode: String?
    @AppStorage("SIMnetworkCode") var SIMnetworkCode: String?
    @AppStorage("SIMsignalStrength") var SIMsignalStrength: String?
    @AppStorage("SIMsignalQuality") var SIMsignalQuality: String?
    
    @State private var presentingSheet = false
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("SIM Card Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            SwiftUI.Text("SIM card Id:")
                            HStack(){
                                Image(systemName: "simcard")
                                SwiftUI.Text(SIMserial ?? "N/A")
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Mobile network operator (MNO):")
                        HStack(){
                            Image(systemName: "phone.circle")
                            SwiftUI.Text(SIMoperator ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Mobile country code (MCC):")
                        HStack(){
                            Image(systemName: "globe")
                            SwiftUI.Text(SIMcountryCode ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Mobile network code (MNC):")
                        HStack(){
                            Image(systemName: "barcode")
                            SwiftUI.Text(SIMnetworkCode ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Signal strength:")
                        HStack(){
                            Image(systemName: "dot.radiowaves.left.and.right")
                            SwiftUI.Text(SIMsignalStrength ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Signal quality:")
                        HStack(){
                            Image(systemName: "antenna.radiowaves.left.and.right")
                            SwiftUI.Text(SIMsignalQuality ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
        }.frame(width: 350)
            .groupBoxStyle(TransparentGroupBox())
    }
}

struct commhardwareSIMData: View {
    
    @AppStorage("SIMCardid") var SIMCardid: String?
    @AppStorage("SIMCardactivationCode") var SIMCardactivationCode: String?
    @AppStorage("SIMCardphoneNumber") var SIMCardphoneNumber: String?
    @AppStorage("SIMCardIPAddress") var SIMCardIPAddress: String?
    @AppStorage("SIMCardActive") var SIMCardActive: String?
    @AppStorage("SIMCarddeliveryDateSIM") var SIMCarddeliveryDateSIM: String?
    @AppStorage("myPortal") var myPortal: String?
    @State private var presentingSheet = false
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("SIM Card Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            SwiftUI.Text("SIM Id: ")
                            HStack(){
                                Image(systemName: "simcard")
                                SwiftUI.Text(SIMCardid ?? "N/A")
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Activation code:")
                        HStack(){
                            Image(systemName: "barcode")
                            SwiftUI.Text(SIMCardactivationCode ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Activation status:")
                        HStack(){
                            Image(systemName: "arrow.left.arrow.right.circle")
                            let longtext = SIMCardActive
                            let returntext_CleanUp = longtext?.replacingOccurrences(of: "success(", with: "")
                            let returntext_CleanUp2 = returntext_CleanUp?.replacingOccurrences(of: ")", with: "")
                            let finalStatus = returntext_CleanUp2?.replacingOccurrences(of: "\"", with: "")
                            if finalStatus == "notactivated" {
                                SwiftUI.Text("Not Activated")
                            }
                            if finalStatus == "ready" {
                                SwiftUI.Text("Ready")
                                    .foregroundColor(Color.colorCardiOrange)
                            }
                            if finalStatus == "test" {
                                SwiftUI.Text("Test")
                                    .foregroundColor(Color.colorCardiOrange)
                            }
                            if finalStatus == "live" {
                                SwiftUI.Text("Live")
                                    .foregroundColor(Color.Calming_Green)
                            }
                            if finalStatus == "suspend" {
                                SwiftUI.Text("Suspended")
                                    .foregroundColor(Color.colorCardiRed)
                            }
                            if finalStatus == "bar" {
                                SwiftUI.Text("Bar")
                                    .foregroundColor(Color.colorCardiRed)
                            }
                            if finalStatus == "unknown" {
                                SwiftUI.Text("Unknown")
                            }
                            if finalStatus == "terminated" {
                                SwiftUI.Text("Terminated")
                                    .foregroundColor(Color.Calming_Green)
                            }
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Activation date:")
                        HStack(){
                            Image(systemName: "calendar")
                            SwiftUI.Text(SIMCarddeliveryDateSIM ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Activation URL:")
                        HStack(){
                            Image(systemName: "link")
                            let myURL = myPortal
                            let sim = "activation?"
                            let theone =  SIMCardactivationCode ?? ""
                            let url = myURL! + sim + theone
                            if theone == "" {
                                SwiftUI.Text("Unavailable")
                            } else {
                                Link(url, destination: URL(string: url)!)
                            }
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
        }.frame(width: 350)
            .groupBoxStyle(TransparentGroupBox())
    }
}

struct defiMainInfo: View {
    
    @AppStorage("defridetailID") var defridetailID: String?
    @AppStorage("defridetailOwner") var defridetailOwner: String?
    @AppStorage("defridetailDescription") var defridetailDescription: String?
    @AppStorage("defridetailSerial") var defridetailSerial: String?
    @AppStorage("defridetailownerName") var defridetailownerName: String?
    
    var body: some View {
        ZStack(){
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 180)
            VStack(alignment: .leading){
                let defaults = UserDefaults.standard
                let backend = defaults.string(forKey: "Backend")
                if #available(iOS 15.0, *) {
                    Text("\(defridetailSerial ?? "Unknown AED")")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(Color.black)
                        .frame(width: 300, height: 30.0, alignment:.leading)
                        .textSelection(.enabled)
                } else {
                    Text("\(defridetailSerial ?? "Unknown AED")")
                        .fontWeight(.bold)
                        .font(.title)
                        .foregroundColor(Color.black)
                        .frame(width: 300, height: 30.0, alignment:.leading)
                }
                Text("\(defridetailownerName ?? "Please try again")")
                    .fontWeight(.medium)
                    .font(.headline)
                    .foregroundColor(Color.black)
                    .frame(width: 300, height: 30.0, alignment:.leading)
                Text("\(defridetailDescription ?? "")")
                    .fontWeight(.light)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
            }.frame(width: 300, height: 150)
                .padding(.horizontal)
        }.padding(.horizontal, 25.0)
    }
}

struct defiMovementSingle: View {
    
    @AppStorage("defridetailStatusValue") var defridetailStatusValue: String?
    @AppStorage("statusImage") var statusColor: String?
    
    var body: some View {
        ZStack(){
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 70)
            
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    Button(action: {
                    }, label: {
                        HStack(){
                            NavigationLink(destination: MapviewMove(location: MapDirectoryMove().places[0], places: MapDirectoryMove().places)) {
                                Image(systemName: "figure.walk")
                                    .resizable()
                                    .foregroundColor(Color.colorCardiRed)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40,
                                           height: 40)
                                    .padding(.leading, 15.0)
                                Text("Movements detected")
                                    .fontWeight(.bold)
                                    .font(.body)
                                    .foregroundColor(Color.black)
                                    .multilineTextAlignment(.leading)
                                Image(systemName: "figure.stand")
                                    .resizable()
                                    .foregroundColor(Color.Calming_Green)
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 40,
                                           height: 40)
                            }
                        }  .simultaneousGesture(TapGesture().onEnded{
                            getmovementData()
                        })
                    })
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}

struct defiStatusSingle: View {
    
    @AppStorage("defridetailStatusValue") var defridetailStatusValue: String?
    @AppStorage("statusImage") var statusColor: String?
    
    var body: some View {
        ZStack(){
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(color: Color.colorCardiGray, radius: 5, y: 5)
                .frame(width: 350, height: 70)
            
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    Text("Status")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(25.0)
                    Spacer()
                    Text("\(defridetailStatusValue ?? "N/A")")
                        .fontWeight(.regular)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                    Image(statusColor ?? "..")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40,
                               height: 40)
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}

struct adminStatusSingle: View {
    
    @AppStorage("defridetailAdminStatusValue") var defridetailAdminStatusValue: String?
    @AppStorage("defridetailAdminStatusReason") var defridetailAdminStatusReason: String?
    @AppStorage("defridetailAdminStatusColor") var defridetailAdminStatusColor: Int?
    
    var body: some View {
        GroupBox() {
            DisclosureGroup("Dashboard State") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            HStack(){
                                Spacer()
                                
                                let whatStatusImage = defridetailAdminStatusColor
                                
                                switch whatStatusImage {
                                case 0:
                                    Text("\(defridetailAdminStatusValue ?? "N/A")")
                                        .fontWeight(.bold)
                                        .font(.body)
                                        .foregroundColor(Color.Calming_Green)
                                        .multilineTextAlignment(.trailing)
                                    
                                case 1:
                                    Text("\(defridetailAdminStatusValue ?? "N/A")")
                                        .fontWeight(.bold)
                                        .font(.body)
                                        .foregroundColor(Color.Cardi_Yellow)
                                        .multilineTextAlignment(.trailing)
                                    
                                case 2:
                                    Text("\(defridetailAdminStatusValue ?? "N/A")")
                                        .fontWeight(.bold)
                                        .font(.body)
                                        .foregroundColor(Color.colorCardiRed)
                                        .multilineTextAlignment(.trailing)
                                    
                                case 3:
                                    Text("\(defridetailAdminStatusValue ?? "N/A")")
                                        .fontWeight(.bold)
                                        .font(.body)
                                        .foregroundColor(Color.Cardi_Yellow)
                                        .multilineTextAlignment(.trailing)
                                    
                                case 4:
                                    Text("\(defridetailAdminStatusValue ?? "N/A")")
                                        .fontWeight(.bold)
                                        .font(.body)
                                        .foregroundColor(Color.colorCardiRed)
                                        .multilineTextAlignment(.trailing)
                                case 5:
                                    Text("\(defridetailAdminStatusValue ?? "N/A")")
                                        .fontWeight(.bold)
                                        .font(.body)
                                        .multilineTextAlignment(.trailing)
                                    
                                default:
                                    Text("\(defridetailAdminStatusValue ?? "N/A")")
                                        .fontWeight(.bold)
                                        .font(.body)
                                        .foregroundColor(Color.colorCardiGray)
                                        .multilineTextAlignment(.trailing)
                                }
                            }
                        }
                    }
                    VStack(alignment: .leading){
                        Divider().opacity(0)
                        HStack(){
                            Text(defridetailAdminStatusReason ?? "N/A")
                                .fontWeight(.regular)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 15.0)
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.padding(.bottom, -22)
            .frame(width: 350)
            .groupBoxStyle(TransparentGroupBox())
    }
}

struct ownerSingle: View {
    
    @AppStorage("defridetailOwner") var defridetailOwner: String?
    @AppStorage("defridetailownerName") var defridetailownerName: String?
    
    var body: some View {
        ZStack(){
            RoundedRectangle(cornerRadius: 15, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(radius: 5, y: 5)
                .frame(width: 350, height: 70)
            
            VStack(alignment: .leading, spacing: 120) {
                HStack(){
                    Text("Owner")
                        .fontWeight(.bold)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 15.0)
                    Spacer()
                    Text("\(defridetailownerName ?? "..")")
                        .fontWeight(.regular)
                        .font(.body)
                        .foregroundColor(Color.black)
                        .multilineTextAlignment(.trailing)
                }
                .padding(.trailing)
            }.frame(width: 330, height: 60)
        }
    }
}

struct descriptionSingle: View {
    
    @AppStorage("defridetailDescription") var defridetailDescription: String?
    
    var body: some View {
        GroupBox() {
            DisclosureGroup("Description") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            HStack(){
                                SwiftUI.Text("\(defridetailDescription ?? "N/A")")
                                    .fontWeight(.regular)
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                }
                .frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }
        .padding(.top)
        .frame(width: 350)
        .groupBoxStyle(TransparentGroupBox())
        
    }
}

struct selfTestSingle: View {
    
    @AppStorage("defridetailOwner") var defridetailOwner: String?
    @AppStorage("defridetailSelfTest00Date") var defridetailSelfTest00Date: String?
    @AppStorage("defridetailSelfTest01Date") var defridetailSelfTest01Date: String?
    @AppStorage("defridetailSelfTest02Date") var defridetailSelfTest02Date: String?
    @AppStorage("defridetailSelfTest00Value") var defridetailSelfTest00Value: String?
    @AppStorage("defridetailSelfTest01Value") var defridetailSelfTest01Value: String?
    @AppStorage("defridetailSelfTest02Value") var defridetailSelfTest02Value: String?
    @AppStorage("defridetailSelfTest00Type") var defridetailSelfTest00Type: String?
    @AppStorage("defridetailSelfTest01Type") var defridetailSelfTest01Type: String?
    @AppStorage("defridetailSelfTest02Type") var defridetailSelfTest02Type: String?
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Last Self Tests") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            HStack(){
                                SwiftUI.Text("Daily")
                                Image(systemName: "calendar")
                                SwiftUI.Text("\(defridetailSelfTest00Date ?? "..")")
                                    .fontWeight(.regular)
                                    .font(.body)
                                    .multilineTextAlignment(.trailing)
                                    .padding(.leading, 15.0)
                            }
                        }
                    }
                    VStack(alignment: .leading){
                        Divider().opacity(0)
                        HStack(){
                            SwiftUI.Text("Daily")
                            Image(systemName: "calendar")
                            SwiftUI.Text("\(defridetailSelfTest01Date ?? "..")")
                                .fontWeight(.regular)
                                .font(.body)
                                .multilineTextAlignment(.trailing)
                                .padding(.leading, 15.0)
                        }
                    }
                    VStack(alignment: .leading){
                        Divider().opacity(0)
                        HStack(){
                            SwiftUI.Text("Daily")
                            Image(systemName: "calendar")
                            SwiftUI.Text("\(defridetailSelfTest02Date ?? "..")")
                                .fontWeight(.regular)
                                .font(.body)
                                .multilineTextAlignment(.trailing)
                                .padding(.leading, 15.0)
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 350)
            .groupBoxStyle(TransparentGroupBox())
    }
}

struct pairedWithSingle: View {
    
    @AppStorage("defridetailpairingDate") var defridetailpairingDate: String?
    @AppStorage("defridetailpairingID") var defridetailpairingID: String?
    @AppStorage("defidetailpairingSerial") var defidetailpairingSerial: String?
    
    var body: some View {
        GroupBox() {
            DisclosureGroup("Paired with") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            HStack(){
                                Image(systemName: "antenna.radiowaves.left.and.right")
                                SwiftUI.Text("Heart Connect")
                                if defridetailpairingID == "N/A" {
                                    SwiftUI.Text("\(defidetailpairingSerial ?? "N/A")")
                                        .fontWeight(.regular)
                                        .font(.body)
                                        .multilineTextAlignment(.trailing)
                                        .padding(.leading, 15.0)
                                } else {
                                    NavigationLink(destination: CommDetailed()) {
                                        SwiftUI.Text("\(defidetailpairingSerial ?? "N/A")")
                                            .fontWeight(.regular)
                                            .font(.body)
                                            .multilineTextAlignment(.trailing)
                                            .padding(.leading, 15.0)
                                    }
                                }
                            }.simultaneousGesture(TapGesture().onEnded{
                                UserDefaults.standard.set(defridetailpairingID, forKey: "SelectedComm")
                                getNKMessagesDataComm()
                                CommGetsingleData()
                            })
                        }
                    }
                    VStack(alignment: .leading){
                        Divider().opacity(0)
                        HStack(){
                            Image(systemName: "calendar.badge.clock")
                            if defridetailpairingDate == "N/A" {
                                SwiftUI.Text("since")
                                SwiftUI.Text("N/A")
                                    .fontWeight(.regular)
                                    .font(.body)
                                    .multilineTextAlignment(.trailing)
                                    .padding(.leading, 15.0)
                                
                            } else {
                                SwiftUI.Text("since")
                                SwiftUI.Text("\(defridetailpairingDate ?? "..")")
                                    .fontWeight(.regular)
                                    .font(.body)
                                    .multilineTextAlignment(.trailing)
                                    .padding(.leading, 15.0)
                            }
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 350)
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct DefibrillatorMenu: View {
    @State private var showButtons = false
    @Environment(\.presentationMode) var presentationMode
    let gradient = Gradient(colors: [Color.colorCardiOrange, Color.Cardi_Text])
    
    var body: some View {
        ZStack() {
            GeometryReader { geometry in
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(
                        LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                    .opacity(showButtons ? 0.9 : 0)
                    .shadow(color: Color.Cardi_Text, radius: 5, y: 5)
                
                    .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            }
        }
        
        HStack(spacing: 40){
            
            Button(action:{ self.presentationMode.wrappedValue.dismiss()
                
                UserDefaults.standard.set("Unknown AED", forKey: "defridetailOwner")
                UserDefaults.standard.set("", forKey: "defridetailStatusValue")
                UserDefaults.standard.set("", forKey: "defridetailpairingDate")
                UserDefaults.standard.set("", forKey: "defridetailpairingID")
                UserDefaults.standard.set("", forKey: "defridetailSelfTest00Value")
                UserDefaults.standard.set("", forKey: "defridetailSelfTest01Value")
                UserDefaults.standard.set("", forKey: "defridetailSelfTest02Value")
                UserDefaults.standard.set("", forKey: "defridetailSelfTest00Date")
                UserDefaults.standard.set("", forKey: "defridetailSelfTest01Date")
                UserDefaults.standard.set("", forKey: "defridetailSelfTest02Date")
                UserDefaults.standard.set("", forKey: "defridetailSelfTest00Type")
                UserDefaults.standard.set("", forKey: "defridetailSelfTest01Type")
                UserDefaults.standard.set("", forKey: "defridetailSelfTest02Type")
                UserDefaults.standard.set("No", forKey: "Moving")
                UserDefaults.standard.set("No", forKey: "MovingLoadingDone")
                UserDefaults.standard.set("YES", forKey: "TESTME")
                
                let fileManager = FileManager.default
                let filenameLatLon = getDocumentsDiretory().appendingPathComponent("SelfTest.json")
                do {
                    try fileManager.removeItem(at: filenameLatLon)
                } catch {
                    return
                }
            }){
                
                Image(systemName: "arrow.left")
                    .font(.title)
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(Color.black)
                    .background(Color.white)
                    .cornerRadius(50)
                    .opacity(showButtons ? 0 : 1)
            }
            Text("AED")
                .fontWeight(.bold)
                .font(.title2)
                .foregroundColor(Color.black)
                .padding(10)
                .background(Capsule(style: .circular).fill(Color.white).opacity(0.9))
                .frame(width: 170, height: 30)
                .padding(.trailing, -40)
                .opacity(showButtons ? 0 : 1)
            
            HStack(){
                ZStack(alignment: .topTrailing) {
                    
                    Group {
                        Button(action:
                                { self.showButtons.toggle() }) {
                            NavigationLink(destination: MessagesMainMenuNK()) {
                                VStack(){
                                    Image(systemName: "envelope.open")
                                        .foregroundColor(Color.colorCardiOrange)
                                        .rotationEffect(Angle.degrees(showButtons ? 0 : -90))
                                    Text("Messages")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                    
                                }.padding(showButtons ? 30.0 : 0)
                            }
                        }
                                .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                                .offset(x: -30, y: showButtons ? 100 : 0) // No
                                .opacity(showButtons ? 1 : 0)
                        Button(action:
                                { self.showButtons.toggle()}) {
                            NavigationLink(destination: AED_GeoLocation()) {
                                VStack(){
                                    Image(systemName: "mappin.and.ellipse")
                                        .foregroundColor(Color.colorCardiOrange)
                                        .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
                                    Text("Geo")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                    Text("location")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                    
                                }.padding(showButtons ? 22.0 : 0)
                            }.simultaneousGesture(TapGesture().onEnded{
                                getGeoLocationdata()
                            })
                        }
                                .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                                .offset(x: showButtons ? -210 : 0, y: showButtons ? 110 : 0)
                                .opacity(showButtons ? 1 : 0)
                        
                        Button(action:
                                { self.showButtons.toggle() }) {
                            NavigationLink(destination: AED_Hardware()) {
                                VStack(){
                                    Image(systemName: "server.rack")
                                        .foregroundColor(Color.colorCardiOrange)
                                        .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
                                    Text("Hardware")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                }.padding(showButtons ? 30.0 : 0)
                            }.simultaneousGesture(TapGesture().onEnded{
                                gethardwaredata()
                            })
                        }
                                .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                                .offset(x: showButtons ? -130 : 0, y: 10)
                                .opacity(showButtons ? 1 : 0)
                        
                        Button(action:
                                { self.showButtons.toggle() }) {
                            
                            NavigationLink(destination: SelfTestMainMenuNK()) {
                                VStack(){
                                    Image(systemName: "calendar.badge.clock")
                                        .foregroundColor(Color.colorCardiOrange)
                                        .rotationEffect(Angle.degrees(showButtons ? 0 : 90))
                                    Text("Self test")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(Color.colorCardiOrange)
                                }.padding(showButtons ? 28.0 : 0)
                            }.simultaneousGesture(TapGesture().onEnded{
                            })
                        }
                                .background(Circle().fill(Color.white).shadow(color: .colorCardiOrange, radius: 8, x: 4, y: 4))
                                .offset(x: showButtons ? -90 : 0, y: 200)
                                .opacity(showButtons ? 1 : 0)
                        Button(action: { self.showButtons.toggle() }) {
                            Image(systemName: "plus.circle")
                                .font(.title)
                                .foregroundColor(Color.black)
                                .padding(showButtons ? 15.0 : 15.0)
                                .rotationEffect(Angle.degrees(showButtons ? 45 : 0))
                        }
                        .background(Circle().fill(Color.white))
                        .offset(x: showButtons ? -50 : 0, y: showButtons ? 15 : 0)
                    }
                    .accentColor(.white)
                    .animation(.default)
                }
            }
        }
        .padding(.top, 40.0)
        .padding(.bottom, 30)
    }
}

struct geoAddressData: View {
    
    @AppStorage("geoAddressStreet") var geoAddressStreet: String?
    @AppStorage("geoAddressNumber") var geoAddressNumber: String?
    @AppStorage("geoAddressFloor") var geoAddressFloor: String?
    @AppStorage("geoAddressPostal") var geoAddressPostal: String?
    @AppStorage("geoAddressCity") var geoAddressCity: String?
    @AppStorage("geoAddressCountry") var geoAddressCountry: String?
    @AppStorage("geoAddressComment") var geoAddressComment: String?
    @State private var presentingSheet = false
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Address") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Street:")
                            HStack(){
                                Image(systemName: "house")
                                SwiftUI.Text(geoAddressStreet ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("House number:")
                        HStack(){
                            Image(systemName: "number.square")
                            SwiftUI.Text(geoAddressNumber ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Floor level:")
                        
                        HStack(){
                            Image(systemName: "arrow.up.square")
                            SwiftUI.Text(geoAddressFloor ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Postal Code:")
                        HStack(){
                            Image(systemName: "00.square")
                            SwiftUI.Text(geoAddressPostal ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("City:")
                        HStack(){
                            Image(systemName: "map")
                            SwiftUI.Text(geoAddressCity ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Country:")
                        HStack(){
                            Image(systemName: "globe")
                            SwiftUI.Text(geoAddressCountry ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Comment:")
                        HStack(){
                            Image(systemName: "text.quote")
                            SwiftUI.Text(geoAddressComment ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
        }.frame(width: 350)
            .groupBoxStyle(TransparentGroupBox())
    }
}

struct geoLatLonsData: View {
    
    @AppStorage("geoLocationLat") var geoLocationLat: String?
    @AppStorage("geoLocationLon") var geoLocationLon: String?
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Geo position") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Latitude:")
                            HStack(){
                                Image(systemName: "point.topleft.down.curvedto.point.bottomright.up")
                                SwiftUI.Text(geoLocationLat ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Longitude:")
                        HStack(){
                            Image(systemName: "point.fill.topleft.down.curvedto.point.fill.bottomright.up")
                            SwiftUI.Text(geoLocationLon ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 350)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct geoFencesData: View {
    
    @AppStorage("geoFenceType") var geoFenceType: String?
    @AppStorage("geoFenceRadius") var geoFenceRadius: String?
    @AppStorage("distanceType") var distanceType: String?
    @AppStorage("distance") var distance: String?
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Geo fence") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            let defaults = UserDefaults.standard
                            let myBackend = defaults.string(forKey: "Backend")
                            if myBackend == "NEW" {
                                SwiftUI.Text("Type:")
                                HStack(){
                                    Image(systemName: "dot.squareshape.split.2x2")
                                    if geoFenceType == "0" || geoFenceType == "N/A" {
                                        SwiftUI.Text("None")
                                    } else {
                                        
                                        SwiftUI.Text("Circle")
                                    }
                                }
                            } else{
                                
                                SwiftUI.Text("Type:")
                                HStack(){
                                    Image(systemName: "dot.squareshape.split.2x2")
                                    SwiftUI.Text(geoFenceType ?? "N/A")
                                }
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        
                        let defaults = UserDefaults.standard
                        let myBackend = defaults.string(forKey: "Backend")
                        if myBackend == "NEW" {
                            if distance == "null" || geoFenceType == "N/A" {
                                SwiftUI.Text("Radius: N/A")
                            } else {
                                if distanceType == "0" {
                                    SwiftUI.Text("Radius: ")
                                    HStack(){
                                        Image(systemName: "checkmark.icloud")
                                        SwiftUI.Text(distance ?? "N/A") +  SwiftUI.Text(" Meter")
                                    }
                                } else {
                                    SwiftUI.Text("Radius: ")
                                    HStack(){
                                        Image(systemName: "checkmark.icloud")
                                        SwiftUI.Text(distance ?? "N/A") +  SwiftUI.Text(" Kilometer")
                                    }
                                }
                            }
                        } else {
                            SwiftUI.Text("Radius: ")
                            HStack(){
                                Image(systemName: "checkmark.icloud")
                                SwiftUI.Text(geoFenceRadius ?? "N/A")
                            }
                        }
                        
                        Divider().opacity(0)
                    }
                    
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 350)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct hardwareBaseData: View {
    
    @AppStorage("harwareModel") var harwareModel: String?
    @AppStorage("harwareLanguage") var languageSettings: String?
    @AppStorage("hardwareBatchID") var hardwareBatchID: String?
    @AppStorage("hardwareProddate") var hardwareProddate: String?
    @AppStorage("hardwareActicatonDate") var hardwareActicatonDate: String?
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Base Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            SwiftUI.Text("Model:")
                            HStack(){
                                Image(systemName: "greetingcard")
                                SwiftUI.Text(harwareModel ?? "N/A")
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Language:")
                        HStack(){
                            Image(systemName: "books.vertical")
                            SwiftUI.Text(languageSettings ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Batch ID:")
                        HStack(){
                            Image(systemName: "cube.transparent")
                            SwiftUI.Text(hardwareBatchID ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Production Date:")
                        HStack(){
                            Image(systemName: "calendar")
                            if hardwareProddate == "" || hardwareProddate == "null" || hardwareProddate == nil || hardwareProddate == ".." {
                                SwiftUI.Text("N/A")
                            } else {
                                SwiftUI.Text(hardwareProddate ?? "N/A")
                            }
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Activation Date:")
                        HStack(){
                            Image(systemName: "calendar.badge.clock")
                            SwiftUI.Text(hardwareActicatonDate ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
        }.frame(width: 350)
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct hardwarePCBData: View {
    
    @AppStorage("serialPCB") var serialPCB: String?
    @AppStorage("batchPCB") var batchPCB: String?
    @AppStorage("manufacturerPCB") var manufacturerPCB: String?
    @AppStorage("hardwarePCB") var hardwarePCB: String?
    @AppStorage("firmwarePCB") var firmwarePCB: String?
    @AppStorage("productionDatePCB") var productionDatePCB: String?
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("PCB Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            SwiftUI.Text("Serial Number:")
                            HStack(){
                                Image(systemName: "greetingcard")
                                SwiftUI.Text(serialPCB ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Batch ID:")
                        HStack(){
                            Image(systemName: "cube.transparent")
                            SwiftUI.Text(batchPCB ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Production Date:")
                        HStack(){
                            Image(systemName: "calendar")
                            SwiftUI.Text(productionDatePCB ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Manufacturer:")
                        HStack(){
                            Image(systemName: "gearshape.2")//.foregroundColor(.colorCardiGray)
                            SwiftUI.Text(manufacturerPCB ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Hardware version:")
                        HStack(){
                            Image(systemName: "server.rack")
                            SwiftUI.Text(hardwarePCB ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Firmware version:")
                        HStack(){
                            Image(systemName: "wrench.and.screwdriver")
                            SwiftUI.Text(firmwarePCB ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
        }.frame(width: 350)
            .groupBoxStyle(TransparentGroupBox())
    }
}

struct hardwareElectrodesData: View {
    
    @AppStorage("modelElectrodes") var modelElectrodes: String?
    @AppStorage("batchElectrodes") var batchElectrodes: String?
    @AppStorage("experationDateElectrodes") var experationDateElectrodes: String?
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        GroupBox() {
            DisclosureGroup("Electrodes Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Model:")
                            HStack(){
                                Image(systemName: "greetingcard")
                                SwiftUI.Text(modelElectrodes ?? "N/A")
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Batch ID:")
                        HStack(){
                            Image(systemName: "cube.transparent")
                            SwiftUI.Text(batchElectrodes ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Expiration Date:")
                        HStack(){
                            Image(systemName: "calendar")
                            SwiftUI.Text(experationDateElectrodes ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 350)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct hardwareBatteryData: View {
    
    @AppStorage("modelBattery") var modelBattery: String?
    @AppStorage("batchBattery") var batchBattery: String?
    @AppStorage("activationsDateBattery") var activationsDateBattery: String?
    
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Battery Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            
                            Divider().opacity(0)
                            SwiftUI.Text("Model:")
                            HStack(){
                                Image(systemName: "greetingcard")
                                SwiftUI.Text(modelBattery ?? "N/A")
                            }
                            Divider().opacity(0)
                        }
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Batch ID:")
                        HStack(){
                            Image(systemName: "cube.transparent")
                            SwiftUI.Text(batchBattery ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Activation Date:")
                        
                        HStack(){
                            Image(systemName: "calendar")
                            SwiftUI.Text(activationsDateBattery ?? "N/A")
                        }
                        Divider().opacity(0)
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 350)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct hardwareBatteryDataNK: View {
    
    @AppStorage("modelBattery") var modelBattery: String?
    @AppStorage("serialNumberBattery") var serialNumberBattery: String?
    @AppStorage("lotNumber") var lotNumber: String?
    @AppStorage("activationsDateBattery") var activationsDateBattery: String?
    @AppStorage("batteryLevel") var batteryLevel: String?
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        
        GroupBox() {
            DisclosureGroup("Battery Information") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            SwiftUI.Text("Model:")
                            HStack(){
                                Image(systemName: "greetingcard")
                                SwiftUI.Text(modelBattery ?? "N/A")
                            }
                            Divider().opacity(0)
                        }
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Serial Number:")
                        HStack(){
                            Image(systemName: "cube.transparent")
                            SwiftUI.Text(serialNumberBattery ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("LOT ")
                        HStack(){
                            Image(systemName: "number.square")
                            SwiftUI.Text(lotNumber ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    
                    VStack(alignment: .leading){
                        SwiftUI.Text("Expiration Date:")
                        HStack(){
                            Image(systemName: "calendar")
                            SwiftUI.Text(activationsDateBattery ?? "N/A")
                            
                        }
                        Divider().opacity(0)
                    }
                    VStack(alignment: .leading){
                        SwiftUI.Text("Battery Percentage:")
                        HStack(){
                            Image(systemName: "minus.plus.batteryblock")
                            SwiftUI.Text(batteryLevel ?? "N/A")
                            SwiftUI.Text("%")
                            
                        }
                        Divider().opacity(0)
                        
                    }
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 350)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct hardwareBLE: View {
    
    @AppStorage("addressBLE") var addressBLE: String?
    @State private var presentingSheet = false
    @ObservedObject var model = Model()
    
    var body: some View {
        GroupBox() {
            DisclosureGroup("Bluetooth") {
                VStack {
                    Group {
                        VStack(alignment: .leading){
                            Divider().opacity(0)
                            SwiftUI.Text("MAC Address:")
                            HStack(){
                                Image(systemName: "waveform")
                                SwiftUI.Text(addressBLE ?? "N/A")
                                
                            }
                            Divider().opacity(0)
                        }
                    }
                    
                }.frame(width: 320)
            }.accentColor(Color.colorCardiOrange)
                .font(.headline)
            
        }.frame(width: 350)
        
            .groupBoxStyle(TransparentGroupBox())
    }
    
}

struct BottomMenuPortal: View {
    
    @State var selection: Int? = nil
    @EnvironmentObject var base:BaseDataFetch
    @EnvironmentObject var def:DefriDataFetch
    @EnvironmentObject var navigationManager: NavigationManager
    let defaults = UserDefaults.standard
    var body: some View {
        
        ZStack(){
            
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color.white)
                .padding(.vertical, 10.0)
                .shadow(radius: 5, y: 5)
                .frame(width: widthInner, height: 60.0)
            
            VStack(){
                HStack(spacing: 0){
                    
                    Button(action: {
                        navigationManager.navigateTo(.login)
                        clearAllFile()
                        defaults.set("NO", forKey: "callServiceTickets")
                        defaults.set("", forKey: "Backend")
                        defaults.set("", forKey: "BackendAdd")
                        defaults.set("Nop", forKey: "ShowForgotPassword")
                        defaults.set("", forKey: "searchText")
                        defaults.set("0", forKey: "GreenCount")
                        defaults.set("0", forKey: "YellowOverdue")
                        defaults.set("0", forKey: "YellowCount")
                        defaults.set("0", forKey: "RedCount")
                        defaults.set("0", forKey: "RedTimeout")
                        defaults.set("0", forKey: "BlueCount")
                        defaults.set("0", forKey: "YellowCountOverdue")
                        defaults.set("0", forKey: "CommunicatorCount")
                        defaults.set("0", forKey: "green")
                        defaults.set("0", forKey: "yellow")
                        defaults.set("0", forKey: "red")
                        defaults.set("0", forKey: "gray")
                        defaults.set("0", forKey: "blue")
                        defaults.set("0", forKey: "withGps")
                        defaults.set("NO", forKey: "WaitForItOverview")
                        defaults.set("NO", forKey: "WaitForIt")
                        defaults.set("false", forKey: "ADExcisting")
                        defaults.set("No", forKey: "NONIOT")
                    }) {
                        HStack {
                            Image(systemName: "escape")
                                .font(.title2)
                            Text("Logout")
                                .font(.system(size: 18))
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                        }
                        .foregroundColor(Color.colorCardiRed)
                    }
                }
            }
        } .offset(x: 0, y: 0)
    }
}
