# JKMonitor

[![CI Status](https://img.shields.io/travis/wangzhiheng/JKMonitor.svg?style=flat)](https://travis-ci.org/wangzhiheng/JKMonitor)
[![Version](https://img.shields.io/cocoapods/v/JKMonitor.svg?style=flat)](https://cocoapods.org/pods/JKMonitor)
[![License](https://img.shields.io/cocoapods/l/JKMonitor.svg?style=flat)](https://cocoapods.org/pods/JKMonitor)
[![Platform](https://img.shields.io/cocoapods/p/JKMonitor.svg?style=flat)](https://cocoapods.org/pods/JKMonitor)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

JKMonitor is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'JKMonitor', :git => 'https://github.com/jack6231/JKMonitor.git'
```
## Swift Project 
add header to ***-Bridging-Header.h
```
#import "JKMonitor.h"
```
use (AppDelegate)
```
JKMonitor.sharedInstance().enable()
```
## Objective-C Project
use (AppDelegate)
```
[[JKMonitor sharedInstance] enable];
```


## Author

wangzhiheng, wangzhiheng6231@163.com

## License

JKMonitor is available under the MIT license. See the LICENSE file for more info.
