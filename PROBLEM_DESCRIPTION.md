## Problem Description

It's a my solution for `Level III, Q1` task from https://dl.funbox.ru/qt-ruby.pdf (Ruby developer vacancy - https://funbox.ru/vacancies/ruby-developer ).

Problem statement is next:

Write an `nmax` script that does the following:
- reads text data from the incoming stream;
- on completion of the input outputs the `n` largest integers found in received text data.

Additional Notes:
- a number is any continuous sequence of numbers in text;
- it is known that there are no numbers longer than 1000 digits in the input data;
- number `n` should be the only parameter of the script;
- the code must be covered by tests;
- code should be designed as a gem (containing an executable file, code modules, etc.);
- plus is hosted on Github and integration with Travis CI.

Example runtime:

```
cat sample_data_40GB.txt | nmax 10000
```
