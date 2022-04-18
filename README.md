# Graphics & Animation (CITS3003) Project 2022

## Project Description
You are required to complete an implementation of a simple scene editor
that allows a collection of objects to be arranged in a scene and various
properties of them to be changed, such as colour, shininess, and texture.

## Notes
Only the files within the project's `src` folder have been included in
this respository. Other files such as the texture can be obtained from the zip files that were provided with the project.

## Building & Running
Navigate to the project folder and run the following commands:
- `cmake --build cmake-build --target clean` (for a clean build if needed)
- `cmake -S . -B cmake-build` to generate build files (only needed to be done once)
- `cmake --build cmake-build` to build project (must be run every subsequent time when .cpp file has been edited)
- `./start_scene` to run the project
