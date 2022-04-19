/// Copyright (c) 2022 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

// 1. ViewModel에서는 UIKit 전체를 가져오지 않는다. (필요한 것만)
import UIKit.UIImage

// 2. 테스트를 위해 WeatherViewModel을 public으로 선언
public class WeatherViewModel {
  // 여기에서 컨트롤러 내부의 뷰모델을 초기화한다
  // 다음으로는 LocationGeocoder 로직으로 이동하자
  // 1. 먼저 VC에서 defaultAddress를 복붙
  private static let defaultAddress = "McGaheysville, VA"
  // 그 다음 VC에서 Geocoder 복붙
  private let geocoder = LocationGeocoder()
  private let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d"
    return dateFormatter
  }()
  private let tempFormatter: NumberFormatter = {
    let tempFormatter = NumberFormatter()
    tempFormatter.numberStyle = .none
    return tempFormatter
  }()
  let locationName = Box("Loading...")
  // 위치를 가져올 때까지 Loading... 표시하도록
  let date = Box(" ")
  let icon: Box<UIImage?> = Box(nil) // no image initially
  let summary = Box(" ")
  let forecastSummary = Box(" ")
  
  func changeLocation(to newLocation: String) {
    locationName.value = "Loading..."
    geocoder.geocode(addressString: newLocation) { [weak self] locations in
      guard let self = self else { return }
      if let location = locations.first {
        self.locationName.value = location.name
        self.fetchWeatherForLocation(location)
        return
      }
      self.locationName.value = "Not found"
      self.date.value = ""
      self.icon.value = nil
      self.summary.value = ""
      self.forecastSummary.value = ""
    }
  }
  // 이 코드는 Geocoder를 통해 가져오기 전에 locationName.value를 Loading...으로 변경한다.
  // Geocoder가 조회를 완료하면 위치 이름을 업데이트하고 해당 위치의 날씨 정보를 가져온다.
  
  private func fetchWeatherForLocation(_ location: Location) {
    WeatherbitService.weatherDataForLocation(
      latitude: location.latitude,
      longitude: location.longitude) { [weak self] (weatherData, error) in
        guard
          let self = self,
          let weatherData = weatherData
        else {
          return
        }
        self.date.value = self.dateFormatter.string(from: weatherData.date)
        self.icon.value = UIImage(named: weatherData.iconName)
        let temp = self.tempFormatter
          .string(from: weatherData.currentTemp as NSNumber) ?? ""
        self.summary.value = "\(weatherData.description) - \(temp)℉"
        self.forecastSummary.value = "\nSummary: \(weatherData.description)"
      }
  }
  
  init() {
    changeLocation(to: Self.defaultAddress)
  }
}
