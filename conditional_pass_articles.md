# Objects and Classes
*Note: 'object' in the article below largely refers to 'instance objects', i.e. instances of class. I choose not to mention that classes are themselves objects as I believe it would simply confuse the discussion given it is meant to be fairly high level*


Within object oriented programming languages, one of the most important relationships is the one tha exists between classes and objects. In the following summary, we will explore this relationship at a high level as it applies to the Ruby programming language.

To start with, what is an object? And what is a class for that matter? There are various answers to these questions, each of which may be more, or less, helpful given the desired level of detail. This summary is intended to be a fairly high level introduction so there will be some details which are not explored in depth or are absent entirely. This choice is made with the intention of increasing the accessiblity and usefullness of the relationship model presented, with the understanding it may come at the expense of some amount of precision.

## What is an Object?
What is an object? For Ruby in particular this can be a tricky question to answer. Some people might say "everything in ruby is an object" and while that may nearly be true, there are a small handful of exceptions though we will not go into detail about them here. For now, a good starting place would be to say that in Ruby, anything that has a value is an object, and nearly everything in Ruby has a value. One way to think about this would be make a comparison to the physical world we live in. Let's say that any discrete observable 'thing' that has mass in the world around us is like an object in Ruby. So, I myself would be an object, as would a car, a building, a pet, etc..

However, an object isn't just 'a dog' or 'a car', for something to be an object it must be a specific dog, or a specific car, though it doesn't matter which specific dog or car. To use the dog as an example, whether it is a 7lb, five year old goldendoodle named Scruffy who doesn't know how to play fetch or an 80lb 3 year old Burmese Mountain Dog named Happy who absolutely knows how to play fetch and hardly wants to do anything else (a very specific dog whom I happen to know) is not important. The key thing is that an object is not just 'a dog', its a specific dog, distinct from all other dogs through its unique characteristics. 

"Unique characteristics?" you might ask, "But what if we have two dogs of the same breed, same age, weight, name etc.? Are they distinct? Or in the ruby universe, would they be considered the same dog object?" The answer is that they are still distinct, even if they have the same characteristics. That said, it is pretty rare that you find two virtually identical dogs with the same name etc., so I wouldn't worry about this too much at this point. *High-level* remember?

So, we now know that objects aren't just a type of thing, they are a specific, distinct *instance*, one could say, of a type of thing. However, lets not lose sight of the fact that regardless of their individuality, there is some similarity from one dog to the next. They all have roughly the same body shape, have fur, walk on four legs, can bark, etc.. In other words, they share enough attributes and behaviors such that regardless of what specific dog we encounter, we can reliable count on the fact that it will look and act in certain ways which as a set are unique to dogs and make them recognizeable as dogs and not...moose for example...meese?...meesen?...moosen??? (truly, one of life's great mysteries). 

In any case, you could say that all dogs seem to belong to a specific class. In fact, in ruby, we can create a structure actually called a **class** for the very purpose of defining what special sauce goes into making a dog a dog. Let's call our dog class `Dog`. Defining this class allows us to be very specific about what that common set of behaviors it is that makes a dog a dog and not a cat or pencil or anything else, which leads us to ask what exactly is a class? What is it that lets us know that dogs are dogs and not *moose*? (I googled it, turns out its just plain old 'moose', real missed opportunity there if you ask me). In the physical world, its a set of attributes and behaviors that lets us know when we are looking at a dog. So, in ruby, how exactly does a class do the same? 

## What is a Class?
Remember when we made a distinction that an object is not just 'a dog' but rather a specific dog, distinct from all other dogs? Well a **class** is the flipside of that. A class can be thought of as the idea of a dog. The `Dog` class contains all the behaviors and attributes that make a dog a dog, regardless of which specific dog it is. It is a type, a category, a template from which all dogs are born out of and to which all dogs belong. 

In ruby, `class` is what tells us what an object is and what we can do with it. But its actually more important than that. In order to create an object at all, you must choose a class from which to create that object. In our comparison to the physical world, attempting to create a ruby object without a class would be like trying to create a physical object that has no attributes, like trying to create, well nothing. And so it is in ruby, you can't create 'nothing', every object has a class and every class defines a set of attributes and behaviors that are endowed upon that object when it is created. Next we will get into some specifics about how, and what it means to define those attributes and behaviors.

