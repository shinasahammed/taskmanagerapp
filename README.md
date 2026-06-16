# Task Manager Flutter App

## Overview

A Flutter Todo Management application built using StatefulWidget and setState.

The app fetches tasks from JSONPlaceholder API and supports:

* View all tasks
* Search tasks by title
* Filter tasks (All / Completed / Pending)
* View task details
* Add new tasks locally
* Persist locally added tasks using SharedPreferences
* Pull-to-refresh
* Loading and error states
* Unit tests for API service

## API

https://jsonplaceholder.typicode.com/todos

## Flutter Version

Flutter 3.44.2

## Packages Used

* http
* shared_preferences


## Project Structure

lib/
├── models/
├── services/
├── screens/
├── widgets/
├── helpers/
└── main.dart

test/
└── todo_api_service_test.dart

## Run Instructions

1. Clone repository

git clone <repository-url>

2. Navigate to project

cd taskmanager

3. Install dependencies

flutter pub get

4. Run application

flutter run

## Run Tests

flutter test

## Features Implemented

* API Integration
* Search Functionality
* Task Filters
* Task Details Screen
* Add New Task
* SharedPreferences Persistence
* Empty State UI
* Pull-to-Refresh
* Error Handling
* Unit Testing
