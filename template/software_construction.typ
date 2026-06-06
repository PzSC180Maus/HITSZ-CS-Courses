#import "../lib.typ": *
#show: conf
#import "@preview/codly:1.3.0": *
#import "@preview/codly-languages:0.1.1": *
#show: codly-init.with()
#codly(languages: codly-languages)
#show table: set align(center)
#default-cover(
  title: [软件构造讲义（期末复习版）],
  subtitle: [课程整理：核心知识点与设计模式总结],
)

#default-outline()

= 软件开发生命周期与过程模型

#introduction[SDLC][瀑布模型][敏捷开发][TDD][软件构造目标]

== 软件生命周期 (SDLC)
软件开发生命周期是指软件从无到有（From 0 to 1）、再从有到优（多版本迭代）的全过程。

#property[软件的组成部分][
  软件 = 程序 + 数据 + 文档。
]

#definition[SDLC 核心阶段][
  1. *计划 (Planning)*：确定目标与范围。
  2. *分析 (Analysis)*：需求定义与规格说明。
  3. *设计 (Design)*：架构设计、模块与接口设计。
  4. *实现 (Implementation)*：编写代码。
  5. *测试与集成 (Testing & Integration)*：发现缺陷，确保功能正确。
  6. *维护 (Maintenance)*：修复错误，适应新需求。
]

== 编程范式：面向过程 vs 面向对象
#definition[核心思想对比][
  - *面向过程 (Procedure Oriented)*：关注“怎么做”，将问题分解为步骤/流程。
  - *面向对象 (Object Oriented)*：关注“是什么”，将问题抽象为对象、属性及其交互。
]

#example[五子棋系统设计][
  - *结构化思想*：开始游戏 $arrow$ 黑方出子 $arrow$ 绘制画面 $arrow$ 判断输赢 $arrow$ 白方出子 $arrow$ ... (循环)。缺点：增加功能（如悔棋）需修改整个业务流。
  - *面向对象思想*：黑白双方 (Player)、棋盘系统 (负责绘制)、规则系统 (负责逻辑)。优点：低耦合，增加悔棋只需在棋盘系统加回溯，其余模块不改。
]



== Java 语言特点
Java 是一种面向对象的、健壮的跨平台语言。
- *平台无关*：一次编译，到处运行（依赖 JVM）。
- *安全性*：废除指针操作，拥有内存管理机制。
- *执行效率*：早期由于解释性特征效率稍低，现代通过 JIT 已大幅优化。

== 经典开发模型
#definition[瀑布模型 (Waterfall Model)][
  线性推进，阶段分明。严格遵循预先计划，不支持迭代。管理简单，但无法适应需求变化。
]
#definition[增量/迭代模型][
  *增量*是将功能分块交付；*迭代*是不断改进已有的版本。这种模型能更早交付有用功能，降低风险。
]
#definition[原型模型 (Prototyping)][
  通过快速搭建可运行的程序子集（原型）来获取用户真实需求或验证技术方案。
]
#definition[敏捷开发 (Agile)][
  通过快速迭代和小规模持续改进来适应变化。代表性方法包括 Scrum、XP 等。
]
#definition[测试驱动开发 (TDD)][
  核心逻辑是“先写测试，再写实现”。
  #definition[TDD 循环 (红-绿-重构)][
    1. *红 (Red)*：编写一个必然失败的测试用例。
    2. *绿 (Green)*：编写最简单的功能代码使测试通过。
    3. *重构 (Refactor)*：在保证测试通过的前提下优化代码结构。
  ]
]

== 软件构造目标
- *可理解性*：遵循命名规范，合理的注释与布局，避免过深嵌套。
- *可维护性*：软件发生变化时能以小代价适应。核心是“高内聚、低耦合”。
- *可复用性*：构造可在不同场景重复使用的模块（如泛型、抽象类）。
- *性能*：关注时间复杂度与空间（内存）效率。

#problemset[
  #exercise[软件通常包含哪三个组成部分？]
  #solution[程序、数据、文档。]
  #exercise[既然结构化编程也能实现功能，为什么要推广面向对象？请以“五子棋悔棋”功能为例说明。]
  #solution[面向对象通过对象间的协作实现功能，具有低耦合特性。在五子棋系统中，增加悔棋只需在“棋盘系统”增加回溯功能，而黑白双方和规则系统无需变动。若是结构化编程，则需要修改整个执行流，复用性差。]
  #exercise[测试驱动开发 (TDD) 的基本过程包含哪三个部分？]
  #solution[红灯（失败的测试）+ 绿灯（写最简代码通过测试）+ 重构（优化结构）。]
]
  #exam[2022年 判断][在对计算性能要求高的单一场景下，更适合采用面向对象而不是面向过程的编程方法。（）]
  #solution[错误。面向对象需要额外的对象创建、方法调用开销，在性能敏感的单一场景下，面向过程更轻量高效。]




#pagebreak(weak: true)
= Java 语言基础与 JVM

#introduction[强类型][数据类型转换][异常机制][JVM 内存区域]

== Java 基础语法
#property[数据类型][
  - *基本数据类型 (8 种)*：`byte`(1), `short`(2), `int`(4), `long`(8), `float`(4), `double`(8), `char`(2), `boolean`。
    - *int 范围*：$-2^(31)$ 到 $2^(31)-1$ (约 21 亿)。
  - *引用数据类型*：*类 (Class)*、*接口 (Interface)*、*数组 (Array)*。
]
#property[类型转换][注意精度丢失。低精度到高精度自动转换；高精度到低精度必须强制转换。*注意：即便是低级别赋给高级别，也有可能因溢出或表示方式导致精度不一致（如 long 转 float）*。]
#property[标识符规范][由字母、数字、\$、\_ 组成；不能以数字开头；区分大小写。类名采用大驼峰（HelloWorld），变量/方法名采用小驼峰（getAge）。]

== 控制流程与跳转
- *分支*：`if-else`, `switch` (支持整型、字符、String)。
- *循环*：`while`, `do-while` (至少执行一次), `for`, `for-each` (迭代集合/数组)。
- *跳转*：`break` (跳出当前层循环), `continue` (跳过本次进入下次循环), `return` (结束方法)。

== 异常机制 (Exception)
Java 异常是识别及响应错误的一致性机制，使正常逻辑与错误处理分离。

#property[关键字][
  - `try-catch-finally`：捕获并处理异常。`finally` 块无论如何都会执行。
  - `throw`：在方法内部抛出一个异常对象。
  - `throws`：在方法签名上声明该方法可能抛出的异常。
]
#definition[异常与错误分类][
  Java 处理系统中所有非正常情况都继承自 `Throwable`。
  - *Error*：严重问题，JVM 无法处理（如 `OutOfMemoryError`）。
  - *Exception*：程序可以处理的情形。
    - *Checked Exception*：编译器要求必须处理（如 `IOException`）。
    - *Runtime Exception*：运行时抛出，可不强制捕获（如 `NullPointerException`）。
]

#definition[异常链 (Exception Chaining)][
  捕获一个异常后抛出另一个新异常，并保留原始异常信息（Cause）。
  - *作用*：在分层架构中，将底层特定异常（如 `SQLException`）转换为上层业务身份异常（如 `DaoException`），同时保留调用栈用于调试。
]

#example[
  *异常转换代码示例*：
  ```java
  try {
      // 访问数据库...
  } catch (SQLException e) {
      // 保留 e 作为原因，抛出业务异常
      throw new DaoException("数据访问失败", e); 
  }
  ```
]

== JVM 内存结构与垃圾回收 (GC)

#definition[什么是 JVM][
  *JVM (Java Virtual Machine)* 是一种能够执行 Java 字节码的虚拟机运行环境。它提供了一个与硬件和操作系统无关的平台。
  - *核心本质*：实现 “Write Once, Run Anywhere” (WORA) 的基石。
  - *跨语言支持*：不仅支持 Java，还支持 Kotlin、Scala、Groovy 等编译为字节码的语言。
  - *两个关键点*：*字节码 (Bytecode)* 是跨平台的媒介；*JVM* 则是跨平台的翻译官（不同系统需安装对应版本的 JDK）。
]

#property[三者关系 (JDK vs JRE vs JVM)][
  - *JVM*：虚拟机，负责运行字节码。
  - *JRE (Runtime)*：JVM + 核心类库。运行 Java 程序的最小环境。
  - *JDK (Development Kit)*：JRE + 开发工具（javac, jdb 等）。开发 Java 程序的完整包。
]

#property[运行时内存区域 (Memory Structure)][
  JVM 将内存划分为线程私有和线程共享两大类：
  - *线程私有 (Thread Private)*：
    - *程序计数器 (PC)*：记录当前线程执行的指令位置。
    - *虚拟机栈 (Stack)*：生命周期随线程，每个方法调用产生一个*栈帧*，存放局部变量。
  - *线程共享 (Thread Shared)*：
    - *堆 (Heap)*：存放对象实例。逻辑划分为：*新生代*（新对象）、*老年代*（长期存活）。是 GC 的主战场。
    - *元空间 (Metaspace)*：Java 8+ 使用，存储类信息、静态变量、常量池。使用物理内存。
  #figure(
    image("/assets/JVM_memory.png"),
    caption: "JVM 的内存架构"
  )
]

#property[垃圾回收 (GC)][
  Java 使用*隐式内存分配/回收器*。通过*可达性分析*算法识别不可达对象并回收。
  - *优点*：提高开发效率，减少内存泄漏风险。
  - *缺点*：不受控的 GC 可能导致 Stop-The-World (STW)，带来额外性能开销。
]

#definition[常见内存溢出 (OOM) 场景][
  1. *StackOverflowError*：栈溢出。通常由于递归过深，栈帧超过限制。
  2. *OutOfMemoryError: Java heap space*：堆溢出。创建了过多大对象或内存泄漏。
  3. *OutOfMemoryError: Metaspace*：元空间溢出。通常由于加载了过多的动态生成的类。
]

#example[
  *造成 OOM 的典型代码片 (八股核心)*：
  ```java
  // 1. StackOverflow
  void recursive() { recursive(); } 

  // 2. Heap OOM
  List<Object> list = new ArrayList<>();
  while(true) { list.add(new Object()); }

  // 3. Metaspace OOM
  // 加载了上万个 CGLib 动态生成的代理类
  ```
]

#problemset[
  #exercise[Java 的引用数据类型包含哪些？]
  #solution[类 (Class)、接口 (Interface) 和数组 (Array)。]
  #exercise[Java 的异常处理机制是否包含错误 (Error)？]
  #solution[包含。`Error` 和 `Exception` 都是 `Throwable` 的子类。]
  #exercise[Java 采用的是隐式还是显式内存分配器？]
  #solution[隐式。Java 通过垃圾回收 (GC) 自动管理内存。]
  #exam[2022年 选择][
    下面哪个语句正确地声明一个整型的二维数组？
    #choices(
      [`int a[][] = new int[][]`],
      [`int a[10][10] = new int[][]`],
      [`int a[][] = new int[10][]`],
      [`int [][]a = new int[][10]`],
    )
  ]
  #solution[C。Java 二维数组声明时，第一维必须指定大小，第二维可省略（不规则数组）。A 两维都没指定，B 声明时不能指定大小，D 第二维不能单独指定。]
  #exam[2022年 选择][
    下面哪个类及其子类所表示的异常是用户程序无法处理的？
    #choices(
      [NumberFormatException],
      [Exception],
      [Error],
      [RuntimeException],
    )
  ]
  #solution[C (Error)。`Error` 类及其子类表示 JVM 层面的严重问题（如 `OutOfMemoryError`、`StackOverflowError`），用户程序一般无法也不应尝试处理。]
  #exam[2022年 选择][
    以下关于构造函数的描述，错误的是：
    #choices(
      [构造函数的返回类型只能是 void 型],
      [构造函数的方法名必须与类名相同],
      [构造函数的主要作用是完成对类的对象的初始化工作],
      [一般在创建新对象时，系统会自动调用构造函数],
    )
  ]
  #solution[A。构造函数*没有任何返回类型*，连 `void` 都不能写。]
  #exam[2022年 判断][一个类只能由一个构造方法。]
  #solution[错误。构造方法可以重载，一个类可以有多个构造方法（参数列表不同即可）。]
  #exam[2024年 选择][
    下列哪个选项不属于 Java 语言的特征？
    #choices(
      [平台无关],
      [面向对象],
      [支持指针类型],
      [垃圾回收],
    )
  ]
  #solution[C。Java 废除指针操作以提高安全性和可移植性，不支持显式指针类型。]
  #exam[2024年 判断][Java 中，所有类都要声明至少一个构造方法。]
  #solution[错误。如果不声明构造方法，编译器会自动生成一个默认无参构造方法。]
  #exam[2024年 选择][
    下面关于 Java 语言中方法的说法错误的是：
    #choices(
      [方法调用时参数类型必须符合方法的定义],
      [参数传递是值传递的方式],
      [如果方法没有返回值，则必须声明返回为 void],
      [如果方法定义为返回 void，则方法中不能出现 return 语句],
    )
  ]
  #solution[D。`void` 方法中可以使用 `return;`（不带返回值）提前退出方法。]
]
#pagebreak(weak: true)
= 面向对象编程核心：基础、接口与继承

