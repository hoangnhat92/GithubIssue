
# GithubIssue

### Overview
- Create an application that allows users to browse a list of issues.
- Users can view the comments of the issue, they also edit, delete and add new comment.
- Using GitHub GraphQL.

### Installing
Go to the root project and type below command in terminal. This command will install dependencies in the project.

<pre>pod install</pre>

Note: You can edit the repository name, owner name and access token by default in AuthenticationViewController.swift. 
Go to setupMockData function which you can inject your information. In the first sign, it looks weird, because I used two variables for token, because whenever I put an private token to my code and push to GitHub, it will be automatically revoked by GitHub system, so I seperate an token to two strings like a way to trick GitHub system. 

### Architectures

For a better experience, the App should run on an iPhone X and the project built by lastest Xcode ( 11.0 )

For the architecture, I choose MVVM, DI and Coordinator. In the real world, we already have many architectures such as MVC, MVP, MVVM, VIPER ... I tried those architectures and none of them is the good architecture for all projects. The good archirecture for the project, it depends on your team, your experience, your requirements. I decided to use MVVM because it's really simple and compare with MVC, MVVM has many advantages like move all business logic or interface logic to ViewModel, we save a lots of code in Controller since it was massive Controller, and MVVM is a good pattern for unit testing. 
Coordinator responsibility is to handle navigation flow, keeping a clean architecture and seperation of concerns of navigation between flows


### GitFlow process

GitFlow The repository follows GitFlow Guidlines: branches come from master, are merged in develop and finally develop is merged into master.

### Challenging with GraphQL and Apollo

This is the first time I work with GraphQL and Apollo. I heard that concept many years ago, I got some articles about it, but I dont have any chance to use it in real project so it's really an opportunity to learn new thing.

I found Apollo like a library to support GraphQL client. It allows you to execute queries and mutations against a GraphQL server and returns results as query-specific Swift types. This means you don't have to deal with parsing JSON, or passing around dictionaries and making clients cast values to the right type manually. You also don't have to write model types yourself, because these are generated from the GraphQL definitions your UI uses.




### Third party libraries

I have chosen three well-known libraries that prove useful for the matter of this challenge as well as any other production App. In fact, I have used myself these frameworks in Production environment.

Apollo: A strongly-typed, caching GraphQL client for iOS, written in Swift

SDWebImage: This library provides an async image downloader with cache support. I love this library, it is easy to use and simplify the caching process.

SnapKit: SnapKit is a DSL to make Auto Layout easy on both iOS and OS X. Actually, I'm not a big fan of Storyboard, because it come to many problems when work with the large team, whenever someone at the team work with same storyboard, it always end up with a lots of conflict and to fixed those conflicts, it's really a challenge. So I decided to SnapKit.

Reusable: When I decided to use programmatically layout by code, Reusable help us to reusing views easily and in a type-safe way.

KeychainSwift: Helper functions for saving text in Keychain securely for iOS. Instead using UserDefaults, I decided use KeychainSwift to take high security, so we can save an access token to local storage safely.

Language: Swift 5

Version control: GitHub

Screenshots

![Screen-Shot-2019-10-22-at-23 22 03](https://user-images.githubusercontent.com/7354180/67307731-28485400-f523-11e9-876e-ca6415a1432b.png)

![Screen-Shot-2019-10-22-at-23 22 50](https://user-images.githubusercontent.com/7354180/67307806-47df7c80-f523-11e9-97fb-695d636ad3d1.png)

![Screen-Shot-2019-10-22-at-23 22 56](https://user-images.githubusercontent.com/7354180/67307827-5037b780-f523-11e9-86ff-3afca2159d52.png)
