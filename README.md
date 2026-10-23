# brand

[![License: source-available](https://img.shields.io/badge/license-source--available-informational)](LICENSE)

> Sogeor brand assets: logo, colors and usage guidelines

The Sogeor mark is the letter S turned 90° to the right and drawn as an infinity sign: a lemniscate with two cuts on either side of the centre, which never touch the central stroke. The files are generated from one script, so every variant has the same geometry.

## Table of Contents

- [Background](#background)
- [Install](#install)
- [Usage](#usage)
- [Maintainers](#maintainers)
- [Contributing](#contributing)
- [License](#license)

## Background

| Path | Contents |
|---|---|
| `logo/svg/sogeor-mark-{black,white,red}.svg` | the mark on a transparent background |
| `logo/svg/sogeor-avatar-*.svg` | the mark on a square background: avatars, app icons |
| `logo/svg/sogeor-favicon.svg` | heavier line for sizes up to 64 px |
| `logo/png/` | PNG at 1024, 512 and 256 px; favicons 16–192 px; `apple-touch-icon.png` |
| `logo/favicon.ico` | 16, 32 and 48 px |
| `social-preview/` | GitHub social preview template and renderer |
| [colors.md](colors.md) | palette |
| [TRADEMARKS.md](TRADEMARKS.md) | how the name and the mark may be used |

## Install

```bash
sudo apt install librsvg2-bin fonts-inter
pipx install pillow || pip install --user pillow
```

## Usage

Regenerate every logo file after changing `scripts/mark.py` or the colors in `scripts/build.sh`:

```bash
scripts/build.sh
```

`scripts/mark.py` options: `--fg`, `--bg`, `--stroke` (line width per 1000 px), `--clearance` (gap between a cut and the central stroke, in line widths), `--scale`.

Social preview for a repository:

```bash
social-preview/render.sh workflows "Reusable GitHub Actions workflows for Sogeor repositories"
```

Use the black mark for documents and trademark filings, the red mark on black or white for the product. Keep clear space around the mark of at least one loop height.

## Maintainers

[Sogeor maintainers](https://github.com/orgs/sogeor/teams/maintainers)

## Contributing

Changes to the mark are made only by the maintainers. Fixes to the scripts and documentation are welcome; read the [contributing guidelines](https://github.com/sogeor/.github/blob/HEAD/CONTRIBUTING.md).

## License

© 2026 Georgii Sopin. Files: [Sogeor License 1.0](LICENSE) (English and Russian; the Russian version prevails). The name and the mark are trademarks; see [TRADEMARKS.md](TRADEMARKS.md).
