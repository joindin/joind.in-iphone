#joind.in iPhone application

iPhone application for Joind.in

Please report any issues at the joind.in JIRA project, in the iPhone App component:

https://joindin.jira.com/browse/JOINDIN/component/10211


### Welcome

Joind.in welcomes all contributors regardless of your ability or experience. We especially welcome
you if you are new to Open Source development and will provide a helping hand. To ensure that
everyone understands what we expect from our community, our projects have a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md) and by participating in the development of joind.in you agree to abide
by its terms.

## Getting started

The project uses CocoaPods for dependency management. The Podfile is located inside the `joindinapp` directory.

1. Clone the repository
2. `cd <project_root>/joindinapp`
3. `pod install`
4. `open joindinapp.xcworkspace`

## Configuration

The default joind.in iOS app OAuth configuration is set up to work with a development version of the API. The app has an extra build step as part of the Archive process, which will allow insertion of different credentials (for example for release builds). To use this:

1. Copy `environment.example.xcconfig` to eg `release.xcconfig`
2. Add a reference to this file to the project (no need to copy it in)
3. Under Project Settings -> Info, set the appropriate configuration file in the Configuration section for your desired build (eg "Release").
4. Create the archive as normal

