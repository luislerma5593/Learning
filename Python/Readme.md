# Python

## OOP

- A variable stored in an instance or class is called an **attribute**.
- A function stored in an instance or class is called a **method**.

### Class
```py
class Animal: 
    def __init__(self, name, color):
        self.name = name
        self.color = color

class Cat(Animal):
    def purr(self):
        print("Purr...")
        
class Dog(Animal):
    def bark(self):
        print("Woof!")

fido = Dog("Fido", "brown")
print(fido.color)
fido.bark()

super().spam() - Look for the spam() method int he superclass
```

### Magic methods
```py
More magic methods for common operators:
__sub__ for -
__mul__ for *
__truediv__ for /
__floordiv__ for //
__mod__ for %
__pow__ for **
__and__ for &
__xor__ for ^
__or__ for |

Python also provides magic methods for comparisons.
__lt__ for <
__le__ for <=
__eq__ for ==
__ne__ for !=
__gt__ for >
__ge__ for >=

There are several magic methods for making classes act like containers.
__len__ for len()
__getitem__ for indexing
__setitem__ for assigning to indexed values
__delitem__ for deleting indexed values
__iter__ for iteration over objects (e.g., in for loops)
__contains__ for in
```

### Class Methods

Class methods are different - they are called by a class, which is passed to the cls parameter of the method.
```py
class Rectangle:
    def __init__(self, width, height):
        self.width = width
        self.height = height

    def calculate_area(self):
        return self.width * self.height

    @classmethod
    def new_square(cls, side_length):
        return cls(side_length, side_length)

square = Rectangle.new_square(5)
print(square.calculate_area())

# new_square is a class method and is called on the class, rather than on an instance of the class. It returns a new object of the class cls.
```

### Static Methods

Static methods are similar to class methods, except they don't receive any additional arguments; they are identical to normal functions that belong to a class.
```py
class Calculator:
    #your code goes here

    @staticmethod   
    def add(n1, n2):
        return n1 + n2
        
n1 = 5
n2 = 6

print(Calculator.add(n1, n2))
```

### Properties

They are created by putting the property decorator above a method, which means when the instance attribute with the same name as the method is accessed, the method will be called instead.
```py
class Pizza:
    def __init__(self, toppings):
        self.toppings = toppings

    @property
    def pineapple_allowed(self):
        return False

pizza = Pizza(["cheese", "tomato"])
print(pizza.pineapple_allowed)
pizza.pineapple_allowed = True
```

## Regex

```py
re.match(pattern,word) - Verify if the beginning of the word matches with the pattern
re.search() - Finds a match of a pattern anywhere in the string
re.findall() - Returns a list of all substrings that match a pattern
re.finditer() - Does the same thing as re.findall, except it returns an iterator, rather than a list
re.sub(pattern, "Amy", str) - Replace the pattern with "Amy" in the string

# pattern ? r"pam"
# "eggspamsausage"

match.group() -> pam
match.start() -> 4
match.end() -> 7
match.span() -> (4,7)
```
### Metacharacters
```py
. (dot) - Match any character
^ - Starts with
$ - Ends with
[] - Match only one of a specific set of characters.
[^...] - Invert a character class
* - 0 or more occurrences of the preceding expression
+ - 1 or more occurrences of the preceding expression
? - Zero or one repetitions
{x,y} - Can be used to represent the number of repetitions between two numbers
() - Creates a group
| - Or
\n (1-99) - Verifica si se repite n veces
\d - Digit
\s - Space
\w - Word
\D - Anythind not digit
\S - Anything not space
\W - Anything not word
\A - Match the beginning if a string
\Z - Match the end of a string
\b - Match empty string or characters  between words or numbers 
```


## Pythonicness & Packaging

```py
```

```py
```

```py
```

```py
```