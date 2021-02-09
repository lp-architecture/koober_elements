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

import Foundation

public struct PickMeUpGetters {

  // MARK: - Properties
  public let getPickMeUpState: (AppState) -> ScopedState<PickMeUpViewControllerState>

  // MARK: - Methods
  public init(getPickMeUpState: @escaping (AppState) -> ScopedState<PickMeUpViewControllerState>) {
    self.getPickMeUpState = getPickMeUpState
  }

  public func getDropoffLocationPickerViewControllerState(appState: AppState) -> ScopedState<DropoffLocationPickerViewControllerState> {
    let pickMeUpScopedState = getPickMeUpState(appState)
    guard case .inScope(let pickMeUpViewControllerState) = pickMeUpScopedState else {
      return .outOfScope
    }
    guard case .selectDropoffLocation(let dropoffLocationPickerViewControllerState) = pickMeUpViewControllerState.state else {
      return .outOfScope
    }
    return .inScope(dropoffLocationPickerViewControllerState)
  }

  public func getMapViewControllerState(appState: AppState) -> ScopedState<MapViewControllerState> {
    let pickMeUpScopedState = getPickMeUpState(appState)
    guard case .inScope(let pickMeUpViewControllerState) = pickMeUpScopedState else {
      return .outOfScope
    }
    return .inScope(pickMeUpViewControllerState.mapViewControllerState)
  }

  public func getRideOptionPickerViewControllerState(appState: AppState) -> ScopedState<RideOptionPickerViewControllerState> {
    let pickMeUpScopedState = getPickMeUpState(appState)
    guard case .inScope(let pickMeUpViewControllerState) = pickMeUpScopedState else {
      return .outOfScope
    }
    guard case .selectRideOption(let rideOptionPickerViewControllerState, _) = pickMeUpViewControllerState.state else {
      return .outOfScope
    }
    return .inScope(rideOptionPickerViewControllerState)
  }
}
