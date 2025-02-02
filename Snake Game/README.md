# Snake Game in Ruby (Ruby2D)
<p align="center">
  <img width="480" alt="Snake" src="https://github.com/user-attachments/assets/04730c10-bc38-4b64-9589-661e0bb030c8" />
</p>
This is a simple Snake game built using Ruby and the Ruby2D library. The game features a moving snake that grows when it eats food, and the game ends if the snake collides with itself.

## Features

- The snake starts in the **middle of the screen**.
- The snake moves in four directions: **up, down, left, and right**.
- The game generates **random food** on the screen.
- The snake **grows** when it eats food.
- **Game Over** occurs when the snake **collides with itself**.
- Display **score** at the top of the screen.
- Press **'R'** to restart after Game Over.

## Installation

1. Install Ruby on your system if not already installed.
2. Install the Ruby2D library by running:
   ```sh
   gem install ruby2d
   ```

## How to Run

1. Clone this repository or download the source code.
2. Navigate to the project folder.
3. Run the game using:
   ```sh
   ruby snake_game.rb
   ```

## Controls

- **Arrow Keys**: Move the snake (**Up, Down, Left, Right**)
- **'R'**: Restart the game after Game Over

## How It Works

- The snake moves continuously in the current direction.
- When it eats food, it grows, and a new food piece appears randomly.
- If the snake **hits itself**, the game ends.
- The score updates each time food is eaten.

## Dependencies

- **Ruby** (Version 2.7 or later recommended)
- **Ruby2D**

---

### Enjoy the game! 🎮
