# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

## [Unreleased]

## [1.0.0] - 2024-08-27

### Added

- 完成时钟配置和引脚配置，完成计数的主体实现

### Waited

- 声音模块
- 闹钟、设置时间、闪烁等功能

## [2.0.0] - 2024-08-28

### Added

- 秒、分、时的进位功能的主体实现完成

### Waited

- 声音模块
- 闹钟、设置时间、闪烁等功能

## [3.0.0] - 2024-08-29

### Added

- 新增整点报时模块、设置时间时闪烁模块
- 完成设置时间时输入保护模块

### Changed

- 优化了部分代码存在的问题。

### Waited

- 存在时钟不同步，进位慢一秒的情况
- 准点报时的扬声器无法发声
- 闹钟功能

## [4.0.0] - 2024-08-30 中期检查

### Changed

- 修复准点报时模块，可以正常发声。--- 推测问题为箱子引脚存在问题。

### Waited

- 闹钟功能无法正常运行

## [5.0.0] - 2024-08-31

### Added

- 修复闹钟模块
- 修复准点时Striking_pulse_generator模块传出信号异常的情况

### Changed

- 修改了部分代码逻辑，修改部分always块中的时钟检测方式
