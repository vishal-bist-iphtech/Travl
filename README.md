# 🌍 Travl

**Travl** is a modern travel planning & trip manager application built with **SwiftUI** and **Core Data**. It helps users organize their trips, track expenses, manage bookings, create packing lists, and preserve travel memories—all in one place.

The project is built using the **MVVM (Model-View-ViewModel)** architecture to keep the code modular, maintainable, and scalable while following SwiftUI best practices.

---

# 🛠 Tech Stack

- Swift
- SwiftUI
- Core Data
- PhotosPicker

---

# 📂 Project Structure

```
Travl
│
├── App
    ├── ContentView
│   ├── SplashView
│   └── TravlApp
├── Models
│   ├── Core Data Entities
│   └── PersistenceController
│
├── ViewModels
│   ├── TripViewModel
│   ├── MemoryViewModel
│   └── BookingViewModel
│
├── Views
│   ├── Dashboard
│   ├── Trips
│   ├── Memories
│   ├── Bookings
│   ├── Expenses
│   └── Shared Components
│
├── Services
│   └── CoreDataService
│
└── Resources
```

---

# 🚀 Getting Started

### Requirements

- Xcode 26 or later
- iOS 26+
- macOS Sequoia or later

### Installation

1. Clone the repository

```bash
git clone https://github.com/vishal-bist-iphtech/Travl.git
```

2. Open the project

```bash
cd Travl
open Travl.xcodeproj
```

3. Build & Run

- Select an iOS Simulator
- Press **⌘ + R**

---

# 🤝 Architecture

This project follows the **MVVM (Model-View-ViewModel)** architecture.

```
Views
   │
   ▼
ViewModels
   │
   ▼
CoreDataService
   │
   ▼
Core Data
```

This separation keeps UI, business logic, and data persistence independent and easier to maintain.

# Demo Video

<video src="https://github.com/user-attachments/assets/29df5178-a2db-4a5e-89b3-b42b122fa568" controls autoplay></video>
