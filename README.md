# COMP 360 – Assignment 3  
## Robot Simulation Game (Godot 4)

### Team Members
- Jasmine  
- Bao  
- Akshit Marwaha
- Manmeet Singh
- Bhavik Wadhwa
- Michael Bassi
- Unnati Sharma
  

---

## Project Overview

This project is a 3D interactive robot simulation built using **Godot Engine 4**. The objective of the assignment is to demonstrate core computer graphics and game engine concepts, including scene construction, physics interactions, collision detection, particle systems, materials, and camera control.

The project features a controllable robot player that interacts with destructible objects inside a simple arena. When objects are smashed, particle effects are triggered and collectible coins are spawned, providing visual and gameplay feedback.

---

## Key Features

- 3D arena constructed using mesh primitives (floor, walls, obstacles)
- Controllable robot player with collision detection
- Breakable objects that respond to player interaction
- Particle effects for:
  - Box destruction (sparks / impact effects)
  - Environmental feedback
- Coin spawning and collection mechanics
- Camera system using `Camera3D` and `SpringArm3D`
- Physics-based interaction using collision shapes
- Export-ready Windows executable

---

## Project Structure
```
res://
├── a-3/ # Robot scene and scripts
├── greyboxing/ # Arena layout and environment meshes
├── breakable_box.gd # Box destruction logic
├── breaker_area.gd # Collision detection for breaking objects
├── coin.gd # Coin behavior logic
├── particle_controller.gd# Particle effect management
├── coin.tscn # Coin scene prefab
├── greyboxing.tscn # Main environment scene
├── project.godot # Godot project configuration
├── icon.svg # Project icon
└── README.md # Project documentation
```

---

## Scene Description

### Main Scene – `greyboxing.tscn`

- Contains the arena floor, walls, obstacles, robot player, camera, lighting, and interaction areas
- Serves as the main gameplay environment
- All interactive elements are positioned and configured within this scene

### Coin Scene – `coin.tscn`

- Instantiated dynamically when a breakable object is destroyed
- Contains its own collision shape and logic for collection

---

## Technical Implementation

### Robot Player

- Implemented using `CharacterBody3D`
- Collision handled via `CollisionShape3D`
- Movement and interaction logic driven by Godot’s physics system
- Includes a robot arm used for smashing objects

---

### Breakable Objects

- Implemented as mesh-based objects with collision shapes
- On collision with the robot’s breaker area:
  - Trigger particle effects
  - Spawn a coin instance
  - Remove the object from the scene

**Core logic (simplified):**
```gdscript
if robot_hit:
	spawn_particles()
	spawn_coin()
	queue_free()
```

## Particle Systems

Particle systems are implemented using `GPUParticles3D`.

Effects include:
- Impact sparks when a box is destroyed
- Visual feedback during interaction events

Particles are controlled centrally through `particle_controller.gd` to ensure consistency and prevent unnecessary re-instantiation.

---

## Camera System

- Implemented using `Camera3D` attached to a `SpringArm3D`
- Prevents camera clipping with environment geometry
- Camera follows the robot while maintaining a playable view
- Adjustable field of view and camera distance for clarity

---

## Physics and Collision

- Physics interactions handled using Godot’s built-in physics engine
- Collision shapes aligned with visual meshes for accurate detection
- Breaker area used to detect smash interactions
- Careful tuning applied to ensure reliable object destruction without instability

---

## Controls

- Movement keys mapped using Godot’s `InputMap`
- Robot movement and interaction handled via keyboard input
- Camera behavior handled automatically through the SpringArm system

---

## Known Issues and Challenges

The following challenges were encountered and resolved during development:

- Missing `.import` and `.godot` directories caused project load failures after cloning
- Scene reference errors due to invalid UIDs after repository transfer
- Camera clipping and unclear angles resolved using `SpringArm3D`
- Physics tuning required for consistent box destruction
- Particle visibility adjusted without sacrificing performance
- Audio driver warnings during debug mode (non-critical)

These challenges demonstrate debugging, problem-solving, and engine-level understanding.

---

## Build and Export

- Platform: Windows
- Export preset configured in Godot
- Main scene set to `greyboxing.tscn`
- Export tested outside the editor to confirm functionality

---

## Team Contributions

**Jasmine**
- Created a spark particle system that triggers when the robot arm destroys the box
- Animated obj3 to move back and forth for the simulation
- Built the initial greyboxed environment using MeshInstance3D (floor, walls, objects)
- Applied Bao’s materials to the 3D layout (floor, walls, objects)

**Bao**
- Programmatic Texture Generation System
- Complete Material Library
- Material Setup Automation
- Technical stuff: use noise algo, pattern generation, color gradients

**Bhavik Wadhwa**
- Implemented the RobotPlayer controller using CharacterBody3D
- Added third-person camera system using SpringArm3D and Camera3D
- Integrated robot arm animations (idle, grab, pickup) with gameplay input
- Designed and implemented smash interaction system using Area3D
- Integrated breakable box destruction with coin spawning
- Fixed coin pickup logic to prevent instant despawn
- Handled collision tuning, animation locking, and interaction debugging
- Managed Git integration, merging, and repository synchronization

**Manmeet Singh**

Windows Executable Export

- Set up and configured the Windows Desktop export preset, ensuring the project builds correctly as a standalone .exe.
- Verified resource inclusion, compression formats, and architecture settings.
- Tested the exported build to confirm proper loading and gameplay functionality.

Path3D Spline Adaptation

- Implemented a procedural movement system using Path3D, Curve3D, and PathFollow3D.
- Created the path_mover.gd script to animate a mesh along a looping spline with visible rotation.
- Integrated the spline system into the main arena to meet the adaptation requirement.

Custom Font + Animated UI Adaptation

- Added the Sansita custom font and created a polished UI title overlay.
- Developed ui_title.gd to animate the title with fade-in and floating motion.
- Ensured UI elements integrate cleanly into the main scene without affecting gameplay.

Stability & Integration Work

- Resolved missing resource references and UID issues after project import.
- Confirmed all added systems (UI, spline, export) run without errors.

**Akshit Marwaha**
- Assisted with mesh placement and physics setup
- Created full project documentation and README
- Handled debugging & project recovery

**Michael Bassi**
- Added background buildings around the arena to improve the overall visual environment
- Implemented a blue sky background using Godot’s WorldEnvironment and ProceduralSkyMaterial
- Adjusted the arena layout and boundary walls to better frame the playable area without affecting gameplay

**Unnati Sharma**
- Implemented breakable object mechanics in a Godot 4 3D robot simulation using collision-based interactions and object lifecycle management (queue_free).
- Developed dynamic coin spawning logic triggered by object destruction, integrating gameplay feedback with existing interaction and particle systems.
- Integrated gameplay interaction logic with the robot’s smash system to ensure reliable object destruction and collectible behavior.
---

## Licenses
- Creative Commons CCO: Kenney 2D Particle Pack used for spark particles

---

## Conclusion

This project demonstrates fundamental computer graphics concepts through an interactive 3D Godot simulation. By integrating physics, particles, collision detection, materials, and camera control, the project fulfills all COMP 360 Assignment 3 requirements and provides a clear demonstration of real-time rendering and interaction using Godot 4.

## GitHub Repository

[GitHub Repository](https://github.com/jasmine6612/Comp360A3)
