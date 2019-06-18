# Pixelist

Pixelist provides a simple command line application to manipulate pixel
matrices stored in text files. It comes with a set of commands to create
a matrix or set pixels and a set of workers which run algorithms on a
pixel matrix.

The pixel matrix is stored in a text file, which can be edited in a text
editor. Each character is representing one pixel.

There is a plugin framework which can be used to add workers which run
on a pixel matrix. This can be used to implement algorithms such as
[Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life):

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

## Running in docker

There is a Dockerfile you can use to build a container in which you can run
pixelist. Build the container by executing a command like

    docker build -t pixelist .

Then run the container with

    docker run -t pixelist

This will execute the default command which runs the game of life.

To execute another command run it with a command such as

    docker run pixelist bin/pixelist -p examples/life.pixels show
