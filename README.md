# Decade Of Movies
A decade of Movies

## How to run the project
Download, and run `$ ./setup.sh`
it will download necessary dependancies if not installed on your machine 

### Other scripts
Use Make file to have scripts shortcut for easy use
run `configuration.rb` or `make config` to reconfiger the project with keys in the xcconfig

## Project Overview

* Fetch Movies list from .json file and display them in Master-Detail flow.
* Search for movies by its title.
* Search data is categorized by year and it shows only top 5 movies in that category.
* Show every movie details in separate screen 


## Project Architecture 
The project is following clean architucte and using MVVM-C with a group of practices and decisions that makes the code testable with independable components. 


Resources:
* [Clean architucte](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
* [The Coordinator](https://khanlou.com/2015/01/the-coordinator/)
* [Advanced iOS App Architecture](https://store.raywenderlich.com/products/advanced-ios-app-architecture)
* [Advanced coordinators in iOS](https://www.hackingwithswift.com/articles/175/advanced-coordinator-pattern-tutorial-ios)