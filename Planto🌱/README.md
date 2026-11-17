# Planto 🌱

A plant-care reminder app built with **SwiftUI** using the **MVVM** pattern and **Liquid Glass** (iOS 26).

## Features
- Add plant reminders with care details (room, light, watering days, water amount)
- Edit and delete plants (from the edit sheet or by swiping)
- Daily reminders list with check / uncheck
- Animated progress bar: "3 of your plants feel loved today ✨"
- "All Done! 🎉" when every plant is watered
- Local notifications
- Data saved locally on the device

## Architecture (MVVM)
```
Planto/
├── App/          PlantoApp, RootView (splash → main)
├── Models/       Plant (struct), Room / LightCondition / WateringFrequency / WaterAmount (enums)
├── ViewModels/   PlantsViewModel, ReminderFormViewModel
├── Views/        MyPlantsView, SetReminderView, SplashView, StateViews
│   └── Components/  PlantRowView, TagView, WateringProgressView, OptionPickerRow
├── Services/     PlantStore (persistence), NotificationManager
└── Theme/        Colors
```

## Swift concepts used
- **Optionals**: `lastWateredDate: Date?`, `activeSheet: ReminderSheet?`, `editingPlant: Plant?`
- **Structs**: `Plant`, `PlantStore`
- **Classes**: `PlantsViewModel`, `ReminderFormViewModel`, `NotificationManager`
- **Enums**: picker options, and `ReminderSheet` with associated values

## Requirements
Xcode 26 · iOS 26