#introduction[封装][继承][多态][抽象类与接口][静态成员][Object 超类][异常继承]

== 1. 封装 (Encapsulation)
隐藏对象内部细节，仅对外公开受控的访问接口（Getter/Setter）。

- *访问修饰符等级*：
  - `private`：仅限同一个类。
  - `default`：同一个类、同一个包。
  - `protected`：同一个类、包、子类。
  - `public`：全局可见。
#property[封装优点][提高安全性（可检查设置值）、高内聚、模块间低耦合。]

== 2. 继承 (Inheritance)
子类继承父类的特征和行为，实现代码复用。

#definition[继承定义][
  - *超类 (Superclass)*：已存在的类，也称父类。
  - *子类 (Subclass)*：从超类派生的新类，具有 `is-a` 关系。
  - *优点/缺点*：提高复用性但增强类间耦合性。
]

#property[super 与 this][
  - `this`：引用当前对象。`this()` 用于调用本类其他构造方法（必须在首行）。
  - `super`：引用父类成员。`super()` 用于调用父类构造方法（必须在首行）。
  - *注意：* 子类不直接继承父类的构造方法；`this()` 和 `super()` 不能共存。
]
#property[继承限制][Java 仅支持*单继承*。子类不能继承父类的私有成员。]
#property[Object 类][所有类的祖先。常用方法：`equals()` (默认比较内存地址), `toString()`。]

== 3. 抽象类与接口
两者都不能被实例化，但用途不同。

#definition[对比总结][
  - *抽象类 (Abstract Class)*：是对事物本质的抽象（Is-a）。可以包含普通方法、属性和构造方法。
  - *接口 (Interface)*：是对行为/契约的抽象（Can-do / Has-a）。
]

#property[核心对比 (高频考点)][
  #figure(
    table(
      columns: (3fr, 3fr, 3fr),
      align: left,
      table.header[*特性*][*抽象类*][*接口*],
      [能否实例化], [不能], [不能],
      [抽象方法], [可有], [可有（默认 public abstract）],
      [属性/字段], [可有实例变量], [仅有常量（public static final）],
      [构造方法], [可以有], [*不能有*],
      [静态方法], [可以有], [Java 8+ 可以有],
      [方法体], [可以有普通方法], [Java 8+ 可用 `default` 含方法体],
      [实现], [单继承 (extends)], [多实现 (implements)],
    ),
    caption: [抽象类与接口核心对比],
  )
]

#property[为什么有了抽象类还需要接口？][
  1. *多继承问题*：Java 单继承限制下，类可实现多个接口。
  2. *跨类型共性行为*：不同类型的类可以共享同一接口（如 `Flyable`）。
]

== 4. 多态 (Polymorphism)
同一个行为具有多种表现形态（一个接口，多个实现）。

#property[实现条件][
多态必须同时满足：
+ 有继承 / 实现
+ 有方法重写
+ 父类引用指向子类对象

]
#property[重写 (Override) vs 重载 (Overload)][
  - *重写*：方法名、参数完全一致，发生在子类对父类。
  - *重载*：方法名同，参数不同，发生在同一个类。
]

#example[多态实例][
  ```java
  Person p = new Student(); 
  p.eat(); // 运行时根据对象实际类型（Student）调用对应的方法
  ```
]

== 5. 静态成员 (static) 与 变量作用域
#property[变量分类][
  - *局部变量*：定义在方法/块中。
  - *成员变量*：定义在类中。
  - *静态变量*：由 `static` 修饰，类加载时初始化，全局共享。
]

#property[static 关键字限制][
  - *静态方法*：不能直接访问非静态成员（无 `this`）。
  - *静态代码块*：类加载时执行且仅一次。
  - *构造方法*：不可被 `static` 修饰。
]

== 6. 异常继承框架与自定义异常
#definition[异常分类][
  - *Checked* (如 `IOException`): 编译时必须处理。
  - *Runtime* (如 `NullPointerException`): 编译时可忽略。
  - *Error* (如 `StackOverflowError`): 无法恢复的严重问题。
]
#property[自定义异常][
  通常继承自 `Exception` 或 `RuntimeException`，通过 `super(msg)` 传递错误信息。
]

#problemset[
  #exercise[当父类和子类存在同名属性时，如何分别访问它们？]
  #solution[`this.变量名` 访问子类，`super.变量名` 访问父类。]
  #exercise[Java 的构造方法返回值是 `void` 吗？]
  #solution[不，构造方法没有任何返回值，也不使用 `void` 关键字。]
  #exam[2022年 选择][
    下面关于类的继承的叙述中，正确的是：
    #choices(
      [子类不能继承父类的私有属性],
      [子类只能继承父类的属性，不能继承父类的方法],
      [JAVA 中可以直接用 extends 实现多继承],
      [JAVA 中的异常是独立的，并没有继承体系],
    )
  ]
  #solution[A。Java 中，父类的private（私有）属性和方法，子类无法直接继承、访问，这是封装性的体现。]
  #exam[2024年 选择][
    给定接口 `Face { int counter = 40; }`，类 `Test implements Face { private static int counter = 0; }`，在 `main` 中执行 `System.out.println(counter + 1);` 输出：
    #choices( [40], [41], [0], [1] )
  ]
  #solution[D (1)。类Test中自己定义了同名变量private static int counter = 0，此时类自身的变量会覆盖接口中的同名常量]
  #exam[2025年 选择][
    下面代码 
    ```java
    interface IImpl { int counter = 20; }
    class Program implements IImpl { private int counter = 0; }
    ```
    在 `main` 中输出 `counter + 1` 结果：
    #choices( [20], [21], [0], [1] )
  ]
  #solution[编译错误。非静态变量无法在静态方法中引用。]
  #exam[2024年 判断][Java 中，一个接口可以继承多个接口。]
  #solution[正确。]
  #exam[2025年 综合][阅读以下代码，完成(1)~(3)问题。（4分）
    ```java
    class Person {
        String name;
        int age;
        public Person(String name, int age) {
            this.name = name;
            this.age = age;
        }
    }
    class Student extends Person {
        String school;
        public Student(String name, int age, String school) {
            super(name, age);
            this.school = school;
        }
    }
    abstract class Animal { abstract void eat(); }
    interface Run { void run(); }
    class Dog extends Animal implements Run {
        @Override
        public void eat() { System.out.println("小狗吃骨头"); }
        @Override
        public void run() { System.out.println("小狗奔跑"); }
    }
    public class Test {
        public static void main(String[] args) {
            Student st = new Student("小王", 20, "哈工深");
            Dog dog = new Dog();
            System.out.print("同学来自" + st.school + "名字叫" + st.name
                + "今年" + st.age + "岁");
        }
    }
    ```
    (1) 构造方法中使用 `super` 的作用是什么？（1分）\ #h(2em)
    (2) 语句 `Animal animal = new Animal();` 正确吗？为什么？（2分） \ #h(2em)
    (3) `Dog` 类继承 `Animal` 类并实现接口 `Run`，这是否违反 Java 标准？（1分）]
  #solution[
     #h(2em) (1) `super(name, age)` 调用父类 `Person` 的构造方法，传入参数以完成父类部分的初始化（`name` 和 `age` 赋值）。 \ #h(2em)
    (2) 不正确。`Animal` 是抽象类（用 `abstract` 修饰），不能被实例化（`new`），只能被继承。 \ #h(2em)
    (3) 不违反。Java 允许一个类继承一个类（单继承）的同时实现多个接口，`Dog extends Animal implements Run` 完全合法。
  ]
]
#pagebreak(weak: true)
= 常用设计模式
== 设计原则
#property[单一职责原则 (SRP)][一个类只负责一项职责，引起类变化的原因应只有一个。]
#property[开闭原则 (OCP)][*软件实体应对扩展开放，对修改关闭*。主要手段是使用抽象类和接口。]
#property[里氏替换原则 (LSP)][所有引用基类的地方必须能透明地使用其子类的对象。]
#property[依赖倒置原则 (DIP)][高层模块不应依赖低层模块，而应依赖其抽象。]
#property[迪米特法则 (LoD)][一个软件实体应尽可能少地与其他实体发生相互作用。]
#property[合成复用原则 (CARP)][尽量使用组合/聚合，而非继承来达到复用目的（白盒 vs 黑盒复用）。]

== 创建型模式
#theorem[单例模式 (Singleton)][
  保证一个类仅有一个实例，并提供全局访问点。
  - *访问修饰符规划*：
    - *属性*：`private static`。`private` 保证封装，`static` 保证全局唯一。
    - *构造方法*：`private`。防止外部类实例化。
    - *访问方法*：`public static`。`public` 供外部访问，`static` 允许不创建对象即可调用。
  - *实现方式*：
    - *饿汉式*：类装载时即创建。线程安全，但可能浪费资源。
    - *懒汉式*：第一次使用时创建。延迟加载，但默认非线程安全。
    - *线程安全懒汉式*：常用双重检查锁 (DCL) + `volatile`。增加开销，但保证安全。
]
#example[
  *饿汉式 (Eager)* 示例：
  ```java
  public final class EagerSingleton {
    private static final EagerSingleton INSTANCE = new EagerSingleton();
    private EagerSingleton() {}
    public static EagerSingleton getInstance() { return INSTANCE; }
  }
  ```
]
#example[
  *懒汉式 (Lazy, 非线程安全)* 示例：
  ```java
  public final class LazySingleton {
    private static LazySingleton instance;
    private LazySingleton() {}
    public static LazySingleton getInstance() {
      if (instance == null) {
        instance = new LazySingleton();
      }
      return instance;
    }
  }
  ```
]
#example[
  *线程安全懒汉式 (DCL)* 示例：
  ```java
  public final class SafeLazySingleton {
    private static volatile SafeLazySingleton instance;
    private SafeLazySingleton() {}
    public static SafeLazySingleton getInstance() {
      if (instance == null) {
        synchronized (SafeLazySingleton.class) {
          if (instance == null) {
            instance = new SafeLazySingleton();
          }
        }
      }
      return instance;
    }
  }
  ```
]


#definition[工厂模式 (Factory)][
  将对象的创建逻辑封装在工厂类中，客户端无需知道具体的类名。
  - 简单工厂、工厂方法、抽象工厂。
]
#note[简单工厂模式 *不*属于*设计模式*，它是一种编程实践，工厂方法和抽象工厂才是经典设计模式。]
#example[简单工厂][
   背景：绘图工具根据用户输入创建不同图形。
  ```java
  interface Shape { void draw(); }
  class Circle implements Shape { public void draw() {} }
  class Rect implements Shape { public void draw() {} }

  class ShapeFactory {
    public static Shape create(String type) {
      return switch (type) {
        case "circle" -> new Circle();
        case "rect" -> new Rect();
        default -> throw new IllegalArgumentException();
      };
    }
  }

  Shape shape = ShapeFactory.create("circle");
  shape.draw();
  ```
]
#example[工厂方法][
  背景：文档系统支持不同格式导出，各格式由子类决定如何创建。
  ```java
  interface Document { void export(); }
  class WordDocument implements Document { public void export() {} }
  class PdfDocument implements Document { public void export() {} }

  abstract class DocumentCreator {
    public abstract Document create();
    public void export() { create().export(); }
  }

  class WordCreator extends DocumentCreator {
    public Document create() { return new WordDocument(); }
  }

  class PdfCreator extends DocumentCreator {
    public Document create() { return new PdfDocument(); }
  }
  ```
]
#example[
  *抽象工厂* 案例背景：跨平台 GUI 需要成套组件（Button + TextBox）保持风格一致。
  ```java
  interface Button {}
  interface TextBox {}
  interface GUIFactory {
    Button createButton();
    TextBox createTextBox();
  }

  class WinButton implements Button {}
  class WinTextBox implements TextBox {}
  class WinFactory implements GUIFactory {
    public Button createButton() { return new WinButton(); }
    public TextBox createTextBox() { return new WinTextBox(); }
  }

  class MacButton implements Button {}
  class MacTextBox implements TextBox {}
  class MacFactory implements GUIFactory {
    public Button createButton() { return new MacButton(); }
    public TextBox createTextBox() { return new MacTextBox(); }
  }
  ```
]

#theorem[建造者模式 (Builder)][
  将一个复杂对象的构建与其表示分离，使得同样的构建过程可以创建不同的表示。适用于构造函数参数过多且可选的情况（Fluent API）。
]

#example[
  *StringBuilder 风格代码演示*：
  ```java
  NutritionFacts cocaCola = new NutritionFacts.Builder(240, 8)
      .calories(100).sodium(35).carbohydrate(27).build();
  ```
]

