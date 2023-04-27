<h1 align="center">Pomodoro</h1> 

## Contents

1. [Description](#description)
2. [Installation](#installation)
3. [App](#app)
4. [Features](#features)

## Description

This is a group project of 3 people in which I am a member. we decided to make a clone of the <a href="https://apps.apple.com/kz/app/pomodoro-focus-timer/id1504867122">Pomodoro</a> application already existing in the App Store. The idea of the application is based on the Pomodoro Technique by which people can perform a To-Do list on a timer

We divided the tasks into 3 parts and my task was to make the Tasks screen.

## Installation

`pod install` and run `Pomodoro.xcworkspace`

## Technologies

* iOS 15+
* UIKit
* MVVM
* AutoLayout - Storyboard
* Realm
* Data Driven UI
* Error Handling

## App

<table>
    <thead>
        <tr>
            <th>My Tasks screen</th>
            <th>Real App's Tasks screen</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>
                <video width="250" src="Video/myApp.mp4">
            </td>
            <td>
                <video width="250" src="Video/originalApp.MP4">
            </td>
        </tr>
    </tbody>
</table>


## Features

1. Adding a new task to the section to perform.
2. Transfer the task to the completed section and return it by swipe to the right.
3. Delete the swipe task to the left.
4. All task states are saved automatically in the Realm database.
5. Selecting a task to work on and transferring it to the main screen after exiting the screen.
