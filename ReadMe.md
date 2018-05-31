
# Objective
Implement Achievements list screen using the VIPER architecture.
More at: https://www.dropbox.com/s/u1xm4x5geyr64nh/stash-ios-challenge.zip?dl=0

# High Level Design and Implementation
For implementation, using VIPER architecture, I tried to use simple structuring and clear code principles as much as possible. Please see attached image to see the high-level relationships and communications for Achievements List module.

The implementation of the project consisted of
1) Learning about VIPER architecture
2) Determining use case boundaries
3) Determining relationships and communications within the module
4) Creating the UI
5) Creating the boilerplate code
6) Implementing the feature
7) Review / repeat 1 - 6
8) Writing unit tests

For image download, I used a lightweight image downloader tool called SDWebImage which helps with image caching too.

# Known Issues
Testing is missing some of the UI tests, Wireframe, DataManager, Model tests.

Some error conditions are not handled(e.g.JSON serialization catch block) and some screens (e.g. ShowNoContentScreen()) not yet implemented.

# Extensibility
Along with the current code, one can add a support for detail view in the same project to see the progress details of the particular level.

# Other notes
To save time, I would have used a template generator for the boilerplate code. That took more time than I anticipated. For this project, I spent more than 5 hours :)

