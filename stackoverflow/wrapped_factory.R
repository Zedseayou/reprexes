power_factory <- function(exp) {
  function(x, text = "default") {
    print(text)
    x ^ exp
  }
}

power2 <- power_factory(2)
power2(3)

wrapped_factory <- function(exp, x, text2) {
  print("I am wrapped")
  power_fun <- power_factory(exp)
  power_fun(x, text = text2)
}

wrapped_factory(2, 3, "my_string")
wrapped_factory(2, 3)

foo <- function(arg1, arg2 = "bar") {
  print(arg1)
  print(arg2)
}
foo("input")
foo("input", foobar)


I suspect that my misunderstanding is something to do with how missing/default arguments in functions are handled, or something to do with the environment at which things are evaluated, but I'd love some clarification.

Say we have some function factory like `power_factory`. Its output function has an argument with a default, here `text`. If we call the factory and then the output function with a missing `text` argument, the default works as expected.

<!-- language-all: lang-r -->

    power_factory <- function(exp) {
      function(x, text = "default") {
        print(text)
        x ^ exp
      }
    }

    power2 <- power_factory(2)
    power2(3)
    #> [1] "default"
    #> [1] 9 # 2 ^ 3 = 9

Now we want to wrap the factory, basically placing it and its output function's arguments on the same level. (Of course this is a convoluted way to achieve the output but bear with me)


wrapped_factory <- function(exp, x, text) {
  print("I am wrapped") # some operation that might justify wrapping
  power_fun <- power_factory(exp)
  power_fun(x, text)
}

Now if I call with the `text` argument supplied it works fine, but if I do not supply it I get an error, and not where I might expect. The error is that the output function `power_fun` is missing its argument, not that the wrapped function `wrapped_factory` is missing its argument.

wrapped_factory(2, 3, "my_string")
#> [1] "I am wrapped"
#> [1] "my_string"
#> [1] 9
wrapped_factory(2, 3)
#> [1] "I am wrapped"
#> Error in power_fun(x, text): argument "text" is missing, with no default

I have two stories here:

  1. I originally expected the second call to work, since if `text` is missing when `power_fun` is called I thought it would revert to the default value.
2. When it failed, I thought that this would be because `wrapped_factory` has no default for `text` and so when it attempts to be evaluated, it cannot be found. However, the error says that it is the `text` argument of `power_fun` that is missing.
