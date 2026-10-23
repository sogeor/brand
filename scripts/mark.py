#!/usr/bin/env python3
"""Generate the Sogeor mark (an S drawn as an infinity sign with two cuts) as SVG.

Usage: mark.py --fg '#E5261F' [--bg '#000000'] [--stroke 78] [--size 1000] > out.svg
"""
import argparse
import math

p = argparse.ArgumentParser()
p.add_argument("--fg", default="#000000")
p.add_argument("--bg", default="none")
p.add_argument("--stroke", type=float, default=78, help="line width per 1000 px")
p.add_argument("--clearance", type=float, default=0.47, help="gap clearance, in line widths")
p.add_argument("--size", type=int, default=1000)
p.add_argument("--scale", type=float, default=1.0, help="mark size relative to the canvas")
a = p.parse_args()

W = 1000.0
cx = cy = W / 2
A = 380.0 * a.scale
sw = a.stroke


def pt(t):
    s = math.sin(t)
    k = 1 + s * s
    return cx + A * math.cos(t) / k, cy + A * s * math.cos(t) / k


def clearance(d):
    # distance from the cut end to the centre line of the spine, minus one line width
    ex, ey = pt(-math.pi / 2 + d)
    # spine tangent at the centre is the diagonal (1, 1) / sqrt 2 before mirroring
    return abs((ex - cx) - (ey - cy)) / math.sqrt(2) - sw


lo, hi = 0.01, 1.2
for _ in range(60):
    mid = (lo + hi) / 2
    if clearance(mid) < a.clearance * sw:
        lo = mid
    else:
        hi = mid
d = hi

n = 1200
t0, t1 = -math.pi / 2 + d, 3 * math.pi / 2 - d
pts = [pt(t0 + (t1 - t0) * i / n) for i in range(n + 1)]
path = "M" + " L".join(f"{W - x:.2f},{y:.2f}" for x, y in pts)  # mirrored: S turned 90° right

bg = "" if a.bg == "none" else f'  <rect width="{W:g}" height="{W:g}" fill="{a.bg}"/>\n'
print(f'''<svg xmlns="http://www.w3.org/2000/svg" width="{a.size}" height="{a.size}" viewBox="0 0 {W:g} {W:g}">
  <title>Sogeor</title>
{bg}  <path d="{path}" fill="none" stroke="{a.fg}" stroke-width="{sw:g}" stroke-linecap="butt" stroke-linejoin="round"/>
</svg>''')
