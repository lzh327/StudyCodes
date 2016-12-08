#ios app 启动过程


## 程序入口点
当iOS app启动时，系统会根据app bundle中的 *Info.plist* 文件中的 *Executable file* 键值（*CFBundleExecutable*）在app bundle中找到app的二进制文件，*Executable file* 键的值就是二进制文件的名字，默认是 EXECUTABLE_NAME 环境变量。

当找到并加载了二进制文件之后，系统会从程序的入口点开始执行。如果是Objective-C程序，入口点就是 *main* 函数， 通常会有一个 *main.m* 文件，代码如下：
```
int main(int argc, char *argv[]) { 
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
```
*main* 函数只做两件事：
- 设定好内存管理环境- *@autoreleasepool*
- 调用 *UIApplicationMain* 函数

如果是Swift程序，则没有 *main* 函数，Swift有一个特殊的属性：*@UIApplicationMain* ， 在 *AppDelegate.swift* 中，该属性附加在 *AppDelegate* 类的声明中：
```
 @UIApplicationMain 
 class AppDelegate: UIResponder, UIApplicationDelegate {
```
该属性的作用与Objective-C的 *main* 函数一样， 它创建一个程序的入口点兵调用*UIApplicationMain* 函数。

在某些情况下，我们可以删除 *@UIApplicationMain* 属性，并用一个 *main* 文件替代它， 我们需要创建一个 *main.swift* 文件并将其加入到app target中， 文件名必须是 *main.swift* ， 该文件的代码与Objective-C中调用 *UIApplicationMain* 函数的作用一样：
```
import UIKit 
UIApplicationMain(
 CommandLine.argc, 
 UnsafeMutableRawPointer(CommandLine.unsafeArgv).bindMemory(to: UnsafeMutablePointer<Int8>.self, capacity: Int(CommandLine.argc)),
 nil,
 NSStringFromClass(AppDelegate.self) )
```
## UIApplicationMain
不管是通过 *main.swift* 文件还是 *@UIApplicationMain* 属性，最后都会调用 *UIApplicationMain* 函数。其实我们的app只做了一件事，就是调用 *UIApplicationMain* 函数。让我们来看看 *UIApplicationMain* 函数都做了什么：

1.  *UIApplicationMain* 创建app中的第一个实例，应用程序实例，*UIApplication.shared*。 *UIApplicationMain* 函数的第三个参数指定了应用程序实例所属的类，默认该参数是 *nil* ，则其默认类就是 *UIApplication*。如果你想subclass一个*UIApplication*， 那就应该将 *UIApplicationMain* 函数的第三个参数指定为你的子类名字，例如 *NSStringFromClass(MyAppSubclass.self)* .

2. *UIApplicationMain* 创建app中的第二个实例，app delegate。*UIApplicationMain* 函数的第四个参数指定了app delegate所属的类， *NSStringFromClass(AppDelegate.self)* 。如果使用 *@UIApplicationMain* 属性，该属性默认附加在 *AppDelegate* 类的声明中，其意义与*UIApplicationMain* 函数一样，即“*AppDelegate* 就是app delegate的类”。

3. 如果 *Info.plist* 文件指定了一个main storyboard， *UIApplicationMain* 函数就载入storyboard并找到其中的initial view controller（或者说是storyboard的入口点），并实例化该view controller，这是创建的第三个实例。对于Single View app模版，这个实例就是 *ViewController* 类的实例，该类定义在 *ViewController.swift* 中。

4. 如果存在main storyboard文件，*UIApplicationMain* 函数现在就该创建应用程序的window了，这是app中的第四个实例，一个UIWindow类的实例（或者在app delegate中，可以替换为一个UIWindow子类的实例）。创建window实例后，将其指定为app delegate的 *window* 属性，同时，将initial view controller实例的指定为window实例的 *rootViewController*属性。

5. *UIApplicationMain* 现在开始处理app delegate实例并调用它的一些方法，如 *application(_:didFinishLaunchingWithOptions:)*， 在该方法中，我们可以加入自己的代码进行一些初始化的设定，但不要进行一些比较耗时的工作，因为在这个时候，我们的app界面还没有显示出来。

6. 如果存在main storyboard文件， *UIApplicationMain* 函数开始调用UIWindow的实例方法 *makeKeyAndVisible* ，这样app界面就显示出来了。

7. 在window显示的过程中，将获取root view controller的main view， 如果view controller的view是通过storyboard或xib文件获取的，那么该nib文件会被加载。nib文件中的实例化并初始化，并称为初始界面的对象，view及其subview将被放置在window中。view controller的 *viewDidLoad* 方法被调用，在这里可以写一些自己的代码。

应用程序现在已经启动完成并开始运行，*UIApplicationMain* 函数仍然运行而且永不return，它继续监视用户行为，管理event loop等。

## App without storyboard
如果没有storyboard，那么创建window实例，赋予它一个root view controller，将其指定为app delegate的window属性，调用 *makeKeyAndVisible* 方法以显示window界面等工作必须由我们自己的代码完成。我们可以创建一个没有storyboard的环境，具体步骤如下（第一步和第二步可以不做，因为我们手动指定root view controller会覆盖*UIApplicationMain*的自动行为）：
1. 编辑target， 在General面板中将“*Main Interface*”选项中的Main删除，并按Tab键保存。
2. 在Project navigator中删除 *Main.stroyboard*。
3. 打开 *AppDelegate.swift* 文件，删除其所有代码。
4. 编辑 *AppDelegate.swift* ，重新创建 *AppDelegate* 类如下：
```
import UIKit
@UIApplicationMain
class AppDelegate : UIResponder, UIApplicationDelegate {
    var window : UIWindow? func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]?) -> Bool {
        self.window = self.window ?? UIWindow()
        self.window!.backgroundColor = .white
        self.window!.rootViewController = ViewController()
        self.window!.makeKeyAndVisible()
        return true
    }
}
```
我们可以通过编辑 *ViewController.swift* 来验证一下程序能够正常运行。
```
 override func viewDidLoad() { 
    super.viewDidLoad() 
    self.view.backgroundColor = .red
}
``
