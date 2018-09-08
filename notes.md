# Elixir Bridge Notes (September 8th, 2018)
Seattle, WA

## Types
* Elixir is not statically typed. But, it does have types.
* Elixir has numbers, floats, booleans, strings, atoms, lists, and tuples.
* Strings are values between double quotes and are UTF-8 encoded. 
* To output strings to the console use `IO.puts("hi")`.
* Elixir has string interpolation. For example -  `"Hello #{receiver}`
* The concatenation operator is  `<>`
* Atoms in Elixir are constants.

## Operators 
* Elixir doesn't have classic assignment, it has pattern matching. For example, `[h | tail] = [1, 2, 3]`
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