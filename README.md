# RecipeLite

RecipeLite is a simple application that allows user to browse list of recipes and details fetched from Contentful API

## Installation:
- Checkout the repository and run using XCode. 
- No need to run `pod install` as all pods are pushed to remote as per Cocoapods guidelines

## Usage & Features:
- This application has 2 screens: List Screen and Details Screen
- List screen displays a list of recipes with title and picture of the recipe
- Tapping on any recipe takes user to Details Screen where user can view the details related to the recipe

## Architecture Used:
- MVVM + Coordinator
(Coordinator handles the navigation logic)

## Other Features:
- Independent modules enabling Dependency Injection and easy to Unit Test
- Programmatically designed UI Interface
- Unit Test for API logic and View Models

## Requirements:
- iOS 13.1
- XCode 11.1
- Swift 5

## Dependency
### CocoaPods
- 'Contentful' - To fetch data from Contentful Content Delivery Network
- 'SDWebImage' - Asynchronous image downloader with cache support as a UIImageView category. 
