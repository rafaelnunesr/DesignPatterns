import Foundation
/*
 The abstract factory protocol declares a set of methods that return different abstract products. These products are called a family and are related by high-level theme or concept. Products of one family are usually able to collaborate among themselves. A family of products may have several variants, but the products of one variant are incompatible with the products of another variant.
 */
protocol GUIFactory {
    func createButton() -> Button
    func createCheckbox() -> Checkbox
}

/*
 Concrete factories produce a family of products that belong to a single variant. The factory guarantees that the resulting products are compatible. Signatures of the concrete factory's methods return an abstract product, while inside the method a concrete product is instantiated.
 */

class WinFactory: GUIFactory {
    func createButton() -> Button {
        return WinButton()
    }
    
    func createCheckbox() -> Checkbox {
        return WinCheckbox()
    }
}

// Each concrete factory has a corresponding product variant
class MacFactory: GUIFactory {
    func createButton() -> Button {
        return MacButton()
    }
    
    func createCheckbox() -> Checkbox {
        return MacCheckbox()
    }
}

/*
 Each distinct product of a product family should have a base protocol. All variants of the product must implement this protocol.
 */
protocol Button {
    func sendEvent()
}

protocol Checkbox {
    func renderImage()
}

// Concrete products are created by corresponding concrete factories.
class WinButton: Button {
    func sendEvent() {
        print("Event sent by Windows application")
    }
}

class WinCheckbox: Checkbox {
    func renderImage() {
        print("Image was rendered by Windows application")
    }
}

class MacButton: Button {
    func sendEvent() {
        print("Event sent by Mac application")
    }
}

class MacCheckbox: Checkbox {
    func renderImage() {
        print("Image was rendered by Mac application")
    }
}

/*
 The client code works with factories and products only through abstract types: GUIFactory, Button and Checkbox. This lets you pass any factory or product subclass to the client code without breaking it.
 */
class Application {
    private var factory: GUIFactory
    private var button: Button?
    private var checkbox: Checkbox?
    
    init(factory: GUIFactory){
        self.factory = factory
        setup()
    }
    
    private func setup() {
        button = factory.createButton()
        checkbox = factory.createCheckbox()
    }
    
    func sendEvent() {
        button?.sendEvent()
    }
    
    func renderImage() {
        checkbox?.renderImage()
    }
}

let windowsApplication = Application(factory: WinFactory())
windowsApplication.renderImage()
windowsApplication.sendEvent()

let macApplication = Application(factory: MacFactory())
macApplication.renderImage()
macApplication.sendEvent()