### Inheritance
In the previous paragraph, I gave the example that in the physical world, you can't create *nothing*. Whatever it is being created, it must at least have the attribute of mass. And if it has mass, it probably has a whole host of other pretty fundamental attributes of physical matter. So, does that mean we have to define all of those fundamental attributes for our dog class as well? Fortuanately, the answer is no, there is a shortcut, and that shorcut is called *inheritance*. Classes can inherit certain attributes and behaviors from a *superclass* (technically, classes don't inherit attributes, but in practice they are often implemented to do so).  For example, we could have a `Dog` class which inherits from a `Mammal` class, which inherits from a `Organism` class and so on and so on. In turn, we could go the other way can create a *subclass* of the Dog class called `Labrador` which would inherit certain attributes and behaviors. The Labrador class could inherit a `wag_tail` method from the Dog class. It could also inherit a `regulate_body_temperature` method from the Dog class, however, it's really inheriting that behavior from the Mammal class via the Dog class since all mammals are warm blooded. Inheritance permeates down through the inheritance structure. What this inheritance phenomenon does is it allows us to focus on defining only those things which seem unique to dogs and not worry about all the other behaviors which are common to all mammals, not just dogs. The same goes for the Labrador class, we can just focus on defining what makes a labrador a labrador.

This ability for classes to inherit behaviors from other classes allows use to create objects which are specialized to function in a variety of ways or otherwise serve various purposes in our code base without having to worry about as many specific details for each class as we otherwise might. It simplifies the process of reasoning about different types of data and what we can do with them. 

For example, assume we are working with data for a financial institution that offers many different types of accounts. Without some structure in place to organize common attributes and behaviors, I may need to remember a whole set of details for every type of account. I may need to remember that a brokerage account has:

*a quick note: attributes are not inherited automatically like methods are, however, in practice many attributes are, in a way, inherited, but it must be made explicit in the code for that to happen*

- an owner name
- an account number
- a list of currently held stocks and bonds
- a balance, and
- a transaction history 

While also keeping in mind that a checking account has

- an owner name
- an account number
- an associated debit card number
- a balance, and
- a transaction history

Instead, all I need to know that a checking account has a debit card number associated with it while a brokerage does not and instead has a list of stocks and bonds. Beyond that, I just need to know what features are common to all types of accounts. Similarly, I don't have to remember which method will return the balance for a checking account vs which will return the balance for a brokerage account. Since they both belong to a hypothetical parent class `FinancialAccount`, we can rely on one interface (set of methods) to interact with accounts of various subtypes. To put it more generally, as previously stated, we can work with a variety of different types of objects, each intended for a specific purpose, without having to consider erroneous details for each one which do not distinguish them from one another. Formally, this phenomenon is refferred to as **polymorphism**. Polymorphism is its own topic and can be accomplished by other means outside of hierarchical inheritance, but we will not be going into that here, though we may in another article.

#### Class Defines Attributes; Attributes Track State
As we've already covered, an object's class defines the object's attributes and behaviors. When we create an object, we can  supply values to those attributes (eg. we can give a Dog object XYZ name). However, we have not yet mentioned that we can change the  values bound to those attributes (eg. we can 'rename' our Dog object). How we do so is beyond the scope of this article but it is important to note that the *state* of an object is not fixed at the point of initialization. Rather, the **state** of an object is composed of its attributes, the values of which are subject to change. Thus, an object's attributes are said to *track* it's state. There is more to be said about the relationship between an object's class and its attributes/state as well as the relationship between object's class and the ability to modify its attributes/state (you need methods to change state and class defines methods) but for now the understanding that an object's state can be modified and that the object's class is important for how and to what extent these modifications occur is sufficient for now. 

## Summary
Hopefully, by now you are able see the relationship between objects and classes coming into clearer focus. Lets take stock of what we have covered so far and then see what some of these concepts look like in actual code. 

- objects are anything that has a value
- objects are not a *type* of thing, they are a specific and distinct *instance* of a type of thing
- classes provide a definition of behaviors and attributes, a template of sorts, from which objects are created
- objects of the same class share a set of attributes and behaviors as defined by the class, but are still distinct from one another
  - example: All pets have a name, but not all pets have the same name, and even if two pets share a name, they are not the same pet
