# WEBSITE_SPEC.md - EnergyTrade (Confidential Energy Trading Platform)

> **NOTE:** This file is for the frontend developer. After the website is created, this file can be deleted from the repository.

## General Description

EnergyTrade is a decentralized energy trading platform with encrypted volumes, prices, and consumption data. Producers and consumers can trade energy privately while maintaining grid transparency.

## Website Structure

### Home Page (/)

**Header:**
- Logo "EnergyTrade" (click → home)
- Navigation:
  - "Market" (click → /market)
  - "Produce" (click → /produce)
  - "Consume" (click → /consume)
  - "My Portfolio" (click → /portfolio)
- "Connect Wallet" button

**Hero:**
- Title: "Private Energy Trading"
- Subtitle: "Trade energy with encrypted prices and volumes"
- Button "View Market" (click → /market)

**Features:**
- "Encrypted Trading" - prices and volumes stay private
- "Grid Balancing" - encrypted grid management
- "Private Consumption" - consumption data encrypted
- "Secure Settlement" - encrypted billing and payments

### Page "Market" (/market)

**Energy Market:**
- Order book with encrypted prices (shown as "***")
- Available energy offers:
  - Producer address
  - Energy type (Solar, Wind, etc.)
  - Volume (encrypted, shown as "***")
  - Price per unit (encrypted, shown as "***")
  - Expiration time
  - Button "Purchase"
- Recent trades (encrypted volumes and prices)
- Grid status indicators

**Filters:**
- By Energy Type
- By Price Range (encrypted)
- By Volume Range (encrypted)
- Sort by: Price, Volume, Newest

### Page "Produce" (/produce)

**Production Dashboard:**
- Current production (encrypted, shown as "***")
- Production history (encrypted volumes)
- Revenue from sales (encrypted)

**Create Energy Offer:**
- Field "Energy Type" (dropdown: Solar, Wind, Hydro, etc.)
- Field "Volume" (number, in kWh, will be encrypted)
- Field "Price per Unit" (number, will be encrypted)
- Field "Expiration" (datetime)
- Estimated Revenue (encrypted, shown as "***")
- Button "Encrypt & Create Offer"
  - On click: encrypts volume and price, creates offer
  - Shows "Creating offer..."
  - After success: "Offer created successfully"
  - Redirects to /portfolio

**Production Tracking:**
- Form to record production:
  - Field "Amount" (number, in kWh, will be encrypted)
  - Field "Timestamp" (auto-filled)
  - Button "Encrypt & Record"
  - Shows encrypted production history

### Page "Consume" (/consume)

**Consumption Dashboard:**
- Current consumption (encrypted, shown as "***")
- Consumption history (encrypted)
- Energy purchases (encrypted amounts)

**Purchase Energy:**
- List of available offers
- Select offer
- Field "Amount to Purchase" (number, in kWh, will be encrypted)
- Total Cost (encrypted, shown as "***")
- Button "Encrypt & Purchase"
  - On click: encrypts amount and purchases
  - Shows "Processing purchase..."
  - After success: "Purchase successful"
  - Redirects to /portfolio

**Consumption Tracking:**
- Form to record consumption:
  - Field "Amount" (number, in kWh, will be encrypted)
  - Field "Timestamp" (auto-filled)
  - Button "Encrypt & Record"
  - Shows encrypted consumption history

### Page "My Portfolio" (/portfolio)

**Tabs:**
- "Overview" (summary)
- "Offers" (my energy offers)
- "Trades" (trading history)
- "Production" (production tracking)
- "Consumption" (consumption tracking)

**Tab "Overview":**
- Total Production (encrypted, button "Decrypt")
- Total Consumption (encrypted, button "Decrypt")
- Net Energy Balance (encrypted)
- Revenue (encrypted, button "Decrypt")
- Expenses (encrypted, button "Decrypt")
- Net Profit (encrypted, button "Decrypt")

**Tab "Offers":**
- Table of my offers:
  - Columns: Energy Type, Volume (encrypted), Price (encrypted), Status, Actions
  - Button "Cancel Offer"
  - Button "View Details"

**Tab "Trades":**
- Table of trades:
  - Columns: Date, Type (Buy/Sell), Partner, Volume (encrypted), Price (encrypted), Total (encrypted), Status
  - Button "Decrypt Trade"
  - Button "Settle Trade"

**Tab "Production":**
- Production timeline (encrypted volumes)
- Daily/weekly/monthly summaries (encrypted)
- Button "Decrypt Production"

**Tab "Consumption":**
- Consumption timeline (encrypted volumes)
- Daily/weekly/monthly summaries (encrypted)
- Button "Decrypt Consumption"

## Common UI Elements

### Modals

**Modal "Offer Details":**
- Full offer information
- Encrypted price and volume shown as "***"
- Button "Decrypt Offer" (for offer owner)
- Button "Purchase"
- Button "Close"

**Modal "Trade Confirmation":**
- Trade summary
- Encrypted volume and price shown as "***"
- Selected offer
- Buttons: "Cancel", "Confirm & Encrypt"

**Modal "Settlement":**
- Settlement details (encrypted)
- Button "Decrypt Settlement"
- Button "Confirm Settlement"
- Button "Close"

### Notifications
- "Offer created successfully" (green)
- "Energy purchased successfully" (green)
- "Trade settled" (success)
- "Production recorded" (info)

### Loading
- "Encrypting offer..."
- "Processing purchase..."
- "Settling trade..."
- "Recording production..."

## Navigation
- `/` - Home
- `/market` - Energy market
- `/produce` - Production dashboard
- `/consume` - Consumption dashboard
- `/portfolio` - My portfolio

## Design
- Energy/grid theme
- Modern, technical design
- Grid visualizations
- Energy flow diagrams
- Responsive design

## Technical Requirements
- Web3 wallet integration (MetaMask only)
- Zama FHEVM for energy/price encryption
- Display encrypted data as "***"
- Trading mechanism
- Production/consumption tracking
- Settlement system
- Decryption on request for verification

