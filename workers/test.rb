require "curses"

Curses.init_screen

begin
  win = Curses.stdscr
  x = win.maxx / 2
  y = win.maxy / 2
  win.setpos(y, x)
  win.addstr("Hello World")
  win.refresh
  win.getch
ensure
  Curses.close_screen
end