- all objects must belong to a class; you cannot create an object without some characteristics to define what is being created, a class provides those characteristics (i.e. attributes and behaviors)
- classes can inherit certain characteristics (technically only behaviors, i.e. methods) from a *parent class* thereby allowing the *subclass* to concern itself with only those things which make it a distinct specialized type of the *superclass*. Think `Labrador` < `Dog` < `Mammal`.

### Code Examples
Here's some code to illustrate some of what we have discussed so far.


The code below shows how classes provide a template for creating objects of that class. It also shows that elements of that template can be inherited by a *subclass* (eg. `Dog`) from a *superclass* (eg. `Mammal`) thereby allowing `Dog` to concern itself with what makes it a specialized form of `Mammal` distinct from other subclasses of `Mammal`, such as `Human`.

```ruby
class Mammal
  def initialize
    @body_type = 'vertabrate'
    @method_of_reproduction = 'live birth'
  end

  def regulate_body_temperature; end

  def forage_for_food; end
end

class Human
  def initialize
    #calls the initialize method from the parent class so that 
    # it can initialize the Mammalian attributes. This is how
    # attributes can be set up to be inherited from a superclass
    super 
    @tail = false
    @hearing = 'subpar'
    @tool_use = true
  end

  def regulate_body_temperature
    sweat
  end

  def sweat; end

  def use_tool; end
end

class Dog < Mammal
  def initialize
    super 
    @tail = true
    @hearing = 'acute'
  end

 # notice both Dog and Human override regulate_body_temperature
 # This enables us to call that menthod on any mammal without worrying 
 # about how that mammal specifically accoplishes it 
  def regulate_body_temperature
    pant
  end

  def pant; end

  def bark; end
end

class Labrador < Dog
  attr_reader: name

  def initialize(name)
    super
    @name = name
    @size = 'medium'
    @temperment = 'friendly'
  end


  def retrieve; end

  def nuzzle_human; end
end
```
The code below demonstrates that even if you have two objects of the same class, with the same values bound to their respective attributes they are still distinct objects.

```ruby
a_dogs_name = 'fido'
fido1 = Labrador.new(a_dogs_name)
fido2 = Labrador.new(a_dogs_name)

puts "My name is #{fido1.name} and my doggie id is: #{fido1.object_id}" 
puts "My name is #{fido2.name} and my doggie id is: #{fido2.object_id}"
# `fido1` and `fido2` will have different doggie id (i.e. object id) numbers. 
```



# Modules
In the previous article about objects and classes we talked about what objects are and their relationship to their class, and how classes can inherit attributes and behaviors from other classes. We also mentioned how this allows for some consistency across classes allowing us to work across a variety of different objects using a simillar interface. We called this phenomenon **polymorphism**. In this article, we will discuss another code structure which enables another type of polymorphism, and which also serves a couple of other functions as well. This code structure is called a **module**.

### What is a Module?
A module is a code structure which contains methods or data which make sense to package together into a single unit, and it has use cases outside of polymorphism. Modules can be thought of as a way to containerize certain abilities and or information across a code base without needing to do so using inheritance heirarchy. In fact, sometimes modules are used to explicitly avoid potential conflicts that may arise within that heirarchy–a use case known as *namespacing* which we will discuss further in a moment. First however, I'll provide a cursory overview of the three types of use cases for modules and then discuss each one in turn and provide code examples.

- **Mixins**: a way to make sure a given class and its subclasses have access to a given set of functionality which might not make sense to define explicitly within a class definition
- **Namespacing**: a method by we can avoid causing potential naming conflicts among classes (eg. classes which have the same name but different implementations)
- **Container for methods**: a way to organize methods which may seem out of place to include elsewhere in the code base

## Mixins
 What does it mean for a module to be *mixed in* or included (mixed in and included mean the same) to a class? It means that just as with class based inheritance, a class can simillarly inherit an interface from a module. This type of inheritance is often refferred to as **interface inheritance*. When a module is mixed in to a given class, the objects of that class will then have access to all of the methods defined in the included module. Modules and classes should not be confused however, for one, you cannot instantiate an object from a module. In addition, in ruby a classes can only inherit from one superclass, while on the other hand, they can include as many modules as desired.

 When does it make sense to include a module in a class? When should we extract methods to a superclass vs extracting them to a module? These questions can be difficult to answer and are heavily dependent on the particular situation. However, one thing to consider is whether the functionality under consideration is needed consistently throughout multiple levels of the class inheritance heirarchy or is it needed only here and there accross the branches of that heirarchy? To illustrate, lets create some classes with the idea in mind that we are going to be mostly dealing with domesticated animals and so those animal classes' functionality is going to be important.

