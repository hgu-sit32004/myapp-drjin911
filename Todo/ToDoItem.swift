//
//  ToDoItem.swift
//  Todo
//
//

import Foundation

class ToDoItem: NSObject {
  var id: String
  var image: String
  var title: String
  var date: Date
  var descriptional: String
  
    init(id: String, image: String, title: String, date: Date, description: String) {
    self.id = id
    self.image = image
    self.title = title
    self.date = date
    self.descriptional = description
  }
}