#definition[工厂三兄弟对比 (高频考点)][
  - *简单工厂*：一个工厂创建所有产品。满足“单一职责”，但不满足“开闭原则”（增加产品需改源码）。
  - *工厂方法*：每个产品由专门的工厂子类创建。既满足“单一职责”又满足“开闭原则”。
    - *优点*：横向扩展（增加新工厂）方便。
    - *缺点*：纵向扩展（在已有工厂内加产品类型）困难。
  - *抽象工厂*：创建一系列相关或相互依赖的对象（产品族）。
    - *优点*：增加产品族容易。
    - *缺点*：增加产品等级（在接口中加方法）困难。
]

#definition[设计模式分类][
  - *创建型 (Creational)*：关注对象创建过程。如：单例、工厂（全系列）、建造者、原型。
  - *结构型 (Structural)*：关注类或对象的组合。如：装饰、代理、适配器。
  - *行为型 (Behavioral)*：关注对象间的通信与职责划分。如：观察者、策略、模板方法。
]

== 结构型模式
#theorem[适配器模式 (Adapter)][
  将一个类的接口转换成客户希望的另外一个接口。例如：`InputStreamReader` 是字节流到字符流的桥梁。
]
#theorem[装饰模式 (Decorator)][
  动态地给一个对象添加一些额外的职责（增量功能）。比继承更灵活。\
  [经典应用] \
  #h(2em)Java I/O 流的包装：`new BufferedReader(new FileReader("..."))`。
]
#theorem[代理模式 (Proxy)][
  为其他对象提供一种代理以控制对这个对象的访问。
  - *静态代理*：显式编写代理类。
  - *动态代理*：运行时通过反射/字节码技术生成（JDK Proxy, CGLIB）。
]

== 行为型模式
#theorem[观察者模式 (Observer)][
  定义对象间一对多的依赖关系，当一个对象状态改变时，所有依赖者都会收到通知并更新。
]
#theorem[模板方法模式 (Template Method)][
  在一个方法中定义一个算法骨架，而将一些步骤延迟到子类中实现。例如钩子（Hook）方法。
]

#problemset[
  #exercise[在单例模式中，为什么属性要用 `static`？为什么构造方法要用 `private`？]
  #solution[属性用 `static` 是为了确保该实例在全局范围内唯一且属于类；构造方法用 `private` 是为了防止外部代码通过 `new` 关键字创建新的实例，从而破坏单例性。]
  #exercise[简单工厂模式和工厂方法模式是否都满足“开闭原则”？]
  #solution[简单工厂不满足（增加产品需要修改工厂类源码）；工厂方法满足（增加产品只需增加对应的工厂子类）。]
  #exercise[抽象工厂模式在面对“增加产品族”和“增加产品类型”时，哪个更方便？]
  #solution[增加产品族更方便（只需增加具体的工厂实现类）；增加产品类型更困难（需要修改抽象工厂接口及其所有子类）。]
]

#definition[设计模式在实际框架中的应用][
  - *Spring Framework*：BeanFactory 是“工厂模式”，AOP 核心是“代理模式”，监听器（Listener）是“观察者模式”。
  - *Java I/O*：FilterInputStream 等通过“装饰模式”扩展功能。
  - *Servlet API*：FilterChain 是“职责链模式”。
  - *JDBC*：DriverManager.getConnection 是“简单工厂/策略”。
]
== 集合与策略、迭代器模式

=== 集合类概述 (Collections Overview)
集合是对象的容器，定义了对多个对象进行操作的常用方法，位于 `java.util` 包中。

#property[与数组的区别][
  - *长度*：数组长度固定，集合长度可变。
  - *内容*：数组可存放基本类型和对象引用；集合只能存放对象引用。
  - *存储能力*：两者都可以存储不同类型的数据。
    - *实现方式*：数组需声明为 `Object[]`。由于 Java 中所有类都继承自 `Object`，该数组可以存储任意对象引用（基本类型会自动装箱）。
    - *ArrayList*：若不使用泛型或使用 `ArrayList<Object>`，由于其底层基于 `Object[]` 实现，也可存储不同类型的对象。
]

#definition[集合分类][
  - *单列集合 (Collection)*：存储单一对象。
    - *List*：有序、有下标、元素可重复。
    - *Set*：无序、无下标、元素不可重复。
  - *双列集合 (Map)*：存储键值对 (key-value) 映射，键不可重复，值可重复。
]

=== 具体集合实现
#property[ArrayList][底层为动态数组，查询快（$O(1)$）、增删慢。]
#property[LinkedList][底层为双向链表，查询慢、增删快（开头/结尾）。]
#property[HashSet][底层哈希表，元素唯一，无序。通过 `add()` 添加。]
#property[HashMap][存储键值对。使用 `put(key, value)` 和 `get(key)` 操作。]

#example[
  *HashMap 迭代示例*：
  ```java
  HashMap<Integer, String> sites = new HashMap<>();
  sites.put(1, "Google");
  sites.put(2, "Apple");
  // 迭代 Key
  for (Integer i : sites.keySet()) {
      System.out.println("key: " + i + " value: " + sites.get(i));
  }
  ```
]

=== 策略模式 (Strategy Pattern)
当存在多种相似算法时，用策略封装算法族并使其可互换，避免复杂的多重 if-else。

#property[核心角色][
  - *抽象策略 (Strategy)*：通常为接口或抽象类，定义算法接口。
  - *具体策略 (ConcreteStrategy)*：实现具体的算法方案。
  - *上下文 (Context)*：持有一个 Strategy 引用，屏蔽外部对策略细节的直接访问。
]

#example[
  *会员打折案例*：
  ```java
  // 抽象策略
  interface MemberStrategy { double calcPrice(double price); }
  // 具体策略
  class AdvancedMember implements MemberStrategy {
      public double calcPrice(double p) { return p * 0.8; } 
  }
  // 上下文
  class Network {
      private MemberStrategy strategy;
      public Network(MemberStrategy s) { this.strategy = s; }
      public double quote(double p) { return strategy.calcPrice(p); }
  }
  ```
]

#property[策略模式要点][
  1. *算法平等*：各个策略地位平等，可无感知替换。
  2. *运行时唯一*：同一时刻只能使用一个具体策略。
  3. *Context 的作用*：屏蔽高层模块对策略（算法）的直接访问，减少耦合，封装变化。
  4. *分类*：属于*行为型*模式，关注行为的选择。
  5. *与工厂模式区别*：工厂模式关注*对象的创建*；策略模式关注*行为的选择*（如何执行算法）。两者常结合使用：工厂负责创建具体策略，策略负责执行逻辑。
]

=== 迭代器模式 (Iterator Pattern)
提供一种方法顺序访问一个聚合对象中各个元素，而又无须暴露该对象的内部表示。

#property[主要操作][
  - `next()`：返回下一个元素并移动指针。
  - `hasNext()`：检查是否还有剩余元素。
  - `remove()`：删除最近返回的元素。
]

#example[
  *安全删除元素*：
  ```java
  Iterator<Integer> it = numbers.iterator();
  while (it.hasNext()) {
      if (it.next() < 10) it.remove(); // 官方推荐的带遍历删除方式
  }
  ```
]

=== 模板方法模式 (Template Pattern)
#property[核心思想][
  定义一个操作中的算法骨架，而将一些步骤延迟到子类中。模板方法使得子类可以不改变一个算法的结构即可重定义该算法的某些特定步骤。
]

#property[核心角色][
  - *抽象类 (AbstractClass)*：定义并实现一个模板方法。它给出了一个顶级逻辑框架，而逻辑框架中的某些步骤（基本方法）可以是抽象的，也可以是具体的。
  - *具体子类 (ConcreteClass)*：实现父类所定义的抽象方法以完成算法中与特定子类相关的步骤。
]

#property[方法分类][
  - *模板方法 (Template Method)*：定义在抽象类中，组合多个基本方法形成算法框架。通常声明为 `final` 以防止子类破坏算法流程。
  - *基本方法 (Basic Method)*：
    - *抽象方法 (Abstract Method)*：子类必须实现的特定逻辑。
    - *钩子方法 (Hook Method)*：父类提供默认或空实现，子类按需重写以干预流程。
]

#property[应考重点][
  - *优点*：封装不变部分，扩展可变部分（OCP）；提取公共代码便于维护；由父类控制流程，子类仅负责具体实现。
  - *多态的应用*：通过抽象类引用指向具体子类对象，利用*动态绑定*机制在运行时调用具体子类重写的方法。
]

#example[数据入库场景][
  ```java
  abstract class DataImporter {
      // 模板方法：定义固定算法骨架
      public final void importData() {
          load();         // 步骤1：加载
          validate();     // 步骤2：校验（通用）
          convert();      // 步骤3：转换
          write();        // 步骤4：写入（通用）
      }
      abstract void load();    // 抽象方法：由子类实现
      abstract void convert(); // 抽象方法：由子类实现
      
      void validate() { System.out.println("通用校验逻辑"); }
      void write() { System.out.println("通用写入数据库"); }
  }

  class MySqlImporter extends DataImporter {
      void load() { System.out.println("从 MySQL 读取数据"); }
      void convert() { System.out.println("转换为标准 JSON 格式"); }
  }
  ```
]

== UML 类图规范

#property[可见性符号 (Visibility)][
  - `+`：*public* (公有) - 全局可访问。
  - `-`：*private* (私有) - 仅限本类内部访问。
  - `#`：*protected* (受保护) - 本类、子类或同包可访问。
  - `~`：*package* (包) - 仅限同一个包内访问。
]

#property[类间关系总结 (Relationships)][
  #table(
    columns: (2fr, 2fr, 5fr),
    stroke: 0.5pt + gray,
    align: (center + horizon, center + horizon, left + horizon),
    inset: 0.6em,
    fill: (x, y) => if y == 0 { blue.lighten(90%) } else { none },
    [*关系类型*], [*图形符号*], [*语义与 Java 关联*],
    [泛化 (Inheritance)], [实线 + 空心三角], [继承关系 (`extends`)。子类指向父类。],
    [实现 (Realization)], [虚线 + 空心三角], [接口实现 (`implements`)。实现类指向接口。],
    [组合 (Composition)], [实线 + 实心菱形], [强整体-部分关系。整体消失则部分必消失。],
    [聚合 (Aggregation)], [实线 + 空心菱形], [弱整体-部分关系。部分可独立于整体存活。],
    [关联 (Association)], [实线 + 普通箭头], [类 A 持有类 B 的成员变量。长期且稳定的关系。],
    [依赖 (Dependency)], [虚线 + 普通箭头], [类 A 在方法中使用类 B (参数/局部变量)。短暂关系。],
  )
]

下面是一个参考(下图中不能画实线)
#image("../assets/observer_pattern_uml.svg", width: 80%)