```ruby
class Human; end

class Dog 
  # needs ability to bark
end

class AustralianShephard < Dog
  # needs ability to bark
  # needs ability to herd other animals
end

class Greyhound < Dog
  # needs ability to bark
  # needs ability to race
end

class Clydesdale 
  # needs ability to haul loads
  # needs ability to pack loads
  # needs ability to trot
end

class QuarterHorse
  # needs ability to trot
  # needs ability to race
  # needs the ability to pack loads
  # needs ability to herd other animals
end

class Ox
  # needs ability to haul loads
  # needs ability to pack loads
end

class Camel
  # needs ability to trot
  # needs ability to race
  # needs ability to pack loads
end
```

If you feel overwhelmed looking at how complex our codebase has now become, do not worry, we will take it piece by piece. Let's start by looking at the `Clydesdale` and `QuarterHorse` classes. Here we can see that one of these  needs the ability to haul and pack loads as well as trot while the other needs the ability to race, pack loads, trot and herd other animals. It looks like the two classes both need the ability to trot as well as to pack loads. Perhaps we should extract those two abilities, trot and pack, to a superclass? Before doing so, lets look at the other classes. Do any of them also require either of those abilities? It looks like both `Camel` and `Ox` also need the abiity to pack a load, while `Camel` is the only other class that needs the ability to trot. So, at this point we need to decide which ability(s) makes sense to extract to a module vs extract to a superclass.

How do we decide...superclass or module? One thing to keep in mind when tyring to decide whether certain behaviors should be extracted to a superclass vs extracted to a module is to think of whether there is a *Class is a...* relationship vs *Class has a* relationship. Class inheritance makes most sense for the former while mixins make most sense for the latter. For example, `Clydesdale`s and `QuarterHorse`s *are a* type of horse and both types *have an* ability to trot and pack loads. So perhaps we should create a `Horse` superclass which has the ability to trot and pack loads? That is certainly one route we could choose to go. On the other hand, the pack and trot abilities are also needed by at least one other class. So, we could just leave the class inheritance structure as it is and extract those abilities to modules. 

This early in the development of the code it is tough to say which is best, there are going to be benefits and challenges inherit to either option. The ability to discern which would be most advantageous given the purpose of the code is something that develops as a programmer spends more and more time working with object oriented programming (OOP). For now, lets leave aside the question above about whether to create a `Horse` superclass or just leave it up to modules alone. Instead, we'll take a shot at some lower hanging fruit. 

We can see a pretty clear case for extracting the race ability to a module given that there likely isn't going to be a useful superclass from which `Camel`, `QuarterHorse`, and `Greyhound` can all inherit. Sure, one could make the argument that they are all domesticated mammals and we could inherit from a hypothetical `DomesticatedAnimal` class and define a race method there. However, if we were to do that, we would probably also need to include all the other classes as well and it probably doesn't make sense for the Ox and Clydsedale classes to have a race method. So, lets just extract the race ability/method/behavior (however you want to call it) to a module called `Raceable`. I think there is also a good argument for doing the same for the herding, packing, and hauling abilities, so lets also create modules for those too.

```ruby
module Herdable; end

module Packable; end

module Haulable; end

module Raceable; end


class Human; end


class Dog
  # needs ability to bark
end

class AustralianShephard < Dog
  include Herdable
  # needs ability to bark
end

class Greyhound < Dog
  include Raceable
  # needs ability to bark
  
end

class Clydesdale 
  include Herdable, Packable
  # needs ability to trot
end

class QuarterHorse
  include Herdable, Raceable, Packable
  # needs ability to trot
end

class Ox
  include Herdable, Packable
end

class Camel
  include Raceable, Packable
  # needs ability to trot
end
```

