# FindIt

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
The application allows users to quickly find various places near their current location based on either previously selected preferences, a certain category, name, or distance and display a detailed page with information on user-selected locations.

### App Evaluation
- **Category:** Lifestyle / Travel
- **Mobile:** This application will be primarily developed for mobile devices but can also be viable on computers, such as Yelp or other similar applications. The application intends to make use of the maps and location features of a mobile device.
- **Story:** Analyzes the user's location and connects the user to nearby locations that might peak their interest/current needs.
- **Market:** Any individual can choose to use this application.
- **Habit:** This application can be used as often as a users wants to depending on their need/desire to search for nearby locations.
- **Scope:** First we would ensure that a user can find locations of restaurants, entertainment, etc. that appear in a list (with a genre and address) based on their current location. Secondly, we would try to expand on the locatins find by providing more in-depth features that would allow users to inderatc with the locations found (i.e. directions, websites, contact information, etc.).

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User logs in to access previous searches and recommendations based on existing profile.
* User can search for a location based on genre, name, search radius.
* User can click on the desired location for the address and a desription.
* User settings page is accessible and can be altered.
* User can see found locations on map interface in comparison to user's current location.

**Optional Nice-to-have Stories**

* User can click on the desired location for detailed desrciption/more information.
* User can "favorite" specific locations to be saved and referenced later on another tab.
* User can change current location to reflect another desired zip code or city.

### 2. Screen Archetypes

* Login
  * Signs up or logs into account.
* Profile Screen
  * Allows user to confirm location and enter preferences.
* Search Screen
  * Upon searching for location category, name, etc., map screen opens
* Map Screen
   * Displays user's search results on map and contains descriptive infromation below in a swipable list.
* Settings Screen
  * Lets people change language and other preferences.

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Search
* Profile
* Settings

**Flow Navigation** (Screen to Screen)

* Forced Log-in -> Account creation if no log in is available.
* Search Screen allows for user input -> Jumps to Map Screen showing search results.
* Profile -> Text fields to be modified. 
* Settings -> Toggle settings.

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]

### Models
[Add table of models]

### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