#problemset[
  #exercise[在 LinkedList 中间插入元素是否一定比 ArrayList 快？请分析原因。]
  #exercise[为什么策略模式建议在 `Context` 中调用策略方法，而不是让 `Client` 直接调用？]
  #solution[为了屏蔽高层模块对具体算法细节的访问，封装可能存在的变化，降低耦合度。]
  #exercise[数组和集合是否都能装载不同类型的数据？]
  #solution[可以。数组只需声明为 `Object[]`；集合由于只能存储对象引用，默认即可存储不同类型的对象（虽通常推荐泛型约束）。]
  #exercise[策略模式是创建型还是行为型模式？为什么？]
  #solution[行为型。因为它关注的是算法行为的定义与选择，而非对象的创建逻辑。]
  #exam[2022年 选择][
    在面向对象的软件开发过程中，采用设计模式（）。
    #choices(
      [允许在非面向对象程序设计语言中使用面向对象概念],
      [以复用成功的设计 和 体系结构],
      [以减少设计过程创建的实例对象的个数],
      [以保证程序的运行速度达到最优],
    )
  ]
  #solution[B。设计模式的核心目的是复用经过验证的成功设计和体系结构，提高开发效率和代码可维护性。]
  #exam[2022年 选择][
    以下关于 Set 和 List 的说法，正确的是：
    #choices(
      [Set 中的元素是可以重复的],
      [List 中的元素是无序的],
      [HashSet 中可以使用 for-each 来迭代访问其中的元素],
      [List 中的元素是不可以重复],
    )
  ]
  #solution[C。`HashSet` 可以使用 `for-each` 迭代。A 错，Set 元素不可重复；B 错，List 有序（有下标）；D 错，List 元素可重复。]
  #exam[2022年 选择][
    ```java
    List<String> list = new ArrayList<>();
    list.add("test"); list.add("red"); 
    list.add(100);
    ``` 输出 list.size() 的结果：
    #choices(
      [2],
      [3],
      [编译错误],
      [运行时异常],
    )
  ]
  #solution[C（编译错误）。`List<String>` 使用泛型约束只能添加 String 类型，`list.add(100)` 添加 int 不匹配，编译期报错。]
  #exam[2024年 选择][
    ```java
    LinkedList list = new LinkedList(); 
    list.add(true); list.add("red"); 
    list.add(100);
    ``` 输出结果：
    #choices(
      [输出 3],
      [编译错误],
      [运行时异常],
      [以上都错误],
    )
  ]
  #solution[A（输出 3）。因为没有使用泛型 `<String>` 约束，`LinkedList` 默认可以添加任意 `Object` 类型（自动装箱），正常运行。]
  #exam[2024年 选择][
    下列不适用于 LinkedList 进行的数据操作的是：
    #choices(
      [增加],
      [删除],
      [查询],
      [插入],
    )
  ]
  #solution[C。`LinkedList` 底层为双向链表，查询需遍历（$O(n)$），效率低；而增删插入在头尾操作效率高（$O(1)$）。]
  #exam[2024年 选择][
    以下数据类型没有实现 Collection 接口的是：
    #choices(
      [ArrayList],
      [LinkedList],
      [HashSet],
      [HashMap],
    )
  ]
  #solution[D。`HashMap` 属于 `Map` 接口体系（双列集合），不实现 `Collection` 接口。]
  #exam[2025年 选择][
    下面对于 HashSet 的理解，正确的是：
    #choices(
      [元素有序、可重复],
      [元素无序、不重复],
      [元素有序、无索引、可重复],
      [线程安全],
    )
  ]
  #solution[B。`HashSet` 底层是哈希表，元素无序且不可重复。C 描述的是 `LinkedList` 特征的一部分但元素重复性错误。]
  #exam[2022年 判断][一个类承担的职责越多，越容易复用，被复用的可能性越大。]
  #solution[错误。职责越多的类耦合度越高，复用难度越大。应遵循"单一职责原则"(SRP)，一个类只负责一项职责。]
  #exam[2024年 判断][简单工厂模式属于传统经典的 23 种设计模式之一，它把创建对象的工作交托给其子类实现。]
  #solution[错误。简单工厂模式*不属于* GoF 23 种设计模式；而且"把创建对象的工作交托给其子类实现"描述的是*工厂方法模式*，并非简单工厂。]
  #exam[2024年 判断][工厂模式是结构型模式。]
  #solution[错误。工厂模式属于*创建型*模式。]
  #exam[2025年 判断][工厂模式是一种行为型模式。]
  #solution[错误。工厂模式是*创建型*模式。]
  #exam[2025年 判断][迭代器模式的目的是为了提高集合的存储效率，而不是提供一种统一的方法顺序访问一个聚合对象中的各个元素。]
  #solution[错误。迭代器模式的目的恰恰是提供统一的方式顺序访问聚合对象中各个元素，并隐藏内部结构。与存储效率无关。]
  #exam[2022年 填空][按照目的来划分，设计模式可以分为（ ）模式、结构型模式和行为型模式。]
  #solution[创建型。]
  #exam[2024年 填空][策略模式的三个角色分别是：抽象策略角色、#underline("    ") 和 #underline("    ")。]
  #solution[具体策略角色 (ConcreteStrategy)、上下文角色 (Context)。]
  #exam[2022年 简答][请分别简要描述 ArrayList 和 LinkedList 适合的使用场景。]
  #solution[`ArrayList` 底层为动态数组，查询快（$O(1)$），适合频繁随机访问的场景；`LinkedList` 底层为双向链表，增删快（头部/尾部 $O(1)$），适合频繁增删、不需要随机访问的场景。]
  #exam[2022年 简答][请简要描述简单工厂和工厂模式的区别。]
  #solution[简单工厂：一个工厂类创建所有产品，不符合"开闭原则"（增加产品需修改工厂源码）。工厂方法：每个产品对应一个工厂子类，符合"开闭原则"（增加产品只需新增一个工厂子类），将对象的创建延迟到子类中。]
  #exam[2024年 简答][请分别描述集合与数组的差别，以及常见集合类型有哪些。]
  #solution[
    差别：数组长度固定，集合长度可变；数组可存基本类型和对象，集合只能存对象引用。常见集合：`List`（ArrayList、LinkedList）、`Set`（HashSet、TreeSet）、`Map`（HashMap、TreeMap）。
  ]
  #exam[2022年 综合][策略模式：现在需要设计一个简单的计算器功能，只考虑加法和减法，拟采用策略模式实现。(共10分)
    (1) 请描述策略模式的目的。（2分）
    (2) 给定一个 `Strategy` 接口如下，请用接口实现的方法写出加法和减法类及其计算操作。（4分）
    ```java
    public interface Strategy {
        double Computing(double num1, double num2);
    }
    ```
    (3) 为使用策略模式，我们接着定义 `Context` 类如下，请判断下面程序输出的结果分别为（ ）和（ ）。（2分）
    ```java
    public class Context {
        private Strategy strategy;
        public Context(Strategy strategy) { this.strategy = strategy; }
        public double ExecuteStrategy(double num1, double num2) {
            return strategy.Computing(num1, num2);
        }
    }
    public class StrategyPatternDemo {
        public static void main(String[] args) {
            Context context = new Context(new OperationAdd());
            System.out.println(context.ExecuteStrategy(10.0, 1.1));
            context = new Context(new OperationSubtract());
            System.out.println(context.ExecuteStrategy(10.0, 1.1));
        }
    }
    ```
    (4) 结合多态的概念，请讨论上述策略模式代码实现中哪些地方使用了多态？（2分）]
  #solution[
    (1) 策略模式定义一系列算法，将每个算法封装起来并使它们可互换，让算法独立于使用它的客户端而变化。\ #h(2em)
    (2) 代码实现：
    ```java
    public class OperationAdd implements Strategy {
        public double Computing(double num1, double num2) { return num1 + num2; }
    }
    public class OperationSubtract implements Strategy {
        public double Computing(double num1, double num2) { return num1 - num2; }
    }
    ```
    (3) 输出结果为 *11.1* 和 *8.9*。（10.0 + 1.1 = 11.1；10.0 - 1.1 = 8.9）\ #h(2em)
    (4) 多态体现在：① `Context` 中持有父类引用 `private Strategy strategy;`；② 构造方法 `new Context(new OperationAdd())` 传入子类对象——父类引用指向子类对象；③ `strategy.Computing(...)` 运行时动态绑定到具体子类的 `Computing` 实现。这三处都体现了多态的三个必要条件。
  ]
  #exam[2022年 综合][单例模式（共12分）
    (1) 单例模式的目的是什么？（1分）
    (2) 单例模式实现方式之一的饿汉式用代码是如何实现的呢？饿汉式的优缺点分别是什么呢？（6分）
    (3) 请完成下面代码的填空，利用反射破坏饿汉式的单例。（3分）
    ```java
    public class SingletonTest {
        public static void main(String[] args) {
            Class<?> objectClass = ___________;
            Constructor<?> constructor = ___________;
            constructor.setAccessible(true);
            Singleton newInstance = ___________;
        }
    }
    ```
    (4) 基于(3)中的代码，如何修改饿汉式使其可以抵御破坏呢？（2分）]
  #solution[
    (1) 保证一个类仅有一个实例，并提供全局访问点。\ #h(2em)
    (2) 饿汉式实现：
    ```java
    public final class Singleton {
        private static final Singleton INSTANCE = new Singleton();
        private Singleton() {}
        public static Singleton getInstance() { return INSTANCE; }
    }
    ```
    优点：线程安全（类加载机制保证单例唯一）；实现简单。缺点：无论是否使用都会创建实例，可能浪费内存资源。\ #h(2em)
    (3) ```java
      public class SingletonTest {
        public static void main() {
          Class<?> objectClass = Singleton.class;
          Constructor<?> constructor = objectClass.getDeclaredConstructor();
          constructor.setAccessible(true);
          Singleton newInstance = (Singleton) constructor.newInstance();
        }
      }
    ```
    (4) 在私有构造方法中加入防御代码：
    ```java
    private Singleton() {
        if (INSTANCE != null) {
          throw new RuntimeException("单例已存在，禁止反射创建新实例");
        }
    }
    ```
  ]
  #exam[2024年 综合][
    (1) 单例模式有一种饿汉式的实现，请把代码补充完整。（提示：包括成员变量、构造方法、部分方法等）（5分）
    ```java
    public class Singleton{
        // 请补全
    }
    ```
    (2) 请叙述饿汉式的单例模式有何优缺点。（2分）
    (3) 单例模式是否可以抵御反射？如果不能，请完善以下代码。（3分）
    ```java
    public class SingletonTest {
        public static void main(String[] args) {
            Class<?> objectClass = Singleton.class;
            Constructor<?> constructor =                      ;
                                                ;
            Singleton newInstance =                        ;
        }
    }
    ```]
  #solution[
    (1) 补全代码：
    ```java
    public class Singleton {
        private static final Singleton INSTANCE = new Singleton();
        private Singleton() {}
        public static Singleton getInstance() { return INSTANCE; }
    }
    ```
    (2) 优点：线程安全，类加载时即创建，实现简单；缺点：非延迟加载，不论是否使用都会创建实例，可能浪费内存。\ #h(2em)

    (3) 不能抵御反射。完善代码：
    ```java
    constructor = objectClass.getDeclaredConstructor();
    constructor.setAccessible(true);
    newInstance = (Singleton) constructor.newInstance();
    ```
  ]
  #exam[2025年 综合][单例模式（8分）
    (1) 请实现饿汉式单例的代码。（提示：包含成员字段、构造方法、成员方法等。）（2分）
    ```java
    public class Singleton {
        // 请补全
    }
    ```
    (2) 饿汉式单例的优缺点都有哪些？（2分）
    (3) 饿汉式单例能否抵抗反射？（1分）完善下面的代码。（3分）
    ```java
    public class SingletonTest {
        public static void main(String[] args) {
            Class<?> objectClass = Singleton.class;
            Constructor<?> constructor =                  ;
                                                ;
            Singleton newInstance =                   ;
        }
    }
    ```]
  #solution[
    (1) 代码同 2024 年(1)。
    (2) 同 2024 年(2)。
    (3) 不能抵抗反射。完善代码同 2024 年(3)，防御方法为在私有构造方法中检查 `INSTANCE != null` 并抛异常。
  ]

  #exam[2024年 综合][策略模式：一款打车软件为用户提供了三种打车策略：(1)拼车；(2)专车；(3)快车。设专车为原价，拼车的价格是原价的二分之一，而快车的价格是原价的两倍。（10分） \
    (1) 请描述策略模式的目的。（2分）\
    (2) 以下是打车策略的接口代码，请使用接口实现三种打车策略及其计算操作。（每个类2分，共6分）
    ```java
    public interface PriceStrategy {
        double Computing(Double originalPrice);
    }
    // 待实现：
    // public class PcStrategy ... { ... }    // 拼车：半价
    // public class ZcStrategy ... { ... }    // 专车：原价
    // public class KcStrategy ... { ... }    // 快车：两倍
    ```
    (3) 结合多态的概念，讨论代码实际运行中使用了多态的地方。（2分）]
  #solution[
    (1) 策略模式定义一系列算法，封装每个算法并使它们可互换，让算法变化独立于使用算法的客户端。
    (2) 实现代码：
    ```java
    public class PcStrategy implements PriceStrategy {
        public double Computing(Double originalPrice) { return originalPrice * 0.5; }
    }
    public class ZcStrategy implements PriceStrategy {
        public double Computing(Double originalPrice) { return originalPrice; }
    }
    public class KcStrategy implements PriceStrategy {
        public double Computing(Double originalPrice) { return originalPrice * 2; }
    }
    ```
    (3) 多态体现：客户端持有 `PriceStrategy` 接口引用，运行时传入不同的具体策略对象（`new PcStrategy()` 等），调用 `Computing()` 时动态绑定到对应子类实现——父类引用指向子类对象 + 方法重写 = 多态。
  ]
  #exam[2025年 综合][策略模式：用策略模式实现快递运费的计算功能。（10分）\
    寄标准快递（BzStrategy）的运费是货物价格的 5%（最低 10 块）；寄快递（KdStrategy）的基础运费是 5 块加上货物价格的 8%；寄特快快递（TkStrategy）的运费固定为 50 块。策略接口的代码已给出。
    ```java
    public interface Strategy {
        double Computing(double originalPrice);
    }
    ```
    (1) 策略模式的目的是什么？（2分）
    (2) 通过以上接口实现三种快递方式的运费计算。（每个2分，共6分）
    (3) 结合多态的概念，讨论在上述策略模式代码实现中，哪些地方使用了多态？（2分）]
  #solution[
    (1) 策略模式定义一系列算法，将每个算法封装起来并使它们可互换，让算法独立于使用它的客户端而变化。
    (2) 实现代码：
    ```java
    public class BzStrategy implements Strategy {
        public double Computing(double originalPrice) {
            double fee = originalPrice * 0.05;
            return fee < 10 ? 10 : fee;  // 最低 10 块
        }
    }
    public class KdStrategy implements Strategy {
        public double Computing(double originalPrice) {
            return 5 + originalPrice * 0.08;
        }
    }
    public class TkStrategy implements Strategy {
        public double Computing(double originalPrice) { return 50; }
    }
    ```
    (3) 同 2024 年策略模式题(3)：接口引用 + 运行时绑定具体策略 = 多态。
  ]
  #exam[2022/2025年 综合][观察者模式：某公司设计一套智能家居系统，功能要求如下：如果传感器（Sensor）检测到室外温度升高到一定温度，会将信号传递给响应设备，包括空调（AirConditioner）自动开启、窗帘（Curtain）自动闭合。为了支持将来引入新类型的相应设备，采用观察者模式设计该系统。（8分）\
    (1) 请简述什么是观察者设计模式。（2分）\
    (2) 讨论其优缺点。（2分） \
    (3) 画出该系统的 UML 类图。（4分）]
  #solution[
    (1) 观察者模式定义对象间一对多依赖关系，当一个对象（Subject）状态改变时，所有依赖者（Observer）都会收到通知并自动更新。本系统中 Sensor 作为 Subject，AirConditioner 和 Curtain 作为 Observer。\
    (2) 优点：Subject 和 Observer 松耦合，可随时增删观察者，符合"开闭原则"。缺点：若观察者过多，通知耗时较长；可能出现循环依赖；观察者无法知道被观察者如何变化。\
    (3) UML 类图：
    
    #image("../assets/observer_pattern_uml.svg", width: 80%)
  ]
  #exam[2025年 综合][模板模式：在某系统中，存在一项"数据入库"任务。无论处理哪种类型的数据，都必须经过以下四个固定阶段：[1] 数据加载 [2] 数据检验完整度 [3] 格式转化 [4] 数据写入。其中：阶段 1 和阶段 3 与输入的数据类型有关，因此需要对不同数据源分别实现；而其他阶段则是通用逻辑。（10分）\
    (1) 什么是模板模式？（2分）\
    (2) 联系多态，说说模板模式是如何实现不同类型数据的处理。（2分）\
    (3) 画出模板模式的 UML 图（名称为 AbstractClass 以及 ConcreteClass）。（4分）\
    (4) 模板模式的优点有哪些？（2分）]
  #solution[
    (1) 模板模式定义一个算法的骨架（固定步骤），将某些步骤延迟到子类中实现，子类可重定义某些步骤而不改变算法结构。\
    (2) 通过抽象类定义模板方法（final，防止子类修改流程），其中可变步骤（加载和格式转化）声明为抽象方法；具体子类实现这些抽象方法。运行时父类引用指向子类对象（多态），调用模板方法时实际执行子类重写的步骤。\
    (3) UML 类图：
    
    #image("../assets/template_pattern_uml.svg", width: 80%)
    
    (4) 优点：封装不变部分，扩展可变部分（OCP）；提取公共代码便于维护；由父类控制流程，子类仅负责具体实现。
  ]

  #exam[2024年 综合][工厂模式：你需要设计一个汽车制造系统，完成汽车的生产和销售。汽车有很多种类（轿车、SUV、跑车等），请使用工厂模式设计系统。提示：汽车工厂（CarFactory）是抽象的接口，而具体的工厂（SedanFactory、SUVFactory、SportsCarFactory）是该接口的实现类。（10分）\
    (1) 请简述工厂模式的优缺点。（3分）\
    (2) 画出系统的 UML 类图。（7分）]
  #solution[
    (1) 工厂模式的优缺点：\
    #h(2em) *优点*：符合"开闭原则"（增加新产品只需增加对应工厂类）；将对象创建与使用解耦；使代码更灵活、可扩展；符合"单一职责原则"（工厂类专门负责创建）。\
    #h(2em) *缺点*：每增加一个产品都要增加对应的具体工厂类，类数量增多；增加了系统复杂度；当产品类型过多时，工厂类可能过多难以管理。
    
    (2) UML 类图：
    
    #image("../assets/car_factory_uml.svg", width: 100%)
    
    *类图说明*：
    - `<<interface>> CarFactory`：工厂接口，定义 `createCar(): Car`
    - 具体工厂类 `SedanFactory`、`SUVFactory`、`SportsCarFactory` 实现 `CarFactory` 接口
    - `<<interface>> Car`：产品接口，定义 `drive()`、`getInfo()` 等操作
    - 具体产品类 `Sedan`、`SUV`、`SportsCar` 实现 `Car` 接口
    - 各工厂类与对应产品类之间有生成（creates）虚线关系
    - 实线空心箭头表示"接口实现"关系
  ]
]
#pagebreak(weak: true)
= 软件测试与代码质量保障