Now we have a codebase which is much more containerized. We dont need to worry about defining methods for each of those abilities for each class. With our hypothetical methods organized into modules we can follow the DRY principal, *don't repeat yourself*. This does not mean we are finished however, we can see that there are still some questions to be answered. How do we want to handle trot? The bark behavior should probably be extracted to the `Dog` superclass. And what about `Human`? Do we want that class to have certain functionalities? If we include `Packable` in `Human` will it still work given that human sized loads will be minescule in comparison to those of the other animal classes? In OOP its difficult to know the right answer, in fact there really isn't a right answer, just tradeoffs. The important thing is to be aware of practices which will inevitably lead you to the *wrong* answer...but that is a topic for another article. 

## Namespacing
**Namespacing** is the term given for when we use modules as a container for grouping related code structures, primarily classes though can also hold things like constants too. There are two main benefits to namespacing:

- It makes it easy to recognize related classes in our code
- Aids in avoiding conflicts between similarly name classes in our code base

To make this concept concrete lets think about a specific example. Lets assume that we are creating an inventory of tools carried by a large tool manufacturer. This tool manufacturer makes hand tools that are for small household jobs, as well as for working on massive mining equipment and othe sizes in-between. Despite the wide range of size and usage contexts, many of the tools have the same names. Therefore, it is important we don't mix things up. So, lets organize our classes into two different namespaces, `Household` and `Mining`.

```ruby
module Household
  class CrescentWrench; end
  class Drill; end
  class Ratchet; end
  class Socket; end
end

module Mining
  class CrescentWrench; end
  class Drill; end
  class Ratchet; end
  class Socket; end
  class SledgeHammer; end
end
```

For the code snippet below, assume the necessary implmentation details for the classes involved have been created despite not being shown above.

```ruby
Mining::Drill.start_inventory
HouseHold::Drill.start_inventory

puts Mining::Drill.current_inventory #=> 855
puts Household::Drill.current_inventory #=> 3_493
```

Because we have created distinct namespaces, the code above is easy to read and makes it clear which type of drill we are taking an inventory of.  

## Container for Methods
We've already mentioned that we can use a module as a 'container' in the namespace use case. And what is a mixin if not a container specifically for methods? So, what do we mean when we say the third use case for module is as a container for methods? Well, we are talking about a module which contains methods which aren't meant to be called on instance objects. We're not trying to give some added functionality to a certain class as with mixins or group classes together as with namespacing. Rather, we are providing a set of methods which can be called on the module itself and provide some functionality that is fairly self contained. For example, using our tools classes from above, we could create a module which provides us with various unit conversions, such as from imperial to metric units. Implementing this functionality in some class or module  would needlessly complicate those structures and potentially create unnecessary dependencies down the road. Unit conversion is something that is broadly useful in a variety of contexts. In other words, unit conversion can occur nearly regardless of the context, unlike iteration for example, which requires a collection to operate on in order to be useful. Therefore, it makes sense to make this functionality fairly indepent in our codebase as well. 

For this example, we cant to create a number of household sized sockets in both metric and imperial unit sizes, and we want the quantity of each type to be balanced. After creating the sockets, we will check the number of 10mm sockets and their imperial equivalent (its 5/8" if curious).

```ruby
module Convertable
  def self.mm_to_inch(milm)
    # code ommitted
  end
end

METRIC_SOCKET_SIZES = ['10mm', '12mm', '14mm']
all_sockets = []

# create sockets
METRIC_SOCKET_SIZES.each do |metric_size|
  imperial_size = Covertable.mm_to_inch(metric_size)

  10.times {all_sockets << Household::Socket.new(metric_size)}
  10.times {all_sockets << Household::Socket.new(imperial_size))}
end

#check socket quantities are balanced
ten_milm_n = all_sockets.count('10mm')
five_eigths_n = all_sockets.count(Convertable.mm_to_inch('10mm')

p ten_milm_n #=> 10
p five_eigths_n #=> 10
```

## Summary
Lets review what we've learned so far. The three use cases for modules are:
  - Mixins
    - Provides functionality to classes via inhertance outside the class heirarchy
    - Sometimes referred to as **interface inheritance**
    - use `include` followed by module name
    - important to consider tradeoffs of using class inheritance vs including a module
  - Namespacing
    - used to easily identify related classes as belonging to a group
    - also used to avoid conflicts with simillarly name classes across code base
    - use `ModuleName::ClassName` syntax
  - Container for methods not belonging elsewhere
    - used to define methods called on the class itself which house functionality that doesn't make sense to define elsewhere