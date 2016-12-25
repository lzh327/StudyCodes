#悬挂指针及内存泄漏#
如果对象a指向对象b，若对象b被释放了，则此时对象a指向一个未知地址，这种情况叫做悬挂指针。
如果对象a指向对象b，若对象a被释放了，则此时没有任何对象能够指向对象b，对象b无法被释放，这种情况叫做内存泄漏。

#手动内存管理#
在ARC出现之前，ios的内存管理是基于手动内存管理，也叫做MRC。
为了防止悬挂指针及内存泄漏，手动内存管理基于一个引用计数（retain count）的概念，所有对象都可以增加或减少一个对象的引用计数，当对象的引用计数大于0，则该对象继续存在；当该对象的引用计数减少到0，则该对象自动销毁。NSObject实现了*retain*和*release*方法，用于增加或减少引用计数。
具体的规则如下：

- 如果对象a通过调用初始化函数初始化了对象b，则初始化函数增加b的引用计数。
- 如果对象a通过*copy*，*mutableCopy*或任何带有*copy*字样的方法获得一个对象b的拷贝，则这些copy方法负责增加这个新的b的拷贝的引用计数。
- 如果对象a直接获取一个对象b的引用（不是通过初始化或拷贝的方法），则对象a自己负责增加对象b的引用计数。
- 如果对象a之前直接或间接的增加了对象b的引用计数，当对象a不再需要对象b的引用之后，对象a要负责减少对象b的引用计数。如果对象b的引用计数减少到0，则对象b被释放。

#ARC#
ARC（以及Swift）出现之后，我们不能再调用*retain*和*release*方法了。对引用计数的工作都由ARC自动完成。ARC被实现为编辑器的一部分，它将在幕后为我们自动加入*retain*和*release*方法。

但即使是在ARC的环境下，仍然有一些内存管理问题需要我们注意或进行手动处理。

#循环引用#
在这里我直接使用官方文档的例子：
```
class Person {
  let name: String
  init(name: String) { self.name = name }
  var apartment: Apartment?
  deinit { print("\(name) is being deinitialized") }
}

class Apartment {
  let unit: String
  init(unit: String) { self.unit = unit }
  var tenant: Person?
  deinit { print("Apartment \(unit) is being deinitialized") }
}

var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john
```

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/3141891-db1b622dfa78cacb.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这是最典型的强引用循环，当john和unit4A释放各自的对象之后，Person和Apartment的实例不会销毁，因为它们在互相引用对方。具体的解决办法有weak和unowned。

##Weak##
将上例的tenant属性声明为weak即可解决循环引用的问题。
```
class Person {
  let name: String
  init(name: String) { self.name = name }
  var apartment: Apartment?
  deinit { print("\(name) is being deinitialized") }
}

class Apartment {
  let unit: String
  init(unit: String) { self.unit = unit }
  weak var tenant: Person?
  deinit { print("Apartment \(unit) is being deinitialized") }
}
```
此时如图：

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/3141891-bcf2e2d2f6318698.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

当john释放时，Person实例因为没有strong引用，所以也被销毁了，tenant属性是weak引用，所以被ARC自动设置为nil。循环引用的问题就此解决。

Weak引用利用了ARC的功能，当一个引用被声明为weak的时候，ARC并不会retain这个对象。ARC会记录所有的weak引用以及它们所指向的对象，当某个对象的引用计数降到0并被销毁之后，ARC会自动将nil赋予这个引用，这也是swift中必须将weak引用声明为optional var的原因。

##Unowned##
与weak引用相类似，unowned引用也不会保存一个strong引用至它所指向的对象。
将一个引用声明为Unowned，意味着ARC对这个引用将不再起任何作用。如果引用的对象被销毁了，我们将真正面临悬挂指针的问题。所以，官方的说法是使用unowned引用必须确保unowned引用所指向的对象拥有与unowned引用相同的或更长的生命期限，因为这样是最安全的。

还是使用官方的例子：
```
class Customer {
  let name: String
  var card: CreditCard?
  init(name: String) {
  self.name = name
  }
  deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
  let number: UInt64
  unowned let customer: Customer
  init(number: UInt64, customer: Customer) {
  self.number = number
  self.customer = customer
  }
  deinit { print("Card #\(number) is being deinitialized") }
}

var john: Customer?
john = Customer(name: "John Appleseed")
john!.card = CreditCard(number: 1234_5678_9012_3456, customer: john!)
```

