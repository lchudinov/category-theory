const width = 10;
const height = 10;

// Инициализируем случайное поле
let grid: number[][] = Array.from({ length: height }, () =>
  Array.from({ length: width }, () => Math.random() < 0.3 ? 1 : 0)
);

function printGrid(grid: number[][]) {
  console.clear();
  console.log(
    '\n' + grid.map(row => row.map(cell => (cell ? "🟩" : "⬛")).join("")).join("\n") + '\n'
  );
}

function nextGen(grid: number[][]): number[][] {
  const newGrid = grid.map(row => [...row]);

  for (let y = 0; y < height; y++) {
    for (let x = 0; x < width; x++) {
      let neighbors = 0;

      for (let dy = -1; dy <= 1; dy++) {
        for (let dx = -1; dx <= 1; dx++) {
          if (dx === 0 && dy === 0) continue;
          const ny = y + dy;
          const nx = x + dx;
          if (ny >= 0 && ny < height && nx >= 0 && nx < width) {
            neighbors += grid[ny][nx];
          }
        }
      }

      const cell = grid[y][x];
      if (cell === 1 && (neighbors < 2 || neighbors > 3)) newGrid[y][x] = 0;
      else if (cell === 0 && neighbors === 3) newGrid[y][x] = 1;
    }
  }
  return newGrid;
}

// Запускаем симуляцию
setInterval(() => {
  printGrid(grid);
  grid = nextGen(grid);
}, 500);
