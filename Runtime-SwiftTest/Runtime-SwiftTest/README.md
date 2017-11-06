#  Log
# viewController
## ①only

### It's weird to see this.
AppDelegate.swift[19],application(_:didFinishLaunchingWithOptions:):iPhone 6
ViewController.swift[103],autoLayoutModels:newValue:Optional([])
ViewController.swift[103],autoLayoutModels:newValue:Optional([<UILabel: 0x15d674db0; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x15d652250>>])
ViewController.swift[103],autoLayoutModels:newValue:nil
ViewController.swift[73],viewDidLoad():nil


### This log is normally and commonly happened.
AppDelegate.swift[19],application(_:didFinishLaunchingWithOptions:):iPhone 6
ViewController.swift[103],autoLayoutModels:newValue:Optional([])
ViewController.swift[103],autoLayoutModels:newValue:Optional([<UILabel: 0x127e64290; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x127e63f80>>])
ViewController.swift[103],autoLayoutModels:newValue:Optional([<UILabel: 0x127e64290; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x127e63f80>>, <UILabel: 0x127e65590; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x127e654c0>>])
ViewController.swift[73],viewDidLoad():Optional([<UILabel: 0x127e64290; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x127e63f80>>, <UILabel: 0x127e65590; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x127e654c0>>])

### Come on.Damn it! I'm speechless!
AppDelegate.swift[19],application(_:didFinishLaunchingWithOptions:):iPhone 6
ViewController.swift[80],autoLayoutModels:newValue:Optional([])
ViewController.swift[80],autoLayoutModels:newValue:Optional([<UILabel: 0x13558b130; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x13558ae20>>])
ViewController.swift[80],autoLayoutModels:newValue:Optional([<UILabel: 0x13558b130; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x13558ae20>>, <UILabel: 0x13558c400; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x13558c320>>])
ViewController.swift[50],viewDidLoad():nil



## ②only
### Yah. This is happened again. 49%/2
AppDelegate.swift[19],application(_:didFinishLaunchingWithOptions:):iPhone 6
ViewController.swift[115],al_layout():yah,it is nil
ViewController.swift[103],autoLayoutModels:newValue:Optional([])
ViewController.swift[103],autoLayoutModels:newValue:Optional([<UILabel: 0x145e54ab0; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x145e54900>>])
ViewController.swift[118],al_layout():It's not nil
ViewController.swift[103],autoLayoutModels:newValue:nil
ViewController.swift[73],viewDidLoad():nil


### I want to see this,and it happened normally. 99%/2
AppDelegate.swift[19],application(_:didFinishLaunchingWithOptions:):iPhone 6
ViewController.swift[115],al_layout():yah,it is nil
ViewController.swift[103],autoLayoutModels:newValue:Optional([])
ViewController.swift[103],autoLayoutModels:newValue:Optional([<UILabel: 0x15ee43a20; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x15ee3af60>>])
ViewController.swift[118],al_layout():It's not nil
ViewController.swift[103],autoLayoutModels:newValue:Optional([<UILabel: 0x15ee43a20; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x15ee3af60>>, <UILabel: 0x15ed77730; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x15ed775d0>>])
ViewController.swift[73],viewDidLoad():Optional([<UILabel: 0x15ee43a20; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x15ee3af60>>, <UILabel: 0x15ed77730; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x15ed775d0>>])

### Sometimes this happened. 1%
AppDelegate.swift[19],application(_:didFinishLaunchingWithOptions:):iPhone 6
ViewController.swift[115],al_layout():yah,it is nil
ViewController.swift[103],autoLayoutModels:newValue:Optional([])
ViewController.swift[103],autoLayoutModels:newValue:Optional([<UILabel: 0x156e4f230; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x156e085b0>>])
ViewController.swift[115],al_layout():yah,it is nil
ViewController.swift[103],autoLayoutModels:newValue:Optional([])
ViewController.swift[103],autoLayoutModels:newValue:Optional([<UILabel: 0x156d6b870; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x156d6b6f0>>])
ViewController.swift[73],viewDidLoad():Optional([<UILabel: 0x156d6b870; frame = (0 0; 0 0); userInteractionEnabled = NO; layer = <_UILabelLayer: 0x156d6b6f0>>])

# Maybe it's all because the key I passed to objc_assoc* func is not Unique
Because when I change it to a real Pointer to the string's hasValue.
or when I define like this :
static let keyPointer = UnsafeRawPointer("autoLayoutModels.key")
rathen than directly pass a string as a UnsafeRawPointer.
It works well.