![Paste_Image.png](http://upload-images.jianshu.io/upload_images/3141891-6a9389c02bc271db.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

这个例子是使用unowned引用最安全的方法，因为unowned引用所指向的对象拥有与unowned引用相同的或更长的生命期限，我们可以理解为两个对象一损俱损的情况下，使用unowned最安全。

但是，如果此时CreditCard实例有另外一个对象指向它，那么当john被释放了，Customer实例也被销毁了，但是CreditCard实例仍然存在，CreditCard类中的customer属性将指向一个悬挂指针，我们需要手动的将nil赋予customer属性。这种情况也是非常常见的。

#一些特殊例子#
##ARC不支持的delegate##
使用weak引用最常见的情况就是在delegate中，如下：
```
class ColorPickerController : UIViewController { 
  weak var delegate: ColorPickerDelegate? // ...
}
```
但是，一些内置的Cocoa类使用了ARC不支持的引用（因为它们是非常老旧的代码或有向后兼容的需求），这种属性使用了*assign*关键字，例如，*AVSpeechSynthesizer*的delegate属性声明如下：
```
@property(nonatomic, assign, nullable) id<AVSpeechSynthesizerDelegate> delegate;
```
在Swift中，对应的声明如下：
```
unowned(unsafe) var delegate: AVSpeechSynthesizerDelegate?
```
在Swift中，*unowned*和Objective-C的*assign*意义相同，都意味着ARC的内存管理机制在这里不起作用。*unsafe*关键字是Swift自己加上去的，作为更进一步的警告吧。

即使我们自己的代码使用了ARC，但是Cocoa的内部代码没有使用ARC，这种情况依然能造成内存错误。例如，我们将某个对象赋予*AVSpeechSynthesizer*的delegate属性，如果我们的对象被销毁了，而这个delegate引用仍然存在，我们就需要手动将nil赋予这个delegate引用。这种情况与我在上一节中最后说的情况一样。

##Notification##
如果使用*addObserver(_:selector:name:object:)*方法注册notification，你其实是在该函数的第一个参数作为一个引用传递给notification center，通常是self。notification center对这个对象的引用是non-ARC的unsafe的引用，当我们的对象被销毁后，notification center将面临悬挂指针的问题。这就是为什么我们必须要在对象销毁前进行unregister。这种情况与前面讲的delegate例子相类似。

如果使用*addObserver(forName:object:queue:using:)*方法注册notification，内存管理的问题将更加复杂。
- *addObserver(forName:object:queue:using:)*方法返回的对象将被notification center retain，直到我们unregister它。
- *addObserver(forName:object:queue:using:)*方法的最后一个参数using是一个closure，它可能会引用self，这就意味着在unregister这个notification之前，notification center还会对self进行retain。这同样意味着我们不可能在*deinit*中进行unregister操作，因为在注册之后，unregister之前，*deinit*不可能被调用。
- 如果我们自己又引用了*addObserver(forName:object:queue:using:)*方法返回的对象，该方法的using参数又引用了self，则形成了一个循环引用。

我们看下面的例子：
```
var observer : Any! 
override func viewWillAppear(_ animated: Bool) {
  super.viewWillAppear(animated) 
  self.observer = NotificationCenter.default.addObserver(forName: .woohoo, object:nil, queue:nil) { _ in
  print(self.description)
  }
}
```
因为unregister的操作不能在*deinit*中进行。
```
override func viewDidDisappear(_ animated: Bool) { 
  super.viewDidDisappear(animated) 
  NotificationCenter.default.removeObserver(self.observer)
}
```
现在完成了register和unregister的操作，但是view controller本身因为有循环引用的问题而出现了内存泄漏的情况，可以发现*deinit*函数不会被调用。
```
deinit { 
print("deinit") 
}
```
最简单的解决方法是在closure中定义捕捉列表，将self声明为unowned。
```
self.observer = NotificationCenter.default.addObserver( forName: .woohoo, object:nil, queue:nil) { 
  [unowned self] _ in 
  print(self.description)
}
```

##Timer##
Timer类文档中有说明如下：“run loops maintain strong references to their timers”。
*scheduled-Timer(timeInterval:target:selector:userInfo:repeats:) *函数的文档说明如下：“The timer main‐tains a strong reference to target until it (the timer) is invalidated.”
上面的文档已经说明当repeat timer没有被invalidate之前，target参数（通常是self）是被run loops retain的，这意味着在invalidate之前，target参数（通常是self）是无法释放的，这同样意味着我们不可能在*deinit*中进行invalidate操作，因为在invalidate之前，*deinit*不可能被调用。与上例相似，我们可以在*viewWillAppear*和*viewDidDisappear*进行相关的操作:
```
var timer : Timer! 
override func viewWillAppear(_ animated: Bool) {
  super.viewWillAppear(animated) 
  self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(fired), userInfo: nil, repeats: true)
  self.timer.tolerance = 0.1
} 
func fired(_ t:Timer) {
  print("timer fired") 
}
override func viewDidDisappear(_ animated: Bool) { 
  super.viewDidDisappear(animated) 
  self.timer.invalidate()
}
```

在ios 10中，我们可以使用*scheduledTimer(withTimeInterval:repeats:block:)*方法，该方法可以*deinit*函数中进行invalida。但是要注意，如果在block参数（closure）中引用了self，同样要解决循环引用的问题。
```
var timer : Timer! 
override func viewWillAppear(_ animated: Bool) {
  super.viewWillAppear(animated) 
  self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
    [unowned self] // * 
    t in 
    self.fired(t)
    }
  self.timer.tolerance = 0.1 
}
func fired(_ t:Timer) { 
  print("timer fired")
}
deinit {
  self.timer.invalidate() 
}
```
#Objective-C 属性#
在Objective-C中，一个*@property*的声明包含一些关于内存管理的描述，例如在*UIViewController*中，view的属性描述如下：
```
@property(null_resettable, nonatomic, strong) UIView *view;
```
strong表示setter方法将会retain传递进来的UIView对象，Swift将上述声明翻译如下：
```
var view: UIView!
```
Swift默认的声明就是strong。

下面列出几种Cocoa属性的内存管理描述：
*strong, retain (no Swift equivalent)*：
这两个描述是一个意思，retain来自于在ARC出现之前的时代。

*weak (Swift weak)*：
该属性将会利用ARC功能，传递进来的对象不会被retain，当该对象被销毁后，ARC将会自动赋予nil给该属性，所以该属性必须声明为optional var。

*assign (Swift unowned(unsafe))*：
ARC的内存管理机制在对属性不起作用，如果该属性所引用的对象被销毁，该属性将变成一个悬挂指针。需要我们自己手动赋值为nil。

*copy (no Swift equivalent, or @NSCopying)*：
与strong和retain相似，不同点在于setter方法会通过发送*copy*方法拷贝传递进来的对象。该对象必须遵循NSCopy。

*copy*属性的应用场合是如果一个immutable类有一个mutable子类，（如*NSString*和*NSMutableString*, 或者*NSArray*和*NSMutableArray*），如果setter期望传进来的是一个immutable类对象，结果传进来的是一个mutable子类对象（根据多态性）。为防止这种情况发生，*copy*属性会使setter方法对传进来的对象调用copy方法并创建一个新的属于immutable类实例。

在Swift中，这种情况不会发生在string或array上，因为string和array在Swift中实现为struct，本身就是值类型，并且通过拷贝的方式进行传递。所以*NSString*和*NSArray*在Swift中对于的*String*和*Array*没有任何特殊的标记。但那些没有桥接到Swift中的Cocoa类型则需要用到*@NSCopying*标记。例如UILabel中的*attributedText*属性，在Swift中声明如下：
```
@NSCopying var attributedText: NSAttributedString?
```
因为*NSAttributedString*有一个mutable子类*NSMutableAttributedString*。

我们同样可以在我们自己的代码中使用*@NSCopying*标记，Swift会负责管理具体的拷贝操作。如下：
```
class StringDrawer { 
  @NSCopying var attributedString : NSAttributedString! 
  // ...
}
```
有时我们会遇到这种情况，我们的类，在类内部可以使用mutable，但是类外部传进来的必须是immutable的，具体方法就是创建一个private的计算型属性即可。
```
class StringDrawer { 
  @NSCopying var attributedString : NSAttributedString! 
  private var mutableAttributedString : NSMutableAttributedString! {
  get { 
    if self.attributedString == nil {return nil} 
    return NSMutableAttributedString(attributedString:self.attributedString)
    }
  set {
    self.attributedString = newValue 
    }
  }
// ...
}
```




