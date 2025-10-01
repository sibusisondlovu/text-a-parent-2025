# Text-a-Parent Flutter App

**Text-a-Parent** is a mobile app for parents to stay updated on school newsletters and messages. The app integrates with a Laravel backend and OneSignal push notifications to ensure parents are always in the loop.

---

## Table of Contents

- [Features](#features)
- [Tech Stack](#tech-stack)
- [Installation](#installation)
- [Configuration](#configuration)
- [Running the App](#running-the-app)
- [Usage](#usage)
- [License](#license)

---

## Features

- **Dashboard** displaying newsletters in card-style list view.
- **Drawer menu** for easy navigation: Dashboard, About, Logout.
- Pulls newsletters from **Laravel backend** via API.
- **Download newsletters** (PDF) directly from the app.
- **OneSignal push notifications** to alert parents of new newsletters.
- Modern, responsive UI designed with Material Design.

---

## Tech Stack

- **Mobile Framework:** Flutter
- **State Management:** Provider
- **API Requests:** HTTP package
- **Push Notifications:** OneSignal Flutter SDK
- **Backend:** Laravel API

---

## Installation

1. Clone the repository:

```bash
git clone https://github.com/your-username/text-a-parent-flutter.git
cd text-a-parent-flutter
26