#introduction[白盒测试][黑盒测试][逻辑覆盖][等价类/边界值][JUnit]

== 1. 白盒测试 (White Box)
基于程序的源代码，关注内部结构、逻辑和实现细节。又称*结构测试*或*逻辑驱动测试*。

#property[逻辑覆盖方法 (从弱到强)][
  - *语句覆盖*：每条可执行语句至少执行一次（最弱）。
  - *判定覆盖 (分支覆盖)*：每个判定的真/假分支至少运行一次。
  - *条件覆盖*：判定表达式中的每个简单条件的真/假情况至少运行一次。*注意：条件覆盖不一定满足判定覆盖*。
  - *判定-条件覆盖*：同时满足判定和条件覆盖。
  - *条件组合覆盖*：所有简单条件的各种取值组合情况至少执行一次。强度极高。
  - *路径覆盖*：每条可能的路径运行一次（最强，但常不可实现）。
]
#property[控制流程图 (CFG)][使用节点、判定节点、过程块表示程序逻辑结构的图形工具。]

== 2. 黑盒测试 (Black Box)
着眼于功能输出，不考虑内部实现细节。又称*功能测试*或*数据驱动测试*。

#property[等价类划分法][
  将输入域划分为*有效等价类*（验证功能）和*无效等价类*（测试容错性）。
  - *有效等价类*：建议设计一个用例尽可能多地覆盖有效等价类。*原因*：若测试通过，说明多个需求同时满足，提高效率。
  - *无效等价类*：建议每个用例只覆盖一个无效等价类。*原因*：若覆盖多个且失败，无法确定是哪个无效输入导致的。
]
#property[边界值分析][
  在边界及附近选择数据进行测试，因为缺陷常发生在输入域的边界上。
  - *多边界 vs 单边界*：单边界测试更有利于错误定位。
]
#property[场景法][
  以事件流为核心，模拟业务逻辑流程。
  - *基本流*：正常、正确的业务路径。
  - *备选流*：由于错误、异常或不同选择产生的偏离路径。
]

== 3. 单元测试与 JUnit
#property[定义][针对最小可测试单元（函数或类）进行的检查，通常由开发人员完成。]
#property[JUnit 框架注解][
  - `@Test`：标记测试方法。
  - `@BeforeEach`：每个测试前运行。
  - `@AfterEach`：每个测试后运行。
  - `assertEquals(expected, actual)`：断言结果。
]

== 4. 代码质量评价指标
1. *可维护性*：是否易于快速修改。
2. *可读性*：命名达意、注释详尽、逻辑清晰。
3. *可扩展性*：通过扩展（OCP）而非修改增加功能。
4. *简洁性*：遵循 *KISS 原则* (Keep It Simple, Stupid)。

#problemset[
  #exercise[当一个判定为 `if (a > 1 && b == 0)` 时，构造测试用例使其满足“条件覆盖”，但却不满足“判定覆盖”。]
  #exercise[为什么在黑盒测试中，一个测试用例只建议覆盖一个“无效等价类”？]
  #solution[为了能够明确地定位错误。如果一个测试用例包含多个无效等价类且运行失败，测试人员无法确定是哪一个无效输入导致了失败。]
  #exercise[条件组合覆盖、条件覆盖和判定/条件覆盖谁的覆盖度更强？为什么？]
  #solution[条件组合覆盖最强。条件覆盖不一定满足判定覆盖；而条件组合覆盖考虑了所有条件的真假组合情况。]
  #exercise[在黑盒测试的边界值分析方法中，多边界测试和单边界测试哪种能更好地帮助定位错误？]
  #solution[单边界测试。]
  #exam[2024年 选择][
    以下不属于常见的黑盒测试用例的设计方法是：
    #choices(
      [路径覆盖],
      [等价类划分],
      [边界值分析],
      [场景法],
    )
  ]
  #solution[A。路径覆盖属于*白盒测试*的逻辑覆盖方法，不是黑盒测试方法。]
  #exam[2025年 选择][
    下面对于白盒测试中条件覆盖的说法，正确的是：
    #choices(
      [要求至少执行程序中所有语句一次],
      [至少执行程序中每个分支一次],
      [保证每个复合判定表达式中每个简单判定条件的真假至少执行一次],
      [保证所有简单判定条件的所有可能取值组合至少执行一次],
    )
  ]
  #solution[C。A 是语句覆盖，B 是判定覆盖，D 是条件组合覆盖。条件覆盖要求复合判定中每个简单条件的真假情况至少执行一次。]
  #exam[2022年 判断][相对于白盒测试，黑盒测试的覆盖率通常较低且对测试人员的代码技术水平要求低一些。]
  #solution[正确。黑盒测试不基于代码，覆盖率自然低于白盒；也不需要理解源代码，对测试人员代码技术水平要求更低。]
  #exam[2024年 判断][路径覆盖是白盒测试最强的逻辑覆盖准则，而且易于实现。]
  #solution[错误。路径覆盖确实是最强的覆盖准则，但随分支增多路径呈指数增长，*不易实现*，通常不切实际。]
  #exam[2025年 判断][在一个测试套组中，如果实现了 100% 的语句覆盖，则必然实现了 100% 的判定覆盖。]
  #solution[错误。语句覆盖是最弱的覆盖，它不要求每个判定的真假分支都执行。例如 `if (a > 0)` 语句执行时可能只走了 true 分支，未覆盖 false 分支。]
  #exam[2022年 填空][白盒测试的覆盖指标中，最强的逻辑覆盖策略是（ ）覆盖。]
  #solution[路径。]
  #exam[2022年 填空][黑盒测试的主要方法包括等价类划分、边界值分析、（ ）。]
  #solution[场景法（或因果图法、判定表法等均可）。]
  #exam[2022年 简答][请简要描述黑盒测试中的等价类测试，以及等价类划分的原则。]
  #solution[等价类划分法将输入域划分为若干子集（等价类），每个子集中任一数据对程序行为等效。原则：有效等价类（测试正常功能）和无效等价类（测试异常处理）。有效等价类应尽可能用一个用例覆盖多个；无效等价类应每个用例只覆盖一个（便于定位错误）。]
]
#pagebreak(weak: true)
= 数据持久化与 I/O

#introduction[流 (Stream)][字节/字符流][序列化][Path & Files][DAO 模式]

== Java 流 (Streams)
流是一个抽象概念，是一组有序的数据序列。Java 中所有的 I/O 操作都以“流”的方式进行。

#property[流的分类][
  - *按方向*：*输入流*（流向内存）和 *输出流*（流出内存）。
  - *按数据单位*：
    - *字节流 (Byte Stream)*：基本单位为 8bit 字节。用于二进制数据。*Stream 结尾的类皆为字节流（如 FilterInputStream）*。
    - *字符流 (Character Stream)*：基本单位为 16bit 字符。*Reader/Writer 结尾的类为字符流*。
  - *按功能*：
    - *节点流*：直接连接到数据源。
    - *处理流 (过滤流)*：通过装饰者模式提供额外功能（如 `BufferedInputStream`）。
]

#definition[为什么要将字节流转为字符流？][
  1. *人类可理解*：字符流直接映射到字符编码，更适合处理文本。
  2. *变长编码处理*：许多编码（如 UTF-8）是变长的，字节流无法直接判断读取几个字节代表一个完整字符，而字符流已封装此逻辑。
]

#definition[四大家族][
  所有流类都继承自以下四个抽象基类：
  #property[字节流][`InputStream` (输入) / `OutputStream` (输出)]
  #property[字符流][`Reader` (输入) / `Writer` (输出)]
  *Java中只要是`Reader`, `Writer`的子类，都属于字符流, `InputStream`, `OutputStream`属于字节流*
]

#example[
  *字节流转字符流（转换流）*：
  ```java
  // 使用 BufferedReader 包装 InputStreamReader，提高读取效率
  BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
  String line = br.readLine();
  ```
]

== 操作文件 (Path & Files)
Java NIO 提供了 `Path` 和 `Files` 工具类，比传统的 `File` 类更强大、更简洁。

#property[Path][表示路径。`Paths.get("path/to/file")`。]
#property[Files 核心操作][
  - *读写*：`readString(path)`, `writeString(path, content)`, `readAllLines(path)`。
  - *管理*：`createDirectory()`, `move()`, `copy()`, `deleteIfExists()`。
  - *属性*：`exists()`, `size()`, `isDirectory()`。
]

== 对象序列化 (Serialization)
将 Java 对象转换为字节序列的过程。

#property[用途][
  - *持久化*：将对象状态保存到磁盘中，供以后恢复。
  - *网络传输*：在分布式系统中通过网络发送对象。
]
#property[实现细节][
  - 必须实现 `Serializable` 接口（标志接口，无方法）。
  #property[serialVersionUID][用于验证序列化对象的版本。若不显式声明，编译器会根据类成员生成哈希值。当类定义改变（如增删字段）且未声明 UID 时，反序列化将抛出 `InvalidClassException`。]
