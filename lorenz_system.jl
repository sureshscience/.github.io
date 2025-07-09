# 1. Define symbolic variables and system
using ModelingToolkit
@parameters t ρ
@variables x(t, ρ) y(t, ρ) z(t, ρ)
D = Differential(t)

# Lorenz system parameters
σ = 10.0
β = 8/3

# Define the Lorenz equations
eq = [
    D(x) ~ σ * (y - x),
    D(y) ~ x * (ρ - z) - y,
    D(z) ~ x * y - β * z,
]

# 2. Domains for t and ρ
domains = [
    t in Interval(0.0, 2.0),
    ρ in Interval(0.0, 60.0)
]

# 3. Initial conditions parameterized by ρ
bcs = [
    x(0, ρ) ~ 1.0,
    y(0, ρ) ~ 0.0,
    z(0, ρ) ~ 0.0,
]

# Create the PDE system
using NeuralPDE
@named lorenz_system = PDESystem(eq, bcs, domains, [t, ρ], [x, y, z])