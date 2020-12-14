# FindIt

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)
5. [Development Progress](#Progress)

## Overview

### Description

The application allows users to keep location-based memory blogs about their trips to various locations across the globe.

### App Evaluation

- **Category:** Lifestyle / Travel
- **Mobile:** This application will be primarily developed for mobile devices but can also be viable on computers, such as Yelp or other similar applications. The application intends to make use of the maps and location features of a mobile device.
- **Story:** Analyzes the user's selected location and connect the user to a new or previously created blog for that location.
- **Market:** Any individual can choose to use this application.
- **Habit:** This application can be used as often as a users wants to depending on their need/desire to digitize written memories of their experiences.
- **Scope:** First we would ensure that a user can find the locations they indicate. Secondly, we would try to expand on the blog posts by location by allowing the to also view all blogs on one screen and search by location or date.).

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] User can log in and sign up for an account.
- [X] User can search for a location based on city name or address.
- [X] User can click on the map annotation to view or add the blog.
- [X] User settings can be viewed.
- [X] User can navigate between tabs.
- [X] User can see found location on map interface in comparison to user's current location.
- [X] User login stays across restart.
- [X] User can click on the desired location for detailed desrciption/more information.
- [X] User can change current location to reflect another desired zip code or city.
- [X] User can zoom and see all blog posts created across the map.

**Optional Nice-to-have Stories**

- [ ] User can "favorite" specific locations to be saved and referenced later on another tab.
- [ ] User settings can be changed.

### 2. Screen Archetypes

* Login
  * Signs up or logs into account.
* Map Screen
   * Displays user's search results on map and contains the annotation of search on map.
* Blog Screen
   * Lets people see the blog post for the location they have specified.
* Profile Screen
  * Lets people confirm location, change language, or change password.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Search
* Profile

**Flow Navigation** (Screen to Screen)

* Forced Log-in -> Account creation if no log in is available.
* Map -> allows for user input -> Jumps to Map Screen showing search results.
* Blog -> Text fields to be modified and viewed
* Profile -> Text fields to be modified. 

## Digital Wireframes
<img src="./login_screens.png" width=600>
<img src="./search_screens.png" width=600>

## Schema

### Models

#### Locations

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | location      | String   | name of location |
   | hasDetails    | Boolean  | Whether or not the blog has been filled |
   | weather       | String   | description to specify category of location |
   | food          | String   | food eaten at location |
   | drink         | String   | drink tasted at location |
   | stayed        | String   | places stayed at location |
   | memory        | String   | favorite memories at location |
   
### Networking

#### List of network requests by screen
* Saved Screen
   - Map Screen
      - (Read/GET) Query all saved locations on map
         ```swift
         let currLocation = PFObject(className: "Locations")
            currLocation["Location"] = city
            currLocation["hasDetails"] = false
            currLocation.saveInBackground() { (success, error) in
                       if success {
                           print("saved!")
                       } else {
                           print("error!")
                       }
            }
         ```
      - (Delete) Delete existing saved location
   - Blog Screen
      - (Create/POST) Create a new "Locations" object
      - (Read/GET) Query "Locations" object if already created + filled
   - Profile Screen
      - (Read/GET) Query logged in user object
      - (Update/PUT) Update user profile image

## Progress

### Week 7 Progress
<img src='http://g.recordit.co/H2Yquo3FfI.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### Week 8 Progress
<img src='http://g.recordit.co/mkIALhWRB1.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### Week 9 - 10 Progress

