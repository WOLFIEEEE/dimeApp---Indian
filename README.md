# Artha (अर्थ)

<p align="center">
  <img src="./docs/assets/hero.png" width="451" style="max-width: 100%; height: auto;" />
</p>

**Artha** (Sanskrit for "wealth" or "prosperity") is a 100% free, open-source personal finance tracker specifically adapted for the Indian market. Built with iOS design guidelines and Indian user needs in mind.

*Originally forked from [Dime](https://github.com/rarfell/dimeApp) by Rafael Soh*

## 🇮🇳 Why Artha for India

### Indian-Specific Features

- **🔢 Indian Number System**: Display amounts in Lakh & Crore format (₹10,00,000 or ₹10L)
- **📊 Financial Year Support**: Track expenses by Indian FY (April-March) with quarterly views
- **🏪 Indian Categories**: Pre-loaded with 40+ relevant categories
  - Auto/Cab, Petrol/Diesel, Metro/Train
  - Kirana/Groceries, Food Delivery, Tiffin Service
  - LPG/Gas, Electricity, Water, Mobile Recharge
  - House Help/Maid, Temple/Donation, Festival Gifts
- **💳 Payment Methods**: Track by Cash, UPI, Card, Wallet, Bank Transfer
- **🗣️ Hindi Language**: Full Hindi localization (हिंदी में उपलब्ध)
- **🪔 Festival Calendar**: 22 Indian festivals with budget reminders
  - Diwali, Holi, Eid, Dussehra, Raksha Bandhan, and more
- **📱 Bill Splitting**: Split expenses with friends and family
- **💰 Lending/Borrowing Tracker**: Track money lent or borrowed with due date reminders
- **🏦 EMI Tracker**: Manage multiple EMIs (Home Loan, Car Loan, etc.)

### Core Features (Inherited from Dime)

- 100% free forever, with no paywall or ads
- Beautifully iOS-centric design, with simplicity at its core
- Insightful expenditure breakdowns over various time periods
- Create budgets based on expense categories and stick to them
- Create recurring expenses with custom time frames
- Sync your expenses, categories and budgets with other devices via iCloud
- Custom reminders to input your expenses
- Biometric authentication to protect your data
- Home screen quick actions make capturing new expenses a breeze
- A gorgeous night theme for dark mode fanatics
- Informative home and lock screen widgets keep you updated at a glance

## App Preview

<p align="center">
  <img src="./docs/assets/3.png" height="300" /> 
  <img src="./docs/assets/4.png" height="300" /> 
  <img src="./docs/assets/5.png" height="300" />
  <img src="./docs/assets/6.png" height="300" />
</p>
<p align="center">
  <img src="./docs/assets/7.png" height="300" />
  <img src="./docs/assets/8.png" height="300" />
  <img src="./docs/assets/9.png" height="300" />
</p>

## 🚀 Quick Start

### Requirements

- Xcode 14.0+
- iOS 15.0+
- macOS 12.0+ (for development)

### Build Steps

1. Clone this repository:
   ```bash
   git clone https://github.com/[your-repo]/dimeApp---Indian.git
   cd dimeApp---Indian/app
   ```

2. Open the project:
   ```bash
   open dime.xcodeproj
   ```

3. Add new Indian feature files to Xcode:
   - In Xcode, right-click on `dime` folder
   - Select "Add Files to 'dime'"
   - Add files from:
     - `dime/Utilities/` (IndianNumberFormat.swift, FinancialYear.swift)
     - `dime/Models/` (PaymentMethod.swift, IndianCategories.swift, etc.)
     - `dime/hi.lproj/` (Localizable.strings)

4. Resolve package dependencies:
   - `File > Packages > Resolve Package Versions`

5. Build and run:
   - Press `Cmd + B` to build
   - Press `Cmd + R` to run

## 📁 New Files Added for Indian Market

### Utilities
- `IndianNumberFormat.swift` - Lakh/Crore formatting
- `FinancialYear.swift` - FY calculations and quarters

### Models
- `PaymentMethod.swift` - Payment type tracking
- `IndianCategories.swift` - 40+ Indian category templates
- `SplitExpense.swift` - Bill splitting data model
- `LendRecord.swift` - Lending/borrowing tracker
- `EMI.swift` - EMI management
- `IndianFestivals.swift` - Festival calendar with 22 festivals

### Localization
- `hi.lproj/Localizable.strings` - Complete Hindi translation (200+ strings)

## 🎯 Usage Examples

### Indian Number Formatting
```swift
let amount: Double = 1500000

// Regular format
amount.toIndianFormat() // "15,00,000"

// Compact format
amount.toIndianCompact() // "15L"

// With currency
amount.toIndianCurrency() // "₹15,00,000"
amount.toIndianCurrency(compact: true) // "₹15L"
```

### Financial Year
```swift
let date = Date()
let fy = date.financialYear // (April 1 - March 31)
print(date.fyString) // "FY 2024-25"
print(date.fyQuarter) // "Q2"
```

### Festival Calendar
```swift
// Get next upcoming festival
if let nextFestival = FestivalCalendar.nextFestival {
    print("\(nextFestival.emoji) \(nextFestival.name) in \(nextFestival.daysUntil) days")
}

// Get festivals within 30 days
let upcoming = FestivalCalendar.upcoming(within: 30)
```

## 🔧 Integration Guide

### Enable Indian Number Format

In any view displaying currency:
```swift
// Before
Text("₹\(amount, specifier: "%.2f")")

// After
Text(amount.toIndianCurrency(compact: true))
```

### Load Indian Categories on First Launch

Add to `WelcomeSheetView.swift` or `ContentView.swift`:
```swift
func loadIndianCategories() {
    guard !UserDefaults(suiteName: "group.com.rafaelsoh.dime")?
        .bool(forKey: "indianCategoriesLoaded") ?? false else { return }
    
    for (index, template) in IndianCategories.expenseCategories.enumerated() {
        let category = Category(context: dataController.container.viewContext)
        category.id = UUID()
        category.emoji = template.emoji
        category.name = template.name
        category.colour = template.color
        category.income = false
        category.order = Int64(index)
        category.dateCreated = Date()
    }
    
    dataController.save()
    UserDefaults(suiteName: "group.com.rafaelsoh.dime")?
        .set(true, forKey: "indianCategoriesLoaded")
}
```

## 🌐 Localization

Artha supports:
- 🇬🇧 English
- 🇮🇳 Hindi (हिंदी)
- 🇫🇷 French (Français)
- 🇷🇺 Russian (Русский)

To test Hindi:
1. Go to iPhone Settings > General > Language & Region
2. Add Hindi
3. Relaunch app

## 📦 Third-party Dependencies

- [Alamofire](https://github.com/Alamofire/Alamofire) - Networking
- [CloudKitSyncMonitor](https://github.com/ggruen/CloudKitSyncMonitor) - iCloud sync monitoring
- [ConfettiSwiftUI](https://github.com/simibac/ConfettiSwiftUI) - Celebration animations
- [CrookedText](https://github.com/duemunk/CrookedText) - Text rendering
- [SwiftUI Introspect](https://github.com/siteline/swiftui-introspect) - UIKit access
- [IsScrolling](https://github.com/fatbobman/IsScrolling) - Scroll detection
- [Popovers](https://github.com/aheze/Popovers/) - Custom popovers
- ScrollViewStyle
- STools

## 🤝 Contributing

Contributions are welcome! Please feel free to:
- Report bugs via [Issues](https://github.com/[your-repo]/dimeApp---Indian/issues)
- Suggest new Indian-specific features
- Submit pull requests
- Improve Hindi translations
- Add support for other Indian languages (Tamil, Telugu, Bengali, etc.)

## 📝 Roadmap

### Planned Features
- [ ] Bank SMS auto-import (when iOS allows)
- [ ] More Indian languages (Tamil, Telugu, Bengali, Marathi)
- [ ] Tax planning (Section 80C tracker)
- [ ] GST tracking for businesses
- [ ] Merchant auto-categorization (Zomato, Swiggy, etc.)
- [ ] Regional festival support

### UI Views to Build
- [ ] Bill Splitting interface
- [ ] Lending/Borrowing management screen
- [ ] EMI tracker dashboard
- [ ] Cash wallet view
- [ ] Festival budget planner

## 📄 License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Original App**: [Dime](https://github.com/rarfell/dimeApp) by [Rafael Soh](https://x.com/rarfell)
- **Indian Adaptation**: Enhanced for the Indian market with cultural and regional features
- **Contributors**: Thanks to all who have contributed to making Artha better for Indian users

## 📞 Support

For questions, suggestions, or support:
- Create an [Issue](https://github.com/[your-repo]/dimeApp---Indian/issues)
- Email: [your-email]
- Twitter/X: [@your-handle]

---

<p align="center">
  <strong>Made with ❤️ for India 🇮🇳</strong><br>
  <em>Track Expenses • Build Wealth • Achieve Artha</em>
</p>
