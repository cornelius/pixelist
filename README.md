# Pixelist

Pixelist provides a simple command line application to manipulate pixel
matrices stored in text files. It comes with a set of commands to create
a matrix or set pixels and a set of workers which run algorithms on a
pixel matrix.

The pixel matrix is stored in a text file, which can be edited in a text
editor. Each character is representing one pixel.

There is a plugin framework which can be used to add workers which run
on a pixel matrix. This can be used to implement algorithms such as
[Conway's Game of Life]:

```
Pixelist Life (step 50)
+--------+
|        |
|        |
|  O     |
|   OO   |
|  OO    |
|        |
|        |
|        |
+--------+
```

Pixelist is meant for experimenting with algorithm which operate on a simple
pixel matrix and learn or experiment with programming techniques such as TDD.
If you find creative use for it, please
[let me know](mailto:schumacher@kde.org).
