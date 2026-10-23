# Social preview

Template for the GitHub social preview image (Settings → General → Social preview) of every Sogeor repository.

- `template.svg` — design: colors, wordmark, layout. Edit it to change all previews.
- `render.sh` — fills the repository name and description and renders `out/<repo>.png` (1280×640).

```bash
sudo apt install librsvg2-bin fonts-inter
./render.sh workflows "Reusable GitHub Actions workflows for Sogeor repositories"
```

Upload `out/<repo>.png` in the repository settings. `out/` is not committed.