#property[transient 关键字][修饰的成员变量不会被序列化，用于保护敏感或大对象。]
  #property[static 关键字][*类变量不参与序列化*。序列化保存的是对象状态，而静态变量属于类。]
  #property[执行顺序 (高频知识点)][
    存在继承关系时的初始化顺序：
    1. 父类静态代码块 $arrow$ 2. 子类静态代码块 $arrow$ 3. 父类初始化块 $arrow$ 4. 父类构造方法 $arrow$ 5. 子类初始化块 $arrow$ 6. 子类构造方法。
  ]
]

#example[
  *序列化实战考点*：
  ```java
  public class User implements Serializable {
      // 显式声明 UID 保证版本兼容性
      private static final long serialVersionUID = 1L;
      private String name;
      private transient String password; // 敏感词不序列化
  }
  ```
]

#example[
  *序列化与反序列化*：
  ```java
  // 写出对象
  ObjectOutputStream oos = new ObjectOutputStream(new FileOutputStream("obj.dat"));
  oos.writeObject(person);
  // 读回对象
  ObjectInputStream ois = new ObjectInputStream(new FileInputStream("obj.dat"));
  Person p = (Person) ois.readObject();
  ```
]

== 数据访问对象模式 (DAO Pattern)
DAO 模式旨在将低级的数据访问 API 与高级业务逻辑分离。

#property[核心参与者][
  1. *数据对象 (Model/VO)*：简单的 POJO，包含属性及 Getter/Setter。
  2. *DAO 接口*：定义标准的数据操作（CRUD）。
  3. *DAO 实现类*：具体实现数据逻辑（访问数据库或文件）。
  4. *服务层 (Service)*：调用 DAO 执行业务逻辑。
]

#example[
  *DAO 模式完整实现示例*：
  ```java
  // 1. Model
  class Student implements Serializable {
      private int id;
      private String name;
      // getters/setters...
  }

  // 2. DAO Interface
  interface StudentDao {
      void save(Student s);
      Student findById(int id);
  }

  // 3. DAO Implementation (File-based)
  class StudentDaoImpl implements StudentDao {
      private final String FILE_PATH = "students.db";
      public void save(Student s) {
          // 实际逻辑：读文件 -> 追加/修改列表 -> 写回文件
      }
      public Student findById(int id) { /* ... */ }
  }

  // 4. Client/Application
  public class DaoDemo {
      public static void main(String[] args) {
          StudentDao dao = new StudentDaoImpl(); // 解耦点
          dao.save(new Student(1, "Alice"));
      }
  }
  ```
]

#property[优点][
  - *隔离性*：修改底层存储方式（如从 MySQL 换到持久化文件）只需改动 DAO 层，不影响业务。
  - *解耦*：降低了服务层与存储层的耦合度。
]

=== try-with-resources (Java 7+)
由于流是稀缺资源，必须在使用后关闭。传统的 `finally` 关闭写法极其臃肿且容易出错。

#property[原理][
  实现了 `AutoCloseable` 接口的资源可以在 `try` 括号中定义，在 `try` 块结束时（无论是否抛出异常）都会被自动关闭。
]

#example[
  *写法对比*：
  ```java
  // ❌ 传统写法（容易忘记 close 或 close 抛异常覆盖原始异常）
  InputStream in = null;
  try { in = new FileInputStream("..."); }
  finally { if (in != null) in.close(); }

  // ✅ 现代写法 (try-with-resources)
  try (InputStream in = new FileInputStream("file.txt")) {
      // 处理流... 
  } // 此处由编译器自动生成 close 调用
  ```
]

#problemset[
  #exercise[读取一个 Word 文档时，应使用字节流还是字符流？为什么？]
  #solution[字节流，因为 Word 文档是二进制格式，字符流适用于文本数据。]
  #exercise[当一个类实现了 `Serializable` 接口，但其内部持有的一个成员对象类没有实现该接口，序列化时会发生什么？]
  #solution[会抛出 `NotSerializableException`，因为序列化需要递归地序列化所有成员对象。]
  #exercise[在 DAO 模式中，为什么要设计接口而不是直接写实现类？这体现了哪个 SOLID 原则？]
  #solution[设计接口可以实现更好的解耦和灵活性，符合 SOLID 原则中的*依赖倒置原则*（DIP）。服务层依赖于抽象接口而非具体实现，使得底层存储方式可以随时替换而不影响业务逻辑。]
  #exercise[I/O 中的“输入”和“输出”是相对于哪里定义的？]
  #solution[相对于内存。流入内存的是输入，流出内存的是输出。]
  #exercise[`FilterInputStream` 是字符流还是字节流？]
  #solution[字节流。Java 中以 `Stream` 结尾的通常为字节流。]
  #exercise[序列化一个含有静态变量的对象，反序列化后该静态变量的值会变吗？]
  #solution[不会被序列化保存。静态变量属性类状态，其值取决于当前类在 JVM 中的状态，而非序列化文件。]
  #exam[2022年 选择][
    下面关于 JAVA 中流与输入输出描述，错误的是：
    #choices(
      [为读写 Word 文档，一般采用字符流],
      [对于文件的读写可使用 FileInputStream 和 FileOutputStream],
      [流使用完后，需要调用 close() 方法],
      [要实现对象序列化，需要让一个类实现 Serializable 接口],
    )
  ]
  #solution[A。Word 文档是二进制格式，应使用*字节流*而非字符流。]
  #exam[2024年 选择][
    下列不属于四种抽象流类型的是：
    #choices(
      [InputStream],
      [BufferStream],
      [Reader],
      [Writer],
    )
  ]
  #solution[B。Java I/O 四大家族是 `InputStream`、`OutputStream`、`Reader`、`Writer`。不存在 `BufferStream`（只有 `BufferedInputStream` / `BufferedReader`，属于处理流而非抽象基类）。]
  #exam[2025年 选择][
    Java 中用哪个类进行字符读入操作：
    #choices(
      [InputStream],
      [OutputStream],
      [Reader],
      [Writer],
    )
  ]
  #solution[C。`Reader` 是字符输入流的抽象基类。]
  #exam[2025年 选择][
    下面对于数据访问对象（DAO）模式的理解，正确的是：
    #choices(
      [减少代码量],
      [隔离数据层，把低级的数据访问操作从高级的业务服务中分离出来],
    )
  ]

  #solution[B。DAO 模式的核心目的就是将底层数据访问逻辑与业务逻辑解耦，而非单纯减少代码量。]
  #exam[2022年 填空][JAVA 的继承框架根节点包括 InputStream 和（ ）、（ ）和 Writer。]
  #solution[OutputStream、Reader。四大家族：`InputStream`、`OutputStream`、`Reader`、`Writer`。]
  #exam[2024年 填空][Java 的 I/O 包括 #underline("    ") 和 #underline("    ")，分别用来处理二进制数据和文本数据。]
  #solution[字节流、字符流。]
  #exam[2024年 判断][Java 中的 I/O 类只能用于文件读写，不能用于网络通信。]
  #solution[错误。Java I/O 流既可以用于文件读写，也可以用于网络通信（如 `Socket.getInputStream()` 获取输入流）。]
]
#pagebreak(weak: true)
= 图形用户界面 (Swing)

#introduction[AWT vs Swing][布局管理器][事件处理][MVC 模式][GUI 组件]

== 1. Swing 框架概览
#property[Java GUI 简史][
  - *AWT (Abstract Window Toolkit)*：Java 1.0 引入。依赖本地平台组件（重量级），存在不同平台的 Bug。
  - *Swing*：采用纯 Java 实现，不依赖本地图形界面（轻量级）。组件都继承自 `JComponent`（除了顶层容器）。
]
#property[容器分类][
  - *重量级容器 (顶层容器)*：`JFrame`, `JDialog`, `JApplet`。不能被其他容器包含。
  - *轻量级容器 (中间层容器)*：`JPanel`, `JScrollPane`。*必须包含在重量级容器中才能显示*。
]

== 2. 布局管理器 (Layout Manager)
布局管理器控制容器中组件的位置和大小。

#definition[常见布局类型][
  - *FlowLayout*：流式布局。组件从左到右、居中排列，一行放不下自动换行。
  - *BorderLayout*：边框布局。将容器划分为东、南、西、北、中五个区域。
  - *GridLayout*：网格式布局。将容器划分为等大的单元格。
  - *GridBagLayout*：网格式布局，可以放置不同大小的组件，功能最灵活。
  - *BoxLayout*：盒式布局。把组件水平或者竖直排在一起。
]

== 3. 显示窗体与信息
#property[显示窗体 (JFrame)][
  使用 `JFrame` 创建窗口，默认大小为 0x0。应在“事件分派线程 (EDT)”中通过 `EventQueue.invokeLater` 启动。
]
#property[内容窗格 (Content Pane)][
  添加到窗体的组件实际被添加到内容窗格中。
]
#property[绘制信息][
  - 扩展 `JComponent` 并覆盖 `paintComponent(Graphics g)`。
  #property[Graphics / Graphics2D][
    `Graphics` 是所有绘制的基础。`Graphics2D` 提供更强大的图形操作（Line2D, Rectangle2D, Ellipse2D），支持浮点坐标。
  ]
  #property[使用颜色与图像][
    - `setPaint(Color)`：设置后续操作的颜色（如 `Color.RED`）。
    - `fill(rect)` / `draw(rect)`：填充或绘制路径。
    - `drawImage()`：显示来自 `ImageIcon` 的图像，可使用 `copyArea` 平铺。
  ]
]

== 4. 事件机制
Swing 采用委托事件模型。

#property[核心角色][
  - *事件源 (Event Source)*：发生动作的组件（如按钮）。
  - *事件 (Event)*：封装用户动作的对象（如 `ActionEvent`）。
  - *监听器 (Listener)*：实现监听器接口的类对象（如 `ActionListener`），处理事件。
]
#example[
  *简洁指定监听器 (Lambda)*：
  ```java
  JButton button = new JButton("OK");
  // 当按钮被点击时执行
  button.addActionListener(event -> {
      System.out.println("Button Clicked!");
  });
  ```
]

== 5. 基本用户组件
#property[文本输入][
  - `JTextField`：接收单行文本。
  - `JTextArea`：接收多行文本（需放在 `JScrollPane` 中以获得滚动条）。
  - `JPasswordField`：回显字符掩盖密码，以 `char[]` 获取结果。
  - `JLabel`：标识组件的标签。
]
#property[选择组件][
  - `JCheckBox`：接收“是”或“否”输入。
  - `JRadioButton`：在多个选择中单选（需加入 `ButtonGroup`）。
  - `JComboBox`：下拉选择列表。
]
#property[菜单 (Menu)][
  - `JMenuBar`：菜单栏。
  - `JMenu`：下拉菜单名字。
  - `JMenuItem`：菜单项（支持 `JCheckBoxMenuItem` 等）。
]

== 6. MVC 模式
Swing 核心设计模式。

#property[MVC 职责划分][
  - *模型 (Model)*：存储数据内容，实现逻辑改变。
  - *视图 (View)*：显示内容（外观），模型更新时同步更新。
  - *控制器 (Controller)*：处理用户输入事件，决定如何修改模型或视图。
]
#property[Swing 实现][
  Swing 将视图和控制器合并。在其体系中，*监听器 (Listener)* 通常充当控制器的角色，在拦截到用户动作后决定修改/控制模型或视图。
  - *DAO 与 MVC*：DAO 层通常属于 *模型 (Model)*，因为它封装了数据的底层操作。
  - *线程安全*：Swing 不是线程安全的，所有组件访问必须在 *事件分派线程 (EDT)* 中。
]

