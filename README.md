# Fishingcom Guide

## Table of Contents
1. [Prerequisites](#prerequisites)
2. [Setting Up Fishingcom](#configuring-fishingcom)
3. [Instructions for Windows Users](#for-windows-users)
4. [Next Steps](#subsequent-actions)

## Prerequisites

Before immersing yourself in the Fishingcom project, ensure that your local system meets the following requirements:

- **Git**: Download and install Git from the [official Git website](https://git-scm.com/).
- **Node.js**: Fishingcom utilizes Node.js for its backend and frontend functionalities. Obtain it from the [official Node.js website](https://nodejs.org/).
- **Docker**: Ensure Docker is installed on your system. If not, download it from the [official Docker website](https://www.docker.com/products/docker-desktop).

## Setting Up Fishingcom for UNIX/macOS platforms

### 1. Clone the Repository
- Open your terminal or command prompt.
- Enter the following command:
  ```bash
  git clone https://github.com/ziobob94/fishingcom
  ```

### 2. Navigate to the Repository Directory
```bash
cd fishingcom
```

### 3. Run the Setup Script
This script simplifies submodule installation.
- **For Unix-based Systems**:
  ```bash
  ./setup.sh --mode dev
  ```
- **For Windows Users**:
  ```bash
  setup.bat --mode=prod
  ```
> Use `--mode=dev` for development or `--mode=prod` for production configurations.

### 4. Environment Configuration
Ensure you modify the `.env` file in each submodule to set up the necessary configurations.

## For Windows platforms

### 1. Open the Command Prompt
- Press `Windows + R`, type `cmd`, and hit `Enter`.
- Navigate to the folder where the app will be located

### 2. Clone the Repository
- Enter the following command:
  ```bash
  git clone https://github.com/ziobob94/fishingcom
  ```

### 3. Navigate to the Fishingcom Directory
```bash
dir fishingcom
```

### 4. Run the Setup Script
```bash
setup.bat --mode=dev
```

### 5. Verify the Setup
Check for successful configuration messages in the Command Prompt.

### 6. Set Up Environment for Submodules
For each submodule, finalize the ***.env***  file by adding your preferences and configurations.

### 7. Deploy with Docker
Use the following commands to build and launch Docker containers:

```bash
docker-compose build
docker-compose up -d
```

## Next Steps

After completing the setup, you can proceed with your development, testing, or deployment activities.

---

This guide offers a structured approach to installing Fishingcom in your local environment. Adhere to the specified prerequisites and steps meticulously to ensure a smooth setup process.