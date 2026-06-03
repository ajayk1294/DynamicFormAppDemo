//
//  README.md
//  DynamicFormAppDemo
//
//  Created by Ajay on 01/06/26.
//

# DynamicFormAppDemo

## Overview

DynamicFormAppDemo is an iOS application built using Swift, SwiftUI, and MVVM architecture that dynamically renders forms from JSON configuration.

The project focuses on scalable form rendering, reusable UI components, centralized validation handling, and clean architecture principles.

The application supports multiple field types including:

* Text Fields
* Dropdowns
* Multi Select Dropdowns
* Checkboxes
* Toggles

The form is fully data-driven, allowing UI generation dynamically without hardcoded screens.

---

# Architecture & Approach

The project follows the MVVM (Model-View-ViewModel) architecture pattern with modular reusable renderer components.

## Project Structure

### Models

Responsible for decoding and managing form-related data.

Includes:

* `DynamicField`
* `FieldType`
* `FieldValue`
* `FormResponse`
* `TextFieldModel`
* `DropdownFieldModel`
* `CheckboxFieldModel`
* `ToggleFieldModel`

These models use `Codable` for dynamic JSON parsing.

---

### ViewModel

`FormViewModel` handles:

* Form state management
* Validation logic
* User input tracking
* Dynamic payload generation
* Submission handling
* Error state updates

The ViewModel uses `ObservableObject` to provide reactive UI updates.

---

### Views

The UI is built using reusable renderer-based components.

Includes:

* `DynamicFormView`
* `DynamicFieldView`
* `TextFieldRenderer`
* `DropdownRenderer`
* `CheckboxRenderer`
* `ToggleRenderer`
* `MultiSelectDropdownView`
* `ValidationErrorView`

The application dynamically renders UI components based on field type received from JSON.

---

### Utilities

Reusable helper utilities:

* `ValidationEngine`
* `JSONLoader`
* `Color+Hex`

---

# Observation & State Management Decision

The project uses ObservableObject with @Published instead of the newer @Observable macro.

Reason:
The assignment required iOS 16 compatibility, while the Observation framework and @Observable macro were introduced in iOS 17.

Using:

ObservableObject + @Published

allowed the project to remain fully compatible with iOS 16 while still providing scalable reactive state management for SwiftUI.

If the deployment target were iOS 17+, the newer Observation framework would be a strong candidate because it reduces boilerplate and simplifies observation behavior.


---

## Decoding Strategy Decision

The project primarily uses `Decodable` instead of full `Codable`.

Reason:
The application only consumes and parses backend JSON payloads and does not encode models back into JSON.

Using `Decodable`:

* keeps the API surface smaller
* better communicates one-way data flow
* avoids unnecessary encoding conformance
* keeps model intent clearer

For polymorphic parsing, the project uses:

* enum-based field decoding
* custom `Decodable` implementations
* lossy defensive parsing via `SafeDynamicField`

This approach satisfies the assignment requirement for robust polymorphic JSON parsing while remaining resilient against malformed or unsupported backend payloads.


---

# Technical Highlights

* Dynamic JSON-driven form rendering
* Reusable renderer-based architecture
* Centralized validation engine
* MVVM architecture
* Reactive state handling using `ObservableObject`
* Dynamic payload generation
* Scalable field-type rendering system
* Clean separation of concerns
* Modular reusable UI components

---

# Product / Edge-Case Decisions

## 1. Validation Trigger Timing

Validation is performed during submission and field editing completion instead of validating every keystroke.

This improves user experience by preventing excessive validation interruptions while typing.

---

## 2. Handling Invalid or Missing JSON Data

If unsupported field types or missing optional values are received from JSON, the app safely ignores those fields instead of crashing.

This improves stability and fault tolerance.

---

## 3. Renderer-Based Architecture

Instead of creating hardcoded form screens, I implemented reusable renderer components for each field type.

This allows adding new field types with minimal changes and improves scalability.

---

# Challenges & Debugging

One of the main challenges was managing reusable dynamic UI rendering while maintaining validation state consistency.

I also encountered:

* AutoLayout and keyboard interaction issues
* Reusable field state update problems
* Validation synchronization challenges

To solve these:

* I refactored validation handling into a centralized validation engine
* Improved ViewModel state management
* Debugged reusable renderer lifecycle behavior
* Manually tested multiple rendering scenarios

---

# Improvements With More Time

Given more time, I would improve:

* Unit test coverage
* UI/Snapshot testing
* Accessibility support
* Additional form field types
* Better animations and transitions
* Form persistence/offline caching
* Improved error messaging
* API integration for remote forms

---

# AI Tool Usage

AI-assisted tools were intentionally used during development as part of the assignment requirements.

Tools used:

* ChatGPT

AI assistance was used for:

* Architecture discussions
* Debugging guidance
* Validation handling ideas
* AutoLayout troubleshooting
* Documentation formatting

All generated suggestions were manually reviewed, tested, and modified before being included in the final project.

Detailed usage information is available in:
`AI_COLLABORATION_LOG.md`

---

# Demo Video

Add your demo video link here:

`https://your-demo-video-link.com`

---

# Requirements

* Xcode 16+
* iOS 16+
* Swift 5+
