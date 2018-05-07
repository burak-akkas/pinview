# PINView
PINView is drag and drop component for PIN input, written in Swift 4.

### Installation
* For now, you can install PINView manually. Drag and drop "PINView.swift" file and "pinview-black-dot.png" (you can change it of course) to your project, and its done.

### Usage
> Do not forget to review the project on the "Example" folder.

* Set delegate for PINView. 
* Implement PINViewDelegate protocol with PINChanged(to: String) and PINFilled(with: String) methods.
* Focus to the keyboard on viewWillAppear with focus() method.

### Properties
You can modify apperance from storyboard with:

* Pin Black Dot Image Name ("pinview-black-dot")
* Empty Pin Alpha (0.2)
* Filled Pin Alpha (1.0)
* Pin Size (5)
* Pin Color (Green)

### Screenshot
![alt tag](https://raw.githubusercontent.com/burak-akkas/pinview/develop/Screenshots/PINView.png)
