//
//  IndianCategories.swift
//  Artha
//
//  Created for Indian market adaptation
//

import Foundation

struct CategoryTemplate {
    let emoji: String
    let name: String
    let color: String
}

class IndianCategories {
    static let expenseCategories: [CategoryTemplate] = [
        // Transportation
        CategoryTemplate(emoji: "🛺", name: "Auto/Cab", color: "#F3BF56"),
        CategoryTemplate(emoji: "⛽", name: "Petrol/Diesel", color: "#EC7A58"),
        CategoryTemplate(emoji: "🚇", name: "Metro/Train", color: "#6E7BF1"),
        CategoryTemplate(emoji: "🏍️", name: "Bike Taxi", color: "#E34D63"),
        
        // Food & Groceries
        CategoryTemplate(emoji: "🍛", name: "Kirana/Groceries", color: "#279AF4"),
        CategoryTemplate(emoji: "🍕", name: "Food Delivery", color: "#E34D63"),
        CategoryTemplate(emoji: "☕", name: "Chai/Snacks", color: "#F6D24A"),
        CategoryTemplate(emoji: "🍽️", name: "Restaurant", color: "#ED80A2"),
        CategoryTemplate(emoji: "🥘", name: "Tiffin Service", color: "#F1AF8A"),
        
        // Bills & Utilities
        CategoryTemplate(emoji: "💡", name: "Electricity Bill", color: "#F3BF56"),
        CategoryTemplate(emoji: "💧", name: "Water Bill", color: "#61C7FA"),
        CategoryTemplate(emoji: "🔥", name: "LPG/Gas Cylinder", color: "#E34D63"),
        CategoryTemplate(emoji: "📱", name: "Mobile Recharge", color: "#6E7BF1"),
        CategoryTemplate(emoji: "📺", name: "DTH/OTT", color: "#C56AF7"),
        CategoryTemplate(emoji: "🌐", name: "Broadband/WiFi", color: "#7CB0AA"),
        
        // Household
        CategoryTemplate(emoji: "🏠", name: "House Rent", color: "#C56AF7"),
        CategoryTemplate(emoji: "👩‍🍳", name: "House Help/Maid", color: "#ED80A2"),
        CategoryTemplate(emoji: "🧹", name: "Cleaning Supplies", color: "#88997A"),
        CategoryTemplate(emoji: "🔧", name: "Maintenance", color: "#C38D5D"),
        CategoryTemplate(emoji: "🏡", name: "Society Charges", color: "#A6678A"),
        
        // Health
        CategoryTemplate(emoji: "💊", name: "Medicine/Pharmacy", color: "#EB7068"),
        CategoryTemplate(emoji: "🏥", name: "Doctor/Hospital", color: "#EC7A58"),
        CategoryTemplate(emoji: "🧪", name: "Lab Tests", color: "#84B4EB"),
        CategoryTemplate(emoji: "💉", name: "Health Insurance", color: "#A0ACF9"),
        
        // Personal Care
        CategoryTemplate(emoji: "💇", name: "Salon/Parlour", color: "#F1AF8A"),
        CategoryTemplate(emoji: "🪒", name: "Grooming", color: "#7CB0AA"),
        CategoryTemplate(emoji: "👕", name: "Laundry", color: "#88997A"),
        
        // Education
        CategoryTemplate(emoji: "🎓", name: "School/College Fees", color: "#7CB0AA"),
        CategoryTemplate(emoji: "✏️", name: "Tuition/Coaching", color: "#279AF4"),
        CategoryTemplate(emoji: "📚", name: "Books/Stationery", color: "#6E7BF1"),
        
        // Shopping
        CategoryTemplate(emoji: "👔", name: "Clothes/Fashion", color: "#ED80A2"),
        CategoryTemplate(emoji: "🛍️", name: "Shopping", color: "#F6D489"),
        CategoryTemplate(emoji: "📱", name: "Electronics", color: "#4088AD"),
        
        // Entertainment
        CategoryTemplate(emoji: "🎬", name: "Movies/Theatre", color: "#C56AF7"),
        CategoryTemplate(emoji: "🎮", name: "Entertainment", color: "#7014F5"),
        
        // Indian Specific
        CategoryTemplate(emoji: "🙏", name: "Temple/Donation", color: "#84B4EB"),
        CategoryTemplate(emoji: "🎁", name: "Gifts/Festival", color: "#A6678A"),
        CategoryTemplate(emoji: "💰", name: "Gold", color: "#F3BF56"),
        CategoryTemplate(emoji: "🎉", name: "Events/Celebrations", color: "#ED80A2"),
        
        // Financial
        CategoryTemplate(emoji: "💳", name: "Credit Card Bill", color: "#E34D63"),
        CategoryTemplate(emoji: "🏦", name: "EMI Payment", color: "#4088AD"),
        CategoryTemplate(emoji: "📈", name: "Investment", color: "#5FAF9F")
    ]
    
    static let incomeCategories: [CategoryTemplate] = [
        CategoryTemplate(emoji: "💰", name: "Salary", color: "#76FBB1"),
        CategoryTemplate(emoji: "📈", name: "Freelance/Side Hustle", color: "#76FBB1"),
        CategoryTemplate(emoji: "🎁", name: "Gift Received", color: "#76FBB1"),
        CategoryTemplate(emoji: "💸", name: "Refund", color: "#76FBB1"),
        CategoryTemplate(emoji: "🏆", name: "Bonus", color: "#76FBB1"),
        CategoryTemplate(emoji: "📊", name: "Investment Return", color: "#76FBB1"),
        CategoryTemplate(emoji: "🏠", name: "Rental Income", color: "#76FBB1")
    ]
}

