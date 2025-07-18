🧠 Overview
This project adopts Clean Architecture with modular feature-based organization and Riverpod for scalable, testable, and reactive state management.

The app architecture separates the codebase into three primary layers:

Data 

Domain 

Presentation 

Each feature lives in its own module, promoting isolation, maintainability, and reusability.

📁 Project Structure
🔹 Core Layer (Shared Modules)
The core/ directory provides app-wide configurations, helpers, services, and reusable UI components.

Includes:

Base Classes: BaseRemoteDataSource, BaseLocalDataSource

Dependency Injection: provider.dart, init_di.dart

Helpers: SharedPrefHelper, .env config loading

Routing: AppRouter, route names (via go_router)

Themes: Color palette, text styles, assets, dimensions

Utils: AppStrings, constants, validators, extensions

Widgets: Custom form fields, dialogs, loaders, etc.

🔹 Features Layer
Each feature is structured into data, domain, and presentation sub-layers.

Example: features/auth/

📦 data/
Responsible for data handling:

datasources/

local/: local_data_source.dart, local_data_source_impl.dart

remote/: remote_data_source.dart, remote_data_source_impl.dart

models/: DTOs like user_model.dart

mappers/: Convert between DTOs and domain entities

repositories/: Implements domain repositories

providers/: Riverpod providers for datasources, mappers, etc.

📦 domain/
Defines business logic:

entities/: Core domain models like User

repositories/: Abstract contracts

usecases/: Business logic (e.g. LoginUseCase)

providers/: Expose domain logic via Riverpod

📦 presentation/
Handles UI and state:

screens/: UI screens (e.g., login_screen.dart)

widgets/: Reusable UI components

providers/: Riverpod providers managing UI state

notifiers/providers/: Notifiers or state classes exposed via StateNotifierProvider, AsyncNotifier, etc.

🎓 Technologies & Dependencies
✨ UI & Layout
flutter_screenutil: Adaptive screen sizes

flutter_svg: Render SVGs

shimmer: Skeleton loaders

marquee: Scrolling text

🌱 State Management
flutter_riverpod: Reactive, compile-safe state management

⚙️ Dependency Injection
Riverpod Providers for injecting datasources, use cases, and repositories

flutter_dotenv: Load .env for environment config

🚀 Networking
dio: HTTP client

retrofit: Declarative API interface

pretty_dio_logger: Dev request logs

📦 Local Storage
shared_preferences: Simple key-value

flutter_secure_storage: Encrypted data

hive / hive_flutter: Lightweight NoSQL DB

path_provider: Local file paths

⚛️ Code Generation
freezed / freezed_annotation: Immutable models

json_serializable / json_annotation: JSON parsing

build_runner: Codegen runner

📸 Media & Assets
cached_network_image: Image caching

image_picker: Media input

🗺️ Maps
mapbox_maps_flutter: Custom interactive maps

flutter_map + latlong2: Open-source map rendering

🔧 Other Utilities
go_router: Declarative and nested navigation

dartz: Functional programming utilities

equatable / collection: Value comparison & helpers

cupertino_icons: iOS-style icons

🧪 Testing & Scalability
This project is built with testability in mind thanks to the clean separation of concerns and Riverpod’s composability.

✅ Unit and Widget Tests are implemented and available on the unit_and_widget_tests branch.

Key testing benefits:

Domain logic is testable in isolation via usecases and repositories

Presentation logic (e.g., UI state) is managed using Riverpod Notifiers and tested with flutter_test

Reusable providers enable easy mocking and overrides in test environments

Features are tested modularly, ensuring scalability and maintainability

🛠️ Coming Enhancements
Global error handling via providers or middlewares
Better loading/error UI handling using AsyncValue or NotifierProvider

 
