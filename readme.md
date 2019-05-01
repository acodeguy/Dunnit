# Dunnit!
## Yeah, another iOS to-do list app.

I created this as a learning exercise whilst getting to grips with Test-Driven Development (TDD) with Swift in XCode. I wanted to create a simple app from the outside in, starting with feature tests then creating unit tests as and when required.

## Features

Current features:

- Add to-do items
- Delete to-do items
- Toggle items completion status

Features to come:

- Reminder alerts
- Persisting of data (saving to a local/remote database)

Enhancements to come:

- UI will scale to work on all devices (currently only works on iPhone 8 Plus)

## Minimum Viable Product (MVP)
For the MVP of this app, it will have the following features:

- Add to-do items
- Delete to-do items
- Toggle items completion status

### 27/4/19 MVP Reached!
![mvp screenshot](readme-images/20190427-mvp-1.png)
![mvp screenshot](readme-images/20190427-mvp-2.png)

At this point, all items are kept in memory and not persisted. This is coming in a later version of this app.

## Approach

I've used TDD to write the code. I've used to MVC design pattern with an idea to possibly move this over to MVVM once i get my head around it.

## Issues Faced

- Testing for the UITableCell's accessory (checkmark) has proven impossible upto this point 

## Getting Started with this Code

1. Clone this repo: ```git clone https://github.com/acodeguy/Dunnit.git```
2. Open it in Xcode
3. Run the tests: ```Cmd+U```
4. Run the project in the simulator: ```Cmd+R```

## Tests
This project has both UI and unit tests, found in the usual test folders. I've written this using TDD to drive development of only the absolutely essential code to make it work.

### Installation/Dependencies

At the moment, this project has no third-party depdencies. This may change if I decide to really pimp it out with some Cocoapods for networking, storage, etc.

## License

Use it, abuse it. But please don't sell it.
