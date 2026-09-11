# CS 442 - Week 1 Lab: Enhance the Counter App

## Student Information

Name: Muhammad Ilyas  
Roll Number: 04072313012

## About This Lab

In this lab, I modified the default Flutter Counter App. I added a reset button, a reset counter, a personalised threshold message, and changed the theme according to my personal parameter.

## Personal Parameters

Last 3 digits of roll number: 012

Threshold calculation:

0 + 1 + 2 + 5 = 8

myThreshold = 8

My first name is Muhammad, which starts with M. Since there is no suitable standard Flutter `Colors.` value starting with M, I used the first letter of my last name, Ilyas.

mySeedColor = Colors.indigo

## Changes Made

- Added a Reset button with the refresh icon.
- The Reset button changes the counter back to 0.
- Added a message that appears when the counter is greater than 8.
- Added a reset tracker showing how many times Reset was pressed.
- Used `Colors.indigo` for the app theme.
- Added my name and roll number to the app.

## Screenshot

![Running App](Screenshot%20%2853%29.png)

The screenshot shows the counter above my threshold and the "You're on a roll!" message. It also shows that the Reset button has been used.

## Reflection on setState()

I understood `setState()` as a way of telling Flutter that something in the app has changed and the screen needs to show the new value. In my app, I use it when the counter changes and when the reset button is pressed. Without `setState()`, the value may change in the code, but the updated value would not be displayed on the screen.

## Testing

I tested the `+` button, Reset button, threshold message, and reset counter. I also checked that the threshold message disappears after resetting the counter and appears again when the counter goes above 8.
