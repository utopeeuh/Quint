# MonthYearPicker

[![Version](https://img.shields.io/cocoapods/v/MonthYearPicker.svg?style=flat)](https://cocoapods.org/pods/MonthYearPicker)
[![License](https://img.shields.io/cocoapods/l/MonthYearPicker.svg?style=flat)](https://cocoapods.org/pods/MonthYearPicker)
[![Platform](https://img.shields.io/cocoapods/p/MonthYearPicker.svg?style=flat)](https://cocoapods.org/pods/MonthYearPicker)

This is a `UIControl` subclass that allows date selection using month and year, unlike `UIDatePicker` which displays year, month, and day. This makes `MonthYearPicker` useful for credit card expiry dates, for example. It is locale-aware and shows localised values. It also supports Dynamic Type and dark mode where available.

![Screenshot](https://raw.githubusercontent.com/alexanderedge/MonthYearPicker/master/screenshot.png)

## Usage

Initialise `MonthYearPicker` in the same way you would a `UIPickerView` instance.

```swift
let picker = MonthYearPickerView(frame: CGRect(origin: CGPoint(x: 0, y: (view.bounds.height - 216) / 2), size: CGSize(width: view.bounds.width, height: 216)))
picker.minimumDate = Date()
picker.maximumDate = Calendar.current.date(byAdding: .year, value: 10, to: Date())
picker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
view.addSubview(picker)
```

## Requirements

iOS 9.0 or later

## Installation

MonthYearPicker is available through [CocoaPods](http://cocoapods.org) or Swift Package Manager. 

### CocoaPods

Add the following line to your Podfile:

```ruby
pod "MonthYearPicker", '~> 4.0.2'
```

### Swift Package Manager

From within Xcode, select _File_ → _Swift Packages_ → _Add Package Dependency..._ and enter `https://github.com/alexanderedge/MonthYearPicker.git`.

## Author

Alexander Edge, alex@alexedge.co.uk

## License

MonthYearPicker is available under the MIT license. See the LICENSE file for more info.