#problemset[
  #exercise[简述 AWT 与 Swing 在组件加载机制上的本质区别。]
  #exercise[在 BorderLayout 中，如何确保一个按钮始终占据窗口剩余的所有中心空间？]
  #exercise[解释 MVC 模式中“模型”与“视图”的协作关系，以及它对代码可维护性的好处。]
  #exercise[在 MVC 模式中，哪个部分包含 DAO 层？为什么？]
  #solution[模型 (Model) 层。因为 DAO 负责封装数据库/文件的底层数据操作，属于业务数据逻辑。]
  #exercise[轻量级容器（如 `JPanel`）可以不包含在其它容器中直接显示逻辑吗？]
  #solution[不可以。轻量级容器必须包含在重量级容器（如 `JFrame`）中才能显示。]
  #exercise[Swing 是线程安全的吗？]
  #solution[不是。所有对 Swing 组件及其状态的访问必须在事件分派线程 (EDT) 中进行。]
  #exam[2022年 选择][
    下列关于 Swing 中的组件和容器的描述中，错误的是：
    #choices(
      [容器也可以看做是组件，可以放到别的容器里],
      [组件是单独的控制元素，需要放到容器里面才能显示出来],
      [Swing 中的组件都继承于 Jcomponent 类],
      [重量级容器（如 JFrame 等）可以放在其他容器里面],
    )
  ]
  #solution[D。重量级容器（如 `JFrame`）是顶层容器，*不能被其他容器包含*。轻量级容器（如 `JPanel`）可以放置在重量级容器内。]
  #exam[2025年 选择][
    下面对于 Swing 容器的说法，错误的是：
    #choices(
      [JFrame 是顶层容器],
      [JDialog 是顶层容器],
      [JApplet 是顶层容器],
      [JPanel 可以直接用来作为顶层窗口],
    )
  ]
  #solution[D。`JPanel` 是轻量级容器，不能直接作为顶层窗口，必须放置在 `JFrame` 等顶层容器中才能显示。]
  #exam[2025年 判断][Swing 框架是 AWT 的轻量化替代，其大部分组件由纯 Java 代码绘制而成，不依赖本地平台组件。]
  #solution[正确。Swing 是轻量级组件，纯 Java 实现，不依赖操作系统本地组件（AWT 是重量级，依赖本地平台）。]
  #exam[2022年 填空][JAVA 中的事件处理机制包括三部分，即事件，事件源，以及（ ）。]
  #solution[事件监听器 (Listener)。委托事件模型的三要素：事件 (Event)、事件源 (Event Source)、监听器 (Listener)。]
  #exam[2024年 填空][Swing 采用了 MVC 设计模式，包括 #underline("    ")、#underline("    ") 和 #underline("    ") 三部分。]
  #solution[模型 (Model)、视图 (View)、控制器 (Controller)。]
  #exam[2025年 填空][在 MVC 模式中，模型与视图之间通过 #underline("    ") 模式交互。模型改变，视图就会更新。]
  #solution[观察者 (Observer)。MVC 中 Model 作为被观察者 (Subject)，View 作为观察者 (Observer)。]
  #exam[2022年 简答][请简要描述 MVC 模式中三方的功能，并讨论 Swing 框架与 MVC 模式之间的联系。]
  #solution[
    - *Model*：存储数据内容和业务逻辑。
    - *View*：负责数据显示，模型更新时同步刷新。
    - *Controller*：处理用户输入事件，决定如何修改 Model 或 View。
    Swing 将 View 和 Controller 合并；在其体系中 Listener 充当 Controller，拦截用户动作后修改 Model 或 View。DAO 层通常属于 Model 层。
  ]
]
#pagebreak(weak: true)
= 并发与多线程

#introduction[进程 vs 线程][生命周期][Synchronized][线程池][生产者-消费者][Callable][死锁避免]

== 1. 进程与线程 (Process vs Thread)
#property[进程 (Process)][正在运行的程序实例。拥有私有内存空间，彼此隔离，是 *操作系统资源分配* 的基本单位。进程间通过消息传递协作。]
#property[线程 (Thread)][进程内的单一顺序控制流。是 *CPU 调度* 的最小单位。多个线程共享进程内的内存（堆）。]

#definition[对比总结][
  #table(
    columns: 3,
    align: center,    // 全部居中
    stroke: 1pt,     // 边框粗细
    
    // 表头
    [特性], [进程], [线程],
    
    // 行内容
    [重量级], [重 (各自独立资源)], [轻 (共享资源)],
    [内存共享], [不共享], [共享 (堆、方法区)],
    [隔离性], [高], [低 (一崩俱崩)],
    [单位], [资源分配单位], [程序执行/调度单位]
  )
]
#definition[线程生命周期 (State)][
  1. *New (新建)*：`new Thread()` 后尚未 `start()`。
  2. *Runnable (就绪/运行)*：等待 CPU 时间片或正在执行。
  3. *Blocked (阻塞)*：试图获取内部对象锁，但该锁被其他线程持有。
  4. *Waiting (等待)*：主动等待通知（`wait()`, `join()`）。
  5. *Timed Waiting (超时等待)*：限期等待（`sleep(ms)`, `wait(ms)`）。
  6. *Terminated (终止)*：`run()` 方法正常结束或因异常意外结束。
]

== 2. 线程创建与控制
#property[创建方式对比][
  - *继承 Thread 类*：实现简单，但受限于单继承。在共享任务成员变量时，必须加 `static` 才能共享。
  - *实现 Runnable 接口*：*推荐方式*。
    - *松耦合*：将任务 (Runnable) 与运行载体 (Thread) 分离。
    - *降低开销*：只需定义任务逻辑，不需要继承 Thread 的所有方法，且容易实现多个线程执行同一个任务。
  - *实现 Callable 接口*：支持返回值 (`call()`)，可抛出异常。
]

#example[Runnable 与 Callable 的区别总结][
  #figure(
    table(
      columns: (2fr, 2fr, 2fr),
      align: center,
      table.header[*特性*][*Runnable*][*Callable*],
      [方法名], [`run()`], [`call()`],
      [返回值], [无 (`void`)], [支持泛型 `V`],
      [异常抛出], [不可向上抛出受检异常], [支持抛出受检异常],
      [主要用途], [后台独立任务], [需获取结果的任务],
    ),
    caption: [Runnable 与 Callable 核心对比],
  )
]

#example[
  *FutureTask 执行 Callable*：
  ```java
  Callable<String> task = () -> {
      Thread.sleep(1000);
      return "Task Result";
  };
  FutureTask<String> ft = new FutureTask<>(task);
  new Thread(ft).start();
  System.out.println(ft.get()); // 阻塞直到获取结果
  ```
]

#property[核心方法总结][
  - `start()`：启动线程（内部调用 `run()`），立即返回。不能直接调 `run()`！
  - `yield()`：*礼让*。建议调度器切换，但可能被忽略。
  - `join()`：*同步/插队*。调用者进入阻塞直到该线程执行完。
  - `interrupt()`：*中断*。设置标志位。若线程处于阻塞态（sleep/wait），抛出 `InterruptedException`。
  - `setDaemon(true)`：*守护线程*。为其他线程服务（如 GC）。当所有用户线程结束，JVM 自动退出。
]

== 3. 线程同步与安全 (Safety)
#property[非原子操作问题][
  `count++` 包含：取数 -> 加法 -> 保存。
  在多线程下，若两线程同时执行该三步指令，会导致覆盖而丢失次数。
]

#property[synchronized][
  - *同步代码块*：`synchronized(lock) { ... }` 锁对象。
  - *同步方法*：
    - 实例方法：锁 `this`。
    - 静态方法：锁 `Class` 对象。
]

#property[volatile 关键字][
  - *可见性*：强制从主内存读写，确保线程间看到最新值。
  - *有序性*：禁止指令重排序。
  - *局限性*：不保证原子性（不适合 `count++`）。
]

#property[死锁 (Deadlock)][
  两个线程互持对方所需的锁导致无限等待。
  - *代码复现关键点*：线程 A 先锁 1 再锁 2；线程 B 先锁 2 再锁 1。
  - *避免规则*：*锁的获取顺序必须一致*。
]

== 4. 线程池 (Thread Pool)
#property[核心价值][减少线程创建/销毁开销，提高响应速度，限制并发量保护系统。]

#definition[ThreadPoolExecutor 七大核心参数][
  1. `corePoolSize`：核心线程数（常驻）。
  2. `maximumPoolSize`：最大线程数。
  3. `keepAliveTime`：空闲线程存活时间。
  4. `unit`：时间单位。
  5. `workQueue`：任务阻塞队列。
  6. `threadFactory`：创建线程的工厂。
  7. `handler`：拒绝策略（如 `AbortPolicy` 抛异常）。
]

== 5. 生产者-消费者模式
#example[
  *缓冲区实现逻辑 (Wait/Notify)*：
  ```java
  // 生产
  public synchronized void put(int val) {
      while (data.size() == MAX) { // 必须用 while
          wait(); // 释放锁并进入等待
      }
      data.add(val);
      notifyAll(); // 唤醒消费者/其他生产者
  }
  // 消费
  public synchronized int take() {
      while (data.isEmpty()) {
          wait();
      }
      int val = data.remove(0);
      notifyAll();
      return val;
  }
  ```
]

#problemset[

#exercise[`sleep()` 和 `wait()` 的异同点？]
#solution[
  *相同*：均阻塞线程、可被中断抛`InterruptedException`。
  *不同*：
  1. `sleep`：`Thread`静态方法，*不释放锁*，任意位置可用，到时自动唤醒；
  2. `wait`：`Object`成员方法，*释放锁*，仅限`synchronized`内，靠`notify/notifyAll`或超时唤醒。
]
#exercise[为什么在检查 `wait()` 条件时必须使用 `while` 循环而不是 `if` 语句？（提示：虚假唤醒）]
  #solution[
  存在*虚假唤醒*，线程无通知也可能被唤醒；`if`只校验一次，唤醒后直接执行出错；`while`被唤醒后循环重试条件，不满足则继续等待。
  ]
#exercise[为什么 `wait()` 方法必须放在 `synchronized` 同步块中运行？]
#solution[
  `wait`依赖对象监视器Monitor，需先持有锁才能释放锁；不在同步代码块会抛出`IllegalMonitorStateException`，同时保证条件判断和等待原子性。
]
  #exercise[为什么在多线程中实现 `Runnable` 接口比继承 `Thread` 类通常更优？]
  #solution[1. 遵循“面向接口编程”思想，任务与运行机制松耦合。2. 避免了 Java 单继承的限制。3. 性能开销更小，不需要继承 Thread 类的所有方法。]
  #exercise[`wait(time)` 方法能否被 `notify()` 或 `notifyAll()` 唤醒？]
  #solution[可以。它可以通过超时自动唤醒，也可以被显式唤醒。]
  #exercise[生产者-消费者模式中，为什么不推荐用 `sleep()` 代替 `wait()`？]
  #solution[1. `sleep` 不会释放持有的锁，导致其它线程（如生产者/消费者）无法进入同步区。2. `sleep` 必须指定具体时间，无法灵活地根据任务完成情况唤醒协作方。]
  #exam[2022年 选择][
     ```java
      Thread t = new Thread(() -> { Thread.sleep(2000); print("2"); }); 
      t.start(); 
      t.join(); 
      print("1");
    ```
    执行结果为：
    #choices(
      [21],
      [12],
      [可能为 12 也可能为 21],
      [都不对],
    )
  ]
  #solution[A (21)。`t.start()` 启动线程后 `t.join()` 阻塞主线程等待 t 执行完毕，t 先 sleep 2 秒后输出 "2"，主线程等待 t 结束后才输出 "1"，所以始终是 "21"。]
  #exam[2024年 选择][
    下列关于线程的说法正确的是：
    #choices(
      [线程的中断不能直接使用 interrupt 方法实现],
      [优先级高的线程不一定比优先级低的线程优先执行],
      [计时器是守护线程],
      [以上都正确],
    )
  ]
  #solution[B。线程优先级只是一个建议，CPU 调度不保证严格按优先级执行。A 错，`interrupt()` 可以中断线程；C 错，计时器不一定是守护线程。]
  #exam[2025年 选择][
    下面对于多线程的说法，正确的是：
    #choices(
      [实现多线程需要调用 Thread 的 run() 方法],
      [通过实现 Runnable 接口的好处是类还可以继承其他类],
      [Callable 接口没有返回值，和 Runnable 相同],
      [以上都不对],
    )
  ]
  #solution[B。Runnable 方式避免 Java 单继承限制。A 错，应调用 `start()` 而不是 `run()`；C 错，Callable 有返回值，`call()` 方法可返回泛型结果。]
  #exam[2024年 判断][Java 中的 wait() 方法不需要放在同步块中。]
  #solution[错误。`wait()` 必须在 `synchronized` 同步块中调用，否则抛出 `IllegalMonitorStateException`。调用 `wait()` 前必须先获取对象锁。]
  #exam[2024年 判断][一个进程可以包含多个线程。]
  #solution[正确。进程是资源分配的基本单位，线程是 CPU 调度的基本单位。一个进程可以包含多个线程共享进程资源。]
  #exam[2024年 填空][Java 采用 #underline("    ")（隐式/显式）分配器进行垃圾回收，该线程属于 #underline("    ") 线程。]
  #solution[隐式、守护 (Daemon)。GC 是 JVM 自带的自动运行线程，为用户线程服务，当所有用户线程结束时 JVM 自动退出。]
  #exam[2024/2025年 简答][生产者-消费者模式一般通过缓冲区完成对生产和消费的解耦。以下是缓冲类（Buffer 类）的代码，请回答下述问题。
    ```java
    public class Buffer {
        private List<Integer> list = new ArrayList<>();
        private static final int MAX = 10;

        public void put(int value) {
            while (true) {
                try {
                    Thread.sleep(500);
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
                synchronized (this) {         // (A)
                    while (list.size() == MAX) { // (B)
                        System.out.println("buffer is full, waiting ....");
                        try {
                            wait();
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    }
                    System.out.println("producer--" +
                        Thread.currentThread().getName() + "--put:" + value);
                    list.add(value);
                    notifyAll();
                }
            }
        }

        public Integer take() {
            // 代码省略
        }
    }
    ```
    (1) 缓冲池为什么一定要同步？(1分)
    (2) 注释 (A) 中，`this` 指代的是什么？（1分）
    (3) 注释 (B) 中，如果把 `while` 改为 `if`，会产生什么后果？（2分）
    (4) 生产者-消费者模式的优点有哪些？（2分）]
  #solution[
    (1) 生产者和消费者线程需要访问共享的缓冲区（`list`）。如果不进行同步，可能会出现数据竞争（如同时修改 `list` 导致数据不一致）或线程安全问题（如一个线程正在检查 `list.size()`，另一个线程正在修改 `list`）。同步保证了同一时刻只有一个线程可以访问缓冲区，确保数据的一致性和正确性。
    (2) `this` 指当前 `Buffer` 对象实例，用作同步锁。
    (3) 如果用 `if` 判断，线程被唤醒后不再检查条件就直接执行后续代码。由于可能存在"虚假唤醒"或被其他线程抢先消费，可能导致在条件不满足时继续执行（如列表已满仍 add）。必须用 `while` 保证唤醒后再次检查条件。
    (4) 优点：解耦生产者和消费者，各自独立处理；缓冲队列削峰填谷，平衡处理速度差异；提高系统吞吐量。
  ]
  #exam[2025年 简答][阅读以下代码，完成(1)~(3)问题。（5分）
    ```java
    public class DeadlockDemo {
        private static final Object lockA = new Object(), lockB = new Object();
        public static void main(String[] args) throws InterruptedException {
            Thread t1 = new Thread(() -> {
                synchronized (lockA) {
                    System.out.println("T1: locked A");
                    sleep(100);
                    System.out.println("T1: trying to lock B");
                    synchronized (lockB) {
                        System.out.println("T1: locked B");
                    }
                }
            });
            Thread t2 = new Thread(() -> {
                synchronized (lockB) {
                    System.out.println("T2: locked B");
                    sleep(100);
                    System.out.println("T2: trying to lock A");
                    synchronized (lockA) {
                        System.out.println("T2: locked A");
                    }
                }
            });
            t1.start();
            t2.start();
        }
        private static void sleep(long ms) {
            try { Thread.sleep(ms); } catch (InterruptedException ignored) { }
        }
    }
    ```
    (1) 代码产生什么问题？（1分）
    (2) 这个问题如何产生？（2分）
    (3) 怎么解决这个问题？（2分）]
  #solution[
    (1) 产生死锁（Deadlock）。两个线程互相等待对方释放锁，程序永久阻塞无法继续。\
    (2) 线程 t1 先持有 `lockA` 再请求 `lockB`，线程 t2 先持有 `lockB` 再请求 `lockA`，形成*循环等待*——四个必要条件齐备（互斥、持有并等待、不可剥夺、循环等待），触发死锁。\
    (3) 解决方法：保证锁的获取顺序一致。例如两个线程都先获取 `lockA` 再获取 `lockB`（即把 t2 中 `lockB` 和 `lockA` 的顺序交换），打破循环等待条件。
  ]
  #exam[2022年 简答][关于多线程编程，使用 Runnable 接口相比继承 Thread 类有什么优势？]
  #solution[
    1. 避免 Java 单继承限制，实现 Runnable 后还可以继承其他类；\ 
    2. 松耦合：将任务 (Runnable) 与运行载体 (Thread) 分离，遵循"面向接口编程"；
    3. 便于多个线程共享同一个任务实例。]
]
#pagebreak(weak: true)
= 泛型与反射

