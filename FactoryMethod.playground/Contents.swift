import Foundation

/*
 The creator class declares the factory method that must return an object of a product class.
 The creator's subclasses usually provide the implementation of this method
 */
class Dialog {
    // The creator may also provide some default implementation of the factory method.
    func createButton() -> Button? {
        return nil
    }
    
    func render() {
        let okButton = createButton()
        okButton?.onClick()
        okButton?.render()
    }
}

class WindowsDialog: Dialog {
    override func createButton() -> Button? {
        return WindowsButton()
    }
}

class WebDialog: Dialog {
    override func createButton() -> Button? {
        return WebButton()
    }
}

protocol Button {
    func render()
    func onClick()
}

class WindowsButton: Button {
    func render() {
        print("Button rendered by Windows Application")
    }
    
    func onClick() {
        print("Button clicked by Windows Application")
    }
}

class WebButton: Button {
    func render() {
        print("Button rendered by Web Application")
    }
    
    func onClick() {
        print("Button clicked by Web Application")
    }
}

class Application {
    private var dialog: Dialog?
    
    init(dialog: Dialog) {
        self.dialog = dialog
    }
    
    func onClick() {
        dialog?.render()
    }
}

let windowsApplication = Application(dialog: WindowsDialog())
windowsApplication.onClick()

let webApplication = Application(dialog: WebDialog())
webApplication.onClick()
