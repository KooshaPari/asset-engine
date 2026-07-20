# asset-engine

**Canonical home** for the Phenotype multi-tool asset creation pipeline (Blender, ImageMagick, FFmpeg, Adobe CC, Unreal Engine).

## Ownership

| Field | Value |
|-------|-------|
| **GitHub** | `KooshaPari/asset-engine` |
| **Boundary** | Asset pipeline / render orchestration |
| **Spine peer** | [`KooshaPari/phenoDesign`](https://github.com/KooshaPari/phenoDesign) — creativity / design / UX spine |
| **Migrated from** | `phenoDesign/engine/` (2026-07-20) |

## Migration note

This repository was **extracted** from [`phenoDesign/engine/`](https://github.com/KooshaPari/phenoDesign/tree/main/engine) on 2026-07-20. The `engine/` tree in phenoDesign remains as a **compatibility submodule pointer** until consumers repoint; canonical development happens here.

Historical git history for the engine subtree lives in `KooshaPari/phenoDesign` commits touching `engine/**`.

## Quick start

See [README.md](./README.md) (inherited from phenoDesign engine) for tool legs, tiers, and orchestrator usage.

```bash
# Example: glassmorphic icon via Blender leg
cd blender
blender -b -P glass_icon.py -- tracera ./tracera_icon.png
```

## Registry

- Boundary owner: `phenotype-registry/BOUNDARY_OWNERS.md` → **asset-engine**
- Disposition: `LIVE` / `DECLARE_BOUNDARY_OWNER` (not absorbed)
