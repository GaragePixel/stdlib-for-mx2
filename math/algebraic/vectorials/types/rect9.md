---
### Rect9 Implementation (GaragePixel/iDkP, 2025-05-19, Aida v1.0)

#### Purpose

The `Rect9` class is a highly versatile mathematical primitive for Monkey2/Wonkey, enabling efficient manipulation of rectangles subdivided into nine regions (the "9-patch" technique). This is essential for scalable UI elements, advanced skinning, bitmap borders, and other graphics or logic operations requiring region-aware scaling and padding.

#### List of Functionality

- **9-patch Geometry**: Models a rectangle as 9 logical regions (A–I) for scalable UI, edge stretching, and non-distorted corners.
- **Memory-Efficient Layout**: Stores only an outer and inner rect, plus four paddings; all sub-regions are computed on demand.
- **Extensive Properties**: 91 properties for accessing edges, corners, padding, center, and derived regions (e.g., `TopLeft`, `PaddingLeft`, `MarginsTop`).
- **Geometric Operations**: Intersection, union, translation, scaling, centering, containment tests, and conversion between types.
- **Operator Overloading**: 29 operators and 28 pseudo-operators for intuitive math (e.g., `+`, `-`, `&`, `|`, `*`, `/` with rects and vectors).
- **Multiple Constructors**: Flexible creation with points, sizes, paddings, or other rects; supports common and advanced initialization patterns.
- **Pad/Margin/Padding Model**:
	- Absolute inner-rect manipulation (`Pad*`).
	- Relative (from outer rect) manipulation (`Padding*`).
	- Direct access to all 9 regions and relevant coordinates.
- **Advanced State Queries**: Fast checks for overlapping/zero padding, emptiness, and region containment.
- **Type Conversion Support**: Operators for converting between `Rect9<T>`, `Rect<T>`, and string representations, supporting generic and float/int specializations.
- **Robust Documentation**: Inline monkeydoc comments and ASCII diagrams clarify usage and intent.

#### Notes on Implementation Choices

- **Data-First Design**: The class is a pure mathematical primitive, intentionally decoupled from rendering, scene graphs, or engine-specific elements.
- **Minimal Memory, Max Functionality**: Only two rects and four paddings are stored; all other properties are derived, reducing memory while providing comprehensive access.
- **Flexible Initialization**: Constructors support all typical UI and geometric use-cases, from direct coordinate input to margin/padding objects.
- **Operator Overloading with Validation**: All mutating operations (`+=`, `-=`, etc.) update and validate state, ensuring rect integrity.
- **Universal Applicability**: Works for rendering, collision, layout, and any process needing scalable regions—unlike "engine-tied" or UI-only 9-patch implementations.
- **Monkey2/Wonkey Style**: Uses tabs only, monkeydoc, and idiomatic control structures per your style guidelines.

#### Technical Advantages & Explanations

- **9-Region Model (A–I)**: Enables non-distorted corners, stretchable edges, and scalable center—critical for high-quality UI scaling.
- **Derived Properties**: Provides both absolute and relative manipulation (e.g., `PadLeft` vs. `PaddingLeft`), supporting all workflow requirements.
- **Generic Typing**: Works with `Int`, `Float`, etc., via type parameters. Aliases like `Rect9i`, `Rect9f` simplify usage.
- **Operator Expressiveness**: Enables powerful, readable math expressions for geometric logic, making code more maintainable and intuitive.
- **Performance**: By computing sub-regions only as needed, avoids unnecessary recalculation and memory bloat, outperforming approaches that store all 9 regions.
- **Cross-Domain Utility**: Unlike UI-exclusive models (e.g., Godot's or Android's 9-patch), `Rect9` is suitable for graphics, physics, procedural maps, and more.

---

#### In summary

`Rect9` is a mathematically rigorous, memory-efficient, and highly extensible solution for 9-patch region manipulation in Monkey2/Wonkey. Its design reflects a data-first philosophy, providing deep geometric control and performance benefits for any domain—not just UI rendering. The class is well-documented, follows strict implementation standards, and offers unmatched versatility for developers wanting both power and clarity.

If you need detailed breakdowns of specific methods, operators, or usage patterns, just specify!