#introduction[编译时安全][通配符][Class 对象][动态调用][反射安全]

== 泛型 (Generics)
泛型是 Java 5 引入的特性，允许在定义类、接口 and 方法时使用*类型参数*。

#property[核心优势][
  - *类型安全*：在编译阶段检测非法数据。
  - *消除强制转型*：获取元素时不再需要显式的 `(String)` 转换。
]
#property[泛型类与方法][
  - *泛型类*：`class MyList<T> { ... }`，`T` 是占位符。
  - *泛型方法*：`public <E> void swap(E[] a) { ... }`。
  *泛型方法不一定要在泛型类中定义，两者没有必然的依赖关系*。
  - *静态泛型*：泛型类中的静态方法如果需要使用泛型，*必须独立声明其类型参数*（即必须定义为泛型方法），因为静态成员无法引用类级别的泛型。
]
#property[通配符 (Wildcards)][
  - `<?>`：无限定通配符，表示不确定的类型。
  - `<? extends T>`：*上界通配符*。适用于读取。
  - `<? super T>`：*下界通配符*。适用于写入。
  - *作用范围*：可以在非泛型类或泛型类中定义，二者不冲突。
]

== 反射 (Reflection)
反射机制允许程序在运行时动态地获取类的结构（字段、方法、构造函数）并进行操作。

#property[获取 Class 对象][
  1. `obj.getClass()`：通过实例获取。
  2. `Person.class`：通过类字面量获取。
  3. `Class.forName("com.xxx.Person")`：通过完整类名字符串获取。
  - *注意*：反射不仅可以操作普通类，也可以获取*抽象类*和*接口*的信息。
]
#property[动态操作][
  - *创建实例*：`clazz.newInstance()` (调用无参构造) 或 `constructor.newInstance(args)`。
  - *成员访问*：使用 `getField()` / `getDeclaredField()` 获取字段，并用 `setAccessible(true)` 强行访问私有成员。
  - *方法调用*：`method.invoke(object, args)`。
]
#example[
  *反射突破私有限制：访问 private 方法*：
  ```java
  Class<?> clazz = Class.forName("com.example.User");
  Object userObj = clazz.getDeclaredConstructor().newInstance();
  // 获取私有方法
  Method method = clazz.getDeclaredMethod("privateWork", String.class);
  // 必须设置为 true 才能访问
  method.setAccessible(true);
  method.invoke(userObj, "加班中...");
  ```
]

#property[反射与单例][
  反射可以通过 `setAccessible(true)` 调用私有构造函数破坏单例。
  - *防御手段*：在私有构造函数中检查实例是否已存在，若存在则抛出异常。
]

#definition[泛型类型擦除 (Type Erasure)][
  Java 泛型是“编译器级”的，编译后所有的泛型信息都会被保留到原始类型（Raw Type，通常是 Object）。
  - *后果*：`List<String>` 和 `List<Integer>` 在运行时的 Class 对象是同一个；不能使用 `new T()`；由于擦除，运行时无法直接获取泛型真实类型。
]

#problemset[
  #example[为什么 `List<Object>` 不能接收 `List<String>` 类型的参数，而 `List<?>` 可以？]
  #solution[
  1. *核心原因：Java泛型不支持协变，且为保证类型安全*
     - `List<String>` 是 `List<?>` 的子类型，但*不是* `List<Object>` 的子类型，泛型类型不具备继承关系的传递 性。
     - 若允许 `List<Object>` 接收 `List<String>`，会破坏类型安全：
       示例：`List<Object> list = new ArrayList<String>();` 后调用 `list.add(123);`，会向String集合插 入Integer类型数据，运行时引发类型转换异常，因此编译器直接禁止该赋值。
     - `List<?>` 是无界通配符类型，表示*任意未知类型*的List，它是所有泛型List的父类型，因此可以接收   `List<String>`、`List<Integer>` 等任意泛型List；但该集合仅支持读取，不支持添加元素（除null外），保证了类型安全。
  ]

  #example[写出通过反射获取一个类中名为 `secretMethod` 的私有方法并执行它的核心代码步骤。]
  #solution[
  ```java
  // 1. 获取目标类的Class对象（两种方式任选）
  Class<?> clazz = 目标类.class;
  // 2. 获取指定名称、指定参数类型的私有方法（getDeclaredMethod可获取所有权限修饰符的方法）
  Method method = clazz.getDeclaredMethod("secretMethod"); 
  // 3. 打破Java的访问权限检查，允许调用私有方法
  method.setAccessible(true);
  // 4. 创建目标类的实例对象（无参构造）
  Object obj = clazz.newInstance(); 
  // 5. 执行私有方法，接收返回值（无返回值则接收null）
  Object result = method.invoke(obj);
  ```
  ]

  #example[泛型信息在运行时期是否还存在？（提示：类型擦除）]
  #solution[
  *答案：泛型信息在运行期不存在，会被Java编译器完全擦除。*
  1. Java泛型采用*类型擦除*机制：编译阶段会校验泛型的类型约束，编译完成后，泛型类型参数会被替换为原始类型（无界泛型 替换为Object，有界泛型替换为边界类型）；
  2. 运行时JVM无法感知泛型的具体类型，例如`List<String>`和`List<Integer>`在运行时都是`List`类型；
  3. 补充：仅类、方法、字段上的*泛型声明信息*会保留在字节码中，而对象实例的泛型类型在运行时完全丢失。
  ]

  #exercise[泛型类中的静态方法如果想带泛型，为什么一定要定义为泛型方法？]
  #solution[因为静态方法属于类，不能引用对象实例化的类型参数，因此必须独立声明类型参数。]
  #exercise[是否可以通过 Class 反射获取抽象类或接口的信息？]
  #solution[可以。]
  #exam[2022年 填空][泛型通配符 `<? ___ T>` 代表的是某类型 T 的父类。]
  #solution[super。`<? super T>` 是下界通配符，表示 T 或 T 的父类，适用于写入。]
  #exam[2024年 填空][泛型通配符 `< ? ___ T >` 代表的是某类型 T 的父类。]
  #solution[super。同 2022 年。]
  #exam[2025年 填空][泛型通配符 `<? ___ T>` 指明传入类是 T 的子类。]
  #solution[extends。`<? extends T>` 是上界通配符，表示 T 或 T 的子类，适用于读取。注意：2025 年考了 `extends`，与 2022/2024 年考的 `super` 互为对偶考点！]
]


#pagebreak(weak: true)
= 网络编程

#introduction[TCP/UDP][Socket][URL][观察者模式]

== 1. 基础概念
#property[IP 地址与端口][
  - *IP 地址*：唯一标识网络接口（IPv4: 32位; IPv6: 128位）。
  - *端口 (Port)*：区分主机上的不同进程。
]
#property[传输协议对比 (高频考点)][
  #property[TCP][面向连接、可靠有序、基于字节流、效率相对低。适用于文件传输、网页访问。]
  #property[UDP][无连接、不可靠、基于数据包、速度快。适用于直播、在线游戏、语音通话。]
]

== 2. Socket 编程
Socket（套接字）是基于 TCP 的通信机制。

#property[通信过程][
  1. *服务器*：创建 `ServerSocket(port)`，调用 `accept()` 阻塞等待客户端连接。
  2. *客户端*：创建 `Socket(ip, port)` 请求连接。
  3. *数据传输*：连接建立后，双方通过字节流进行双向通信。*注意：套接字是通过字节流而非字符流通信的。*
]

== 3. URL 与网页获取
#property[URL (统一资源定位符)][由协议、主机、端口、路径、查询参数组成。]
#property[获取资源][
  使用 `URL.openStream()` 获取输入流，可将被动等待的网页内容读入程序。
]

== 4. 观察者模式 (Observer Pattern)
观察者模式定义了一种一对多的依赖关系，让一个对象状态改变时，所有依赖者都收到通知并自动更新。

#property[核心角色][
  - *Subject (目标/被观察者)*：维护观察者列表，提供 `attach()`, `detach()` 方法。
  - *Observer (观察者)*：为具体观察者定义更新接口 `update()`。
]
#property[应用 context][
  - *MVC 模式*：Model 作为 Subject，View 作为 Observer。
  - *GUI 事件*：按钮作为 Subject，Listener 作为 Observer。
]

#problemset[
  #exercise[Socket 通信与 URL 通信的主要区别是什么？]  
  #exercise[在网络编程中，服务器如何实现为多个客户同时提供服务？]
  #solution[通过多线程机制。主线程循环调用 `accept()`，监听到连接后启动一个新线程处理该客户端请求。]
  #exam[2024/2025年 选择][
    Java 语言编写网络通信程序一般位于 TCP/IP 的：
    #choices(
      [应用层],
      [传输层],
      [网络层],
      [网络接口层],
    )
  ]
  #solution[A。Java 使用 `Socket`/`ServerSocket` 编程，工作在应用层，底层依赖 TCP（传输层协议），但程序员基于 Socket API（应用层）编程。]

  #exam[2022年 判断][Socket 允许两台计算机之间通过字节流来进行通信。]
  #solution[正确。Socket 基于字节流（`InputStream`/`OutputStream`）进行双向通信。]
  #exam[2024年 填空][TCP/IP 是最常用的网络协议，基于 #underline("    ")（字节/字符）流传输方式。]
  #solution[字节。TCP 是面向字节流的传输协议。]
  #exam[2025年 填空][TCP/IP 是最常用的网络协议。它基于 #underline("    ")（字节/字符）流传输方式。]
  #solution[字节。同 2024 年。]
]


