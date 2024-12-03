# DiscogsApp

DiscogsApp is a SwiftUI-based iOS application that allows users to search for artists, view detailed artist information, and explore their discographies using the Discogs API. The app is designed with an intuitive user interface, efficient API integration, and a clean architecture.

---

## Features

- **Search Artists**: Search for artists using the Discogs API and display results in a clean, scrollable list.
- **Artist Details**: View detailed information about an artist, including their biography, images, and band members.
- **Albums**: Explore the artist's albums sorted by release date, with filtering options by year, genre, and label.
- **Album Details**: View detailed information about an album, including its tracklist, contributors, and other metadata.
- **Carousel Display**: Artist band members are displayed in a carousel-like format with images and status.
- **Local Image Caching**: Reduces network usage and improves performance by caching album and artist images locally.
- **Debounced Search**: Implements debounced search to optimize network calls.

---

## Architecture

This project uses **MVVM (Model-View-ViewModel)** combined with **Clean Architecture** principles to ensure separation of concerns and a scalable, maintainable codebase.

### Architecture Overview

1. **Model**: Represents the app's core data structures (e.g., `Artist`, `Album`, `ArtistRelease`).
2. **View**: SwiftUI-based UI components that display data and respond to user interactions.
3. **ViewModel**: Handles business logic, communicates with the repository, and updates the view state.
4. **Repository**: Provides an abstraction layer for data access. Communicates with the Discogs API and local cache.
5. **Networking**: Implements API integration with asynchronous calls and proper error handling.
6. **Caching**: Implements image caching to optimize performance and reduce redundant network requests.

---

## Installation

### Requirements

- Xcode 13.0+
- iOS 15.0+
- Swift Package Manager (SPM) for dependencies

### Steps

1. Clone the repository:
   ```bash
   git clone https://github.com/juanjogramo/ios-discogsapp.git
   cd ios-discogsapp
    ```

2.	Open the project in Xcode:
3.	Build and run the app on a simulator or a real device.

### Usage

1.	Launch the app and use the search bar to search for your favorite artists.
2.	Tap on an artist to view detailed information and explore their albums.
3.	Navigate through band members or albums using the carousel and list views.
4.	Filter albums by year, genre, or label to refine your search.

### Technologies Used

-	SwiftUI: Declarative UI framework for building the user interface.
-	Combine: Handles asynchronous tasks and debouncing search functionality.
-	Discogs API: Provides artist and album data.
-	MVVM + Clean Architecture: Ensures scalability and maintainability.
-	Local Image Caching: Optimizes performance and user experience.

### License

DiscogsApp is licensed under the MIT License.