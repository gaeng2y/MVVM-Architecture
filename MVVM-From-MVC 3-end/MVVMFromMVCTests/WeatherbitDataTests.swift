/// Copyright (c) 2019 Razeware LLC
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
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import XCTest
@testable import Grados

class WeatherbitDataTests: XCTestCase {
  private static let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "MM-dd-yyyy"
    return formatter
  }()
  
  var exampleJSONData: Data!
  var weather: WeatherbitData!

  override func setUp() {
    let bundle = Bundle(for: type(of: self))
    let url = bundle.url(forResource: "WeatherbitExample", withExtension: "json")!
    exampleJSONData = try! Data(contentsOf: url)
  
    let decoder = JSONDecoder()
    weather = try! decoder.decode(WeatherbitData.self, from: exampleJSONData)
  }
    
  func testDecodeTemp() throws {
    XCTAssertEqual(weather.currentTemp, 24.19)
  }
  
  func testDecodeIcon() throws {
    XCTAssertEqual(weather.iconName, "c03d")
  }
  
  func testDecodeDescription() throws {
    XCTAssertEqual(weather.description, "Broken clouds")
  }
  
  func testDecodeDate() throws {
    XCTAssertEqual(Self.dateFormatter.string(from: weather.date), "08-28-2017")
  }

  func testChangeLocationUpdatesLocationName() {
    // 1. locationName 바인딩은 비동기식이다. expectation을 이용하여 비동기식 이벤트를 기다리자
    let expectation = self.expectation(
      description: "Find location using geocoder")
    // 2. 테스트할 viewModel의 인스턴스 생성
    let viewModel = WeatherViewModel()
    // 3. locationName 바인딩하고 값이 예상 결과와 일치하는 경우에만 expecation.fullfill().
    // Loading... 또는 기본 주소와 같은 위치 이름 값을 무시한다.
    // 예상 결과만 테스트 기대치를 충족해야 한다.
    viewModel.locationName.bind {
      if $0.caseInsensitiveCompare("McGaheysville, VA") == .orderedSame {
        expectation.fulfill()
      }
    }
    // 4. 위치를 변경하여 테스트 시작. 보류 중인 geocoding 활동이 먼저 완료되도록 변경하기 전에 몇초 기다리는 것이 중요. 앱이 시작되면 geocoder를 조회한다.
    // 뷰 모델의 테스트 인스턴스를 생성할 때 geocoder 조회도 실행한다. 몇 초를 기다리면 테스트 조회를 트리거하기 전에 다른 조회가 완료될 수 있다.
    // 요청 비율이 너무 높으면 CLLocation에서 오류 발생할 수 있다.
    DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
      viewModel.changeLocation(to: "Richmond, VA")
    }
    // 5. 기대가 충족될 때까지 최대 8초를 기다린다. 테스트는 예상 결과가 시간 초과 전에 도착한 경우에만 성공
    waitForExpectations(timeout: 8, handler: nil)
  }

}
