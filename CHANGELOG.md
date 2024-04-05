# Changelog

## [1.1.0](https://github.com/SinaBYR/analogue.nvim/compare/v1.0.1...v1.1.0) (2024-04-05)


### Features

* add :AnaloguePosition command to change clock's position in current neovim instance ([a4428b2](https://github.com/SinaBYR/analogue.nvim/commit/a4428b23951ff17b1ea6f7dfde8d625303e68ffe))
* finish implementation of :AnaloguePositionY command ([4405ec6](https://github.com/SinaBYR/analogue.nvim/commit/4405ec69d24eb1cec3b2cac160417d45c655c203))
* implement :AnaloguePositionX command ([9eb3f0e](https://github.com/SinaBYR/analogue.nvim/commit/9eb3f0e5fc63950b518d0bb8e7f9b0a3de1771bc))


### Bug Fixes

* preserve adjusted position after AnalogueReset execution ([6cd0d13](https://github.com/SinaBYR/analogue.nvim/commit/6cd0d13b1d766b2c4191ba28364bcb541976da81))
* subtract lualine height from clock's position on y axis ([ef79f84](https://github.com/SinaBYR/analogue.nvim/commit/ef79f843656ef21dc90d99746e10cc9082e80a49))

## [1.0.1](https://github.com/SinaBYR/analogue.nvim/compare/v1.0.0...v1.0.1) (2024-04-02)


### Bug Fixes

* debug AnalogueReset functionality for other fixed positions ([f0ffb88](https://github.com/SinaBYR/analogue.nvim/commit/f0ffb88f61c1929f925e03a4181d808bf161501c))
* get rid of win_fixed_positions by adding function to return desired table ([a792ec6](https://github.com/SinaBYR/analogue.nvim/commit/a792ec62c73607e25e7e8047d19504e36b3daa54))
* share fixed_position value with commands by storing it in command cache ([0e5f265](https://github.com/SinaBYR/analogue.nvim/commit/0e5f2651866ccf62c7aa1c9da58928ec5e0aebdb))

## 1.0.0 (2024-01-05)


### Bug Fixes

* update release workflow ([79c8675](https://github.com/SinaBYR/analogue.nvim/commit/79c867585c2d72bfcd3fcfdb69eccada02bf79c5))
