# Elixir Bridge Notes (September 8th, 2018)
Seattle, WA

## General
* Elixir is a compiled language. Modules are compiled alphabetically.
* It is zero-indexed.
* OTP - fault tolerant concurrency
* There are two types of processes in elixir - supervisors and worker. The supervisors watch the workers and have info on what to do when they fail.
* Using `:observer.start` will show us what is happening inside the Erlang vm.
* The Erlang vm is referred to as the "beam".

## Types
* Elixir is not statically typed. But, it does have types.
* Elixir has numbers, floats, booleans, strings, atoms, lists, and tuples.
* Strings are values between double quotes and are UTF-8 encoded. 
* To output strings to the console use `IO.puts("hi")`.
* Elixir has string interpolation. For example -  `"Hello #{receiver}`
* The concatenation operator is  `<>`
* Atoms in Elixir are constants.

## Pattern Matching
* Elixir doesn't have classic assignment, it has pattern matching. For example, `[h | tail] = [1, 2, 3]`
* Lists allow pattern mattching. Tuples allow pattern matching.
* If we try to match patterns of different sizes, we'll get a `MatchError`.
* Putting the pin operator (`^`) in front of the variablewill match against the constents of the variable. In other wrods, we will keep the value of the variable, rather than bind that variable to a new value.

## Operators 
* Use `++` and `--` for list manipulation.
* `and`, `or`, and `not` are the boolean operators.
* The `or` and `and` operators are referred to as short-circuit operators as they execute the left-side first and only execute the right side if necesary.
* Elixir has `==` and `===`, but because Elixir won't coerce your values types. You'll only need to use `===` for integers and floats.

## Data Structures
* Elixir has singly linked lists (called lists). There are no arrays.
* Tuples store a fixed number of elements between currrly braces. Tuples are ordered, but accessing by position in the tuple isn't often. Tuples are generally used for pattern matching.
* Keyword lists are special kinds of lists. They are a list of tuples where the first element in each tuple is an atom. For example, `[greeting: "hello", receiver: "world"]`
* Keys in keywords lists are atoms, ordered, and not unique.
* Keyword lists are still lists. 
* Maps in Elixir are key-value stores. Maps can be created using `%{}` syntax. Keys in maps can be any type. Maps are unordered. 
* An example of nesting various data structures - 
```
users = [
    john: %{name: "John", age: 27, languages: ["Arabic, French, Elixir"]}
    mary: %{name: "Mary", age: 32, languages: ["German, Erlang, Elixir"]}
]
```
* Retrieve variables using bracket or dot notation. For example, `users[:john].age`.

## Pipe Operator
* The `|>` pipe operator passes the result of one function on to the next function. 
* That means this `f(d(b(:atom)))` becomes `b(:atom) |> d() |> f()`
* Use pipes when you want to transform a request type or build up a data structure with different functions.

## Enumerables
* If we invoke a function in the Enum module, the first arugment is usually a collection that must implement a certain protocol. 
Example of using Enum - 
```
Enum.map([1, 2, 3], fn(x) -> x * 2 end)
Enum.reduce(1..3, 0, fn(x, acc) -> acc + x end)
Enum.reduce(1..3, 0, &+/2)
```
`Enum.map` returns a list where each item is the result of invoking `fn` on each respective item of the enumerable.    
`Enum.reduce` invokes a function for each element in the enumberable, and passes each element and the accumulator as arguments.
* Enums have a bunch of other helpful methods including `Enum.chunk`, `Enum.max`, `Enum.sort`, `Enum.uniq`, `Enum.all?`, `Enum.any?`.
* To see all functions available to `Enum` use `Enum.__info__(:functions) |> Enum.each(&(IO.inspect(&1)))`.

## Lazy and Eager Loading
* Eager loading is when all operations need to execute before completion.
* Lazy loading allows you to start your operations before your file is fullt loaded into memory.
* Streams in Elixir are composable are lazy enumerables. A stream is any enumerable that generates items one by one.
* `Stream.cycle/1` will create a stream that will cycle through a given enumerable infinitely. For example, `Stream.cycle([1,2,3])`.
* `Stream.take(enum,count)` takes the numbers of items from the enumerable equal to the count, and stops the enumeration. For example, `Stream.cycle([1, 2, 3]) |> Stream.take(10) |> Enum.to_list`
* Note - `Stream.cycle` will run infinitely


## Modules
* Modules group together related functions
* Create constants in modules using module attribtues (with `@`).
```
defmodule Calc do
    @note "Fancy"
    def desc() do
        ~s(#{@note} calculator)
    end
end
```
* Structs are built upon maps. 
* Using `defstruct` we define what fields the struct will have along with their default values. 
* Structs take the name of the module they are defined within.
* Structs provide a compile-time guarantee that only the fields defined in `defstruct` are allowed to exist in the struct.
```
defmodule Calc.Op do
    defstruct name: "add", a: 1, b: 1
end
```
* `import` allows us to bring in functions from other modules
* `require` ensures a module is compiled and loaded in another module. 

## Functions
* In Elixir functions can be anonymous, in modules, or inline functions.
* Functions in elixir have implicit return. There is no return function.
  
Example of anonymous function - 
```
add = fn a, b -> a + b end
```
  
Example of functions in modules - 
```
defmodule Foo do
    def hashtag(word) do
        "#" <> word
    end
end
Foo.hashtag("elixir")
```
  
Examples of inline functions - 
```
def hashtag(word), do: "#" <> word
```
  
* There is pattern matching with functions. For example - 
```
defmodule Social do
    def hashtag({:twitter, word}), do "#" <> word <> "#twitterisgreat"

    def hashtag({:facebook, word}), do "#" <> word <> "#facbeookislovely"
end
```
* Patterns are matched in the order that they appear in the file. 

* To create a private function, use the `defp` keyword.
```
defp add(a, b) do
    a + b
end
```

## Supervisors
* A process is a small self-contained program. A supervisor is a process that watches over other processes (child processes).

## Control Structures
* The `case` function allows us to compare a value against several patterns until we find one that matches.
* The `cond` function allows us to check against the condition which evaluates to true rather than different values.
* We can check a single value by using the `if` and `unless`.
* We can use `else` in our `if` and `unless` blocks as well.
* `do/end` blocks allow us to define a start and end block to be executed if a condition has been met.

## Recursion
* Data in Elixir is immutable, so we don't have traditional loops. Instead we use recursion. We recursively call a function until we hit a condition (base case).
Example of recursion in Elixir -
```
defmodule Recursion do
    def each(x) do
        [head | tail] = x
        function.(head)
    end
end
```
  
Example of fibonacci fn in Elixir -
```
defmodule Math do
    def fibonacci(x) when x <= 1, do: x
    def fibonacci(x), do: fibonacci(x - 1) + fibonacci(x - 2)
end
```
* Elxir implement recursive functions efficiently, so we can rely on recursive statements safely. 

## More resources
* ElixirSchool
* Programming Phoenix (new version coming!)
* Elixir in Action (new version coming!)